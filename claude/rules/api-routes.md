---
globs: "**/src/app/api/**/*.ts"
---

# APIルート ルール

## エラーハンドリング

- 全てのAPIルートでtry/catchを使用し、構造化されたエラーオブジェクトを返すこと
- エラーレスポンスは一貫したフォーマットで返すこと
- 予期しないエラーはSentryに送信すること
- 適切なHTTPステータスコードを返すこと

## セキュリティ

- 環境変数でシークレットを管理し、コードに直接ハードコードしないこと
- CORS設定を適切に行うこと
- Rate Limitingを実装すること

## Webhookエンドポイント

- microCMSからのWebhookは `api/webhook/cache-clear/{slug}` パターンで実装
- `revalidateTag` で対象リソースのキャッシュのみクリアすること
- Webhookの認証（シークレットトークン）を必ず検証すること

## レスポンス

- `NextResponse.json()` を使用すること
- レスポンス型を明示的に定義すること
