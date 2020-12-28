
 
# アプリケーション概要
 
自身の大学時代の経験から、法学生が他者と意見討論を行い知識の定着と表現力を養う「ゼミ」を気軽にオンラインで出来るようなアプリがあればと考え、作りました。

ゼミを行う場合、大学院や予備校のように整備された環境下でグループを作り意見討論をすることが普通です。しかし、そのような環境に身を置けない法学生にも気軽にゼミを行えるような場所を作りたくてこのアプリを制作しました。
 
# URL

http://13.115.62.7/
 
GitHub:https://github.com/hujiohujio/legalvl

 
 
# 利用方法
 
トップページの新規登録ボタンからユーザー登録を行い、新規投稿作成と編集が行えます
投稿詳細ページでは投稿物を確認しながらチャット機能によって他のユーザーと意見交換を行うことが可能です
ユーザー登録を行わなくても、投稿物の閲覧、登録ユーザーのプロフィールの閲覧ができます

- 投稿記事詳細ページでコメントを投稿する様子
  https://gyazo.com/aca54b9e7a76533cb18752ca5e595567
 


 
# 機能一覧
 
- ユーザー登録機能
  - 新規登録、ログイン、ログアウト（deviseを使用）
  - マイページ、登録情報編集

- 記事投稿機能
  - 一覧表示、記事詳細表示、投稿、削除機能
- チャット機能
  - 非同期通信の実装
  - 投稿物に紐づくチャット機能
  
# 今後実装したい機能
- ユーザー間の個別チャット機能
- 投稿記事検索機能
- ブックマーク機能
- いいね機能
- チャット通知機能
- ページネーション機能


# 使用技術

- フロントエンド
  - HTML/CSS/Bootstrap
  - jquery
  - JavaScript
- バックエンド
  - Ruby 2.6.5
  - RubyOnRails 6.0.0
- インフラ
  - AWS（S3、EC2、IAM）
  - nginx
  - Docker,Docker-compose（未実装）
  - mysql
  - Capistrano
- テスト
  - RSpec（テストフレームワーク）
  - CircleCi（未実装）

サーバーサイドはRuby+RubyOnRailsで構築しています。
EC2にCapistranoを実装し自動デプロイを実現しました。







# DB 設計

## users table

| Column             | Type                | Options                |
|--------------------|---------------------|------------------------|
| nickname           | string              | null: false            |
| email              | string              | null: false            |
| encrypted_password | string              | null: false            |
| profile            | text                |                        |
| fav_subj           | string              |                        |
| weak_subj          | string              |                        |

### Association

* has_many :messages
* has_many :articles

## messages table

| Column                 | Type                    | Options                           |
|------------------------|-------------------------|----- -----------------------------|
| content                | text                    | null: false                       |
| user                   | references              | null: false, foreign_key: true    |
| article                | references              | null: false, foreign_key: true    |


### Association

* belongs_to :user
* belongs_to :article


## articles table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| user               | references          | null: false, foreign_key: true    |
| text               | text                | null: false                       |
| title              | title               | null: false                       |

### Association

* belongs_to :user
* has_many : tags
* has_many : article_tags
* has_many : messages


## article_tags table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| article            | references          | null: false, foreign_key: true    |
| tag                | references          | null: false, foreign_key: true    |

### Association

* belongs_to :tag
* belongs_to :article


## tags table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| subj               | string              | null: false                       |

### Association

* has_many :articles
* has_many :article_tags


