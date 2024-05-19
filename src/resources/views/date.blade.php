@extends('layouts.app')

@section('css')
<link rel="stylesheet" href="{{ asset('css/date.css') }}">
<script src="https://cdn.tailwindcss.com"></script>
@endsection

@section('content')
<div class="date__content">
  <div class="date-title__content">
    <div class="date-title__left"><</div>
    <div class="date-title__center">
      <div class="title"><?php echo \Carbon\Carbon::now()->format('Y-m-d');?></div>
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

          @foreach ($works as $work)
          <tr>
            <form action="">
              <td class="date-table__row">
                @foreach ($users as $user =>$value )
                            @if($value['id'] == $work['user_id'])
                                <p class="contact-table__item-input">{{ $value['name'] }}</p>
                            @endif
                @endforeach
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">{{ $work['start_time'] }}</p>
              </td>
              <td class="date-table__row">
                <p class="date-table__item-input">{{ $work['end_time'] }}</p>
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">{{ $work['rest_time'] }}</p>
              </td>
              <td class="date-table__row">
                  <p class="date-table__item-input">{{ $work['work_time'] }}</p>
              </td>
            </form>
          </tr>
        @endforeach
      </table>
  </div>

  <div class="page">{{ $works->onEachSide(0)->links('vendor.pagination.tailwind') }}</div>

</div>
@endsection