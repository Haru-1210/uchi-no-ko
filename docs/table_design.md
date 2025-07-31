# テーブル設計（Uchi no Ko）

## users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many :albums
- has_many :posts, through: :albums
- has_many :comments
- has_many :downloads

---

## albums テーブル

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| title  | string     | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association
- belongs_to :user  
- has_many :posts
- has_one :access_code
- has_many :downloads

---

## posts テーブル（写真・動画投稿）

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| title      | string     | null: false                    |
| caption    | text       |                                |
| media_type | string     | null: false                    |
| date       | date       | null: false                    |
| album      | references | null: false, foreign_key: true |

### Association
- belongs_to :album  
- has_many :comments  
- has_many :post_tags  
- has_many :tags, through: :post_tags
- has_many :sns_links
- has_one_attached :media

---

## tags テーブル

| Column | Type   | Options                   |
|--------|--------|---------------------------|
| name   | string | null: false, unique: true |

### Association
- has_many :post_tags  
- has_many :posts, through: :post_tags

---

## post_tags テーブル（中間テーブル）

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| post   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### Association
- belongs_to :post  
- belongs_to :tag

---

## comments テーブル

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association
- belongs_to :user  
- belongs_to :post

---

## access_codes テーブル（公開用パスワード）

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| code        | string     | null: false                    |
| album       | references | null: false, foreign_key: true |

### Association
- belongs_to :album

---

## sns_links テーブル（SNS共有）

| Column    | Type       | Options                        |
|-----------|------------|--------------------------------|
| platform  | string     | null: false                    |
| url       | string     | null: false                    |
| post      | references | null: false, foreign_key: true |

### Association
- belongs_to :post

---

## downloads テーブル（一括ダウンロード履歴）

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| user          | references | null: false, foreign_key: true |
| album         | references | null: false, foreign_key: true |
| downloaded_at | datetime   | null: false                    |

### Association
- belongs_to :user
- belongs_to :album
