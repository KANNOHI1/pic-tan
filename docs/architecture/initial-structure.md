# Initial Structure

## App layer (`apps/ios`)
SwiftUI app, navigation, local persistence wiring, animation and character presentation.

## Core layer (`packages/core`)
Pure logic modules for:
- card mode state
- session progression
- review queue calculation (initial simplified version)

## Content layer (`packages/content`)
Locale-specific content payloads and pictogram metadata.

## Data contract draft
Each vocabulary entry should have:
- `id`
- `word_en`
- `word_ja`
- `theme`
- `difficulty`
- `pictogram_prompt`
- `audio_key` (optional)

## Quality gates (initial)
- Content JSON schema check script
- Unit tests for core scheduling logic
- Manual smoke flow in iOS simulator
