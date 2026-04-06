#!/usr/bin/env python3
"""
Get next task ID for a prefix from tasks/TASK_BOARD.md.

Usage:
  python scripts/next_task_id.py --prefix DEV
  python scripts/next_task_id.py --prefix MKT
  python scripts/next_task_id.py --prefix IMG
  python scripts/next_task_id.py --prefix SUP
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


VALID_PREFIXES = {"DEV", "MKT", "IMG", "SUP"}
ID_RE = re.compile(r"\|\s*([A-Z]{3})-(\d{3})\s*\|")


def next_id(task_board: Path, prefix: str) -> str:
    text = task_board.read_text(encoding="utf-8", errors="replace")
    max_num = 0
    for m in ID_RE.finditer(text):
        pfx, num = m.group(1), int(m.group(2))
        if pfx == prefix and num > max_num:
            max_num = num
    return f"{prefix}-{max_num + 1:03d}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--prefix", required=True, help="DEV/MKT/IMG/SUP")
    parser.add_argument(
        "--task-board",
        default="tasks/TASK_BOARD.md",
        help="Path to task board markdown",
    )
    args = parser.parse_args()

    prefix = args.prefix.upper()
    if prefix not in VALID_PREFIXES:
        raise SystemExit(f"Invalid prefix: {prefix}. Use one of {sorted(VALID_PREFIXES)}")

    board = Path(args.task_board)
    if not board.exists():
        raise SystemExit(f"Task board not found: {board}")

    print(next_id(board, prefix))


if __name__ == "__main__":
    main()
