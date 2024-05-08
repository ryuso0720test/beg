<?php

namespace App\Http\Controllers;
use App\Models\User;
use App\Models\Work;
use App\Models\Rest;
use Carbon\Carbon;

use Illuminate\Http\Request;

class RestController extends Controller
{
    // 勤務終了
    public function storeRest(Request $request)
    {

        $rest = $request->only([
            'start_time',
        ]);

        //ユーザーID取得
        $id = auth()->id();

        //日付取得
        $date = date('Y-m-d');

        $works = Work::select('id')->get();

        // 該当workId取得
        $s = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->orderBy('id', 'desc')
        ->value('id');


        // 
        $rest["work_id"] = $s;

        Rest::create($rest);

        return redirect('/');
    }

    public function updateRest(Request $request)
    {
        $rest = $request->only([
            'end_time',
        ]);

        // ユーザーID取得
        $id = auth()->id();

        // 現在日付取得
        $date = date('Y-m-d');

        // 該当workId取得
        $id = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->where('end_time',NULL)
        ->orderBy('id', 'desc')
        ->value('id');

        // 休憩開始時間取得
        $rest_start = Rest::query()
        ->where('work_id',$id)
        ->where('end_time',NULL)
        ->value('start_time');

        // 1.開始日時を設定
        $startDate = new Carbon($rest_start);

        // 2.終了日時を設定
        $endDate = new Carbon($rest['end_time']);

        // 3.差分の秒数を計算
        $diffInSeconds = $startDate->diffInSeconds($endDate);

        // 4.秒数から時間、分、秒を計算
        $hours = floor($diffInSeconds / 3600);
        $minutes = floor(($diffInSeconds % 3600) / 60);
        $seconds = $diffInSeconds % 60;

        // 休憩時間セット
        $intervel =date('H:i:s',mktime($hours,$minutes,$seconds)); 

        $rest["rest_time"] = $intervel;

        // dd($rest);

        Rest::query()
        ->where('work_id',$id)
        ->where('end_time',NULL)
        ->update($rest);

        return redirect('/');
    }
}
