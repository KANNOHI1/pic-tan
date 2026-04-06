#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


def load_cards(content_root: Path) -> dict[str, list[dict]]:
    cards_by_theme: dict[str, list[dict]] = {}
    for path in sorted(content_root.glob("*.json")):
        theme = path.stem
        payload = json.loads(path.read_text(encoding="utf-8-sig"))
        if not isinstance(payload, list):
            raise ValueError(f"{path} must be an array")
        entries: list[dict] = []
        for idx, card in enumerate(payload):
            if not isinstance(card, dict):
                raise ValueError(f"{path}:{idx} must be an object")
            card_id = card.get("id")
            if not isinstance(card_id, str) or not card_id.strip():
                raise ValueError(f"{path}:{idx} missing valid 'id'")
            entries.append(card)
        cards_by_theme[theme] = entries
    return cards_by_theme


def existing_images(base_dir: Path) -> set[str]:
    if not base_dir.exists():
        return set()
    return {p.stem for p in base_dir.rglob("*.png")}


def summarize(
    cards_by_theme: dict[str, list[dict]],
    ios_images: set[str],
    web_images: set[str],
) -> tuple[list[str], int]:
    lines: list[str] = []
    missing_total = 0

    grand_total = sum(len(cards) for cards in cards_by_theme.values())
    lines.append(f"Total cards: {grand_total}")
    lines.append("")

    for theme, cards in cards_by_theme.items():
        ids = [c["id"] for c in cards]
        missing_ios = [cid for cid in ids if cid not in ios_images]
        missing_web = [cid for cid in ids if cid not in web_images]
        missing_total += len(missing_ios)

        lines.append(f"[{theme}] cards={len(ids)}")
        lines.append(f"- iOS images present: {len(ids) - len(missing_ios)}/{len(ids)}")
        lines.append(f"- Web images present: {len(ids) - len(missing_web)}/{len(ids)}")
        if missing_ios:
            lines.append(f"- Missing for iOS generation ({len(missing_ios)}):")
            for cid in missing_ios:
                lines.append(f"  - {cid}")
        else:
            lines.append("- Missing for iOS generation: none")
        if missing_web:
            lines.append(f"- Missing for web sync ({len(missing_web)}):")
            for cid in missing_web:
                lines.append(f"  - {cid}")
        else:
            lines.append("- Missing for web sync: none")
        lines.append("")

    return lines, missing_total


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Check image coverage against content card IDs."
    )
    parser.add_argument(
        "--locale",
        default="ja-JP",
        help="Locale folder under packages/content/data (default: ja-JP)",
    )
    parser.add_argument(
        "--write-report",
        default="",
        help="Optional output file path for markdown report",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    content_root = repo_root / "packages" / "content" / "data" / args.locale
    ios_images_root = repo_root / "apps" / "ios" / "Resources" / "Images"
    web_images_root = repo_root / "apps" / "web" / "assets"

    cards_by_theme = load_cards(content_root)
    ios_images = existing_images(ios_images_root)
    web_images = existing_images(web_images_root)
    lines, missing_total = summarize(cards_by_theme, ios_images, web_images)

    report = "\n".join(lines)
    print(report)
    print(f"Missing image IDs total: {missing_total}")

    if args.write_report:
        out_path = repo_root / args.write_report
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(report + "\n", encoding="utf-8")
        print(f"Wrote report: {out_path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
