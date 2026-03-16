---
globs: "**/*.graphql,**/*.gql"
---

# GraphQLスキーマ ルール

## Schema-first開発

- 必ず`.graphql`ファイルでスキーマを先に定義すること
- スキーマ変更後は `pnpm codegen` を実行してTypeScript型を再生成すること
- `schema.mapper.ts` でGraphQL型定義とTypeScript型定義を対応させること

## 命名規則

- Query/Mutation: camelCase（`getUser`, `createOrder`）
- Type: PascalCase（`User`, `InsuranceProduct`）
- Input: PascalCase + `Input`サフィックス（`CreateUserInput`）
- Enum: PascalCase、値はSCREAMING_SNAKE_CASE

## パフォーマンス

- N+1問題を避けるためDataLoaderパターンを採用すること
- 大量データ取得にはページネーション（Cursor-based推奨）を実装すること

## セキュリティ

- GraphQL Shieldでアクセス制御を実装すること
- 入力値のバリデーションをResolver内で行うこと

## codegen実行

- スキーマ変更後は必ず以下を実行:
  - EC: `cd apps/ec && pnpm codegen`
  - Backend: `cd apps/backend && pnpm codegen`
