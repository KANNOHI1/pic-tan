# Flashcard Ultra Simple Redesign — Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** フラッシュカード画面を「画像のみ→タップで英日同時表示」のUltra Simpleデザインに刷新する。

**Architecture:** 現行の3ステージ（画像→英語→日本語+評価）を2ステージ（画像+こたえは？→英日同時+評価）に簡略化。CSSでカードの白枠・ボーダーを廃止し、画像をクリーム背景に直置きする。

**Tech Stack:** Vanilla JS, CSS custom properties, HTML（変更なし）

---

## 変更ファイル一覧

| ファイル | 変更内容 |
|---|---|
| `apps/web/styles.css` | `.study-card` 白枠廃止、`.card-image-wrap` サイズUP、`.card-word-ja` サイズ・色変更、`.tap-hint` スタイル変更 |
| `apps/web/app.js` | `renderCard()` tapHint文言変更、`handleCardTap()` 中間ステージ削除（英日同時表示） |
| `apps/web/index.html` | **変更なし** |

---

## Task 1: CSSでカードビジュアルをUltra Simpleに変更

**Files:**
- Modify: `apps/web/styles.css:310-402`

### 変更仕様

#### `.study-card`（現在 styles.css:310-325）
```css
/* 変更前 */
.study-card {
  margin: 8px 16px;
  background: var(--white);
  border: 2.5px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  justify-content: center;
  transition: transform 100ms ease;
  box-shadow: var(--shadow);
}

/* 変更後：白背景・ボーダー・shadowを削除、背景をクリームに */
.study-card {
  margin: 8px 16px;
  background: transparent;
  border: none;
  border-radius: var(--radius-lg);
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  justify-content: center;
  transition: transform 100ms ease;
  box-shadow: none;
}
```

#### `.card-image-wrap`（現在 styles.css:327-345）
```css
/* 変更前: max-width: 200px */
/* 変更後: max-width: 220px */
.card-image-wrap {
  width: 100%;
  max-width: 220px;
  aspect-ratio: 1;
  border-radius: var(--radius-md);
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  filter: drop-shadow(0 12px 24px rgba(61,50,39,0.12));
}
```

#### `.card-word-en`（現在 styles.css:347-356）
```css
/* 変更前: font-size: 2.6rem */
/* 変更後: font-size: 2.25rem（≈36px） */
.card-word-en {
  font-family: var(--font-en);
  font-size: 2.25rem;
  font-weight: 900;
  color: var(--charcoal);
  text-align: center;
  letter-spacing: 0.02em;
  animation: wordReveal 150ms ease-out;
}
```

#### `.card-word-ja`（現在 styles.css:357-364）
```css
/* 変更前: font-size: 1.4rem, color: var(--muted) */
/* 変更後: font-size: 2.25rem, color: var(--charcoal)（英語と同サイズ・同色） */
.card-word-ja {
  font-family: var(--font-ja);
  font-size: 2.25rem;
  font-weight: 700;
  color: var(--charcoal);
  text-align: center;
  animation: wordReveal 150ms ease-out;
}
```

#### `.tap-hint`（現在 styles.css:369-374）
```css
/* 変更前: font-size: 0.9rem, color: var(--muted) */
/* 変更後: 大きく・濃い色に（こたえは？のスタイル） */
.tap-hint {
  text-align: center;
  color: var(--charcoal);
  font-family: var(--font-ja);
  font-size: 1.4rem;
  font-weight: 700;
  padding: 8px 20px;
}
```

### 手順

- [ ] **Step 1: `.study-card` を編集** — background/border/box-shadowを削除
- [ ] **Step 2: `.card-image-wrap` を編集** — max-width 200px→220px、drop-shadowを追加
- [ ] **Step 3: `.card-word-en` を編集** — font-size 2.6rem→2.25rem
- [ ] **Step 4: `.card-word-ja` を編集** — font-size 1.4rem→2.25rem、color `--muted`→`--charcoal`
- [ ] **Step 5: `.tap-hint` を編集** — font-size/color/font-family/font-weight更新
- [ ] **Step 6: ブラウザで目視確認**
  ```
  python -m http.server 8000
  → http://localhost:8000/apps/web/
  ```
  確認ポイント：カードが白枠なし・画像が220px・tapHintが大きく表示されること
