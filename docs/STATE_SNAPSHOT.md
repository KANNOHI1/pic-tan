# State Snapshot

Last updated: 2026-04-07

## Delivery status
- Done:
  - PT-001 (Codex): core Swift domain models
  - PT-002..PT-005 (Claude): iOS loader + card study UI + rating actions + mascot reactions
  - PT-006 (Codex): review queue tests
  - PT-007 (Codex): content validation script
  - PT-008 (Claude): Xcode project and local Swift package wiring
  - PT-009 (Claude): JSON bundle resources connected to app target
  - PT-010 (Codex): supervisor/implementer governance and restart-safe docs
  - PT-019 (Codex): browser preview app for collaborative verification
  - PT-020..PT-027 (Claude): playable kid-focused upgrade (emoji cards, home/theme flow, new content/themes, web preview refresh)
  - PT-028 (Codex): content validator updated for required `emoji` field
  - PT-029 (Claude, reviewed by Codex): decoding tests for `emoji` + web fetch absolute-path fix
  - PT-031 (Antigravity): marketing strategy & GTM plan — user approved
  - PT-032..PT-034 (Claude, reviewed by Codex): concept-aligned UX/playstyle reboot and parent trust UI layer
  - PT-036 (Antigravity): parent evidence brief & claims table — user approved
  - PT-045..PT-050 (Claude, reviewed by Codex): age-band UX, content schema v2, flags/capitals v1 themes, and integration QA
  - PT-051..PT-055 (Claude, reviewed by Codex): flag card data restructure (country_*/capital_*), Core=国名/Challenge=首都 quiz branching, validator update
  - PT-056..PT-059 (Antigravity): App Store submission package (metadata, screenshots, preflight, packaging)
  - PT-060..PT-062 (Antigravity): App Store listing freeze, A/B measurement spec, Apple review QA templates
  - PT-063..PT-065 (Claude): Mac build handoff doc, task number conflict resolution, web regression report
  - PT-066..PT-067 (Claude, reviewed by Codex): minBand gating implementation and regression report refresh (Core g20/eurozone hidden)
  - PT-068..PT-070 (Antigravity): parent flag difficulty guide, interim screenshot copy adoption (JP/US), pricing communication guide
  - PT-071..PT-074 (Claude, reviewed by Codex): web image fallback, image sync check, and coverage report updating
  - PT-075..PT-078 (Antigravity): town growth UX messaging, co-play guidelines, 12-stage reward catalog
  - PT-083..PT-085 (Antigravity): town-centric store materials update, parent LP structure, 3-month seasonal campaign calendar
  - PT-079..PT-082 (Claude): town-centric UX implementation (12-level growth, parent co-play flow, streak, unified town copy)
  - PT-086..PT-090 (Claude): theme badge SVG implementation, image-first priority rendering, badge naming guide update, QA
  - PT-091..PT-094 (Antigravity): US App Store wording risk fix, merged Town-centric App Store freeze, seasonal operations brief, town UX KPI design
  - MKT-001..MKT-004 (Antigravity): Actionable marketing brief prep (Metadata draft, Screenshot UI brief, Event specs for KPIs, Low payload operations base)
  - MKT-005..MKT-007 (Antigravity): Final integrated App Store v1.3 freeze, seasonal ops template, KPI review script
  - DEV-001 (Claude): card image prominence update (larger media in study card flow)
  - DEV-002 (Claude): app.js UTF-8 stabilization and mojibake recovery; play/complete screen-state stability restored
  - DEV-003 (Claude): `enablePremiumFx` feature flag baseline (default OFF), complete-screen-only lightweight FX path
  - DEV-004 (Codex): web UI/UX polish pass in `apps/web` (screen fade transitions, 2-tap card reveal, partner-specific motion, completion celebration, sequential heart fill, reduced-motion support)
- Current product state:
  - Source code scaffold is complete
  - Build/run verification is release-critical and blocked until Mac access is available
  - Browser preview (`apps/web`) is available for collaborative flow checks without Xcode
  - Brand positioning baseline is documented in `docs/BRAND_CONCEPT.md`
  - Marketing strategy & GTM plan approved (Antigravity artifact)
  - Parent evidence design (Scientific claims/App Store wording) approved (Antigravity artifact)
  - Monetization confirmed: Freemium (free MVP + one-time ¥480 unlock)
  - App Store metadata and screenshot tracking strategy (A/B) are fully packaged into `docs/release/` and are documentation-ready for submission operations (PT-056~059).
  - Town-centric experience redesign is now implemented in web preview (growth-first messaging and co-play flow)
  - Web preview now includes animated screen transitions, card entrance/reveal polish, partner-specific town motion, and complete-screen celebration effects with reduced-motion fallback
  - Product direction is fixed to Town-centric: "learn while growing a town" as primary user experience, not score-centric quiz messaging
  - Image pipeline is quota-constrained; record-first asset planning is documented for flags/maps expansion
  - Web preview now includes age-band routing and geography quiz themes (g7/g20/eurozone flags)
  - MVP image coverage is now 100% on both iOS/Web (69/69, no missing IDs)

## Working software map
- App files: `apps/ios/**`
- Browser preview: `apps/web/**`
- Core package: `packages/core/**`
- Content source: `packages/content/data/**`
- iOS bundled resources: `apps/ios/Resources/**`

## Current blockers/decisions
1. PT-011 is blocked: first Mac/Xcode simulator run cannot be executed on Windows.
2. Apple Developer Program (individual) signup is pending.
3. Support email must be created before App Store submission.
4. ~~App Store metadata/legal artifacts are not drafted yet.~~ → App Store submission package finalized (`docs/release/` artifacts). PT-016 is done as documentation, while actual store submission remains blocked by account/device prerequisites.
5. Monetization model confirmed: Freemium (free MVP + one-time ¥480 unlock).

## Immediate next recommended task
- **Gate 1**: Execute PT-011 on Mac — highest-priority release gate. Handoff doc: `docs/release/mac_build_handoff.md`
- **Gate 2**: After PT-011 passes, port PT-037~055 web features to iOS (3-stage display, age-band, flag quiz logic)
- **Gate 3**: PT-012 App Store submission — documentation ready in `docs/release/`, pending Apple Developer account + support email
