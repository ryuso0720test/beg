@extends('layouts.app')

@section('css')
<link rel="stylesheet" href="{{ asset('css/index.css') }}">
@endsection

@section('content')

<div class="attendance__content">
  <div class="attendance__alert">
    テスト太郎さんお疲れ様です!
  </div>
  <div class="attendance__content-area">
    <div class="attendance__panel-top">
      <form class="attendance__button">
        <button class="attendance__button-submit" type="submit">勤務開始</button>
      </form>
      <form class="attendance__button">
        <button class="attendance__button-submit" type="submit">勤務終了</button>
      </form>
    </div>
    <div class="attendance__panel-bottom">
      <form class="attendance__button">
        <button class="attendance__button-submit" type="submit">休憩開始</button>
      </form>
      <form class="attendance__button">
        <button class="attendance__button-submit" type="submit">休憩終了</button>
      </form>
    </div>
  </div>
</div>
@endsection