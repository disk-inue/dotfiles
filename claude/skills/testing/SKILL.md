---
name: testing
description: "TDDに基づいたテスト作成支援。テストを書くとき、テスト駆動開発を行うときに使用"
---

# Testing Skill

## Use when

- 新機能のテストを書くとき
- TDD（テスト駆動開発）で実装するとき
- 既存コードにテストを追加するとき
- テストのリファクタリングが必要なとき

## TDDサイクル（t_wada推奨アプローチ）

### Red-Green-Refactor

1. **Red**: 失敗するテストを書く
   - 最小限の失敗するテストを1つ書く
   - テストが意図通り失敗することを確認

2. **Green**: テストを通す最小限のコードを書く
   - テストを通すことだけを考える
   - きれいなコードは後回し
   - ハードコードでもOK

3. **Refactor**: コードを改善する
   - テストが通る状態を維持
   - 重複を排除
   - 命名を改善
   - 構造を整理

### 原則

- **仮実装**: まずハードコードで通す
- **三角測量**: 2つ以上のテストで実装を導く
- **明白な実装**: 自明な場合は直接実装
- **小さなステップ**: 一度に1つの変更

## テスト構造（Arrange-Act-Assert）

```typescript
describe('機能名', () => {
  describe('メソッド名/シナリオ', () => {
    it('期待する振る舞いの説明', () => {
      // Arrange: テストの準備
      const input = createTestData();

      // Act: テスト対象の実行
      const result = functionUnderTest(input);

      // Assert: 結果の検証
      expect(result).toBe(expected);
    });
  });
});
```

## テストの命名

```typescript
// 良い例：振る舞いを説明
it('空の配列を渡すと空の配列を返す', () => {});
it('無効なメールアドレスでエラーをスローする', () => {});

// 避けるべき例：実装の詳細
it('filterメソッドを呼ぶ', () => {});
it('lengthが0のとき', () => {});
```

## Vitest固有の機能

```typescript
// モック
vi.mock('@/lib/api', () => ({
  fetchData: vi.fn(),
}));

// スパイ
const spy = vi.spyOn(object, 'method');

// タイマー
vi.useFakeTimers();
vi.advanceTimersByTime(1000);

// スナップショット
expect(component).toMatchSnapshot();
```

## React/Next.jsコンポーネントテスト

```typescript
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

describe('Button', () => {
  it('クリックするとonClickが呼ばれる', async () => {
    const handleClick = vi.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    await userEvent.click(screen.getByRole('button'));

    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

## GraphQL/Prismaテスト

```typescript
// リゾルバーテスト
describe('UserResolver', () => {
  it('IDでユーザーを取得できる', async () => {
    const mockPrisma = {
      user: {
        findUnique: vi.fn().mockResolvedValue({ id: '1', name: 'Test' }),
      },
    };

    const result = await resolvers.Query.user(null, { id: '1' }, { prisma: mockPrisma });

    expect(result).toEqual({ id: '1', name: 'Test' });
  });
});
```

## テストのアンチパターン

### 避けるべきこと

- **実装の詳細をテスト**: 内部状態や private メソッドのテスト
- **モックの過剰使用**: 本物を使える場合はモックを避ける
- **テスト間の依存**: 各テストは独立して実行可能に
- **アサーションの欠如**: テスト内で何も検証しない
- **曖昧なテスト名**: 何をテストしているか分からない

### Martin Fowlerのリファクタリング原則

- テストはリファクタリングのセーフティネット
- テストが壊れやすい場合、テスト自体を見直す
- パブリックインターフェースをテストする

## コマンド

```bash
# 全テスト実行
pnpm test

# 特定ファイル
pnpm test path/to/file.test.ts

# ウォッチモード
pnpm test --watch

# カバレッジ
pnpm test --coverage
```
