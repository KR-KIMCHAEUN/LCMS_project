<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
  /* body 스타일 */
  html, body {
    overflow: hidden;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
  /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
  .fc-header-toolbar {
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }
</style>
<div class="card card-body">
<h1 style="text-align:center;">HRU 학사일정</h1>
  <div id='calendar-container'>
    <div id='calendar'></div>
  </div>
</div>
<div class="modal fade schdlModal" id="exampleModal" tabindex="-1"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModal">일정 추가하기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
               aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <input type="text" id="schdlTitle" placeholder="내용"
               class="dateInput">
            <!--             <label>내용</label> -->
            <span></span> <br /> <input type="date" id="schdlStart"
               placeholder="날짜 선택" required aria-required="true"
               class="dateInput my-2" /><br /> <input type="date" id="schdlEnd"
               placeholder="날짜 선택" required aria-required="true"
               class="dateInput mb-2" /><br /> <select id="color"
               class="schdlColor">
               <option>색상선택</option>
               <option value="#f6714f">빨강색</option>
               <option value="#f9cb71">주황색</option>
               <option value="#d8fe66">노랑색</option>
               <option value="#a9fa83">초록색</option>
               <option value="#77c4f7">파랑색</option>
               <option value="#fa75c7">남색</option>
               <option value="#cca7fa">보라색</option>
            </select>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-light" data-bs-dismiss="modal">
               취소</button>
            <button type="button" class="btn btn-warning" id="saveChanges">
               추가</button>
         </div>
      </div>
   </div>
</div>
  <script>
  (function(){
    $(function(){
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        //initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        // 이벤트 
events: function(info, successCallback, failureCallback) {
    $.ajax({
        url: 'infoMain/getInfo',
        dataType: 'json',
        success: function(response) {
            // 서버에서 받은 JSON 데이터를 이벤트 배열로 변환
            var events = [];
            response.aList.forEach(function(event) {
         
                events.push({
                    title: event.cldrMemo,
                    start: event.cldrStart,
                    end: event.cldrEnd,
                    backgroundColor: event.cldrColor
                });
            });
            successCallback(events);
        },
        error: function(error) {
            console.error('Error fetching events:', error);
            failureCallback(error);
        }
    });
}
          });
      // 캘린더 랜더링
      calendar.render();
    });
  })();
  </script>