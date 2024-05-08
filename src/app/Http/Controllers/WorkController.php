<?php

namespace App\Http\Controllers;
use App\Models\User;
use App\Models\Work;
use App\Models\Rest;
use Carbon\Carbon;

use Illuminate\Http\Request;

class WorkController extends Controller
{
    public function store(Request $request)
    {
        $work = $request->only([
            'start_time',
            'date',
            'user_id'
        ]);
        // //ユーザーID取得
        // $id = auth()->id();

        // //日付取得
        // $date = date('Y-m-d');

        // //現在日時取得
        // $now = now()->format('H:i');

        Work::create($work);
        return redirect('/');
    }

    // 勤務終了
    public function store_end(Request $request)
    {

        $work = $request->only([
            'end_time',
        ]);

        //ユーザーID取得
        $id = auth()->id();

        //日付取得
        $date = date('Y-m-d');

        // workIdを取得
        $work_id = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->where('end_time',NULL)
        ->value('id');

        if($work_id == NULL)
        {
            dd();
            return;
        }

        // 
        $total_rest = Rest::query()
        ->selectRaw('SUM(time_to_sec(rest_time) )as sec')
        ->where('work_id',$work_id)
        ->value('sec');

        // 秒数から時間、分、秒を計算
        $hours = floor($total_rest / 3600);
        $minutes = floor(($total_rest % 3600) / 60);
        $seconds = $total_rest % 60;

        // 休憩時間セット
        $rest_time =date('H:i:s',mktime($hours,$minutes,$seconds)); 
        $work["rest_time"] = $rest_time;


        // 勤務時間計算
        $start_time = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->where('end_time',NULL)
        ->value('start_time');

        // 1.開始日時を設定
        $startDate = new Carbon($start_time);

        // 2.終了日時を設定
        $endDate = new Carbon($work['end_time']);

        // 3.差分の秒数を計算
        $diffInSeconds = $startDate->diffInSeconds($endDate);

        $work_time_sec = $diffInSeconds - $total_rest;

        $hours = floor($work_time_sec / 3600);
        $minutes = floor(($work_time_sec % 3600) / 60);
        $seconds = $work_time_sec % 60;

        // 勤務時間セット
        $work_time =date('H:i:s',mktime($hours,$minutes,$seconds)); 

        $work["work_time"] = $work_time;


        $s = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->where('end_time',NULL)
        ->where('work_time',NULL)
        ->update($work);

        // dd($s);
        return redirect('/');
    }

    public function show ()
    {
        return view('date');
    }


}
