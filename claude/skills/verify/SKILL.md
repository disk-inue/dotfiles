---
name: verify
description: "変更ファイルを分析し、変更種別に応じた検証を自動実行。コード検証をしたいときに使用"
---

# Verify Skill

## Use when

- ユーザーが「検証して」「verify」「チェックして」と言ったとき
- 実装の品質を確認したいとき
- コミット前の最終確認をするとき

## 実行フロー

### Step 1: 変更ファイルの分析

```bash
git diff --name-only HEAD~1  # 直近のコミット
git diff --name-only         # 未コミット変更
```

変更ファイルのパスから変更種別を分類:

| パスパターン | 種別 | 検証内容 |
|---|---|---|
| `apps/ec/**` | フロントエンド | lint, typecheck, test, build |
| `apps/backend/**` | バックエンド | lint, typecheck, test, build |
| `**/*.graphql` | GraphQL | codegen, lint, typecheck |
| `**/schema.prisma` | Prisma | codegen, migrate check |
| `**/*.test.ts` | テスト | test実行 |
| `package.json`, `pnpm-lock.yaml` | 依存関係 | pnpm install, typecheck |

### Step 2: 種別ごとの検証

#### フロントエンド検証

```bash
cd apps/ec
pnpm format        # フォーマット
pnpm lint          # lint
pnpm typecheck     # 型チェック
pnpm test          # ユニットテスト
pnpm build         # ビルド確認
```

#### バックエンド検証

```bash
cd apps/backend
pnpm format        # フォーマット
pnpm lint          # lint
pnpm typecheck     # 型チェック
pnpm test          # ユニットテスト
pnpm build         # ビルド確認
```

#### GraphQL検証

```bash
cd apps/ec && pnpm codegen      # EC側codegen
cd apps/backend && pnpm codegen # Backend側codegen
# codegen後にtypecheck
```

#### Prisma検証

```bash
cd apps/backend
pnpm codegen:prisma    # Prisma Client再生成
pnpm typecheck         # 型チェック
```

### Step 3: 結果レポート

検証結果をまとめて報告:

```markdown
## Verify Results

### 変更種別: [フロントエンド / バックエンド / GraphQL / Prisma / 混合]

| チェック | 結果 | 詳細 |
|---------|------|------|
| Format  | PASS/FAIL | ... |
| Lint    | PASS/FAIL | ... |
| Type    | PASS/FAIL | ... |
| Test    | PASS/FAIL | ... |
| Build   | PASS/FAIL | ... |

### 問題点（FAILの場合）
- 問題の詳細と修正方法
```

## 注意事項

- 全てPASSなら「検証完了、問題なし」と報告
- FAILがあればエラー内容と修正案を提示
- build検証は時間がかかるため、`--skip-build` で省略可能
- テスト実行は変更ファイルに関連するテストのみ（可能な場合）
