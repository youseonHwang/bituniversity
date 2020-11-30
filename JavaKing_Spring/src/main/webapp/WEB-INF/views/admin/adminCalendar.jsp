<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
  
  	<!-- FullCalendar -->
  	<link href='../css/fullcalendar.min.css' rel='stylesheet' />
	<script src='../js/moment.min.js'></script>
	<script src='../js/fullcalendar.min.js'></script>
	<script src='../js/ko.js'></script>
<style type="text/css">
.fc-day-sat {
	color: #0000FF;
} /* 토요일 색상변경*/
.fc-day-sun {
	color: #FF0000;
} /* 일요일 색상변경*/
#tip {
    position:absolute;
    color:#FFFFFF;
    padding:5px;
    display:none;
    background:#450e4c;
    border-radius: 5px;
}

.fc-event-title-container:hover {
	position: relative;
}
.fc-event-title-container:hover:after {
	content: ;

    position: absolute;
	bottom: 100%;
	left: 0;
    
    background-color: rgba(0, 0, 0, 0.8);
	color: #FFFFFF;
	font-size: 12px;

	z-index: 9999;
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	/*시큐리티 토큰 설정*/
	var csrf_token = "{{ csrf_token() }}";
	$.ajaxSetup({
	    beforeSend: function(xhr, settings) {
	        if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
	            xhr.setRequestHeader("X-CSRFToken", csrf_token);
	        }
	    }
	});
	
	/*캘린더 기본 설정*/
	document.addEventListener('DOMContentLoaded', function() {
		const eventsArr = [];
		$.ajax({
			url : '/admin/adminLoadCalendar.do',
			type : 'get',
			async : false,
			success : function(data) {
				$.each(data, function(idx, item) {
					const type = item.type;
					let colorType = '#083b90';	//디폴트 색상
					if (type == '2') {	//공휴일 색상
						colorType = "#cc0066";
					} else if (type == '3') {	//강조 색상
						colorType = "#20b2aa";
					}
					eventsArr.push({
						title : item.title,
						start : item.start_date,
						end : item.end_date,
						allDay : 'true',
						color : colorType
					});
				})
			},
			error : function() {
				alert("에러발생")
			}
		});
		console.log(eventsArr);
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			//     timeZone : 'local'	//한국시간으로 설정
			initialView : 'dayGridMonth',
			headerToolbar : {
				left : 'prev',
				center : 'title',
				right : 'today next',
				allDay: 'true'
			},
			buttonText : {
				today : '오늘'
			},
			events : eventsArr,
			eventLimit : true,
			eventLimitText : "more",
			eventLimitClick : "popover",
			editable : true, //드래그 수정가능
			locale : 'ko'
		});
		calendar.render();
	});
