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
        //ユーザーID取得
        $id = auth()->id();

        //現在日付取得
        $date = date('Y-m-d');

        $work_id = Work::query()
        ->where('user_id',$id)
        ->where('date',$date)
        ->value('id');

        if($work_id != null)
        {
            return redirect('/')->with('flash_message', '本日はすでに勤務開始が登録済み');
        }

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
            return redirect('/')->with('flash_message', 'すでに勤務終了済みまたは勤務開始が押されていません');
        }
        // restIdを取得
        $rest_id = Rest::query()
        ->where('work_id',$work_id)
        ->where('start_time',!NULL)
        ->where('end_time',NULL)
        ->value('id');
        if($rest_id != NULL)
        {
            return redirect('/')->with('flash_message', '休憩中のため勤務終了できません');
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
        //日付取得
        $date = date('Y-m-d');

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->paginate(5);
        
        $users = User::all();

        return view('date',compact('works','users','date'));
    }

    public function userList()
    {
        $users = User::orderBy('updated_at', 'desc')
        ->paginate(5);

        return view('userList',compact('users'));
    }

    /** 次の日 */
    public function dateNext(Request $request)
    {
        $c = $request->only([
            'next-date',
        ]);
        $day =  $c["next-date"];
        $date = date('Y-m-d',strtotime($day . '+1 day'));
        $currentDay = date('Y-m-d');

        //未来の場合
        if($currentDay < $date)
        {
            return redirect('/attendance');
        }

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->paginate(5);
        $users = User::all();

        return view('date',compact('works','users','date'));
    }

    /** 前の日 */
    public function datePre(Request $request)
    {
        $c = $request->only([
            'pre-date',
        ]);
        $day =  $c["pre-date"];
        $date = date('Y-m-d',strtotime($day . '-1 day'));

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->paginate(5);
        $users = User::all();

        return view('date',compact('works','users','date'));
    }

    public function user_date(Request $request)
    {
        $id = $request->only([
            'user_id',
        ]);
        $user_id = $id['user_id'];
        $user_name = User::query()
        ->where('id',$user_id)
        ->value('name');

        $date = date('Y-m-d');

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->where('user_id',$user_id)
        ->paginate(5);

        return view('date-user',compact('works','user_name','date','user_id'));
    }

    /** ユーザー毎 次の日 */
    public function dateNextUser(Request $request)
    {
        $c = $request->only([
            'next-date',
            'user_id',
        ]);
        $day =  $c["next-date"];
        $user_id =  $c["user_id"];

        $user_name = User::query()
        ->where('id',$user_id)
        ->value('name');

        $date = date('Y-m-d',strtotime($day . '+1 day'));
        $currentDay = date('Y-m-d');

        //未来の場合
        if($currentDay < $date)
        {
            return redirect('/attendance');
        }

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->where('user_id',$user_id)
        ->paginate(5);
        $users = User::all();

        return view('date-user',compact('works','user_name','date','user_id'));
    }

    /**ユーザー毎 前の日 */
    public function datePreUser(Request $request)
    {
        
        $c = $request->only([
            'pre-date',
            'user_id',
        ]);
        $user_id =  $c["user_id"];
        $day =  $c["pre-date"];
        $date = date('Y-m-d',strtotime($day . '-1 day'));

        $user_name = User::query()
        ->where('id',$user_id)
        ->value('name');

        //データ取得
        $works = Work::query()
        ->where('date',$date)
        ->where('user_id',$user_id)
        ->paginate(5);
        $users = User::all();

        return view('date-user',compact('works','user_name','date','user_id'));
    }


}
