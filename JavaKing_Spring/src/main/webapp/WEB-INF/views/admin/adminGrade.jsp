<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Title -->
<title>:: 비트대학교 ::</title>

<!-- Required Meta Tags Always Come First -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Favicon -->
<link rel="shortcut icon" href="../../favicon.ico">

<!-- Google Fonts -->
<link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">

<!-- CSS Implementing Plugins -->
<link rel="stylesheet" href="../../assets/vendor/font-awesome/css/all.min.css">
<link rel="stylesheet" href="../../assets/vendor/hs-megamenu/src/hs.megamenu.css">
<link rel="stylesheet" href="../../assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="../../assets/vendor/custombox/dist/custombox.min.css">
<link rel="stylesheet" href="../../assets/vendor/animate.css/animate.min.css">

<!-- CSS Space Template -->
<link rel="stylesheet" href="../../assets/css/theme.css">
<!-- JS Implementing Plugins -->

<style type="text/css">
/*강의리스트 tr 클릭 색상*/
.selectClassInfoTr {
	background-color: #083b90;
	color: white;
}
/*학생리스트 tr 클릭 색상*/
.selectClassStdInfoTr {
	background-color: #083b90;
	color: white;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
window.onload = function(){
	var csrf_token = "{{ csrf_token() }}";
	
	$.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                xhr.setRequestHeader("X-CSRFToken", csrf_token);
            }
        }
    });
	
	//객체(노드) 자체를 갖고온다
	const insertForm = document.getElementById("insertForm");
	const updateForm = document.getElementById("updateForm");
	const deleteForm = document.getElementById("deleteForm");
	
	const addGrade = document.getElementById("addGrade");	
	const btnAdd = document.getElementById("btnAdd");
	
	const studentList = document.getElementById("studentList");
	const delModal = document.getElementById("delModal");
	const btnDel = document.getElementById("btnDel");
	const delGrade = document.getElementById("delGrade");
	const upGrade = document.getElementById("upGrade");
	
	const grade_class_no = document.getElementById("grade_class_no");
	const className = document.getElementById("className");
	const proName = document.getElementById("proName");
	const std_no = document.getElementById("std_no");
	const grade_no = document.getElementById("grade_no");

	const tbody = document.getElementById("tbody");

	const alter_grade_level = document.getElementById("alter_grade_level");
	const alter_grade_semester = document.getElementById("alter_grade_semester");
	const alter_grade_score = document.getElementById("alter_grade_score");
	const alter_grade_regcredit = document.getElementById("alter_grade_regcredit");
	const alter_grade_getcredit = document.getElementById("alter_grade_getcredit");
	const alter_class_no = document.getElementById("alter_class_no");
	const alter_grade_no = document.getElementById("alter_grade_no");
	const alter_std_no = document.getElementById("alter_std_no");

	
	/*-------------------------강의 정보 가져오기--------------------------*/
	
	/*년도,학기 선택 후 강의 조회버튼 클릭시*/
	search.addEventListener("click",function(e){
		classList();
	});

	/*년도,학기를 매개변수로 강의정보 ajax연결 통해 가져오는 함수 detailClassController 사용*/
	function classList(){
		const cYear = document.getElementById("class_year");
		var classyear = cYear.value;
		const cSemester = document.getElementById("classreg_semester");
		var classregsemester = cSemester.value;
		console.log(classyear);
		console.log(classregsemester);
		$.ajax({
			url : "/admin/detailClassGrade.do",
			type : "POST",
			data : {
				"class_year":classyear, 
				"classreg_semester":classregsemester
			},
			beforeSend : function(xhr)
			  {
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			success : function(list){
				console.log(list);
				setList(list);
			},
			error : function(){
				alert("에러발생");
			}
		})
	}

	/*년도,학기 선택 후 강의 조회버튼 눌렀을때 동적노드로 생성할 강의정보테이블*/
	function setList(list){
		tbody.innerHTML = '';
		for(let i in list){
			const cv = list[i];
			const tr = document.createElement("tr");
			tr.className = "classInfoTr";
			tr.setAttribute("class_year",cv.class_year);
			tr.setAttribute("classreg_semester",cv.classreg_semester);
			tr.setAttribute("class_no",cv.class_no);
			tr.setAttribute("class_name",cv.class_name);
			tr.setAttribute("pro_name",cv.pro_name);
			let str = '<td name="year">'+cv.class_year+'</td>\
			<td name="semester">'+cv.classreg_semester+'</td>\
			<td name="class_type">'+cv.class_type+'</td>\
			<td name="class_no">'+cv.class_no+'</td>\
			<td name="class_name"><span  id="getClass" class_no='+cv.class_no+'>'+cv.class_name+'</span></td>\
			<td name="pro_name">'+cv.pro_name+'</td>\
			<td name="class_credit">'+cv.class_credit+'</td>\
			<td name="class_dayofweek_class_time">'+cv.class_dayofweek+cv.class_time+'</td>'
			tr.innerHTML = str;
			tbody.append(tr);

			//tr내부 클릭시 클릭한 노드의 정보 전달+배경색 바뀜
			tr.addEventListener("click", function(e){
				const class_year = this.getAttribute("class_year");
				const classreg_semester = this.getAttribute("classreg_semester");
				const class_no = this.getAttribute("class_no");
				const class_name = this.getAttribute("class_name");
				const pro_name = this.getAttribute("pro_name");
				btnDel.setAttribute("class_no",class_no);
				btnAdd.setAttribute("class_no",class_no);

				grade_class_no.value = class_no;

				className.innerHTML = class_name;
				console.log(className);
				proName.innerHTML = pro_name;
				console.log(proName);

				const classInfoTrList = document.querySelectorAll("#tbody tr");
				Array.from(classInfoTrList).forEach(function(tr, i) {
					  tr.className = "classInfoTr";
				})
				this.className ="selectClassInfoTr";
			});
		}
	}//

	/*-------------------------학생 정보 가져오기--------------------------*/

	/*수정/삭제버튼 클릭시 학생리스트 ajax 연결*/
	btnDel.addEventListener("click",function(e){
		updateForm.reset();
		stdInfo();
	});

	/*학생리스트 ajax연결로 가져오는 함수*/
	function stdInfo(){
		const class_no = btnDel.getAttribute("class_no");
		if(class_no=="0"){
			alert("과목을 선택해주세요");
			btnDel.stopPropagation();
			btnDel.preventDefault();
			return;
		}
		$.ajax({
			url : "/admin/stdListGrade.do",
			type : "POST",
			data : {	
				"class_no":class_no
			},
			beforeSend : function(xhr)
			  {
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			success : function(slist){
				console.log(slist);
				setStdList(slist);
			},
			error : function(){
				alert("에러발생");
			}
		})
	}

	/*성적 수정/삭제 창 내부에 띄울 해당 과목 수강학생 목록을 동적노드로 받아온다*/
	function setStdList(slist){
		studentList.innerHTML = '';
		console.log(slist)
		for(let j in slist){
			const cs = slist[j];
			const tr2 = document.createElement("tr");
			tr2.className = "classStdInfoTr";
			tr2.setAttribute("grade_no",cs.grade_no);
			tr2.setAttribute("std_no",cs.std_no);
			tr2.setAttribute("class_no",cs.class_no);
			tr2.setAttribute("grade_level",cs.grade_level);
			tr2.setAttribute("grade_semester",cs.grade_semester);
			tr2.setAttribute("grade_regcredit",cs.grade_regcredit);
			tr2.setAttribute("grade_getcredit",cs.grade_getcredit);
			tr2.setAttribute("grade_score",cs.grade_score);
			let str2 = '<td name="std_name">'+cs.std_name+'</td>\
			<td name="std_no">'+cs.std_no+'</td>\
			<td name="class_type">'+cs.class_type+'</td>\
			<td name="grade_getcredit">'+cs.grade_getcredit+'</td>\
			<td name="grade_score">'+cs.grade_score+'</td>\
			<td name="grade_rank">'+cs.grade_rank+'</td>\''
			tr2.innerHTML = str2;
			studentList.append(tr2);
			console.log(studentList);
 
			/*tr내부 클릭시 클릭한 노드의 정보 전달+배경색 바뀜*/
			tr2.addEventListener("click", function(e){
				const grade_no = this.getAttribute("grade_no");
				const std_no = this.getAttribute("std_no");
				const class_no = this.getAttribute("class_no");
				const grade_level = this.getAttribute("grade_level");
				const grade_semester = this.getAttribute("grade_semester");
				const grade_regcredit = this.getAttribute("grade_regcredit");
				const grade_getcredit = this.getAttribute("grade_getcredit");
				const grade_score = this.getAttribute("grade_score");

				alter_grade_no.value = grade_no;
				alter_std_no.value = std_no;
				alter_class_no.value = class_no;
				alter_grade_level.value = grade_level;
				alter_grade_semester.value = grade_semester;
				alter_grade_regcredit.value = grade_regcredit;
				alter_grade_getcredit.value = grade_getcredit;
				alter_grade_score.value = grade_score;
				
				delGrade.setAttribute("grade_no",grade_no);
				
				const classStdInfoTrList = document.querySelectorAll("#studentList tr");
				Array.from(classStdInfoTrList).forEach(function(tr, j) {
					  tr.className = "classStdInfoTr";
				})
				this.className ="selectClassStdInfoTr";		
			});	
		} 
	}
	
	/*-------------------------성적 등록--------------------------*/

	/*강의 선택 후 성적등록 버튼 클릭시 성적번호 자동생성*/
	btnAdd.addEventListener("click",function(e){
		console.log("성적 등록 버튼 누름");
		insertForm.reset();
		grade_class_no.value= btnAdd.getAttribute("class_no");
		getNextNo();
	});

	/*성적등록시 성적번호 자동생성하는 함수*/
	function getNextNo(){
		$.ajax({
			url : "/admin/getNextNoGrade.do",
			type : "POST",
			data : {
			},
			beforeSend : function(xhr)
			  {
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			success : function(no){
				console.log(no);
				grade_no.value=no;
			},
			error : function(){
				alert("에러발생");
			}
		})
	}
	
	/*모달창 내부에서 성적 등록 버튼 클릭시 ajax 연결*/
	addGrade.addEventListener("click",function(e){
		//폼데이터 객체생성시 생성자값으로 폼의 태그를 넣으면
		//input태그에 한하여 네임이 키값이 되고, value가 value가 된다.
		//like 제이슨 데이터
		const formData = new FormData(insertForm);
		$.ajax({
			url:"/admin/adminGrade.do",
			type:"post",
			data:formData,
			beforeSend : function(xhr)
			  {
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			contentType: false,
			processData: false,
			success:function(re){
				if(re=='1'){
					alert("등록 성공!");
					insertForm.reset();
					$('#addModal').modal('hide');
				}else{
					alert("등록 오류!");
				}
			},
			error:function(){
				console.log("에러발생");
			}
		})
	});

	/*-------------------------성적 수정/삭제--------------------------*/
	
	/*모달창 내부에서 성적 수정 버튼 클릭시 ajax 연결*/
	upGrade.addEventListener("click",function(e){
		const formData = new FormData(updateForm);
		$.ajax({
			url:"/admin/updateGrade.do",
			type:"post",
			data:formData,
			beforeSend : function(xhr){
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			contentType: false,
			processData: false,
			success:function(re){
				if(re=='1'){
					alert("수정 성공!");
					updateForm.reset();
					stdInfo();
				}else{
					alert("수정 오류!");
				}
			},
			error:function(){
				console.log("에러발생");
			}
		})
	});

	/*모달창 내부에서 성적 삭제 버튼 클릭시 ajax 연결*/
	delGrade.addEventListener("click",function(e){
		const grade_no = delGrade.getAttribute("grade_no");
		if(grade_no=="0"){
			alert("삭제할 행을 선택해주세요");
			return;
		}
		$.ajax({
			url : "/admin/deleteGrade.do",
			type : "POST",
			data : {
				"grade_no":grade_no
			},
			beforeSend : function(xhr)
			  {
			   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			   var token = $("#token");
			   console.log($(token).attr("data"));
			   console.log($(token).val());
			   xhr.setRequestHeader($(token).attr("data"), $(token).val());
			  },
			success : function(re){
				if(re=='1'){
					alert("삭제 성공!");
					updateForm.reset();
					stdInfo();
				}else{
					alert("삭제 오류!");
				}
			},
			error : function(){
				alert("에러발생");
			}
		})
	});
}
</script>
</head>
<body>
	<!-- Skippy -->
	<a id="skippy" class="sr-only sr-only-focusable u-skippy"
		href="#content">
		<div class="container">
			<span class="u-skiplink-text">Skip to main content</span>
		</div>
	</a>
	<!-- End Skippy -->

	<!-- ========== HEADER ========== -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- ========== END HEADER ========== -->

	<!-- ========== MAIN CONTENT ========== -->
	<main id="content">
		<!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna">성적정보 관리</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
			<div class="row">
				<div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
					<!-- Hire Us Form -->

					<form>
					<input type="hidden" id="token" data="${_csrf.headerName}" value="${_csrf.token }">
						<br><h5>강의 조회</h5><br>
						<div class="form-inline form-group">
							<label class="h6 small d-block text-uppercase"> 년도 </label>
							<div class="col-sm-3">
								<select class="selectpicker form-control" id="class_year"
									name="class_year">
									<option disabled selected></option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
								</select>
							</div>
							<label class="h6 small d-block text-uppercase"> 학기 </label>
							<div class="col-sm-3">
								<select class="selectpicker form-control" id="classreg_semester"
									name="classreg_semester">
									<option disabled selected></option>
									<option value="1">1</option>
									<option value="2">2</option>
								</select>
							</div>

							<button type="button" id="search" class="btn btn-xs btn-primary">조회</button>
						</div>
					</form>
					<br>
					<table class="table table-sm table-hover">
						<thead>
							<tr>
								<th scope="col">년도</th>
								<th scope="col">학기</th>
								<th scope="col">이수구분</th>
								<th scope="col">과목번호</th>
								<th scope="col">과목명</th>
								<th scope="col">담당교수</th>
								<th scope="col">학점</th>
								<th scope="col">강의시간</th>
							</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
					<!-- modal 구동 버튼 (trigger) -->
					<button type="button" id="btnAdd" class="btn btn-xs btn-primary"
						data-toggle="modal" data-target="#addModal" class_no="0">&nbsp;성적
						등록&nbsp;</button>
					<button type="button" id="btnDel" class="btn btn-xs btn-primary"
						data-toggle="modal" data-target="#delModal" class_no="0">성적
						수정/삭제</button>

					<!-- 성적 등록 Modal -->
					<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="myModalLabel">성적 등록</h4>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form class="js-validate" id="insertForm">
									<input type="hidden" id="token" data="${_csrf.headerName}" value="${_csrf.token }">
										<div class="row">
											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														강의번호 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="grade_class_no" name="class_no" required readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학번
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="std_no" name="std_no" required placeholder="학번 입력">
													</div>
												</div>
											</div>

											<div class="w-100"></div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학년
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="grade_semester" name="grade_semester" required
															placeholder="1/2/3/4">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학기
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															name="grade_level" required placeholder="1/2">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														성적번호 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="grade_no" name="grade_no" required readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														수강학점 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															name="grade_regcredit" required placeholder="1/2/3">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														취득점수 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															name="grade_getcredit" required
															placeholder="4.5 4 3.5 3 2.5 2 1.5 1">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														백분율점수 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															name="grade_score" required placeholder="0~100점">
													</div>
												</div>
											</div>
										</div>
										<div class="text-center">
											<button type="button"
												class="btn btn-primary btn-sm btn-primary" id="addGrade">등록</button>
										</div>
									</form>
									<!-- End Hire Us Form -->
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End Pagination -->
					<!-- 성적 수정/삭제 Modal -->
					<div class="modal fade" id="delModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="myModalLabel">성적 수정/삭제</h4>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form class="js-validate" id="deleteForm">
									<input type="hidden" id="token" data="${_csrf.headerName}" value="${_csrf.token }">
										<span id="className" name="className"
											style="font-weight: bold;"></span>&nbsp;-&nbsp;<span
											id="proName" name="proName"></span>&nbsp;교수<br>
										<br>
										<table class="table table-sm table-hover">
											<thead>
												<tr>
													<th scope="col">학생이름</th>
													<th scope="col">학번</th>
													<th scope="col">이수</th>
													<th scope="col">점수</th>
													<th scope="col">백분율점수</th>
													<th scope="col">등급</th>
												</tr>
											</thead>
											<tbody id="studentList">
											</tbody>
										</table>
									</form>
									<form class="js-validate" id="updateForm">
									<input type="hidden" id="token" data="${_csrf.headerName}" value="${_csrf.token }">
										<div class="row">
											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														강의번호 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_class_no" name="class_no" required readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학번
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_std_no" name="std_no" required readonly>
													</div>
												</div>
											</div>

											<div class="w-100"></div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학년
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_level" name="grade_level" required
															placeholder="1/2/3/4">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 학기
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_semester" name="grade_semester" required
															placeholder="1/2">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														성적번호 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_no" name="grade_no" required readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														수강학점 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_regcredit" name="grade_regcredit"
															required placeholder="1/2/3">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														취득점수 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_getcredit" name="grade_getcredit"
															required placeholder="4.5 4 3.5 3 2.5 2 1.5 1">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase">
														백분율점수 <span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_grade_score" name="grade_score" required
															placeholder="0~100점">
													</div>
												</div>
											</div>
										</div>
										<div class="text-center">
											<button type="button"
												class="btn btn-primary btn-sm btn-primary" id="upGrade">수정</button>
											<button type="button"
												class="btn btn-primary btn-sm btn-primary" id="delGrade">삭제</button>
										</div>
									</form>
									<!-- End Hire Us Form -->
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End Pagination -->
				</div>

				<div class="col-lg-3 order-lg-1">
					<div class="portlet light profile-sidebar-portlet bordered">
						<!--     <div class="card-body user-profile-card mb-3">
              <img src="../upload/${sv.std_fname }" class="user-profile-image rounded-circle" alt="" width="160" height="160"/>
          </div>-->
						<hr>
						<!-- Categories -->
						<!-- ========== schoolRegi_leftBar_Categories 삽입 ========== -->
						<jsp:include page="../admin_leftBar_Categories.jsp"/>
						<!-- ========== END schoolRegi_leftBar_Categories 삽입 ========== -->
						<!-- End Categories -->
					</div>
				</div>
			</div>
			<!-- End News Blog Content -->
	</main>
	<!-- ========== END MAIN CONTENT ========== -->

	<!-- ========== FOOTER ========== -->
	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- ========== END FOOTER ========== -->

	<!-- Go to Top -->
	<a class="js-go-to u-go-to" href="javascript:;"
		data-position='{"bottom": 15, "right": 15 }' data-type="fixed"
		data-offset-top="400" data-compensation="#header"
		data-show-effect="slideInUp" data-hide-effect="slideOutDown"> <i
		class="fa fa-arrow-up u-go-to__inner"></i>
	</a>
	<!-- End Go to Top -->

	<!-- JS Global Compulsory -->
	<script src="../../assets/vendor/jquery/dist/jquery.min.js"></script>
	<script
		src="../../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
	<script src="../../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
	<script src="../../assets/vendor/bootstrap/bootstrap.min.js"></script>

	<!-- JS Implementing Plugins -->
	<script src="../../assets/vendor/hs-megamenu/src/hs.megamenu.js"></script>
	<script
		src="../../assets/vendor/jquery-validation/dist/jquery.validate.min.js"></script>
	<script
		src="../../assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="../../assets/vendor/custombox/dist/custombox.min.js"></script>
	<script
		src="../../assets/vendor/custombox/dist/custombox.legacy.min.js"></script>
	<script src="../../assets/vendor/instafeed.js/instafeed.min.js"></script>

	<!-- JS Space -->
	<script src="../../assets/js/hs.core.js"></script>
	<script src="../../assets/js/components/hs.header.js"></script>
	<script src="../../assets/js/components/hs.unfold.js"></script>
	<script src="../../assets/js/components/hs.validation.js"></script>
	<script src="../../assets/js/helpers/hs.focus-state.js"></script>
	<script src="../../assets/js/components/hs.malihu-scrollbar.js"></script>
	<script src="../../assets/js/components/hs.modal-window.js"></script>
	<script src="../../assets/js/components/hs.show-animation.js"></script>
	<script src="../../assets/js/components/hs.instagram.js"></script>
	<script src="../../assets/js/components/hs.go-to.js"></script>

	<!-- JS Plugins Init. -->
	<script>
    $(window).on('load', function () {
      // initialization of HSMegaMenu component
      $('.js-mega-menu').HSMegaMenu({
        event: 'hover',
        pageContainer: $('.container'),
        breakpoint: 991,
        hideTimeOut: 0
      });
    });

    $(document).on('ready', function () {
      // initialization of header
      $.HSCore.components.HSHeader.init($('#header'));

      // initialization of unfold component
      $.HSCore.components.HSUnfold.init($('[data-unfold-target]'), {
        afterOpen: function () {
          if (!$('body').hasClass('IE11')) {
            $(this).find('input[type="search"]').focus();
          }
        }
      });

      // initialization of form validation
      $.HSCore.components.HSValidation.init('.js-validate', {
        rules: {
          confirmPassword: {
            equalTo: '#password'
          }
        }
      });

      // initialization of forms
      $.HSCore.helpers.HSFocusState.init();

      // initialization of malihu scrollbar
      $.HSCore.components.HSMalihuScrollBar.init($('.js-scrollbar'));

      // initialization of autonomous popups
      $.HSCore.components.HSModalWindow.init('[data-modal-target]', '.js-signup-modal', {
        autonomous: true
      });

      // initialization of show animations
      $.HSCore.components.HSShowAnimation.init('.js-animation-link');

      // initialization of instagram api
      $.HSCore.components.HSInstagram.init('#instaFeed', {
        resolution: 'standard_resolution',
        after: function () {
          // initialization of masonry.js
          var $grid = $('.js-instagram').masonry({
            percentPosition: true
          });

          // initialization of images loaded
          $grid.imagesLoaded().progress(function () {
            $grid.masonry();
          });
        }
      });

      // initialization of go to
      $.HSCore.components.HSGoTo.init('.js-go-to');
    });
  </script>
</body>
</html>