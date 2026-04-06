# Town Asset Generation Plan

Last updated: 2026-03-06

## Goal
Enable continuous, quota-friendly image production for the town-growth experience without blocking engineering.

## Scope
This plan covers non-vocabulary visual assets used by the town experience:
- Town growth level visuals (12 levels)
- Reward overlays and celebration stamps
- Parent-child co-play mini icons
- Seasonal decoration variants
- Theme badges fallback quality pass (optional)

## Base art direction
- Felt-cute, handcrafted, warm, child-safe
- Soft light, simple composition, high readability on mobile
- No text in images
- No logos, no trademarks, no watermark

## Asset format and placement
- Format: PNG (transparent background preferred for overlays/icons)
- Size:
  - Town scenes: 1536x1024
  - Reward/overlay stamps: 1024x1024
  - Small UI icons: 512x512
- Color: sRGB
- Placement:
  - iOS: `apps/ios/Resources/Images/town/`
  - Web: `apps/web/assets/town/`

## Naming convention
- Town levels: `town_level_01.png` ... `town_level_12.png`
- Growth stamps: `town_reward_{name}.png`
- Co-play icons: `town_coplay_{name}.png`
- Seasonal overlays: `town_season_{spring|summer|autumn|winter}_{variant}.png`

## Priority batches
### Batch A (must-have MVP+)
1. `town_level_01` to `town_level_12`
2. `town_reward_built_tree`
3. `town_reward_new_house`
4. `town_reward_open_bakery`
5. `town_reward_fireworks`

### Batch B (engagement)
1. `town_coplay_highfive`
2. `town_coplay_show_parent`
3. `town_coplay_keep_going`
4. `town_coplay_proud`
5. `town_coplay_together`

### Batch C (seasonal starter)
1. `town_season_spring_flowers`
2. `town_season_summer_sun`
3. `town_season_autumn_leaves`
4. `town_season_winter_snow`

## Quota-safe operation
1. Produce in small batches (max 4-6 images/run when quota is unstable).
2. After each run, copy assets to both iOS and web paths.
3. Report done/missing IDs in `tasks/HANDOFF_LOG.md`.
4. Stop immediately on quota error and resume from remaining IDs only.

## Quality gate (must pass before marking done)
1. Visual consistency with felt-cute style
2. Recognizable at small size on mobile
3. No unsafe or brand-sensitive elements
4. Filenames exactly match this plan IDs
5. Both platform folders updated

## Handoff template (for image 담당)
- Completed IDs:
- Failed/blocked IDs:
- Quota status:
- Next run starting point:
- Notes (quality risks or rework candidates):
