@extends('layouts.app')

@section('css')
<link rel="stylesheet" href="{{ asset('css/date.css') }}">
@endsection

@section('content')
<div class="date__content">
  <div class="date-title__content">
    <div class="date-title__left"><</div>
    <div class="date-title__center">
      <div class="title">2022-11-22</div>
    </div>
    <div class="date-title__right">></div>
  </div>


  <div class="date__main">
      <table class="date-table" >
          <tr class="date__header">
              <th class="date-table__header">名前</th>
              <th class="date-table__header">勤務開始</th>
              <th class="date-table__header">勤務終了</th>
              <th class="date-table__header">休憩時間</th>
              <th class="date-table__header">勤務時間</th>
          </tr>

          <tr>
            <form action="">
              <td class="date-table__row">
                <p class="date-table__item-input">テスト太郎</p>
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">10:00:00</p>
              </td>
              <td class="date-table__row">
                <p class="date-table__item-input">20:00:00</p>
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">20:00:00</p>
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">20:00:00</p>
              </td>
            </form>
          </tr>

      </table>
  </div>

</div>
@endsection