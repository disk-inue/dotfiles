---
globs: "**/src/presenter/**/*.tsx"
---

# Reactコンポーネント ルール

## コンポーネント設計

- 1コンポーネントは最大100行（ESLintで強制）
- Props型はTypeScript interfaceで定義すること
- Props destructuringは関数シグネチャで実行すること
- Server Componentを優先し、Client Componentは最小限に

## DesignRule Namespace パターン

```tsx
// OK: DesignRule名前空間経由
import { DesignRule } from "@/presenter/design-rule-components"
<DesignRule.Section>...</DesignRule.Section>

// NG: 直接インポート
import { Section } from "@/presenter/design-rule-components/section/section"
```

## section-component パターン

- 複数セクションのページは `section-components/` ディレクトリに分離
- セクションファイル: `section{N}-{feature}.tsx`
- `index.ts` で `SectionCmp` オブジェクトとしてまとめてエクスポート

## Client Component

- `"use client"` は必要最小限のコンポーネントにのみ付与
- [CompositionPatterns](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns)を活用し、Client Component部分を最小化すること

## エラーハンドリング

- Error Boundary + Sentry でエラーを捕捉すること
- ユーザー向けのフォールバックUIを必ず用意すること
