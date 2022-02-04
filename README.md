# MacroStore

# サービス概要

コンビニ食品で食事をとっているがダイエットをしたい人に向けて、
ユーザーに応じてダイエットに最適なコンビニ食品を探せる、**コンビニ食品検索サービス**です。

## リンク

### [macrostore.jp](https://www.macrostore.jp)

<br />

## ターゲットユーザー

### メイン

コンビニ食品でダイエットしたい人

### サブ

トレーニング、食事管理をしている人

<br />

## ユーザーが抱える課題

### メイン

健康志向の需要が高まっており、コンビニ食でも「たんぱく質が摂れる」や「糖質オフ」と、商品名に入れるほどである。
しかし、人によってダイエットに最適なカロリーは違うため、知識がない人がダイエットに最適な食品を選ぶのは難しい

### サブ

コンビニ食品で済ませたい時に適切な PFC バランスのものを瞬時に探すのが難しい。またこんなご時世なので、色々な商品を手に取って確認するのは避けたい
※PFC・・・たんぱく質、脂質、炭水化物のこと

<br />

## 解決方法

- 厚生労働省のデータをもとに、ユーザーのダイエットに最適な 1 食分の摂取カロリーとの PFC バランスを算出する
- 摂取したい PFC の数値を入れて検索(上記計算結果は自動で反映)をすると、その条件をクリアしたコンビニ食品が出てくる

<br />

### 使用画面一部

|                                                               トップ                                                                |                                                          カロリー計算結果                                                           |                                                            食品検索結果                                                             |
| :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: |
| [![Image from Gyazo](https://i.gyazo.com/4deb5fab9b010287c4d07bb787a87ef8.gif)](https://gyazo.com/4deb5fab9b010287c4d07bb787a87ef8) | [![Image from Gyazo](https://i.gyazo.com/94b69e3630c431a9091790ef8cdfd120.gif)](https://gyazo.com/94b69e3630c431a9091790ef8cdfd120) | [![Image from Gyazo](https://i.gyazo.com/0edffb3396c54a24dfe850a37d66033b.gif)](https://gyazo.com/0edffb3396c54a24dfe850a37d66033b) |

<br />

## 実装機能

- **一般ユーザー**

  - 新規会員登録機能
  - 摂取カロリー計算機能
  - 食品詳細情報閲覧機能
  - 食品検索機能
    - 名前検索
    - 数値検索

- **会員ユーザー**

  - ログイン機能
  - 編集機能
  - 削除機能
  - ユーザーマイページ機能
  - 摂取カロリー登録機能
  - 登録摂取カロリーによる数値検索機能
  - 食品お気に入り機能

<br />

## なぜこのサービスを作りたいのか？

1. 開発者が食事管理とトレーニングが趣味であり、コンビニにて瞬時に摂取したい PFC の食品を探せなかったため、このようなサービスが欲しいと思ったから
1. 人によってダイエットに最適なカロリーは違うため、健康的な食事を心がけても、実際にはその人の意向に反した食品を選ぶケースが多いのではないかと感じている。そのような人が 自身に見合った摂取カロリーを知り、理想の体型を目指すきっかけになれば嬉しい

<br />

### [画面遷移図](https://xd.adobe.com/view/1b33426e-d01e-4f44-9644-837593edbfed-4e60/)

### [ER 図](https://i.gyazo.com/8634c04911134ea6ec59f3a3b33988eb.png)
