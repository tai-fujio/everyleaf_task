## HerokuへのDeploy手順　　　
#### 開発環境　　
- ruby 2.6.5　　
- Rails 5.2.3　　
- PostgreSQL　12.0　　
#### 手順
1. Herokuに登録する　　
1. Herokuをインストールする　　
1. Herokuにログインする $heroku login　　
1. Herokuに新規アプリケーションをつくる
 $heroku create　　
1. Herokuにデプロイする　　
 $git push heroku master　　　
1. DBのmigrationを行う　　