$(function(){
	/*-------------------------일정 등록--------------------------*/
    
	/*일정 번호 자동생성 함수*/
	var getNextNo = function(){
		$.ajax({
			url : "/admin/getNextNoCalendar.do",
			type : "POST",
			async : false,
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
				$("#no").val(no);
			},
			error : function(){
				alert("에러발생");
			}
		});
    };

	/*모달창 내부에서 폼에 일정 입력 후 등록 버튼 클릭 시 ajax연결*/
	$('#addGrade').click(function(){
		const formData = new FormData(insertForm);
		formData.set("X-CSRFToken", csrf_token);
		$.ajax({
			url:"/admin/insertCalendar.do",
			type:"post",
			async : false,
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
				console.log(re);
				if(re=='1'){
					alert("등록 성공!");
					
					$(location).attr('href','/admin/adminCalendar.do')
				}else{
					alert("등록 오류!");
				}
			},
			error:function(){
				console.log("에러발생!");
			}
		})
	});

	/*-------------------------일정 수정/삭제--------------------------*/
	
	/*모달창 내부에서 조회 버튼 클릭시 이벤트*/
	$('#search').click(function(){
		searchAjax();
	})
	
	/*모달창 내부에서 년도,시작월,종료월 선택 후 조회 버튼 클릭시 ajax 연결하는 함수*/
	var searchAjax = function(arr){
		$('#clist').html('');
		var start_date = $('#search_start_date').val();
		var end_date = $('#search_end_date').val();
		console.log(start_date);
		console.log(end_date);
		$.ajax({
			url : "/admin/searchCalendar.do",
			type : "POST",
			data : {
				"start_date":start_date,
				"end_date":end_date
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
				setSearchList(list);
			},
			error : function(){
				alert("에러발생");
			}
		})
	};
	
	/*ajax으로 받아온 캘린더 일정으로 동적노드 생성하는 함수*/
	var setSearchList = function(arr){
		$.each(arr, function(idx, item){
			var tr = $("<tr></tr>");
			$(tr).attr("no", item.no );
			$(tr).attr("title", item.title );
			$(tr).attr("start_date", item.start_date );
			$(tr).attr("end_date", item.end_date );
			$(tr).attr("type", item.type );
			var td1 = $("<td></td>").html(item.no);
			var td2 = $("<td></td>").html(item.title);
			var td3 = $("<td></td>").html(item.start_date);
			var td4 = $("<td></td>").html(item.end_date);
			let cType = '일반';	//디폴트
			if (item.type == '2') {
				cType = "공휴일";
			} else if (item.type == '3') {
				cType = "강조";
			}
			var td5 = $("<td></td>").html(cType);
			$(tr).append(td1,td2,td3,td4,td5);
			$("#clist").append(tr);
		});
	};

	/*선택한 일정의 정보를 ajax 연결해 update폼에 value 입력*/
	$("#clist").on("click","tr",function(){
		$("tr").css("background-color","#FFFFFF");
		$("tr").css("color","#000000");
		$(this).css("background-color","#083b90");
		$(this).css("color","#FFFFFF");
		var no = $(this).attr("no");
		var title = $(this).attr("title");
		var start_date = $(this).attr("start_date");
		var end_date = $(this).attr("end_date");
		var type = $(this).attr("type");
		$('#alter_no').val(no);
		$('#alter_title').val(title);
		$('#alter_start_date').val(start_date);
		$('#alter_end_date').val(end_date);
		$('#alter_type').val(type);
		console.log(no+title+start_date+end_date+type);
	});


	/*모달창 내부에서 일정 수정 후 수정 버튼 클릭 시 ajax연결*/
	$('#upGrade').click(function(){
		const formData = new FormData(updateForm);
		formData.set("X-CSRFToken", csrf_token);
		$.ajax({
			url:"/admin/updateCalendar.do",
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
				console.log(re);
				if(re=='1'){
					alert("수정 성공!");
					$("#updateForm").find('input, select').val('');
					searchAjax();
				}else{
					alert("수정 오류!");
				}
			},
			error:function(){
				console.log("에러발생");
			}
		})
	});
	
	/*모달창 내부에서 삭제 버튼 클릭시 ajax 연결*/
	$('#delGrade').click(function(){
		var no = $('#alter_no').val();
		if(no==null){
			alert("삭제할 행을 선택해주세요");
			return;
		}
		$.ajax({
			url : "/admin/deleteCalendar.do",
			type : "POST",
			data : {
				"no":no
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
					$("#updateForm").find('input, select').val('');
					searchAjax();
				}else{
					alert("삭제 오류!");
				}
			},
			error : function(){
				alert("에러발생");
			}
		})
	});

	/*모달창 내부에서 닫기 버튼 클릭시 창 새로고침*/
	$('#cancel').click(function(){
		$(location).attr('href','/admin/adminCalendar.do');
	});
});
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
		<div
			class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
			<h1 class="h1 hanna">학사일정 관리</h1>
		</div>
		<!-- End Hero Section -->

		<!-- News Blog Content -->
		<div class="container space-3-bottom--lg space-2-top">
			<div class="row">
				<div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">

					<!-- modal 구동 버튼 (trigger) -->
					<button type="button" id="btnAdd" class="btn btn-xs btn-primary"
						data-toggle="modal" data-target="#addModal" class_no="0">일정
						추가</button>
					<button type="button" id="btnDel" class="btn btn-xs btn-primary"
						data-toggle="modal" data-target="#delModal" class_no="0">일정
						수정/삭제</button>
					<br>
					<!-- 일정 등록 Modal -->
					<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="myModalLabel">일정 추가</h4>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form class="js-validate" id="insertForm">
										<input type="hidden" id="token" data="${_csrf.headerName}"
											value="${_csrf.token }">
										<div class="row">
											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 번호
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="no" name="no" value="${calendarNo }" required
															readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 내용
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="title" name="title" required placeholder="일정 제목">
													</div>
												</div>
											</div>

											<div class="w-100"></div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 시작일
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															id="start_date" name="start_date" required
															placeholder="형식 : 2020-12-02">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 종료일
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															name="end_date" required placeholder="형식 : 2020-12-04">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<label class="h6 small d-block text-uppercase"> 유형 </label>
												<div class="col-sm-12">
													<select class="selectpicker form-control" id="type"
														name="type">
														<option disabled selected></option>
														<option value="1">일반</option>
														<option value="2">공휴일</option>
														<option value="3">강조</option>
													</select>
												</div>
											</div>

										</div>
										<div class="text-center">
											<button type="button" class="btn btn-primary btn-sm"
												id="addGrade">등록</button>
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
					<!-- 일정 수정/삭제 Modal -->
					<div class="modal fade" id="delModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="myModalLabel">일정 수정/삭제</h4>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">

									<!-- --------------시작일,종료일로 캘린더 정보 조회하는 창-------------- -->
									<hr>
									<h5>일정 조회</h5>
									<form>
										<input type="hidden" id="token" data="${_csrf.headerName}"
											value="${_csrf.token }">
										<div class="form-inline form-group">
											검색 범위&nbsp; : &nbsp;&nbsp;&nbsp;
											<div class="col-sm-4 mb-4">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 시작일
														<span class="text-danger"></span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															id="search_start_date" name="search_start_date" required
															placeholder="형식 : 2020-12-02">
													</div>
												</div>
											</div>

											<div class="col-sm-4 mb-4">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 종료일
														<span class="text-danger"></span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															id="search_end_date" name="search_end_date" required
															placeholder="형식 : 2020-12-04">
													</div>
												</div>
											</div>
											&nbsp;&nbsp;
											<button type="button" id="search"
												class="btn btn-xs btn-primary">조회</button>
										</div>
									</form>
									<!-- --------------캘린더 리스트 받아오기-------------- -->
									<form class="js-validate" id="calendarForm">
										<input type="hidden" id="token" data="${_csrf.headerName}"
											value="${_csrf.token }">
										<table class="table table-sm table-hover">
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">제목</th>
													<th scope="col">시작일</th>
													<th scope="col">종료일</th>
													<th scope="col">유형</th>
												</tr>
											</thead>
											<tbody id="clist">
											</tbody>
										</table>
									</form>
									<!-- --------------캘린더 리스트의 클릭한 정보 받아와 수정폼에 입력-------------- -->
									<br>
									<hr>
									<h5>일정 수정/삭제</h5>
									<br>
									<form class="js-validate" id="updateForm">
										<input type="hidden" id="token" data="${_csrf.headerName}"
											value="${_csrf.token }">
										<div class="row">
											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 번호
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_no" name="no" required readonly>
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 내용
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="text"
															id="alter_title" name="title" required
															placeholder="일정 제목">
													</div>
												</div>
											</div>

											<div class="w-100"></div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 시작일
														<span class="text-danger">*</span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															id="alter_start_date" name="start_date" required
															placeholder="형식 : 2020-12-02">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<div class="js-form-message">
													<label class="h6 small d-block text-uppercase"> 종료일
														<span class="text-danger">* </span>
													</label>

													<div class="js-focus-state input-group form">
														<input class="form-control form__input" type="date"
															id="alter_end_date" name="end_date" required
															placeholder="형식 : 2020-12-04">
													</div>
												</div>
											</div>

											<div class="col-sm-6 mb-6">
												<label class="h6 small d-block text-uppercase"> 유형 </label>
												<div class="col-sm-12">
													<select class="selectpicker form-control" id="alter_type"
														name="type">
														<option disabled selected></option>
														<option value="1">일반</option>
														<option value="2">공휴일</option>
														<option value="3">강조</option>
													</select>
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
										data-dismiss="modal" id="cancel">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End Pagination -->
					<br>
					<div id='calendar'></div>

					<!-- End Pagination -->
				</div>

				<div class="col-lg-3 order-lg-1">
					<div class="portlet light profile-sidebar-portlet bordered">
						<div class="card-body user-profile-card mb-3">
							<!--     <img src="../upload/${sv.std_fname }" class="user-profile-image rounded-circle" alt="" width="160" height="160"/>  -->
						</div>
						<!-- Categories -->
						<!-- ========== schoolRegi_leftBar_Categories 삽입 ========== -->
						<jsp:include page="../admin_leftBar_Categories.jsp" />
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
    data-position='{"bottom": 15, "right": 15 }'
    data-type="fixed"
    data-offset-top="400"
    data-compensation="#header"
    data-show-effect="slideInUp"
    data-hide-effect="slideOutDown">
    <i class="fa fa-arrow-up u-go-to__inner"></i>
  </a>
  <!-- End Go to Top -->

  <!-- JS Global Compulsory -->
  <script src="../../assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="../../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
  <script src="../../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="../../assets/vendor/bootstrap/bootstrap.min.js"></script>

  <!-- JS Implementing Plugins -->
  <script src="../../assets/vendor/hs-megamenu/src/hs.megamenu.js"></script>
  <script src="../../assets/vendor/jquery-validation/dist/jquery.validate.min.js"></script>
  <script src="../../assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
  <script src="../../assets/vendor/custombox/dist/custombox.min.js"></script>
  <script src="../../assets/vendor/custombox/dist/custombox.legacy.min.js"></script>
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