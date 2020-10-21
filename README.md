
## 使用技術

#### 環境
Ruby: 2.6.5

Rails: 5.2.4

MySQL: 5.7

Rspec

Rubocop

jQuery

Bootstrap4

Docker/Docker-compose(開発環境)

CircleCI

#### インフラ
- AWS: VPC, RDS, EC2, Route53, VPC, ELB, ACM
- アプリケーションサーバー: Unicorn
- Webサーバー: Nginx

#### AWS構成図

![AWS 構成図](https://user-images.githubusercontent.com/62746943/86996438-a1d5be80-c1e6-11ea-990b-598d5924ffd3.png)


#### ER図

![sample](https://user-images.githubusercontent.com/62746943/86989276-0e47c200-c1d5-11ea-9383-099215fd3166.png)

## アプリケーションの機能
- ユーザーのサインイン/サインアップ(Devise gemを使用)

- カスタムショップのサインイン/サインアップ(Devise gemを使用)
- ゲストユーザーログイン機能
- 質問の投稿機能
- 質問に対するコメント機能
- 複数画像投稿機能(Jqueryで動的なフォームを作成)
- お気に入り機能(登録、削除)
- 検索機能(ransack)
- カテゴリー機能
- 通知機能
- ユーザーとカスタムショップにポリモーフィックの関連付け(コメント、通知)
- 質問とコメントにポリモーフィックの関連付け(画像)
- 車名の入力時、カーセンサーさんのAPIを利用した、語彙予測機能

## その他

  独自ドメインを取得し、SSL

## 今後、実装したい技術及び機能

- Capristianoを用いた、自動デプロイ

- CDパイプラインの構築
- erbファイルを、slimで記述
- 質問詳細表示画面に同カテゴリーに属した質問を表示させ、ユーザーの回遊性を向上

