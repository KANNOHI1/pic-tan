#!/usr/bin/env python3
"""
Content validation script for Pic-tan vocabulary JSON files.
Schema v2: supports both legacy (word_en/word_ja/emoji)
and new (answerEn/answerJa/assetId) field names.
ageBand and promptType are required for all cards.
Flag themes (*_flags) additionally require country_* and capital_* fields.
"""
import json
import sys
from pathlib import Path

VALID_AGE_BANDS    = {"Easy", "Core", "Challenge"}
VALID_PROMPT_TYPES = {"image", "text"}

REQUIRED_FIELDS = {
    "id":         str,
    "theme":      str,
    "difficulty": int,
    "ageBand":    str,
    "promptType": str,
}

# Additional required fields for flag themes
FLAG_REQUIRED_FIELDS = {
    "country_en": str,
    "country_ja": str,
    "capital_en": str,
    "capital_ja": str,
}


def is_flag_entry(entry: dict) -> bool:
    theme = entry.get("theme", "")
    return isinstance(theme, str) and theme.endswith("_flags")


def _has_word_en(entry: dict) -> bool:
    return bool(entry.get("word_en") or entry.get("answerEn"))


def _has_word_ja(entry: dict) -> bool:
    return bool(entry.get("word_ja") or entry.get("answerJa"))


def _has_emoji(entry: dict) -> bool:
    return bool(entry.get("emoji") or entry.get("assetId"))


def validate_entry(entry: dict, index: int, file_path: Path) -> list[str]:
    errors: list[str] = []

    # Required typed fields (all cards)
    for field, expected_type in REQUIRED_FIELDS.items():
        if field not in entry:
            errors.append(f"{file_path}:{index} missing required field '{field}'")
            continue
        value = entry[field]
        if not isinstance(value, expected_type):
            errors.append(
                f"{file_path}:{index} field '{field}' expected "
                f"{expected_type.__name__}, got {type(value).__name__}"
            )
        if isinstance(value, str) and not value.strip():
            errors.append(f"{file_path}:{index} field '{field}' must not be empty")

    # Constrained string values
    if isinstance(entry.get("ageBand"), str) and entry["ageBand"] not in VALID_AGE_BANDS:
        errors.append(
            f"{file_path}:{index} 'ageBand' must be one of {sorted(VALID_AGE_BANDS)}, "
            f"got '{entry['ageBand']}'"
        )

    if isinstance(entry.get("promptType"), str) and entry["promptType"] not in VALID_PROMPT_TYPES:
        errors.append(
            f"{file_path}:{index} 'promptType' must be one of {sorted(VALID_PROMPT_TYPES)}, "
            f"got '{entry['promptType']}'"
        )

    # Answer fields: at least one of each pair required
    if not _has_word_en(entry):
        errors.append(f"{file_path}:{index} must have 'word_en' or 'answerEn'")
    if not _has_word_ja(entry):
        errors.append(f"{file_path}:{index} must have 'word_ja' or 'answerJa'")
    if not _has_emoji(entry):
        errors.append(f"{file_path}:{index} must have 'emoji' or 'assetId'")

    if "difficulty" in entry and isinstance(entry["difficulty"], int) and entry["difficulty"] < 1:
        errors.append(f"{file_path}:{index} field 'difficulty' must be >= 1")

    # PT-054: Flag themes require country_* and capital_* fields
    if is_flag_entry(entry):
        for field, expected_type in FLAG_REQUIRED_FIELDS.items():
            if field not in entry:
                errors.append(
                    f"{file_path}:{index} flag entry missing required field '{field}'"
                )
                continue
            value = entry[field]
            if not isinstance(value, expected_type):
                errors.append(
                    f"{file_path}:{index} flag field '{field}' expected "
                    f"{expected_type.__name__}, got {type(value).__name__}"
                )
            if isinstance(value, str) and not value.strip():
                errors.append(
                    f"{file_path}:{index} flag field '{field}' must not be empty"
                )

    return errors


def validate_file(file_path: Path) -> list[str]:
    try:
        payload = json.loads(file_path.read_text(encoding="utf-8-sig"))
    except Exception as exc:
        return [f"{file_path}: failed to parse JSON ({exc})"]

    if not isinstance(payload, list):
        return [f"{file_path}: root must be an array"]

    errors: list[str] = []
    seen_ids: set[str] = set()
    for index, entry in enumerate(payload):
        if not isinstance(entry, dict):
            errors.append(f"{file_path}:{index} entry must be an object")
            continue
        errors.extend(validate_entry(entry, index, file_path))

        card_id = entry.get("id")
        if isinstance(card_id, str):
            if card_id in seen_ids:
                errors.append(f"{file_path}:{index} duplicate id '{card_id}'")
            seen_ids.add(card_id)

    return errors


def discover_content_files() -> list[Path]:
    root = Path(__file__).resolve().parents[1]
    content_dir = root / "packages" / "content" / "data"
    return sorted(content_dir.glob("*/*.json"))


def main() -> int:
    files = discover_content_files()
    if not files:
        print("No content files found.")
        return 1

    all_errors: list[str] = []
    for file_path in files:
        all_errors.extend(validate_file(file_path))

    if all_errors:
        print("Validation failed:")
        for error in all_errors:
            print(f"- {error}")
        return 1

    print(f"Validation passed for {len(files)} files.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
