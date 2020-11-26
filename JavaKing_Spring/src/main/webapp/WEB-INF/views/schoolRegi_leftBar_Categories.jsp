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
    	<h3 class="h5 my-0 font-weight-bold">학사정보</h3>
	</div>
    <div id='cssmenu' class="border rounded">
      <!-- Categories List -->
	 <ul>
	   <li class='active has-sub'><a>학적</a>
	   		<ul>
	         <li><a href='/login/studentInfo.do'>학적조회</a></li>
	         <li><a href='/login/change.do'>학적변동</a></li>
	      </ul>
	   </li>
	   <li class='active has-sub'><a>성적</a>
	      <ul>
	         <li><a href='/login/listGrade.do'>성적조회</a></li>         
	      </ul>
	   </li>
	   <li class='active has-sub'><a>등록</a>
	      <ul>
	         <li><a href='/login/listRegister.do'>등록금납부조회</a></li>         
	      </ul>
	   </li>
	   <li class='active has-sub'><a>수강</a>
	      <ul>
	      	<li><a href='/login/classSearch.do'>통합강의정보</a></li>   
	         <li><a href="/login/detailClass.do">수강내역조회</a></li>         
	         <li><a href="/login/classReg.do">수강신청</a></li>         
	         <li><a href="/login/classRegCheck.do">수강신청확인</a></li>         
	      </ul>
	   </li>
	   <li class='active has-sub'><a>대학정보</a>
	      <ul>
	         <li><a href='/classInfo.do'>학부별강의목록</a></li>         
	         <li><a href='/login/listProfessor.do'>교수정보</a></li>         
	      </ul>
	   </li>
	</ul>   
    </div>
  </div>
  <!--====== End Categories ==-->