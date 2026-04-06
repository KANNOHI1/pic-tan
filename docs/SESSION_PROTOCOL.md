# SESSION_PROTOCOL

Last updated: 2026-03-04

## Start of session (restart-safe)
1. Pull latest changes.
2. Read in order:
   - `docs/START_HERE.md`
   - `docs/PROJECT_MEMORY.md`
   - `docs/STATE_SNAPSHOT.md`
   - `AGENTS.md`
   - `tasks/TASK_ID_POLICY.md`
   - `tasks/TASK_BOARD.md`
   - `tasks/HANDOFF_LOG.md`
3. Optional: run `scripts/session_bootstrap.ps1` for a one-command context dump.
4. Confirm role:
   - Codex: supervisor/reviewer/planner
   - Claude: implementer
5. Claim one `READY` task and set to `IN_PROGRESS` with owner/date.

## During session
- Keep scope to one task.
- Before creating any new task ID, generate it via `python scripts/next_task_id.py --prefix <DEV|MKT|IMG|SUP>`.
- Avoid editing files owned by another in-progress task.
- If overlap is unavoidable, document section ownership in handoff log.
- If implementation deviates from agreed role split, log rationale in handoff.

## End of session
1. Move task to `REVIEW` or `DONE`.
2. Append brief entry to `tasks/HANDOFF_LOG.md`:
   - changed files
   - verification performed
   - open risks / next action
3. Update `docs/STATE_SNAPSHOT.md` if project state changed.
