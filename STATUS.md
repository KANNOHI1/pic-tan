# PROGRESS — Pic-tan

> このファイルはセッション末に更新する。セッション開始時に最初に読む。

---

## 現在地

Web プレビューは town-centric UX として完成済み。iOS コードはスキャフォールド完了。
Mac実機ビルド（PT-011）待ちで、App Store申請もアカウント登録待ちのためブロック中。
Batch A 街画像（全16枚）は生成・配置済みで、Codex によるレビュー待ち。

---

## 完了済み

- PT-001〜PT-090: iOS基盤・Webプレビュー・コンテンツ・UI全面構築（3段階表示・年齢帯・国旗クイズ・まち成長12段階・親子共遊・streak）
- MKT-001〜007: App Storeメタデータ v1.3 Freeze・スクショブリーフ・KPI設計・季節運用テンプレ
- DEV-001: カード画像強化（Stage別サイズ拡大）
- DEV-002: app.js UTF-8 完全安定化（文字化け除去）
- DEV-003: `enablePremiumFx` フラグ実装（完了画面のみ、デフォルト OFF）
- IMG-001 Batch A: 街画像 town_level_01〜12 + town_reward ×4 生成・iOS/Web 配置済み

---

## 次にやること

1. **Gate 1（最優先）**: Mac で PT-011 実行 → `docs/release/mac_build_handoff.md` 参照
2. Codex による IMG-001 Batch A レビュー承認 → Batch B（co-play 画像等）着手
3. **Gate 2**: PT-011 通過後、Web 実装の3段階/年齢帯/国旗クイズロジックを iOS にポート
4. **Gate 3**: Apple Developer Program 登録 + サポートメール作成 → App Store 申請

---

## 未解決の問題・懸案

- [ ] PT-011 BLOCKED: Mac/Xcode 実機ビルド未検証（Windows環境のため）
- [ ] Apple Developer Program（個人）未登録
- [ ] サポートメール未作成（App Store 申請必須）
- [ ] g20 ×12 / eurozone ×7 の国旗画像が不足（コンテンツ登録済み、画像未生成）
- [ ] IMG-001 Batch B（co-play・bonus画像）は Codex 承認待ち

---

## 直近の判断メモ

| 日付 | 決定 | 理由 |
|---|---|---|
| 2026-03-05 | 収益モデルを Freemium（無料MVP + ¥480 買い切り）に確定 | ユーザー承認 |
| 2026-03-05 | 製品方向を Town-centric に固定 | スコア訴求より「まちを育てる達成感」が差別化になるため |
| 2026-03-05 | App Store Listing v1.3 Freeze（JP=パターンA / US=パターンB） | JP親安心訴求 / US学習効果訴求の地域差別化 |
| 2026-03-11 | enablePremiumFx = false でリリース（DEV-003） | 演出テスト前に船を出さないため；フラグ1行で ON 可能 |

---

## セッション履歴（直近3件）

### 2026-03-20 — Claude (Ultra Simple リデザイン)
- フラッシュカード Ultra Simple リデザイン完了（commit: 7b197aa）
  - CSS: カード枠なし・画像220px・英日同サイズ/同色（2.25rem/charcoal）・「こたえは？」大きく
  - JS: 3ステージ→2ステージ（1タップで英日同時表示）
- Stitch MCP でデザイン案5案を探索、「Ultra Simple（案5）」を採用
- ボタンはみ出しバグ修正（#nextDayBtn width: calc(100% - 32px)）
- CLAUDE.md に「絶対ルール」（Skills常時検討・Stitch確認必須）を追加

### 2026-03-20 — Claude (PIC-5, PIC-6, PIC-7)
- PIC-5: 保護者パネル完成。StreakStore / ParentSettings を PicTanCore に追加。HomeView に計算問題ゲート・streak バナー・年齢帯ピッカー・まち住民表示を実装。
- PIC-6: 旗画像監査。G20×12 / Eurozone×8 すべて存在確認。ギャップなし。IMAGE_COVERAGE_REPORT.md 更新。
- PIC-7: デバイス QA テスト計画を docs/release/device_qa_plan.md に作成（10セクション）。Gate 3 申請前必須。

### 2026-03-20 — Claude (PIC-2, PIC-3, PIC-4)
- PIC-4: TownResident / TownState / TownStore を PicTanCore に追加。12段階レベル・仲良し度・まちへの引越し・リワードスタンプ4種・UserDefaults永続化。テスト追加。

### 2026-03-20 — Claude (PIC-2, PIC-3)
- PIC-2: iOS scaffold audit完了。全8 Swift + PicTanCore 6ファイルが production-quality、スタブなし。PT-011 simulator build ready。
- PIC-3: PicTanCore に3段階表示フロー追加。CardRevealStage / AgeBand / SessionProgress 新規追加、StudySessionState 拡張、ReviewQueueSeeder.buildSession 追加。テスト25件記述。

### 2026-03-19 — Claude
- 記憶ゼロからの復帰。STATE_SNAPSHOT・TASK_BOARD・HANDOFF_LOG を読んで現況把握。
- メモリシステム（MEMORY.md + project_pic_tan_state.md）を新規作成。
- PROGRESS.md（本ファイル）を新規作成。CLAUDE.md にセッション開始手順を追記。

### 2026-03-11 — Antigravity (IMG-001)
- Batch A 残分（Reward スタンプ4枚）を生成・配置完了。Batch A 全16枚揃い。
- Batch B は Codex 承認待ちで停止。

### 2026-03-11 — Claude (DEV-003)
- `enablePremiumFx` フラグ実装（app.js + styles.css）。OFF 時ゼロ差分を確認。
