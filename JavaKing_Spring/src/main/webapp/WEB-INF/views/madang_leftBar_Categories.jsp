<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/styles.css">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="../script/script.js"></script>
<!-- <script src="../assets/vendor/bootstrap/bootstrap.min.js"></script> -->
</head>
<!--============ Categories ==-->
<div class="mb-7">
	<div style="display:block;" class="mb-3 p-2 bg-primary text-white text-center">
    	<h3 class="h5 my-0 font-weight-bold">마당목록</h3>
	</div>
    <div id='cssmenu' class="border rounded">
      <!-- Categories List -->
	 <ul>
	   <li class='active has-sub'><a>알림마당</a>
	   		<ul>
	         <li><a href='/login/listBoard.do?board_boardno=100'>공지사항</a></li>
	         <li><a href='/login/calendar.do'>학사일정</a></li>
	         <li><a href='/login/map.do'>오시는길</a></li>
	      </ul>
	   </li>
	   <li class='active has-sub'><a>참여마당</a>
	      <ul>
	         <li><a href='/login/listStudy.do'>비트스터디</a></li>
	         <li><a href='/login/listBoard.do?board_boardno=300&board_category=자유게시판'>자유게시판</a></li>
	         <li><a href='/login/listBoard.do?board_boardno=300&board_category=익명게시판'>익명게시판</a></li>
	         <li class='active has-sub'><a>중고장터</a>
	         	<ul>
	               <li><a href='/login/listBoard.do?board_boardno=300&board_category=삽니다'>삽니다</a></li>
	               <li><a href='/login/listBoard.do?board_boardno=300&board_category=팝니다'>팝니다</a></li>
            	</ul>
	         </li>       
	      </ul>
	   </li>
	   <li class='active has-sub'><a>도움마당</a>
	      <ul>
	         <li><a href='/login/listBoard.do?board_boardno=200&board_category=시설QNA'>시설Q&A</a></li>         
	         <li><a href='/login/listBoard.do?board_boardno=200&board_category=학사QNA'>학사Q&A</a></li>         
	      </ul>
	   </li>
	</ul>   
    </div>
  </div>
  <!--====== End Categories ==-->