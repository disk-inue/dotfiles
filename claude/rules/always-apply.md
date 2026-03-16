# 常時適用ルール

## 回答言語

- 日本語で回答すること

## ブランチルール

- mainブランチおよびdevelopブランチで直接コミットしないこと

## 命名規則

- ファイル名: kebab-case（`header-menu.tsx`, `user-service.ts`）
- 変数/関数: camelCase（`getUserData`, `isValidEmail`）
- コンポーネント/クラス/型: PascalCase（`HeaderMenu`, `UserService`）
- 定数: SCREAMING_SNAKE_CASE（`API_BASE_URL`）
- 未使用変数: アンダースコアプレフィックス（`_unusedVar`）

## パッケージマネージャ

- pnpmのみを使用すること（npm, yarnは使用禁止）
- `npx` は使用禁止。代わりに `pnpm exec` または `pnpm dlx` を使用すること

## コマンド実行

- コマンドは必ずカレントワーキングディレクトリで実行すること
- git worktreeで作業している場合、ルートリポジトリのパスに `cd` して実行しないこと
- `gh` などのCLIツールもworktreeのディレクトリ内で実行すること

## コード品質

- `any`, `unknown`, `never`型は可能な限り避け、明示的な型を使用すること
- デフォルトエクスポートは避け、名前付きエクスポートを優先すること
- コード変更後は必ず format, lint, typecheck を実行すること
