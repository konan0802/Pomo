# Pomo

## Usage

## Specification
### 画面
* 時間グラフ
	* 押下 ⇒ スタートボタン（25m）<br>
		※タスク実行中は実行なし
* 項目選択（左下）
	* スプシからタスク一覧を取得
* 操作画面（右下）
	* MTG（60m）
	* SBR（5m）
	* LBR（15m）
	* フィニッシュ<br>
		※タスク停止中は実行なし

### 各環境で実施する動作
* Swift
	* Toggl
		* GET: 現在タスク取得
		* POST: スタート
		* POST: フィニッシュ
	* GAS
		* GET: タスク一覧を取得
* GAS
	* GET: タスク一覧を取得（実行可能API）
	* 実績値の取得
		* Toggl
			* 特定タスクの経過時間の取得

## Get Start

### Deploy

### Reference
1. 環境設定
    * [Apple Watchアプリ開発の超絶基礎・通信編 2022版](https://tech-blog.cloud-config.jp/2022-04-07-apple-watch-app-method/)