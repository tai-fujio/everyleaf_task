## HerokuへのDeploy手順　　　
#### 開発環境　　
- ruby 2.6.5　　
- Rails 5.2.3　　
- PostgreSQL　12.0　　
#### 手順
1. Herokuにサインアップする　　
1. Herokuをインストールする $ brew tap heroku/brew && brew install heroku　　
1. Herokuにログインする $ heroku login　　
1. アセットファイルをプリコンパイルする　rails assets:precompile RAILS_ENV=production　　
1. git commitでコミットする　　
1. Herokuに新規アプリケーションをつくる
 $ heroku create　　
1. Herokuにデプロイする　　
 $ git push heroku master　　
　　1. pushがrejectされた場合 $ heroku buildpacks:set heroku/ruby
 $ heroku buildpacks:add --index 1 heroku/nodejs を試す　　
1. DBのmigrationを行う $ heroku run rails db:migrate　　
1. Herokuアプリし確認する　$ heroku configでアドレスを確認　　
