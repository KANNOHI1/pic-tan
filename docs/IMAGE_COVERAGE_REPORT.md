Total cards: 69
Last audited: 2026-03-20 (PIC-6)

[animals] cards=20
- iOS images present: 20/20
- Web images present: 20/20
- Missing for iOS generation: none
- Missing for web sync: none

[colors] cards=10
- iOS images present: 10/10
- Web images present: 10/10
- Missing for iOS generation: none
- Missing for web sync: none

[eurozone_flags] cards=8
- iOS images present: 8/8
- Web images present: 8/8
- Missing for iOS generation: none
- Missing for web sync: none
- Countries registered: Spain, Netherlands, Belgium, Austria, Portugal, Greece, Finland, Ireland
- Emojis in JSON: ✅ all 8 have emoji flag fallback

[fruits] cards=12
- iOS images present: 12/12
- Web images present: 12/12
- Missing for iOS generation: none
- Missing for web sync: none

[g20_flags] cards=12
- iOS images present: 12/12
- Web images present: 12/12
- Missing for iOS generation: none
- Missing for web sync: none
- Countries registered: Brazil, China, India, Russia, South Korea, Australia, Mexico, Indonesia, Saudi Arabia, Turkey, Argentina, South Africa
- Note: G20 has 19 members; EU-as-bloc, USA (in G7), Canada (in G7), Germany (in G7), France (in G7), Italy (in G7), UK (in G7) are represented in other themes. Japan (in G7) also covered. No gaps relative to current card scope.
- Emojis in JSON: ✅ all 12 have emoji flag fallback

[g7_flags] cards=7
- iOS images present: 7/7
- Web images present: 7/7
- Missing for iOS generation: none
- Missing for web sync: none

---
AUDIT SUMMARY (PIC-6, 2026-03-20)
Gap status: CLOSED — all 69 cards × 2 platforms fully covered.

The issue description referenced "19 missing flags (G20 x12, Eurozone x7)" reflecting the state prior
to Batch A image generation. Batch A is now complete and IMAGE_COVERAGE_REPORT.md was already updated
in a prior session. Fresh audit on 2026-03-20 confirms 0 missing images.

FUTURE: If Eurozone scope expands (e.g. add Italy, Luxembourg, Slovakia), new card entries + image
generation will be needed. Each new flag needs:
  Filename:   flag_eu_{2-letter ISO code}.png
  Dimensions: match existing flags (verify with: identify apps/ios/Resources/Images/g7_flags/flag_g7_jp.png)
  Style:      Refer to docs/IMAGE_GENERATION_RUNBOOK.md for prompt template
  Placement:  apps/web/assets/eurozone_flags/ AND apps/ios/Resources/Images/eurozone_flags/
  pbxproj:    Add new PNG reference to apps/ios/PicTan.xcodeproj/project.pbxproj
