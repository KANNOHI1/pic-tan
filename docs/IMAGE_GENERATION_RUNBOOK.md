# Image Generation Runbook

Last updated: 2026-03-06

## Objective
Keep image generation running in batches without blocking app development.

## Source of truth
- Vocabulary IDs: `packages/content/data/ja-JP/*.json`
- Coverage check script: `scripts/check_image_coverage.py`
- Latest status report: `docs/IMAGE_COVERAGE_REPORT.md`
- Flags/maps guideline: `docs/IMAGE_GENERATION_GUIDE_FLAGS_MAPS.md`
- Town asset plan: `docs/TOWN_ASSET_GENERATION_PLAN.md`

## Asset spec (fixed)
- Format: PNG
- Size: 1024x1024
- Color: sRGB
- Composition: centered subject, plain pastel background
- Style: felt doll, warm soft light, child-safe expression
- No text, no logo, no watermark
- Naming: `{id}.png` (must match card `id`)

## Prompt template
`A cute felt doll style {subject}, handcrafted wool texture, soft studio lighting, centered composition, plain pastel background, child-friendly, no text, no logo, high detail, square 1024x1024.`

## Current status
- Vocabulary card images (MVP 69 cards) are complete:
  - animals / fruits / colors / g7_flags / g20_flags / eurozone_flags
- Active image work is now town-centric assets (see `docs/TOWN_ASSET_GENERATION_PLAN.md`).

## Placement
- iOS: `apps/ios/Resources/Images/{theme}/{id}.png`
- Web: `apps/web/assets/{theme}/{id}.png`

## Batch workflow
1. Generate only missing IDs from `docs/IMAGE_COVERAGE_REPORT.md`.
2. Save with exact `{id}.png` name.
3. Re-run coverage check:
   - `python scripts/check_image_coverage.py --write-report docs/IMAGE_COVERAGE_REPORT.md`
4. Hand off updated missing list to next batch.

## Expansion backlog (after MVP 42 cards complete)
1. vehicles
2. foods
3. body parts
4. daily objects
5. actions (verbs)

Add each new theme to `packages/content/data/ja-JP/*.json` first, then generate by ID.
