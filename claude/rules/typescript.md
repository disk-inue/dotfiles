---
globs: "**/*.ts,**/*.tsx"
---

# TypeScript ルール

## 型の厳格さ

- TypeScript strict mode（`"strict": true`）を遵守すること
- `any`型は使用禁止。明示的な型定義を行うこと
- `unknown`は外部入力のバリデーション時のみ使用可
- `as`によるキャストは最小限に留め、型ガードを優先すること

## インポート規則

- 絶対パス `@/` プレフィックスを使用すること
- インポート順序はPrettierプラグインにより自動整理される
- デフォルトエクスポートは避け、名前付きエクスポートを使用すること
- 使用していないインポートは削除すること

## エクスポート規則

- `export default`は避け、`export function`や`export const`を使うこと
- 型のエクスポートには`export type`を使用すること
- barrelファイル（`index.ts`）での再エクスポートは適切に使うこと

## コーディング規約

- 未使用変数にはアンダースコアプレフィックスを付ける（`_unusedVar`）
- enum よりも union type や const object を優先すること
- 関数の戻り値型は明示すること（推論に頼らない）
