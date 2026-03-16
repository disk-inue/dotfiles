---
name: refactor
description: "Martin Fowlerのアプローチに基づいたリファクタリング支援。コード改善、技術的負債解消時に使用"
---

# Refactor Skill

Martin Fowlerのリファクタリング原則に基づいてコードを改善する。

## Use when

- コードの可読性を改善したいとき
- 重複を排除したいとき
- 技術的負債を解消したいとき
- パフォーマンスを改善したいとき

## リファクタリングの原則

### 前提条件

1. **テストが存在すること**: リファクタリング前にテストを確認/追加
2. **小さなステップ**: 一度に1つの変更のみ
3. **頻繁にテスト実行**: 各ステップ後にテストを実行
4. **コミット**: 動作する状態でこまめにコミット

### リファクタリングのタイミング

- **Three Strikes Rule**: 3回同じコードを書いたら抽象化を検討
- **Preparatory Refactoring**: 新機能追加前に構造を整える
- **Comprehension Refactoring**: コードを理解するために整理
- **Opportunistic Refactoring**: 触ったついでに改善

## よく使うリファクタリングパターン

### Extract Function（関数の抽出）

```typescript
// Before
function printOwing(invoice: Invoice) {
  let outstanding = 0;
  for (const o of invoice.orders) {
    outstanding += o.amount;
  }
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}

// After
function printOwing(invoice: Invoice) {
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice, outstanding);
}

function calculateOutstanding(invoice: Invoice): number {
  return invoice.orders.reduce((sum, o) => sum + o.amount, 0);
}

function printDetails(invoice: Invoice, outstanding: number) {
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

### Inline Function（関数のインライン化）

関数の本体が名前と同程度に明確な場合。

### Replace Temp with Query（一時変数をクエリに置き換え）

```typescript
// Before
const basePrice = quantity * itemPrice;
if (basePrice > 1000) return basePrice * 0.95;

// After
if (getBasePrice() > 1000) return getBasePrice() * 0.95;

function getBasePrice() {
  return quantity * itemPrice;
}
```

### Replace Conditional with Polymorphism

```typescript
// Before
function getSpeed(vehicle: Vehicle) {
  switch (vehicle.type) {
    case 'car': return vehicle.baseSpeed;
    case 'bike': return vehicle.baseSpeed * 0.8;
    case 'truck': return vehicle.baseSpeed * 0.6;
  }
}

// After
interface Vehicle {
  getSpeed(): number;
}

class Car implements Vehicle {
  getSpeed() { return this.baseSpeed; }
}

class Bike implements Vehicle {
  getSpeed() { return this.baseSpeed * 0.8; }
}
```

### Decompose Conditional

```typescript
// Before
if (date >= SUMMER_START && date <= SUMMER_END) {
  charge = quantity * summerRate;
} else {
  charge = quantity * regularRate;
}

// After
if (isSummer(date)) {
  charge = summerCharge(quantity);
} else {
  charge = regularCharge(quantity);
}
```

## Reactコンポーネントのリファクタリング

### コンポーネント分割

```typescript
// 100行を超えるコンポーネントを分割
// Before: 1つの大きなコンポーネント
// After: 論理的な単位で分割

// Header.tsx
export function Header() { ... }

// HeaderNav.tsx
export function HeaderNav() { ... }

// HeaderLogo.tsx
export function HeaderLogo() { ... }
```

### Custom Hook抽出

```typescript
// Before: コンポーネント内にロジック
function Component() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  useEffect(() => { /* fetch logic */ }, []);
  // ...
}

// After: Custom Hookに抽出
function useData(id: string) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  useEffect(() => { /* fetch logic */ }, [id]);
  return { data, loading };
}

function Component() {
  const { data, loading } = useData(id);
  // ...
}
```

## 手順

1. 現状のコードを理解
2. テストの存在確認（なければ追加）
3. リファクタリング計画を立てる
4. 小さなステップで変更
5. 各ステップ後にテスト実行
6. 完了後に`pnpm lint && pnpm typecheck`

## 注意事項

- **機能追加と混ぜない**: リファクタリングは振る舞いを変えない
- **パフォーマンス最適化と分ける**: まず正しく動くコード、次に速く
- **過度な抽象化を避ける**: 今必要なものだけを抽象化
