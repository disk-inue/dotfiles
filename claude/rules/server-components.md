---
globs: "**/src/app/**/page.tsx,**/src/app/**/layout.tsx"
---

# Server Components ルール

## 基本方針

- page.tsx, layout.tsx はデフォルトでServer Componentとして実装すること
- `"use client"` を付与しないこと（Client Componentが必要な場合は子コンポーネントに分離）

## キャッシュ戦略

- fetchは `force-cache` をデフォルトとする
- microCMS更新時はWebhookで `revalidateTag` を呼び出し、対象データのみ更新
- キャッシュクリアAPIは `src/app/(ec)/api/webhook/cache-clear/{slug}` に配置

## Dynamic APIの回避

- `cookies()`, `headers()`, `searchParams` 等のDynamic APIはSSRを強制するため、可能な限り避けること
- 必要な場合はServer Actions を `useEffect` 内で呼び出す設計にすること

## パフォーマンス

- ISR/SSG を最大限活用すること
- `next/image` で画像最適化を行うこと
- Code SplittingとDynamic importsでバンドルサイズを削減すること

## データフェッチ

- GraphQLクエリは `src/repository` 層で定義すること
- クエリ作成時はキャッシュクリア対象を考慮すること
