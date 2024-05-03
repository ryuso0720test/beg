<?php

namespace App\Http\Controllers;
use App\Models\User;
use App\Models\Work;

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
        //ユーザーID取得
        $id = auth()->id();

        //日付取得
        $date = date('Y-m-d');

        //現在日時取得
        $now = now()->format('H:i');

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

        $s = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->update($work);

        // dd($s);
        return redirect('/');
    }

    public function show ()
    {
        return view('date');
    }


}
