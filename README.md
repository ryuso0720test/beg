

# 初級案件(勤怠管理システム)

## 機能一覧
- ログイン認証
- ユーザー登録時のメール認証（ローカル環境のみ）
- 打刻機能（勤怠開始、勤怠終了、休憩開始、休憩終了）
- 日別勤怠一覧
- ユーザー別日別勤怠一覧
- ユーザー一覧
## Docker ビルド
1. git clone https://git@github.com:ryuso0720test/beg.git
2. docker-compose up -d --build
*MySQL は、OS によって起動しない場合があるのでそれぞれの PC にあわせて docker-compose.yml ファイルを編集してください。

## Laravel環境構築
1. docker-compose exec php bash
2. composer install
3. .env ファイルの編集 「.env.example」ファイルを 「.env」ファイルに命名を変更。または、新しく.envファイルを作成 .envに以下の環境変数を追加
```
   DB_CONNECTION=mysql
   DB_HOST=mysql
   DB_PORT=3306
   DB_DATABASE=laravel_db
   DB_USERNAME=laravel_user
   DB_PASSWORD=laravel_pass

   MAIL_MAILER=smtp
   MAIL_HOST=mailhog
   MAIL_PORT=1025
   MAIL_USERNAME=null
   MAIL_PASSWORD=null
   MAIL_ENCRYPTION=null
   MAIL_FROM_ADDRESS="hello@example.com"
```

4. php artisan key:generate
5. php artisan migrate
6. php artisan db:seed
   ※シーディングデータには6/1日の勤怠データが挿入されます

## 使用技術
- PHP 7.4.9
- Laravel 8.83.27
- mysql:8.0.26
- nginx:1.21.1

## URL
- 開発環境： http://localhost/
- phpMyAdmin：http://localhost:8080/
- mailhog：http://localhost:8025/
- 本番環境：http://57.181.199.200/
- - テストユーザー情報
- - mail：test@example.com
- - password：aaaa1111
※本番環境ではメール認証機能は実装しておりません

## ER図
![新規 テキスト ドキュメント](https://github.com/ryuso0720test/beg/assets/155881611/304b3162-5eba-4b07-9e61-74a19540a217)




