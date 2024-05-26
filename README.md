

# 初級案件(勤怠管理システム)
環境構築
Dockerビルド

git clone git@github.com:estra-inc/confirmation-test-contact-form.git
DockerDesktopアプリを立ち上げる
docker-compose up -d --build
MacのM1・M2チップのPCの場合、no matching manifest for linux/arm64/v8 in the manifest list entriesのメッセージが表示されビルドができないことがあります。 エラーが発生する場合は、docker-compose.ymlファイルの「mysql」内に「platform」の項目を追加で記載してください

mysql:
    platform: linux/x86_64(この文追加)
    image: mysql:8.0.26
    environment:
Laravel環境構築

docker-compose exec php bash
composer install
「.env.example」ファイルを 「.env」ファイルに命名を変更。または、新しく.envファイルを作成
.envに以下の環境変数を追加
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_pass
アプリケーションキーの作成
php artisan key:generate
マイグレーションの実行
php artisan migrate
シーディングの実行
php artisan db:seed
使用技術(実行環境)
PHP8.3.0
Laravel8.83.27
MySQL8.0.26
ER図
