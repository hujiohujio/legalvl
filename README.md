# アプリケーション名
 
 法学生が大学や大学院、予備校などで行う意見討論のゼミをオンラインで誰とでも気軽に行えるようにしたいという意味合いで命名しました

 
# アプリケーション概要
 
法学生が他社と意見討論を行い知識の定着と表現力を養う「ゼミ」を気軽にオンラインで出来るようなアプリを作りました
 
# URL
 
（未デプロイ）
GitHub:https://github.com/hujiohujio/legalvl
 
 
# 利用方法
 
トップページの新規登録ボタンからユーザー登録を行い、新規投稿作成と編集が行えます
投稿詳細ページでは投稿物を確認しながらチャット機能によって他のユーザーと意見交換を行うことが可能です
ユーザー登録を行わなくても、投稿物の閲覧、登録ユーザーのプロフィールの閲覧はできます
 

# 目指した課題解決
 
法学生がゼミを行う場合、大学院や予備校のような整備された環境下でグループを作り意見討論をすることが普通です。しかし、そのような環境に身を置けない法学生にも気軽にゼミを行えるような場所を作りたくてこのアプリを制作しました。

 
# 洗い出した要件　
 
- ユーザー登録機能
  - 新規登録、ログイン、ログアウト（未実装）画像登録機能（未実装）
- 投稿機能
- チャット機能
  - 非同期通信の実装
  - 投稿物に紐づくチャット機能
  - ユーザー間のチャット機能（未実装）
- 検索機能（未実装）
- いいね機能（未実装）
- ブックマーク機能（未実装） 


# 使用技術

- フロントエンド
  - HTML/CSS/Bootstrap
  - jquery
  - JavaScript
- バックエンド
  - Ruby 2.6.5
  - RubyOnRails 6.0.0
- インフラ
  - AWS（S3、EC2）（未実装）
  - nginx（未実装）
  - mysql





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
| titile             | title               | null: false                       |

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


# ローカルでの動作方法
