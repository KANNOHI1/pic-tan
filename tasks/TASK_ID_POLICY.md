# Task ID Policy

Last updated: 2026-03-06

## Why this exists
Multiple agents worked in parallel and collided on `PT-xxx` IDs.  
From now on, ID namespaces are separated by role to make collisions impossible.

## Rule (effective immediately)
- Legacy `PT-xxx` IDs are historical and stay as-is.
- New tasks must use one of these prefixes:
  - `SUP-xxx`: supervisor/governance/orchestration tasks (Codex)
  - `DEV-xxx`: engineering implementation tasks (Claude Code)
  - `MKT-xxx`: marketing/concept/store copy tasks (マーケ)
  - `IMG-xxx`: image generation/asset pipeline tasks (画像担当)

## Numbering
- `xxx` is a zero-padded 3-digit sequence per prefix.
- Example: `DEV-001`, `DEV-002`, `MKT-001`.
- Never reuse an ID, even if task is canceled.

## Source of truth
- `tasks/TASK_BOARD.md` is the only source for assigned IDs.
- Before creating a task, generate next ID from current board using:
  - `python scripts/next_task_id.py --prefix DEV`
  - `python scripts/next_task_id.py --prefix MKT`
  - `python scripts/next_task_id.py --prefix IMG`
  - `python scripts/next_task_id.py --prefix SUP`

## Assignment protocol
1. Supervisor decides owner.
2. Supervisor generates ID with script.
3. Task is appended to `TASK_BOARD.md`.
4. Agent executes and reports with the same ID.

## Emergency fallback
If script is unavailable, manually scan `TASK_BOARD.md` for the highest ID in that prefix and increment by 1.
