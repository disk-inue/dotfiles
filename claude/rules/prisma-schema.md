---
globs: "**/schema.prisma"
---

# Prismaスキーマ ルール

## スキーマ変更手順

1. `schema.prisma` を編集する
2. `npx prisma migrate dev --name 変更内容の説明` でマイグレーション作成
3. `pnpm codegen` でPrisma Client再生成
4. 本番デプロイ前にマイグレーションを必ずレビューすること

## コーディング規約

- モデル名: PascalCase（`User`, `InsuranceProduct`）
- フィールド名: camelCase（`firstName`, `createdAt`）
- リレーション: 明示的にリレーション名を指定すること

## トランザクション

- 複数の関連操作は `$transaction` 内で実行すること
- ネストしたcreate/updateよりも明示的なトランザクションを優先すること

## 型安全性

- Prisma生成型を最大限活用すること
- 直接SQLクエリは避け、Prisma Clientを使用すること
- `$queryRaw` を使う場合は型引数を明示すること

## codegen実行

- スキーマ変更後は必ず `cd apps/backend && pnpm codegen` を実行すること
