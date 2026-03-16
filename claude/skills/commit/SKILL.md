---
name: commit
description: "コミットメッセージ作成とコミット実行。変更をコミットするときに使用"
---

# Commit Skill

## Use when

- ユーザーが「コミットして」「commit」と言ったとき
- 変更をgitにコミットする必要があるとき

## コミットメッセージ規約

### フォーマット

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- **feat**: 新機能
- **fix**: バグ修正
- **docs**: ドキュメントのみの変更
- **style**: コードの意味に影響しない変更（空白、フォーマット等）
- **refactor**: バグ修正でも機能追加でもないコード変更
- **perf**: パフォーマンス改善
- **test**: テストの追加・修正
- **chore**: ビルドプロセスやツールの変更

### Scope

- **ec**: ECフロントエンド
- **backend**: バックエンドAPI
- **deps**: 依存関係
- **ci**: CI/CD設定
- スコープは省略可能

### Subject

- 変更内容を簡潔に（日本語可、50文字以内推奨）
- 命令形で書く（「追加する」ではなく「追加」）
- 末尾にピリオドを付けない

### Body（オプション）

- なぜこの変更が必要だったかを説明
- 72文字で折り返す

## コミット手順

1. `git status`で変更ファイルを確認
2. `git diff`でステージ済み・未ステージの変更を確認
3. `git log --oneline -5`で直近のコミットスタイルを確認
4. 変更内容を分析してコミットメッセージを作成
5. 関連ファイルをステージング
6. コミット実行

## 注意事項

- コミット前に`pnpm lint`と`pnpm typecheck`が通ることを確認
- 機密情報（.env、credentials等）をコミットしない
- 大きな変更は論理的な単位で分割してコミット
- WIPコミットは避け、完成した単位でコミット

## コミットメッセージ例

```bash
# 機能追加
feat(ec): 商品検索フィルター追加

# バグ修正
fix(backend): ユーザー認証のトークン検証を修正

# リファクタリング
refactor(ec): Headerコンポーネントの分割

# 依存関係更新
chore(deps): Next.js 15.1.0にアップデート
```

## フッター

コミットメッセージの末尾に以下を追加：

```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```
