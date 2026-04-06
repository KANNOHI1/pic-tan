# Mac Build Handoff — PT-011 実行パック

**対象**: Macを持っている協力者・レンタルMac担当者
**目的**: PT-011（初回Xcodeビルド＆動作確認）を単独で完走できるようにする
**前提知識**: 不要（コマンドはコピペ可）

---

## 1. 事前確認（Mac側）

| 項目 | 最低要件 | 確認コマンド |
|------|----------|-------------|
| macOS | 13 Ventura 以上 | Apple メニュー → このMacについて |
| Xcode | 15 以上 | `xcode-select --version` |
| 空き容量 | 30 GB 以上 | ストレージ設定で確認 |
| RAM | 8 GB 以上 | このMacについて |

Xcode が未インストールの場合:
```
App Store → 「Xcode」で検索 → 入手（15〜30分）
```

---

## 2. プロジェクトをMacに持ち込む

### 方法A: GitHub からクローン（推奨）
```bash
cd ~/Desktop
git clone https://github.com/KANNOHI1/Pic-tan.git
cd Pic-tan
```

### 方法B: USB / AirDrop / クラウドストレージ
- `Pic-tan` フォルダごとデスクトップに配置する

---

## 3. Xcodeを起動してビルドする

### 3-1. プロジェクトを開く
```bash
open ~/Desktop/Pic-tan/apps/ios/PicTan.xcodeproj
```
または Finder で `apps/ios/PicTan.xcodeproj` をダブルクリック。

> パッケージ解決中の「Fetching...」表示が消えるまで待つ（1〜3分）

### 3-2. ターゲットとシミュレーターを選択
- 左上のデバイス選択ドロップダウンをクリック
- **ターゲット**: `PicTan`
- **シミュレーター**: `iPhone 15 Pro`（または iPhone 15）

### 3-3. ビルド & 実行
```
Cmd + R
```
または ▶ ボタンをクリック。

**成功の見分け方**: シミュレーター画面にアプリが起動し、カード画面が見える。

---

## 4. 合否チェックリスト

下記を順番に確認し、結果を PASS / FAIL で記録してください。

| # | 確認項目 | 期待結果 | 結果 |
|---|----------|----------|------|
| 1 | アプリ起動 | ホーム画面（テーマ選択）が表示される | |
| 2 | テーマ選択 | 「どうぶつ」をタップ → カード画面に遷移する | |
| 3 | カード表示 | 絵文字（🐱など）と英語・日本語が表示される | |
| 4 | 学習モード切替 | モードセレクタが反応する（EN→JA / 絵→EN など） | |
| 5 | カードめくり | タップ/スワイプでカードが進む | |
| 6 | 評価ボタン | perfect / ok / hard / unknown のいずれかが押せる | |
| 7 | 次のカードへ | 評価後に次のカードが表示される | |
| 8 | セッション完了 | 全カード終了後に完了画面（スコア表示）が出る | |
| 9 | ホームへ戻る | 「ホームへ」ボタンでホーム画面に戻れる | |
| 10 | クラッシュなし | 上記操作中にアプリが落ちない | |

**合格基準**: 10項目すべて PASS → PT-011 完了

---

## 5. エラー発生時のログ採取手順

### ビルドエラーの場合
```
Xcode メニュー → Report Navigator（左サイドバーの ⚡ アイコン）
→ 最新ビルドを選択 → エラー行を右クリック → Copy
```

### 実行時クラッシュの場合
```
Xcode 下部パネル → Console タブ → 全テキストをコピー
```

### コマンドラインでログを保存する場合
```bash
cd ~/Desktop/Pic-tan
xcodebuild -project apps/ios/PicTan.xcodeproj \
  -scheme PicTan \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  build 2>&1 | tee build_log.txt
```
生成された `build_log.txt` を共有してください。

---

## 6. よくあるエラーと対処

| エラー | 対処 |
|--------|------|
| `No such module 'PicTanCore'` | `File → Packages → Resolve Package Versions` |
| `Signing requires a development team` | `Signing & Capabilities → Team` に Apple ID を設定 |
| `Build input file cannot be found` | `Shift + Cmd + K`（クリーン）→ `Cmd + R` |
| プロジェクトが開けない | 下記フォールバックAを実行 |
| JSON読み込み失敗 | 下記フォールバックBを確認 |

### フォールバックA: XcodeGen でプロジェクト再生成
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install xcodegen
cd ~/Desktop/Pic-tan/apps/ios
xcodegen generate
open PicTan.xcodeproj
```

### フォールバックB: CoreパッケージのみSwiftテスト
```bash
cd ~/Desktop/Pic-tan/packages/core
swift test
```

---

## 7. 完了報告テンプレート（コピペして記入）

```
## YYYY-MM-DD - PT-011 ビルド報告

- ビルド結果: 成功 / 失敗
- macOS バージョン:
- Xcode バージョン:
- 使用シミュレーター:
- チェックリスト通過: X / 10 項目
- 発見した問題:
  -
- 次のアクション:
```

記入後、`tasks/HANDOFF_LOG.md` の先頭（"Use newest entry at top." の直下）に貼り付けてください。

---

*作成: 2026-03-05 Claude (PT-060)*
*元情報: docs/MAC_BUILD_PLAYBOOK.md (PT-013)*
