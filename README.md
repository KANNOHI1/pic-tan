# Pic-tan（ピクたん）

子ども（2〜6歳）向け英日単語学習iOSアプリ。

## コンセプト

「勉強した動物がまちに住み着く」Town-centricナラティブ。毎日3分のセッションで語彙に触れ、仲良し度が上がった動物がまちへ引っ越してくる。Freemium（無料MVP + ¥480買い切り）。

## プロジェクト構成

```
apps/
  ios/          SwiftUI iOSアプリ
  web/          Webプレビュー（Mac不要の動作確認用）
packages/
  core/         ドメインロジック（TypeScript）
  content/      単語コンテンツJSON
docs/           設計・マーケティング・画像生成ドキュメント
tasks/          タスクボード・ハンドオフログ
scripts/        検証・ユーティリティスクリプト
```

## クイックスタート（Webプレビュー）

```bash
python -m http.server 8000
# → http://localhost:8000/apps/web/
```

## ドキュメント入口

- 現在地・次アクション: `PROGRESS.md`
- 全体地図: `CLAUDE.md`
- タスク管理: `tasks/TASK_BOARD.md`
- 現行デザイン仕様: `docs/superpowers/specs/2026-03-19-pictan-redesign-design.md`

## チーム

| 役割 | 担当 |
|---|---|
| 製作総指揮 | 菅野 宏勇 |
| 実装 | Claude Code |
| 監督・レビュー | Codex |
| 画像生成 | Gemini（Antigravity） |
