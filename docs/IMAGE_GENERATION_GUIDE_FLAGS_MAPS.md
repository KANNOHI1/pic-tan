# Image Guide: Flags and Maps

Last updated: 2026-03-05

## Purpose
Pre-record production rules for new general-knowledge themes while image generation is quota-limited.

## Scope
- `g7_flags`
- `g20_flags`
- `eurozone_flags`
- `japan_prefectures` (shape/silhouette first)
- `us_states` (shape/silhouette first)
- `*_capitals` (text-first in v1, landmark images only in v2)

## Core policy
1. Ship text-first if image quality or legal risk is unclear.
2. Prefer silhouette/icon assets over photoreal city images.
3. Keep visual style child-safe and consistent with felt/pastel direction where possible.

## Do and Don't
### Do
- Use exact card `id` naming and folder rules.
- Keep background simple, high contrast, no text in image.
- Use neutral educational framing (no political message).
- Use public-domain-safe inputs for country flags and map outlines.

### Don't
- Do not include copyrighted mascot/artwork or stock watermarks.
- Do not add flag labels or country names inside image.
- Do not use disputed-border visualizations in v1.
- Do not use "real city photo look" for capitals in v1.

## Theme-specific specs
### Flags (`g7_flags`, `g20_flags`, `eurozone_flags`)
- Asset type: flat icon style or felt-cut style flag tile.
- Composition: single flag centered, soft neutral backdrop.
- Quality gate: recognizable at small size (mobile card view).

### Maps (`japan_prefectures`, `us_states`)
- Asset type: clean silhouette with one accent color.
- No labels, no neighboring region details in v1.
- Keep stroke weight and visual density uniform across set.

### Capitals (`*_capitals`)
- v1: no image dependency; quiz is text-led (`country -> capital`).
- v2: only iconic landmark-style illustrations for globally obvious cities.
- If ambiguity exists, keep text-only.

## Naming and placement
- File name: `{id}.png`
- iOS: `apps/ios/Resources/Images/{theme}/{id}.png`
- Web: `apps/web/assets/{theme}/{id}.png`

## テーマアイコン（バッジ画像）— PT-085 追加

テーマカード先頭に表示される丸形バッジ画像。個別カードとは別管理。

| テーマ | 現在 | 差し替え先 (PNG) |
|--------|------|------------------|
| g7_flags | `apps/web/assets/theme-icons/theme_g7.svg` (SVG仮) | `apps/web/assets/theme-icons/theme_g7.png` |
| g20_flags | `apps/web/assets/theme-icons/theme_g20.svg` (SVG仮) | `apps/web/assets/theme-icons/theme_g20.png` |
| eurozone_flags | `apps/web/assets/theme-icons/theme_eurozone.svg` (SVG仮) | `apps/web/assets/theme-icons/theme_eurozone.png` |

**差し替え手順（ノーコード）**:
1. PNG を `apps/web/assets/theme-icons/` に配置（ファイル名は上記に合わせる）
2. `app.js` の `THEME_ICON_BASE` は変更不要
3. `themeIcon` のパスに `.svg` → `.png` を変更（1箇所/テーマ）

**バッジ画像要件**:
- サイズ: 64×64px 以上（正方形推奨）
- 背景: 透過 PNG
- モチーフ: テキストなし、子ども向け丸形バッジ
- G7: 7要素の記号モチーフ（国旗の複製不可）
- G20: グローブ／20点モチーフ
- ユーロ圏: 星輪＋グローブ抽象（EU旗の複製は不可）

## Batch operation memo (quota reset day)
1. Generate only IDs listed as missing in `docs/IMAGE_COVERAGE_REPORT.md`.
2. Save by exact ID, then run:
   - `python scripts/check_image_coverage.py --write-report docs/IMAGE_COVERAGE_REPORT.md`
3. Report `done/missing` counts by theme in handoff.

