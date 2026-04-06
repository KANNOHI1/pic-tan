# CLAUDE.md — Pic-tan

セッション開始時に自動読み込みされる唯一の地図。ここに書いてあることだけ読めば全体像がわかる。

---

## セッション開始手順

1. **`/recall`** を実行（`STATUS.md` の現在地・次アクションを確認）
2. 作業内容を1〜2行でサマリしてから開始

> クラッシュ・文脈喪失からの復帰時: STATUS.md が古ければ下記「ドキュメント地図」を順に参照する。

---

## プロジェクト概要（2行）

子ども（2〜6歳）向け英日単語学習iOSアプリ。「勉強した動物がまちに住み着く」Town-centricナラティブで差別化。Freemium（無料MVP + ¥480買い切り）。

---

## ドキュメント地図

### 現在地・タスク
| ファイル | 役割 |
|---|---|
| `STATUS.md` | **セッション開始時に必ず読む**。現在地・次アクション・未解決問題 |
| `tasks/TASK_BOARD.md` | タスク正本（唯一）。READY/IN_PROGRESS/DONEで管理 |
| `tasks/HANDOFF_LOG.md` | append-only。削除禁止 |

### 設計・方向性
| ファイル | 役割 |
|---|---|
| `docs/superpowers/specs/2026-03-19-pictan-redesign-design.md` | **現行デザイン仕様**（リデザイン承認済み）。画面構成・パートナーキャラ・まちの発展・カラーパレット |
| `docs/PROJECT_MEMORY.md` | 不変の製品方針・チーム構成・過去意思決定 |
| `docs/BRAND_CONCEPT.md` | ブランドトーン・メッセージング原則 |
| `docs/ios-design.md` | iOS/SwiftUI実装時のUI原則（実装時のみ参照） |

### 画像・アセット
| ファイル | 役割 |
|---|---|
| `docs/IMAGE_GENERATION_RUNBOOK.md` | 画像生成の公式スタイル・プロンプトテンプレート・配置ルール |
| `docs/TOWN_ASSET_GENERATION_PLAN.md` | まち画像のバッチ計画（Batch A完了・Batch B未着手） |
| `docs/IMAGE_COVERAGE_REPORT.md` | 現在の画像カバレッジ状況 |

### マーケティング
| ファイル | 役割 |
|---|---|
| `docs/marketing/gtm_strategy.md` | 90日GTMプラン・マネタイズ設計・ASO戦略 |
| `docs/marketing/evidence_brief.md` | 科学的根拠5本・許可/禁止表現一覧 |
| `docs/marketing/appstore_listing_v1_freeze.md`（`docs/release/`配下）| App Store掲載文v1.3 Freeze |

### 歴史記録（参照頻度低）
| ファイル | 役割 |
|---|---|
| `docs/STATE_SNAPSHOT.md` | PT-001〜DEV-003の完了記録。現状把握には`STATUS.md`で十分 |
| `docs/PRD-Pic-tan.md` | PRD v1.0（2026-03-16） |

---

## 現在のブロッカー（大事なので明記）

1. **PT-011 BLOCKED**: Mac/Xcode実機ビルド未検証 → `docs/MAC_BUILD_PLAYBOOK.md`
2. Apple Developer Program 未登録
3. サポートメール未作成
4. IMG-001 Batch B（co-play画像）: Codex承認待ち

---

## 役割分担

| 役割 | 担当 |
|---|---|
| 製作総指揮 | 菅野 宏勇（ユーザー） |
| 実装担当 | Claude Code（このファイルを読んでいるあなた） |
| 監督・レビュー | Codex |
| 画像生成 | Gemini（Antigravity） |

---

## テキスト出力ルール

コピペ時の余分なスペース・改行混入を避けるため、以下の条件では必ず `output/text.txt` に上書き出力する。チャット上への表示は不要（「ファイルに書いた」と一言でよい）。

**自動出力する条件:**
- 実行するコマンド（PowerShell/bash/CLIコマンド）
- メール・メッセージの下書き
- 他サービスに貼る文章（設定値・テンプレート等）
- ユーザーが「貼り付けたい」「送りたい」と示唆する文章

**ルール:**
- パス固定: `C:\Users\c6341\Documents\Projects\Pic-tan\output\text.txt`
- 常に上書き（appendしない）
- ファイルが存在しなければ作成する

---

## 絶対ルール（例外なし）

### 1. Skills を常に検討する
あらゆるタスクの前に、適用できるSkillがないか確認する。
- UIタスク → `writing-plans` → `subagent-driven-development`
- バグ → `systematic-debugging`
- 完了宣言前 → `verification-before-completion`
- コードレビュー → `requesting-code-review` / `codex`

### 2. デザイン案は必ずStitchでユーザーと確認してから実装する

**UIタスクの必須ワークフロー:**
```
1. Stitch でデザイン案を生成・ユーザーに提示
2. ユーザーと一緒にレビュー → 方向決め
3. writing-plans で実装計画を書く
4. subagent-driven-development で実装
```

**Stitch MCP ツール:**
- `mcp__stitch__generate_screen_from_text` — 新規画面生成
- `mcp__stitch__edit_screens` — 既存画面を修正
- `mcp__stitch__get_screen` — 生成済み画面を確認
- プロジェクトID: `14277669186111410059`

> コードを1行も書く前にStitchで見せること。ユーザーの確認なしに実装してはいけない。

---

## 実行ポリシー

1. タスクを1つ `IN_PROGRESS` に変えてから着手
2. 完了したら `tasks/HANDOFF_LOG.md` に追記 → `tasks/TASK_BOARD.md` を DONE に更新 → **`STATUS.md` を更新**
3. 役割を超えて実装した場合は HANDOFF_LOG に理由を記録
4. `tasks/TASK_BOARD.md` が唯一の正本。`docs/TASK_BOARD.md` は廃止済み（存在しない）

---

## Source of truth

- **現在地**: `STATUS.md`
- **タスク**: `tasks/TASK_BOARD.md`
- **現行デザイン**: `docs/superpowers/specs/2026-03-19-pictan-redesign-design.md`
- **製品方針**: `docs/PROJECT_MEMORY.md`
- **画像スタイル**: `docs/IMAGE_GENERATION_RUNBOOK.md`