- [ ] **Step 7: コミット**
  ```bash
  git add apps/web/styles.css
  git commit -m "style: flashcard ultra simple — no card border, larger image, equal text sizes"
  ```

---

## Task 2: JSでタップフローを2ステージに簡略化

**Files:**
- Modify: `apps/web/app.js:324-375`

### 変更仕様

#### `renderCard()`（現在 app.js:324-346）
```js
// 変更箇所: tapHintのテキストを'タップしてね 👆' → 'こたえは？'
function renderCard() {
  const card = state.session[state.pos];
  if (!card) return;

  state.tapStage = 0;
  state.lastAnimal = card;

  // Image
  const imageWrap = document.getElementById('cardImageWrap');
  imageWrap.innerHTML = cardImageHTML(card, state.theme.id);

  // Hide text/rating
  document.getElementById('cardWordEn').hidden = true;
  document.getElementById('cardWordJa').hidden = true;
  document.getElementById('ratingWrap').hidden = true;

  // ★ 変更: "タップしてね 👆" → "こたえは？"
  document.getElementById('tapHint').textContent = 'こたえは？';
  document.getElementById('tapHint').hidden = false;

  // Tap handler
  const studyCard = document.getElementById('studyCard');
  studyCard.onclick = handleCardTap;
  studyCard.onkeydown = e => { if (e.key === 'Enter' || e.key === ' ') handleCardTap(); };
}
```

#### `handleCardTap()`（現在 app.js:348-375）
```js
// 変更: 3ステージ→2ステージ
// 旧: stage1=英語のみ, stage2=日本語+評価
// 新: stage1=英日同時+評価（中間ステージ廃止）
function handleCardTap() {
  const card = state.session[state.pos];
  state.tapStage++;

  if (state.tapStage === 1) {
    // ★ 英語と日本語を同時に表示
    const en = document.getElementById('cardWordEn');
    en.textContent = card.wordEN;
    en.hidden = false;

    const ja = document.getElementById('cardWordJa');
    ja.textContent = card.wordJA;
    ja.hidden = false;

    // tapHintを非表示
    document.getElementById('tapHint').hidden = true;

    // 評価ボタンを表示
    document.getElementById('ratingWrap').hidden = false;

    // カードタップを無効化（評価ボタンを使う）
    document.getElementById('studyCard').onclick = null;

    // 評価ハンドラ
    document.querySelectorAll('.btn-rating').forEach(btn => {
      btn.onclick = () => handleRating(btn.dataset.rating === 'knew');
    });
  }
  // stage2以降は何もしない（評価ボタンが処理する）
}
```

### 手順

- [ ] **Step 1: `renderCard()` のtapHintテキストを変更**
  - `apps/web/app.js:339` の `'タップしてね 👆'` → `'こたえは？'`
  - `apps/web/app.js:340` の `'もう一度タップ 👆'` を設定している行を削除対象としてマーク
- [ ] **Step 2: `handleCardTap()` を書き換え**
  - tapStage===1のブロックを「英日同時表示＋評価ボタン」に変更
  - tapStage===2のブロックを削除
- [ ] **Step 3: ブラウザで動作確認**
  - 画像のみ表示 ✓
  - 「こたえは？」が表示 ✓
  - タップで英語・日本語が同時出現 ✓
  - 評価ボタンが出現 ✓
  - 「しってた！😊」「むずかしい😵」でnextカードへ ✓
- [ ] **Step 4: コミット**
  ```bash
  git add apps/web/app.js
  git commit -m "feat: flashcard 2-stage reveal — tap once to show EN+JA simultaneously"
  ```

---

## 完了確認チェックリスト

- [ ] カードに白枠・ボーダーがない
- [ ] 画像がクリーム背景に直置きで浮いて見える
- [ ] 「こたえは？」が大きく・濃い色で表示される
- [ ] 1タップで APPLE と りんご が同時に出現する
- [ ] APPLE と りんご が同サイズ（2.25rem）・同色（charcoal）
- [ ] 評価ボタン（しってた！/ むずかしい）が正常に動作する
- [ ] セッション完了画面に正常に遷移する
- [ ] ストリーク・スペースドリピティションのロジックは変更なし（app.js下部は触らない）
