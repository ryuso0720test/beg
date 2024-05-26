@extends('layouts.app')

@section('css')
<link rel="stylesheet" href="{{ asset('css/date.css') }}">
<script src="https://cdn.tailwindcss.com"></script>
@endsection

@section('content')
<div class="date__content">
  <div class="date-title__content">
    <div class="date-title__center">
      <div class="title">ユーザーリスト</div>
    </div>
  </div>


  <div class="date__main">
      <table class="date-table" >
          <tr class="date__header">
              <th class="date-table__header">ユーザー名</th>
              <th class="date-table__header"></th>
          </tr>

          @foreach ($users as $user)
          <tr>
            <form action="/attendance/{{ $user['id'] }}">
              <td class="date-table__row">
                <p class="date-table__item-input">{{ $user['name'] }}</p>
              </td>
              <td class="date-table__row">
                <button class="info-btn">勤怠情報</button>
                <input type="hidden" id="user_id" name="user_id" value="{{ $user['id'] }}" readonly />
              </td>
            </form>
          </tr>
          @endforeach
      </table>
  </div>
  <div class="page">{{ $users->onEachSide(0)->links('vendor.pagination.tailwind') }}</div>

</div>

</div>
@endsection