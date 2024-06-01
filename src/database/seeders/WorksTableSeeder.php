<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WorksTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $param = [
            'user_id' => '1',
            'start_time' => '09:00:00',
            'date' => '2024-06-01',
            'end_time' => '18:00:00',
            'work_time' => '08:00:00',
            'rest_time' => '01:00:00',
        ];
        DB::table('works')->insert($param);

        $param = [
            'user_id' => '2',
            'start_time' => '09:00:00',
            'date' => '2024-06-01',
            'end_time' => '18:00:00',
            'work_time' => '08:00:00',
            'rest_time' => '01:00:00',
        ];
        DB::table('works')->insert($param);

        $param = [
            'user_id' => '3',
            'start_time' => '09:00:00',
            'date' => '2024-06-01',
            'end_time' => '18:00:00',
            'work_time' => '08:00:00',
            'rest_time' => '01:00:00',
        ];
        DB::table('works')->insert($param);

        $param = [
            'user_id' => '4',
            'start_time' => '09:00:00',
            'date' => '2024-06-01',
            'end_time' => '18:00:00',
            'work_time' => '08:00:00',
            'rest_time' => '01:00:00',
        ];
        DB::table('works')->insert($param);
    }
}
