# Pic-tan Web Preview

ブラウザで Pic-tan の学習フローを体験できるプレビューアプリ。

## 起動方法（重要: リポジトリルートから起動すること）

```powershell
# リポジトリルート (Pic-tan/) で実行
python -m http.server 8000
```

ブラウザで開く:

```
http://localhost:8000/apps/web/
```

> ⚠️ `apps/web/` フォルダを直接サーバルートにすると、コンテンツJSONの
> fetchパスが解決できず 404 になります。必ずリポジトリルートから起動してください。

## 機能

- テーマ選択ホーム画面（どうぶつ / くだもの / いろ）
- 4学習モード（絵→EN / 絵→JA / EN→JA / JA→EN）
- 絵モードで Unicode 絵文字を大表示
- カードタップで答え表示（フリップ）
- 4段階評価ボタン（わからない / むずかしい / まあまあ / かんぺき）
- マスコット反応（🐣 🤔 🌟 💪）
- セッション完了画面（星アニメ・正解数）

## コンテンツソース

```
packages/content/data/ja-JP/
├── animals.json  (20枚)
├── fruits.json   (12枚)
└── colors.json   (10枚)
```
