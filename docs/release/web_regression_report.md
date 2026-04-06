# Web プレビュー 回帰チェックレポート — PT-065 / PT-067

**最終更新**: 2026-03-05 (PT-067: minBand フィルター実装後に更新)
**担当**: Claude（コードレビューベース）
**対象**: `apps/web/app.js` + `apps/web/index.html` + `apps/web/styles.css`
**検証方法**: 静的コードレビュー（制御フロー・データフロー分析）

---

## 変更履歴

| バージョン | 内容 |
|-----------|------|
| PT-065 初版 | Easy/Core/Challenge 動線確認。minBand フィルター未実装を TODO として記録 |
| PT-067 更新 | PT-066 で `themeHiddenAtBand()` 実装済み。Core で g20/eurozone 非表示を PASS に更新 |

---

## 1. Easy タブ（かんたん / 3–5歳）

| 確認項目 | 期待結果 | コード根拠 | 結果 |
|----------|----------|-----------|------|
| g7_flags テーマが非表示 | 表示されない | `themeHiddenAtBand(g7_flags, "Easy")`: minBand="Core", BAND_ORDER.indexOf("Easy")=0 < indexOf("Core")=1 → true | ✅ PASS |
| g20_flags テーマが非表示 | 表示されない | minBand="Challenge", 0 < 2 → true | ✅ PASS |
| eurozone_flags テーマが非表示 | 表示されない | minBand="Challenge", 0 < 2 → true | ✅ PASS |
| startTheme() ガード | URL直リンクでも起動不可 | `themeHiddenAtBand(theme, "Easy")` → true → early return | ✅ PASS |
| 次のテーマ提案にフラグなし | 完了画面で非表示 | `remaining` フィルター: `!themeHiddenAtBand(t, "Easy")` | ✅ PASS |
| animals/fruits/colors 表示 | 表示される | minBand 未設定 → `themeHiddenAtBand` = false | ✅ PASS |
| Easy カード枚数（animals=8枚） | 8枚 | `filterAndLimitCards()` ageBand="Easy" → `slice(0,8)` | ✅ PASS |

**Easy 総合**: ✅ PASS（7/7）

---

## 2. Core タブ（ふつう / 6–8歳）

| 確認項目 | 期待結果 | コード根拠 | 結果 |
|----------|----------|-----------|------|
| g7_flags テーマが表示される | 表示される | minBand="Core", BAND_ORDER.indexOf("Core")=1, indexOf("Core")=1 → 1 < 1 = false → visible | ✅ PASS |
| g20_flags テーマが非表示 | **表示されない** | minBand="Challenge", indexOf("Core")=1 < indexOf("Challenge")=2 → true → hidden | ✅ PASS *(PT-066で修正済み)* |
| eurozone_flags テーマが非表示 | **表示されない** | 同上 | ✅ PASS *(PT-066で修正済み)* |
| startTheme() g20 ガード | 直リンク起動不可 | `themeHiddenAtBand(g20_flags, "Core")` → true → return | ✅ PASS |
| 次のテーマ提案: g20 なし | g20 が提案されない | `remaining` フィルターで除外 | ✅ PASS |
| g7_flags → promptHint | "どこのくに？" | `getPromptHint()`: themeType="flag" & band≠"Challenge" | ✅ PASS |
| g7_flags Stage2 | 国名EN + 国名JA | `mapCard()` useCapital=false → wordEN=country_en | ✅ PASS |
| 評価ボタン Stage2のみ | ratings.hidden = stage < 2 | `renderPlay()` L426 | ✅ PASS |
| unknown/hard 再キュー | 動作維持 | `queueAdvance()` 変更なし | ✅ PASS |

**Core 総合**: ✅ PASS（9/9）

---

## 3. Challenge タブ（チャレンジ / 9–12歳）

| 確認項目 | 期待結果 | コード根拠 | 結果 |
|----------|----------|-----------|------|
| g7_flags テーマが表示される | 表示される | minBand="Core", indexOf("Challenge")=2 < indexOf("Core")=1 → false → visible | ✅ PASS |
| g20_flags テーマが表示される | 表示される | minBand="Challenge", 2 < 2 = false → visible | ✅ PASS |
| eurozone_flags テーマが表示される | 表示される | 同上 | ✅ PASS |
| g7_flags → promptHint | "首都は？" | `getPromptHint()`: band="Challenge" | ✅ PASS |
| g7_flags Stage2 | 首都EN/JA + 国名note | `renderCardByStage()` L471: `card.isFlag && "Challenge"` 分岐 | ✅ PASS |
| 次のテーマ提案: g20/eurozone あり | 提案される | `remaining` フィルター: `themeHiddenAtBand(t, "Challenge")` = false | ✅ PASS |
| セッション枚数 | 最大14枚 | `band.sessionLimit=14` | ✅ PASS |

**Challenge 総合**: ✅ PASS（7/7）

---

## 4. 共通動線（全帯共通）

| 確認項目 | 期待結果 | コード根拠 | 結果 |
|----------|----------|-----------|------|
| unknown → pos+2 に再キュー（最大2回） | 正しく挿入 | `queueAdvance()`: requeues < 2 条件 | ✅ PASS |
| hard → pos+4 に再キュー（最大1回） | 正しく挿入 | requeues < 1 条件 | ✅ PASS |
| ok/perfect → 再キューなし | splice なし | 条件外 | ✅ PASS |
| localStorage 永続化 | pictan_town 増加 | `incrementTownCompletions()` | ✅ PASS |
| 年齢帯切替後テーマ再描画 | `buildThemeCards()` 呼び出し | `buildAgeBandTabs()` click handler | ✅ PASS |
| missionDots も minBand 適用 | Core で g20/eurozone dot 非表示 | `buildMissionDots()` も `themeHiddenAtBand` 使用 | ✅ PASS |

**共通動線総合**: ✅ PASS（6/6）

---

## 5. 実装確認 — `themeHiddenAtBand()` ロジック検証

```
BAND_ORDER = ["Easy", "Core", "Challenge"]
indexOf("Easy")=0, indexOf("Core")=1, indexOf("Challenge")=2

theme \ band     | Easy | Core | Challenge
-----------------+------+------+----------
minBand 未設定   | show | show | show
minBand="Core"   | hide | show | show
minBand="Challenge"| hide| hide | show
```
期待動作と完全一致 ✅

---

## 6. 残存 TODO

なし（minBand 表示フィルター解消済み）

---

## 7. 総評

| 帯 | 結果 |
|----|------|
| Easy | ✅ 全項目PASS |
| Core | ✅ 全項目PASS（PT-066修正後）|
| Challenge | ✅ 全項目PASS |
| 共通動線 | ✅ 全項目PASS |

**PT-067 判定: PASS — 既知 TODO なし、Web 提出前回帰チェック完了**

---

*初版: 2026-03-05 Claude (PT-065)*
*更新: 2026-03-05 Claude (PT-067) — PT-066 minBand フィルター実装後に全項目再確認*
