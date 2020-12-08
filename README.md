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

* has_many :comments
* has_many :constitutions
* has_many :civils
* has_many :criminals
* has_many :articles

## comments table

| Column                 | Type                    | Options                           |
|------------------------|-------------------------|----- -----------------------------|
| content                   | text                    | null: false                       |
| user                   | references              | null: false, foreign_key: true    |
| constitution           | references              | null: false, foreign_key: true    |
| civil                  | references              | null: false, foreign_key: true    |
| criminal               | references              | null: false, foreign_key: true    |


### Association

* belongs_to :user
* belongs_to :constitution
* belongs_to :civil
* belongs_to :criminal

## articles table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| user               | references          | null: false, foreign_key: true    |


### Association

* belongs_to :user
* has_one :constitution
* has_one :civil
* has_one :criminal

## constitutions table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| user               | references          | null: false, foreign_key: true    |
| article            | references          | null: false, foreign_key: true    |
| text               | text                | null: false                       |
| title              | text                | null: false                       |


### Association

* belongs_to :user
* belongs_to :article

## civils table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| user               | references          | null: false, foreign_key: true    |
| article            | references          | null: false, foreign_key: true    |
| text               | text                | null: false                       |
| title              | text                | null: false                       |

### Association

* belongs_to :user
* belongs_to :article

## criminals table

| Column             | Type                | Options                           |
|--------------------|---------------------|-----------------------------------|
| user               | references          | null: false, foreign_key: true    |
| article            | references          | null: false, foreign_key: true    |
| text               | text                | null: false                       |
| title              | text                | null: false                       |
