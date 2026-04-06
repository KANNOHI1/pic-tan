# AGENTS.md (Pic-tan)

This file defines how Codex and Claude Code collaborate in this project.

## Governance Model
- Supervisor: Codex (GPT-Codex)
- Implementer: Claude Code
- Decision owner for architecture and task sequencing: Codex
- Primary code implementation owner: Claude Code

## Goal
Deliver the iOS MVP quickly without merge conflicts or duplicated work.

## Role split
- Codex:
  - project structure and operating rules
  - domain logic contracts and test strategy
  - task planning, review, and acceptance
  - handoff integrity and conflict prevention
- Claude Code:
  - app/UI implementation in `apps/ios/**`
  - integration of core models into screens and flows
  - iterative UX implementation and refinement
- Shared ownership:
  - architecture decisions
  - content data contracts
  - release checklist

## Ground rules
1. Do not rewrite someone else's in-progress file unless the task board says it is safe.
2. Keep commits and edits small and scoped to one task.
3. Update task status immediately when starting/finishing work.
4. Record decisions and unresolved issues in the handoff log.
5. If scope changes, update docs first (`docs/project-scope.md`) then code.
6. Preserve prior handoff entries when editing `tasks/HANDOFF_LOG.md`.
7. On any restart, recover context from `docs/START_HERE.md` and `docs/PROJECT_MEMORY.md` before coding.

## Task workflow
1. Open `tasks/TASK_BOARD.md`.
2. Move one `READY` item to `IN_PROGRESS` with owner and date.
3. Implement only that item.
4. Move to `REVIEW` or `DONE`.
5. Append summary in `tasks/HANDOFF_LOG.md`.

## Memory hygiene
- Keep `docs/PROJECT_MEMORY.md` updated when user-level decisions change.
- Keep `docs/STATE_SNAPSHOT.md` updated when implementation state changes.
- Use `scripts/session_bootstrap.ps1` for fast restart context.

## File ownership (default)
- `apps/ios/**`: Claude-first edits
- `packages/core/**`: Codex-first edits
- `packages/content/**`: shared
- `docs/**` and `tasks/**`: shared

## Conflict prevention
- If both agents need the same file, split by section and document section ownership in the handoff log.
- Prefer adding new files over large rewrites.
- Run format/lint/tests relevant to touched areas before handoff.

## Definition of done (MVP task)
- Acceptance criteria in task board are satisfied.
- Any changed behavior is documented.
- Minimal verification steps are recorded.
