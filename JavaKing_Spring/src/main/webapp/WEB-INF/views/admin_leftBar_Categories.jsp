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
<div class="mb-7">
	<div style="display:block;" class="mb-3 p-2 bg-primary text-white text-center">
    	<h3 class="h5 my-0 font-weight-bold">관리자 페이지</h3>
	</div>
    <div id='cssmenu' class="border rounded">
      <!-- Categories List -->
	 <ul>
	   <li class='active has-sub'><a>학적</a>
	   		<ul>
	         <li><a href='/admin/adminStudentInfo.do'>학생 기본정보 관리</a></li>
	         <li><a href='/admin/adminCalendar.do'>학사일정 관리</a></li>
	      </ul>
	   </li>
	   <li class='active has-sub'><a>등록금</a>
	      <ul>
	         <li><a href='/admin/insertRegister.do'>등록금 등록</a></li>         
	         <li><a href='/admin/listRegfee.do'>등록금 미납관리</a></li>         
	      </ul>
	   </li>
	   <li class='active has-sub'><a>강의</a>
	      <ul>
	         <li><a href="/admin/insertProfessor.do">교수정보 관리</a></li>         
	         <li><a href="/admin/adminGrade.do">성적정보 관리</a></li>         
	         <li><a href="/admin/class.do">강의정보 관리</a></li>         
	      </ul>
	   </li>
	</ul>   
    </div>
  </div>
  <!--====== End Categories ==-->