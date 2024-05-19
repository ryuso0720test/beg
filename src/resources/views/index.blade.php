@extends('layouts.app')

@section('css')
<link rel="stylesheet" href="{{ asset('css/index.css') }}">
@endsection

@section('content')

<div class="attendance__content">
  <div class="attendance__alert">
    {{ $userName}}さんお疲れ様です!
  </div>
  <!-- フラッシュメッセージ -->
  @if (session('flash_message'))
      <div class="flash_message">
          {{ session('flash_message') }}
      </div>
  @endif
  <div class="attendance__content-area">
    <div class="attendance__panel-top">
      <form class="attendance__button" action="/workStart" method="post">
        @csrf
        <button class="attendance__button-submit" type="submit">勤務開始</button>
        <input type="hidden" id="start_time" name="start_time" value="<?php echo \Carbon\Carbon::now()->format('H:i:s');?> " readonly />
        <input type="hidden" id="date" name="date" value="<?php echo date('Y-m-j');?> " readonly />
        <input type="hidden" id="user_id" name="user_id" value="<?php echo Auth::id(); ?> " readonly />

      </form>
      <form class="attendance__button" action="/workEnd" method="post">
        @csrf
        <button class="attendance__button-submit" type="submit">勤務終了</button>
        <input type="hidden" id="end_time" name="end_time" value="<?php echo \Carbon\Carbon::now()->format('H:i:s');?> " readonly />
      </form>
    </div>
    <div class="attendance__panel-bottom">
      <form class="attendance__button" action="/restStart" method="post">
        @csrf
        <button class="attendance__button-submit"  type="submit">休憩開始</button>
        <input type="hidden" id="start_time" name="start_time" value="<?php echo \Carbon\Carbon::now()->format('H:i:s');?> " readonly />
      </form>
      <form class="attendance__button" action="/restEnd" method="post">
        @csrf
        <button class="attendance__button-submit" type="submit">休憩終了</button>
        <input type="hidden" id="end_time" name="end_time" value="<?php echo \Carbon\Carbon::now()->format('H:i:s');?> " readonly />
      </form>
    </div>
  </div>
</div>
@endsection