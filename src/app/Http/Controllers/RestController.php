<?php

namespace App\Http\Controllers;
use App\Models\User;
use App\Models\Work;
use App\Models\Rest;

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

        //ユーザーID取得
        $id = auth()->id();

        //日付取得
        $date = date('Y-m-d');

        // 該当workId取得
        $id = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->value('id');

        Rest::query()
        ->where('work_id',$id)
        ->update($rest);

        return redirect('/');
    }
}
