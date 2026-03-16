---
name: pr-review
description: "PRのレビューを実行。GitHub PRのURLまたはPR番号を指定してレビューするときに使用"
---

# PR Review Skill

GitHub Pull Requestの包括的なレビューを実行する。

## Use when

- PRのレビューを依頼されたとき
- `gh pr view`でPRを確認するとき
- PRのURLや番号を指定されたとき

## レビュー手順

### 1. PR情報の取得

```bash
# PR詳細を取得
gh pr view <PR番号> --json title,body,files,commits,additions,deletions

# 差分を取得
gh pr diff <PR番号>

# PRのコメントを確認
gh api repos/<owner>/<repo>/pulls/<PR番号>/comments
```

### 2. コンテキスト確認

- **PR概要**: タイトルと説明から目的を理解
- **変更規模**: additions/deletionsから影響範囲を把握
- **関連ファイル**: 変更ファイル一覧から影響箇所を特定
- **コミット履歴**: 変更の経緯を理解

### 3. レビュー観点

#### コード品質
- 可読性と保守性
- DRY原則の遵守
- 適切な命名
- コンポーネント設計（100行以内）

#### TypeScript
- 型安全性（any/unknown/neverの回避）
- 適切な型定義
- nullチェック

#### React/Next.js
- Server Component優先
- Client Componentの最小化
- 適切なhooks使用

#### セキュリティ
- 入力バリデーション
- 認証・認可
- 機密情報の取り扱い

#### パフォーマンス
- 不要なre-render
- バンドルサイズ
- N+1問題（GraphQL）

#### テスト
- 必要なテストの有無
- テストの品質

### 4. レビューコメント作成

```markdown
## PR Review: #<PR番号>

### 概要
- **目的**: [PRの目的]
- **変更規模**: +X/-Y lines, N files

### 良い点
- [具体的に良かった実装]

### 必須対応
- [ ] `file:line` - 問題の説明
  - 修正提案

### 推奨対応
- [ ] `file:line` - 改善点
  - 改善案

### 質問・確認事項
- [意図が不明な点への質問]

### 総合評価
- [ ] Approve
- [ ] Request Changes
- [ ] Comment
```

## レビューコメントの投稿

```bash
# レビューコメントを投稿
gh pr review <PR番号> --comment --body "レビューコメント"

# Approve
gh pr review <PR番号> --approve --body "LGTM"

# Request changes
gh pr review <PR番号> --request-changes --body "修正をお願いします"
```

## Tips

- 批判ではなく改善提案を心がける
- 良い実装は積極的に褒める
- 重要な点に集中し、細かすぎる指摘は避ける
- 疑問点は質問形式で確認
