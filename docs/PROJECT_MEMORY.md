# PROJECT_MEMORY

Last updated: 2026-03-17

## Stable project facts
- Project name (temporary): `ピクたん / Pic-Tan`
- Target platform: iOS App Store
- Governance: Codex supervises, Claude implements
- Single task source: `tasks/TASK_BOARD.md`
- Session history source: `tasks/HANDOFF_LOG.md`

## Why this project exists (do not forget)
- Build a child-first language app where kids learn EN/JA through cute images in short daily sessions.
- Shift the core value from "solving quizzes" to "parent-child co-play + town growth experience."
- Give parents a credible reason to choose the app: ad-free safety, short 3-minute habit, and evidence-aligned learning design.
- Maintain a global-ready direction (JP first, worldwide expansion), while keeping claims legally safe and non-exaggerated.

## Team naming memory (must stay stable)
- `ユーザー`: 製作総指揮 (executive producer)
- `Codex`: 監督 + supervisor + occasional coding
- `Claude Code`: coding implementer
- `画像担当`: Gemini image generation role (generation-capable environment required)
- `マーケ`: Gemini marketing/concept role

## Product decisions (already made)
- Initial age rating policy: 4+
- Product safety policy: ad-free experience for children
- Monetization model: Freemium (free MVP + one-time unlock, non-ad)
- Launch unlock price guideline: JPY 480 (final regional pricing TBD)
- Initial UI language: Japanese first
- Release region policy: worldwide
- Apple Developer Program: individual account (not yet created)
- Image production ops: while quota-limited, record-first workflow (theme specs and ID lists) is mandatory

## Brand and positioning baseline
- Product concept: daily 3-minute parent-child EN/JA learning habit
- Core learning style: cute image-first vocabulary exposure
- Primary buyer: parent/guardian
- Primary user: child
- Canonical concept document: `docs/BRAND_CONCEPT.md`

## Engineering status
- Core logic package exists (`packages/core`)
- iOS app scaffold and xcodeproj exist (`apps/ios`)
- JSON resources are bundled in app resources
- Windows environment cannot run Xcode; macOS needed for PT-011
- Web flow status: age-band routing and minBand theme gating are implemented (PT-066/067 accepted)
- Release docs status: App Store listing freeze/A-B measurement/review QA templates exist in `docs/release`
- UX stability status: web mojibake/screen-overlap issues fixed in DEV-002; premium FX toggle baseline added in DEV-003 (default OFF)
- ID governance status: new task IDs use prefixes (`DEV/MKT/IMG/SUP`) via `scripts/next_task_id.py` (manual numbering prohibited)

## Image pipeline status (2026-03-06 snapshot)
- Coverage report source: `docs/IMAGE_COVERAGE_REPORT.md`
- Total cards: 69
- Missing image IDs: 0
- Coverage: animals/colors/fruits/g7_flags/g20_flags/eurozone_flags are all 100% on both iOS and Web
- Operation rule remains: if new themes are added, generate only missing IDs from the coverage report
- Next image phase source of truth: `docs/TOWN_ASSET_GENERATION_PLAN.md` (town-centric assets)

## Deferred backlog (do after town-centric redesign PT-075..080)
- Build `Imagen API` execution script pipeline (auth, retries, save PNG, placement to iOS/Web, coverage check integration), then re-handoff image ops from chat-only role to CLI role
- Town-centric UI prioritization pass (make town growth the primary visual hierarchy across Home/Play/Complete)
- Strengthen parent-facing UX copy wiring (3 pillars in Home/Complete/parent panel)
- First-run onboarding optimization (age-band select -> start in minimal taps)
- Streak and continuity visualization polish
- Sound/motion quality pass with child-safe defaults and toggle
- Content quality lint (age-band consistency, wording and difficulty checks)
- Parent explainer screen (why image-first, why 3 minutes; allowed wording only)
- iOS port-prep refactor for web logic added in PT-037..067

## Never forget rules
1. Append-only for `tasks/HANDOFF_LOG.md`.
2. `tasks/TASK_BOARD.md` is canonical.
3. Update `docs/STATE_SNAPSHOT.md` when project state changes.
4. If role boundary is crossed, explain why in handoff log.
5. New task IDs must follow `tasks/TASK_ID_POLICY.md` and be generated via `scripts/next_task_id.py`.
