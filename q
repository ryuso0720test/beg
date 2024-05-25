[33mcommit 0d552da22164f04cf28564c60d9d3bdb02123df2[m
Author: r-takahashi <ryuso0720.work@gmail.com>
Date:   Sun May 19 09:44:31 2024 +0900

    メール認証

[1mdiff --git a/README.md b/README.md[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/docker-compose.yml b/docker-compose.yml[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex 2a38a62..60be941[m
[1m--- a/docker-compose.yml[m
[1m+++ b/docker-compose.yml[m
[36m@@ -1,42 +1,48 @@[m
[31m-version: '3.8'[m
[32m+[m[32mversion: "3.8"[m
 [m
 services:[m
[31m-    nginx:[m
[31m-        image: nginx:1.21.1[m
[31m-        ports:[m
[31m-            - "80:80"[m
[31m-        volumes:[m
[31m-            - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf[m
[31m-            - ./src:/var/www/[m
[31m-        depends_on:[m
[31m-            - php[m
[32m+[m[32m  nginx:[m
[32m+[m[32m    image: nginx:1.21.1[m
[32m+[m[32m    ports:[m
[32m+[m[32m      - "80:80"[m
[32m+[m[32m    volumes:[m
[32m+[m[32m      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf[m
[32m+[m[32m      - ./src:/var/www/[m
[32m+[m[32m    depends_on:[m
[32m+[m[32m      - php[m
 [m
[31m-    php:[m
[31m-        build: ./docker/php[m
[31m-        volumes:[m
[31m-            - ./src:/var/www/[m
[32m+[m[32m  php:[m
[32m+[m[32m    build: ./docker/php[m
[32m+[m[32m    volumes:[m
[32m+[m[32m      - ./src:/var/www/[m
 [m
[31m-    mysql:[m
[31m-        image: mysql:8.0.26[m
[31m-        environment:[m
[31m-            MYSQL_ROOT_PASSWORD: root[m
[31m-            MYSQL_DATABASE: laravel_db[m
[31m-            MYSQL_USER: laravel_user[m
[31m-            MYSQL_PASSWORD: laravel_pass[m
[31m-        command:[m
[31m-            mysqld --default-authentication-plugin=mysql_native_password[m
[31m-        volumes:[m
[31m-            - ./docker/mysql/data:/var/lib/mysql[m
[31m-            - ./docker/mysql/my.cnf:/etc/mysql/conf.d/my.cnf[m
[32m+[m[32m  mysql:[m
[32m+[m[32m    image: mysql:8.0.26[m
[32m+[m[32m    environment:[m
[32m+[m[32m      MYSQL_ROOT_PASSWORD: root[m
[32m+[m[32m      MYSQL_DATABASE: laravel_db[m
[32m+[m[32m      MYSQL_USER: laravel_user[m
[32m+[m[32m      MYSQL_PASSWORD: laravel_pass[m
[32m+[m[32m    command: mysqld --default-authentication-plugin=mysql_native_password[m
[32m+[m[32m    volumes:[m
[32m+[m[32m      - ./docker/mysql/data:/var/lib/mysql[m
[32m+[m[32m      - ./docker/mysql/my.cnf:/etc/mysql/conf.d/my.cnf[m
 [m
[31m-    phpmyadmin:[m
[31m-        image: phpmyadmin/phpmyadmin[m
[31m-        environment:[m
[31m-            - PMA_ARBITRARY=1[m
[31m-            - PMA_HOST=mysql[m
[31m-            - PMA_USER=laravel_user[m
[31m-            - PMA_PASSWORD=laravel_pass[m
[31m-        depends_on:[m
[31m-            - mysql[m
[31m-        ports:[m
[31m-            - 8080:80[m
[32m+[m[32m  phpmyadmin:[m
[32m+[m[32m    image: phpmyadmin/phpmyadmin[m
[32m+[m[32m    environment:[m
[32m+[m[32m      - PMA_ARBITRARY=1[m
[32m+[m[32m      - PMA_HOST=mysql[m
[32m+[m[32m      - PMA_USER=laravel_user[m
[32m+[m[32m      - PMA_PASSWORD=laravel_pass[m
[32m+[m[32m    depends_on:[m
[32m+[m[32m      - mysql[m
[32m+[m[32m    ports:[m
[32m+[m[32m      - 8080:80[m
[32m+[m
[32m+[m[32m  #メールサーバのコンテナ[m
[32m+[m[32m  mailhog:[m
[32m+[m[32m    image: mailhog/mailhog[m
[32m+[m[32m    ports:[m
[32m+[m[32m      - 8025:8025[m
[32m+[m[32m      - 1025:1025[m
[1mdiff --git a/docker/mysql/my.cnf b/docker/mysql/my.cnf[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/docker/nginx/default.conf b/docker/nginx/default.conf[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/docker/php/Dockerfile b/docker/php/Dockerfile[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/docker/php/php.ini b/docker/php/php.ini[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex 68ac572..5a3145a[m
[1m--- a/docker/php/php.ini[m
[1m+++ b/docker/php/php.ini[m
[36m@@ -3,3 +3,5 @@[m [mdate.timezone = "Asia/Tokyo"[m
 [mbstring][m
 mbstring.internal_encoding = "UTF-8"[m
 mbstring.language = "Japanese"[m
[32m+[m
[32m+[m[32msendmail_path = "/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025"[m
[1mdiff --git a/src/.editorconfig b/src/.editorconfig[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/.env.example b/src/.env.example[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/.gitattributes b/src/.gitattributes[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/.gitignore b/src/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/.styleci.yml b/src/.styleci.yml[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/README.md b/src/README.md[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Actions/Fortify/CreateNewUser.php b/src/app/Actions/Fortify/CreateNewUser.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Actions/Fortify/PasswordValidationRules.php b/src/app/Actions/Fortify/PasswordValidationRules.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Actions/Fortify/ResetUserPassword.php b/src/app/Actions/Fortify/ResetUserPassword.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Actions/Fortify/UpdateUserPassword.php b/src/app/Actions/Fortify/UpdateUserPassword.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Actions/Fortify/UpdateUserProfileInformation.php b/src/app/Actions/Fortify/UpdateUserProfileInformation.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Console/Kernel.php b/src/app/Console/Kernel.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Exceptions/Handler.php b/src/app/Exceptions/Handler.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Controllers/AuthController.php b/src/app/Http/Controllers/AuthController.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Controllers/Controller.php b/src/app/Http/Controllers/Controller.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Controllers/RestController.php b/src/app/Http/Controllers/RestController.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Controllers/WorkController.php b/src/app/Http/Controllers/WorkController.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Kernel.php b/src/app/Http/Kernel.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/Authenticate.php b/src/app/Http/Middleware/Authenticate.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/EncryptCookies.php b/src/app/Http/Middleware/EncryptCookies.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/PreventRequestsDuringMaintenance.php b/src/app/Http/Middleware/PreventRequestsDuringMaintenance.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/RedirectIfAuthenticated.php b/src/app/Http/Middleware/RedirectIfAuthenticated.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/TrimStrings.php b/src/app/Http/Middleware/TrimStrings.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/TrustHosts.php b/src/app/Http/Middleware/TrustHosts.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/TrustProxies.php b/src/app/Http/Middleware/TrustProxies.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Http/Middleware/VerifyCsrfToken.php b/src/app/Http/Middleware/VerifyCsrfToken.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Models/Rest.php b/src/app/Models/Rest.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Models/User.php b/src/app/Models/User.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex ed28e93..97f3b25[m
[1m--- a/src/app/Models/User.php[m
[1m+++ b/src/app/Models/User.php[m
[36m@@ -6,12 +6,15 @@[m
 use Illuminate\Database\Eloquent\Factories\HasFactory;[m
 use Illuminate\Foundation\Auth\User as Authenticatable;[m
 use Illuminate\Notifications\Notifiable;[m
[32m+[m[32muse Laravel\Fortify\TwoFactorAuthenticatable;[m
 use Laravel\Sanctum\HasApiTokens;[m
 [m
[31m-class User extends Authenticatable[m
[32m+[m[32mclass User extends Authenticatable implements MustVerifyEmail[m
 {[m
     use HasApiTokens, HasFactory, Notifiable;[m
 [m
[32m+[m[32m    use Notifiable, TwoFactorAuthenticatable;[m
[32m+[m
     /**[m
      * The attributes that are mass assignable.[m
      *[m
[1mdiff --git a/src/app/Models/Work.php b/src/app/Models/Work.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Providers/AppServiceProvider.php b/src/app/Providers/AppServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Providers/AuthServiceProvider.php b/src/app/Providers/AuthServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Providers/BroadcastServiceProvider.php b/src/app/Providers/BroadcastServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Providers/EventServiceProvider.php b/src/app/Providers/EventServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/app/Providers/FortifyServiceProvider.php b/src/app/Providers/FortifyServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex 8ff8bae..4848cb6[m
[1m--- a/src/app/Providers/FortifyServiceProvider.php[m
[1m+++ b/src/app/Providers/FortifyServiceProvider.php[m
[36m@@ -12,6 +12,7 @@[m
 use Illuminate\Support\ServiceProvider;[m
 use Illuminate\Support\Str;[m
 use Laravel\Fortify\Fortify;[m
[32m+[m[32muse Laravel\Fortify\Contracts\RegisterResponse;[m
 [m
 class FortifyServiceProvider extends ServiceProvider[m
 {[m
[36m@@ -20,7 +21,12 @@[m [mclass FortifyServiceProvider extends ServiceProvider[m
      */[m
     public function register(): void[m
     {[m
[31m-        //[m
[32m+[m[32m        $this->app->instance(RegisterResponse::class, new class implements RegisterResponse {[m
[32m+[m[32m        public function toResponse($request)[m
[32m+[m[32m        {[m
[32m+[m[32m            return view('auth.mail');[m
[32m+[m[32m        }[m
[32m+[m[32m    });[m
     }[m
 [m
     /**[m
[36m@@ -39,6 +45,8 @@[m [mpublic function boot(): void[m
             return view('auth.login');[m
         });[m
 [m
[32m+[m
[32m+[m
         RateLimiter::for('login', function (Request $request) {[m
             $email = (string) $request->email;[m
 [m
[1mdiff --git a/src/app/Providers/RouteServiceProvider.php b/src/app/Providers/RouteServiceProvider.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/artisan b/src/artisan[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/bootstrap/app.php b/src/bootstrap/app.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/bootstrap/cache/.gitignore b/src/bootstrap/cache/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/composer.json b/src/composer.json[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/composer.lock b/src/composer.lock[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/app.php b/src/config/app.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/auth.php b/src/config/auth.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/broadcasting.php b/src/config/broadcasting.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/cache.php b/src/config/cache.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/cors.php b/src/config/cors.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/database.php b/src/config/database.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/filesystems.php b/src/config/filesystems.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/fortify.php b/src/config/fortify.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex 0fe22c8..0213717[m
[1m--- a/src/config/fortify.php[m
[1m+++ b/src/config/fortify.php[m
[36m@@ -147,7 +147,7 @@[m
     'features' => [[m
         Features::registration(),[m
         Features::resetPasswords(),[m
[31m-        // Features::emailVerification(),[m
[32m+[m[32m        Features::emailVerification(),[m
         Features::updateProfileInformation(),[m
         Features::updatePasswords(),[m
         Features::twoFactorAuthentication([[m
[1mdiff --git a/src/config/hashing.php b/src/config/hashing.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/logging.php b/src/config/logging.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/mail.php b/src/config/mail.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mindex f96c6c7..0fd3c65[m
[1m--- a/src/config/mail.php[m
[1m+++ b/src/config/mail.php[m
[36m@@ -36,13 +36,20 @@[m
     'mailers' => [[m
         'smtp' => [[m
             'transport' => 'smtp',[m
[31m-            'host' => env('MAIL_HOST', 'smtp.mailgun.org'),[m
[31m-            'port' => env('MAIL_PORT', 587),[m
[32m+[m[32m            'host' => env('MAIL_HOST', 'mailhog'),[m
[32m+[m[32m            'port' => env('MAIL_PORT', 1025),[m
             'encryption' => env('MAIL_ENCRYPTION', 'tls'),[m
             'username' => env('MAIL_USERNAME'),[m
             'password' => env('MAIL_PASSWORD'),[m
             'timeout' => null,[m
             'auth_mode' => null,[m
[32m+[m[32m            'stream' => [[m
[32m+[m[32m                'ssl' => [[m
[32m+[m[32m                    'allow_self_signed' => true,[m
[32m+[m[32m                    'verify_peer' => false,[m
[32m+[m[32m                    'verify_peer_name' => false,[m
[32m+[m[32m                ],[m
[32m+[m[32m            ],[m
         ],[m
 [m
         'ses' => [[m
[1mdiff --git a/src/config/queue.php b/src/config/queue.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/sanctum.php b/src/config/sanctum.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/services.php b/src/config/services.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/session.php b/src/config/session.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/config/view.php b/src/config/view.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/.gitignore b/src/database/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/factories/UserFactory.php b/src/database/factories/UserFactory.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2014_10_12_000000_create_users_table.php b/src/database/migrations/2014_10_12_000000_create_users_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2014_10_12_100000_create_password_resets_table.php b/src/database/migrations/2014_10_12_100000_create_password_resets_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2014_10_12_200000_add_two_factor_columns_to_users_table.php b/src/database/migrations/2014_10_12_200000_add_two_factor_columns_to_users_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2019_08_19_000000_create_failed_jobs_table.php b/src/database/migrations/2019_08_19_000000_create_failed_jobs_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2019_12_14_000001_create_personal_access_tokens_table.php b/src/database/migrations/2019_12_14_000001_create_personal_access_tokens_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2024_04_29_161044_create_works_table.php b/src/database/migrations/2024_04_29_161044_create_works_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/migrations/2024_05_06_100614_create_rests_table.php b/src/database/migrations/2024_05_06_100614_create_rests_table.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/database/seeders/DatabaseSeeder.php b/src/database/seeders/DatabaseSeeder.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/package.json b/src/package.json[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/phpunit.xml b/src/phpunit.xml[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/.htaccess b/src/public/.htaccess[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/common.css b/src/public/css/common.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/date.css b/src/public/css/date.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/index.css b/src/public/css/index.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/login.css b/src/public/css/login.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/mail.css b/src/public/css/mail.css[m
[1mnew file mode 100644[m
[1mindex 0000000..7c86331[m
[1m--- /dev/null[m
[1m+++ b/src/public/css/mail.css[m
[36m@@ -0,0 +1,4 @@[m
[32m+[m[32m.title {[m
[32m+[m[32m    text-align: center;[m
[32m+[m[32m    margin-top: 5%;[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/src/public/css/register.css b/src/public/css/register.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/css/sanitize.css b/src/public/css/sanitize.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/favicon.ico b/src/public/favicon.ico[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/index.php b/src/public/index.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/public/robots.txt b/src/public/robots.txt[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/css/app.css b/src/resources/css/app.css[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/js/app.js b/src/resources/js/app.js[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/js/bootstrap.js b/src/resources/js/bootstrap.js[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/en/auth.php b/src/resources/lang/en/auth.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/en/pagination.php b/src/resources/lang/en/pagination.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/en/passwords.php b/src/resources/lang/en/passwords.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/en/validation.php b/src/resources/lang/en/validation.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/ja/auth.php b/src/resources/lang/ja/auth.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/ja/pagination.php b/src/resources/lang/ja/pagination.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/ja/passwords.php b/src/resources/lang/ja/passwords.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/ja/validation-inline.php b/src/resources/lang/ja/validation-inline.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/lang/ja/validation.php b/src/resources/lang/ja/validation.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/auth/login.blade.php b/src/resources/views/auth/login.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/auth/mail.blade.php b/src/resources/views/auth/mail.blade.php[m
[1mnew file mode 100644[m
[1mindex 0000000..1b76ecf[m
[1m--- /dev/null[m
[1m+++ b/src/resources/views/auth/mail.blade.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m
[32m+[m
[32m+[m[32m@section('css')[m
[32m+[m[32m<link rel="stylesheet" href="{{ asset('css/mail.css') }}">[m
[32m+[m[32m@endsection[m
[32m+[m
[32m+[m[32m<div class="mail__content">[m
[32m+[m[32m  <div class="mail__heading">[m
[32m+[m[32m    <h2 class="title">メールを送信しました</h2>[m
[32m+[m[32m  </div>[m
[32m+[m[41m  [m
[32m+[m[32m</div>[m
\ No newline at end of file[m
[1mdiff --git a/src/resources/views/auth/register.blade.php b/src/resources/views/auth/register.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/date.blade.php b/src/resources/views/date.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/index.blade.php b/src/resources/views/index.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/layouts/app.blade.php b/src/resources/views/layouts/app.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/userList.blade.php b/src/resources/views/userList.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/bootstrap-4.blade.php b/src/resources/views/vendor/pagination/bootstrap-4.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/default.blade.php b/src/resources/views/vendor/pagination/default.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/semantic-ui.blade.php b/src/resources/views/vendor/pagination/semantic-ui.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/simple-bootstrap-4.blade.php b/src/resources/views/vendor/pagination/simple-bootstrap-4.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/simple-default.blade.php b/src/resources/views/vendor/pagination/simple-default.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/simple-tailwind.blade.php b/src/resources/views/vendor/pagination/simple-tailwind.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/vendor/pagination/tailwind.blade.php b/src/resources/views/vendor/pagination/tailwind.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/resources/views/welcome.blade.php b/src/resources/views/welcome.blade.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/routes/api.php b/src/routes/api.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/routes/channels.php b/src/routes/channels.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/routes/console.php b/src/routes/console.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/routes/web.php b/src/routes/web.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/server.php b/src/server.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/app/.gitignore b/src/storage/app/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/app/public/.gitignore b/src/storage/app/public/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/.gitignore b/src/storage/framework/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/cache/.gitignore b/src/storage/framework/cache/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/cache/data/.gitignore b/src/storage/framework/cache/data/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/sessions/.gitignore b/src/storage/framework/sessions/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/testing/.gitignore b/src/storage/framework/testing/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/framework/views/.gitignore b/src/storage/framework/views/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/storage/logs/.gitignore b/src/storage/logs/.gitignore[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/tests/CreatesApplication.php b/src/tests/CreatesApplication.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/tests/Feature/ExampleTest.php b/src/tests/Feature/ExampleTest.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/tests/TestCase.php b/src/tests/TestCase.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/tests/Unit/ExampleTest.php b/src/tests/Unit/ExampleTest.php[m
[1mold mode 100755[m
[1mnew mode 100644[m
[1mdiff --git a/src/webpack.mix.js b/src/webpack.mix.js[m
[1mold mode 100755[m
[1mnew mode 100644[m
