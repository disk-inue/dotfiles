---
name: create-pr
description: "PR作成 + CI監視 + 自動修正フロー。PRを作りたいときに使用"
---

# Create PR Skill

## Use when

- ユーザーが「PR作って」「プルリク作成」と言ったとき
- 実装が完了してPRを作成する必要があるとき
- 既存PRのCIを監視・修正したいとき（「CI直して」「CIこけてる」など）
- ClaudeAutoReviewの指摘を自動修正したいとき

## 引数

- `--wait`: CI完了まで監視し、失敗時は自動修正を試行（最大3回）。ClaudeAutoReviewの指摘も自動修正対象に含む
- `--draft`: ドラフトPRとして作成
- `--base <branch>`: ベースブランチ指定（デフォルト: main）
- `--watch-only <PR番号 or URL>`: 既存PRに対してCI監視+自動修正のみ実行（PR作成をスキップ）
- `--skip-review-fix`: ClaudeAutoReviewの指摘自動修正をスキップ（CI修正のみ実行）

## 実行モード

このスキルには2つのモードがある:

### 通常モード（デフォルト）

PR作成からCI監視までの全フローを実行する。

### watch-onlyモード（`--watch-only` 指定時）

既存PRに対してCI監視+自動修正のみを実行する。Step 1・Step 2をスキップし、Step 3から開始する。

**PR番号の解決:**
1. `--watch-only` に PR番号またはURLが指定されていればそれを使用
2. 引数なしの場合、現在のブランチに紐づくPRを `gh pr view --json number` で自動検出
3. PRが見つからない場合はエラーとしてユーザーに報告

## 実行フロー

### Step 1: 事前チェック（通常モードのみ）

1. `git status` で未コミットの変更がないか確認
2. 未コミット変更があれば `/commit` スキルを実行
3. `git log main..HEAD` で含まれるコミットを確認
4. `git diff main...HEAD` で全体の差分を把握

### Step 2: PR作成（通常モードのみ）

1. リモートにpush: `git push -u origin <current-branch>`
2. コミット履歴から変更内容を分析
3. PRタイトル（70文字以内）とサマリーを生成
4. `gh pr create` で作成

```bash
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
<箇条書き 1-3個>

## Changes
<変更ファイルと概要>

## Test plan
- [ ] テスト項目...

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### Step 3: CI監視（通常モードでは `--wait` 指定時、watch-onlyモードでは常時実行）

1. `gh pr checks <pr-number> --watch` でCI状態を監視
   - `Claude Auto Review` ジョブも監視対象に含まれる（GitHub Actionsジョブとしてchecksに表示される）
2. 全チェックがpassしたら Step 5 へ進む
3. 失敗した場合は Step 4 へ

### Step 4: CI自動修正（最大3回）

1. `gh pr checks <pr-number>` で失敗チェックを特定
2. 失敗原因を分析：
   - lint失敗 -> `pnpm lintfix` 実行
   - typecheck失敗 -> 型エラーを修正
   - test失敗 -> テストを修正
   - build失敗 -> ビルドエラーを修正
3. 修正をコミット&push
4. CIを再監視（Step 3へ戻る）
5. 3回失敗したら諦めてユーザーに報告

### Step 5: ClaudeAutoReview判定チェック（`--skip-review-fix` 未指定時）

CI全チェックがpassした後、ClaudeAutoReviewの判定を確認する。

1. `claude[bot]` の最新サマリーコメントを取得:
   ```bash
   gh api repos/{owner}/{repo}/issues/{pr}/comments \
     --jq '[.[] | select(.user.login == "claude[bot]")] | sort_by(.created_at) | last'
   ```
2. コメント本文の `### 判定` セクションをパース:
   - `LGTM` -> 完了。ユーザーに報告
   - `要修正` -> Step 6 へ
   - `軽微な修正あり` -> 完了。ユーザーに指摘事項を報告（修正は任意）
3. `claude[bot]` のコメントが存在しない場合:
   - `Claude Auto Review` ジョブがchecksに存在するか確認
   - 存在しない場合（ドラフトPR、renovateラベル等でスキップ）: レビューなしとして完了
   - ジョブは存在するがコメントがない場合: 最大60秒待ってリトライ（1回のみ）

### Step 6: レビュー指摘の自動修正（最大3回）

ClaudeAutoReviewの指摘内容に基づいて修正を行う。

#### 6-1. 指摘内容の収集

**サマリーコメント**（issue comment）から全体像を把握:
```bash
gh api repos/{owner}/{repo}/issues/{pr}/comments \
  --jq '[.[] | select(.user.login == "claude[bot]")] | sort_by(.created_at) | last | .body'
```
- `#### CRITICAL` セクション: 必ず修正
- `#### WARNING` セクション: 修正を試行

**インラインコメント**（review comment）から具体的な修正箇所を特定:
```bash
gh api repos/{owner}/{repo}/pulls/{pr}/comments \
  --jq '[.[] | select(.user.login == "claude[bot]") | {path: .path, line: .line, side: .side, body: .body, created_at: .created_at}]'
```
- インラインコメントにはファイルパス・行番号・具体的な修正案が含まれる
- `**[CRITICAL]**` または `**[WARNING]**` ラベルで重要度を判別

#### 6-2. 修正の実行

1. インラインコメントがある場合、それを優先的に修正（ファイルパスと行番号が明確なため）
2. インラインコメントがない指摘はサマリーから内容を読み取り、該当コードを特定して修正
3. `INFO` レベルの指摘は修正対象外（参考情報のため）

#### 6-3. 修正のコミット&push

1. 修正内容をコミット（コミットメッセージ例: `fix(<scope>): address Claude review feedback`、scopeは変更ファイルに応じて `ec` / `backend` / `deps` から選択）
2. `git push` でリモートに反映
3. pushにより `synchronize` イベントが発火し、ClaudeAutoReviewが自動で再実行される
4. Step 3 に戻ってCI + レビューを再監視

#### 6-4. リトライ上限

- CI修正（Step 4）とレビュー修正（Step 6）を合わせて **最大3回** のループで打ち切り
- 3回修正しても `LGTM` にならない場合、残っている指摘内容をユーザーに報告して終了

## PRテンプレート

### タイトル規則

- `feat(scope): 説明` - 新機能
- `fix(scope): 説明` - バグ修正
- `refactor(scope): 説明` - リファクタリング
- `chore(scope): 説明` - メンテナンス

### スコープ

- `ec`: フロントエンド
- `backend`: バックエンド
- `deps`: 依存関係

## 注意事項

- mainブランチから直接PRを作らないこと
- 機密情報が含まれていないことを確認
- 大きな変更は分割PRを検討
- PRのURLを必ずユーザーに報告すること
- ClaudeAutoReviewはドラフトPR・renovateラベル・tagprラベル付きPRではスキップされる
- レビュー修正のpushで `synchronize` イベントが発火し、auto-reviewが再実行される（古いコメントはワークフロー側で自動最小化される）
- CI修正とレビュー修正のリトライ回数は合算でカウントする（合計最大3回）
