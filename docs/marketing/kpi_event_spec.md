# KPI計測イベント定義書 (MKT-003)

> **作成日**: 2026-03-06  
> **対象**: アプリ開発エンジニア・データ分析チーム  
> **目的**: 街体験のKPI（town_growth_kpi.md）を計測するため、アプリ内で発火させるトラッキングイベントのスキーマと発火タイミングを定義する。

---

## 共通パラメータ (Common Properties)
すべてのイベントに付与すべき基本プロパティ：
- `user_id`: ユーザーの一意識別子
- `installed_at`: 初回起動日時（D14判定用）
- `current_town_level`: 現在の街レベル（1〜12）
- `current_streak`: 現在の連続プレイ日数

---

## 1. 街の成長イベント `town_level_reached`
**発火タイミング**: ユーザーのプレイ回数が閾値に達し、街のレベルが上がった直後（リザルト画面での演出表示時）。
**目的**: 「Lv4 = 60%到達」「Lv7 = 30%到達」のKPIを図る。

**イベントプロパティ**:
- `reached_level` (Integer): 到達した新しいレベル（2〜12）
- `sessions_played` (Integer): ここまでの累計セッション完了数
- `days_since_install` (Integer): インストールからの経過日数

---

## 2. 親子共遊導線イベント `parent_report_opened`
**発火タイミング**: 完了画面（Complete View）に表示される「おうちの人に見せる」ボタンがタップされた時。
**目的**: 全完了セッションに対する「親子共遊導線クリック率（15%目標）」を算出する。

**イベントプロパティ**:
- `source` (String): 遷移元（"session_complete", "home_screen" など。ここでは "session_complete"）
- `session_id` (String): 直前にクリアしたセッションのID

---

## 3. セッション完了イベント `session_completed`
**発火タイミング**: ユーザーが1回のクイズセット（例：10問）を最後まで解き終わり、結果画面が表示された時。
**目的**: ユーザーのアクティビティ量（D1/D7継続率）および、各種クリック率の分母として計測する。

**イベントプロパティ**:
- `theme` (String): プレイしたテーマ（例: "animals", "g7_flags"）
- `band` (String): 年齢バンド設定（"Easy", "Core", "Challenge"）
- `correct_count` (Integer): 正答数
- `duration_seconds` (Integer): プレイにかかった秒数
