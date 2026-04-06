# Operating Model

Last updated: 2026-03-05

## Team Structure
- Executive Producer (`ユーザー`): final direction and priority decisions
- Director + Supervisor (`Codex`): planning, review, acceptance, and occasional coding
- Implementer (`Claude Code`): app and feature coding
- Image Lead (`画像担当` / Gemini): visual asset generation
- Marketing Lead (`マーケ` / Gemini): concept and go-to-market strategy

## Naming Rules
- Use `画像担当` (not any other nickname) for Gemini image work.
- Use `マーケ` for Gemini marketing/concept work.

## Authority
- Codex is the supervisor for planning, review, architecture consistency, and acceptance.
- Claude Code is the implementer for feature delivery.

## Responsibility map
- Codex:
  - maintains governance and project state documents
  - defines and updates task sequencing
  - validates implementation against acceptance criteria
  - owns core domain package (`packages/core`) and automation (`scripts`)
- Claude:
  - implements app behavior and screens (`apps/ios`)
  - wires domain models to UI flows
  - reports implementation status in handoff log

## Decision flow
1. Codex defines or updates tasks.
2. Claude claims and implements tasks.
3. Codex reviews report and state, then accepts/redirects.
4. Both update handoff and snapshot docs.

## Non-negotiable rules
- `tasks/TASK_BOARD.md` is the only task source.
- Task ID issuance must follow `tasks/TASK_ID_POLICY.md` (no direct manual `PT-xxx` issuance for new tasks).
- Preserve handoff history; append only.
- If role boundary is crossed, record reason in `tasks/HANDOFF_LOG.md`.
