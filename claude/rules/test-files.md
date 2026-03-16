---
globs: "**/*.test.ts,**/*.test.tsx,**/*.spec.ts,**/*.spec.tsx"
---

# テストファイル ルール

## TDD（t_wadaアプローチ）

- テスト駆動開発を必須で実施すること
- Red -> Green -> Refactorのサイクルを厳守すること
- まず失敗するテストを書き、次に最小限の実装で通し、最後にリファクタリング
- TODOリストを作成し、1つずつ消化していくこと

## テスト構造（AAA パターン）

- Arrange（準備）-> Act（実行）-> Assert（検証）の構造で書くこと
- 1つのテストケースでは1つの振る舞いのみ検証すること

## テストの書き方

- テスト名は振る舞いを日本語で記述すること（例: `it("ユーザーが存在しない場合はnullを返す")`）
- 実装の詳細ではなく、振る舞い（behavior）をテストすること
- モックは必要最小限に留めること
- テストデータはファクトリパターンで生成すること

## テストフレームワーク

- Vitest を使用すること
- integration test は `*.integration.spec.ts` とすること
- Visual Regression Test は Playwright で `test/vrt/` に配置すること

## テスト実行

- EC: `cd apps/ec && pnpm test`
- Backend: `cd apps/backend && pnpm test`
- 単体: `pnpm test path/to/file.test.ts`
