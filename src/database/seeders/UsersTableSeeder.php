<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $param = [
            'name' => 'UserName1',
            'email' => 'User1@mailaddress.com',
            'password' => bcrypt('password'),
        ];
        DB::table('users')->insert($param);

        $param = [
            'name' => 'UserName2',
            'email' => 'User2@mailaddress.com',
            'password' => bcrypt('password'),
        ];
        DB::table('users')->insert($param);

        $param = [
            'name' => 'UserName3',
            'email' => 'User3@mailaddress.com',
            'password' => bcrypt('password'),
        ];
        DB::table('users')->insert($param);

        $param = [
            'name' => 'UserName4',
            'email' => 'User4@mailaddress.com',
            'password' => bcrypt('password'),
        ];
        DB::table('users')->insert($param);
        $param = [
            'name' => 'User5Name',
            'email' => 'User@mailaddress.com',
            'password' => bcrypt('password'),
        ];
        DB::table('users')->insert($param);
    }
}
