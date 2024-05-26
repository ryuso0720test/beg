<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class AuthController extends Controller
{
    public function index()
    {
        //ユーザーID取得
        $id = auth()->id();
        $userName = User::query()
        ->where('id',$id)
        ->value('name');

        return view('index',compact('userName'));
    }

}
