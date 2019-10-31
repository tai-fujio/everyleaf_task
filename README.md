## データ構造の設計　　
#### User　
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|name|string|
|email|string|
|password_digest|string|
|admin?|boolean|
#### Task　　
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|references|
|name|string|
|detail|text|
|deadline|date|
|priority|integer|
|status|integer|
|labeling_id(FK)|references|
#### Commit
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|integer|
|task_id(FK)|integer|
#### labeling
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|labeling_name|string|

## HerokuへのDeploy手順　
#### 開発環境
- ruby 2.6.5　　
- Rails 5.2.3　　
- PostgreSQL 12.0
#### 手順
1. Herokuにサインアップする
1. Herokuをインストールする $ brew tap heroku/brew && brew install heroku
1. Herokuにログインする $ heroku login
1. アセットファイルをプリコンパイルする rails assets:precompile RAILS_ENV=production
1. git commitでコミットする
1. Herokuに新規アプリケーションをつくる
 $ heroku create
1. Herokuにデプロイする
 $ git push heroku master
    - pushがrejectされた場合
      - $ heroku buildpacks:set heroku/ruby
      - $ heroku buildpacks:add --index 1 heroku/nodejs を試す
1. DBのmigrationを行う $ heroku run rails db:migrate
1. Herokuアプリし確認する　$ heroku configでアドレスを確認
