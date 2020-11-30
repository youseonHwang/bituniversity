<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>

<!-- Title -->
<title>:: 비트대학교 ::</title>

<!-- Required Meta Tags Always Come First -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />

<!-- Favicon -->
<link rel="shortcut icon" href="../image/favicon.ico">

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
<style type="text/css">
#image {
	position:relative;
	margin-left:28%;
}

#image #text {
	position:absolute;
	top:50%;
	left:30%;
	transform:translate(-50%,-50%);
	width:700px;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
window.onload = function(){
	var csrf_token = "{{ csrf_token() }}";
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const parameter = $("meta[name='_csrf_parameter']").attr("content");

	/*시큐리티 토큰 설정*/
	$.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                xhr.setRequestHeader("X-CSRFToken", csrf_token);
            }
        }
    });
    
	const tbody = document.getElementById("tbody");
	
	/*프린트 출력 함수*/
	submit.addEventListener("click",function(e){
		document.getElementsByClassName("printScope").style="display:inline-block";
		document.getElementById("printAreaTitle").style="display:block"; 
		document.getElementById("printAreaTitle").style="text-align:center";
		document.getElementById("printAreaEnd").style="display:block"; 
		document.getElementById("printAreaEnd").style="text-align:center";
		document.body.innerHTML = printArea.innerHTML;
		setTimeout(function() {
			window.print();
			document.getElementById("printAreaTitle").style="display:none";
			document.getElementById("printAreaEnd").style="display:none";
			location.reload();
        }, 300)
	});

	/*학년 학기 기준으로 구분하기 위해 detail이라는 class name을 붙이고 , 클릭시 detail함수 동작*/
	const detailList = document.querySelectorAll(".detail");
	console.log(detailList);
	for(let i=0; i<detailList.length; i++){
		detail(detailList[i],0); // 0을주면 테이블에 달기
		detailList[i].addEventListener("click",function(e){
			e.preventDefault();
			detail(e.target,1); // 1을주면 상세정보에 달기
		})
	};

	/*년도와 학기를 매개변수로 ajax연결로 성적 상세정보를 가져온다*/
	function detail(obj,check){
		console.log("작동함!!");
		const year = obj.getAttribute("year");
		const semester = obj.getAttribute("semester");
		const idx = obj.getAttribute("idx");
		console.log(year);
		console.log(semester);
		$.ajax({
				url : "/login/detailGrade.do?"+parameter+"="+token,
				type : "POST",
				data : {
					"year":year, 
					"semester":semester
				},
				success : function(dlist){
					console.log(dlist);
					if(check == 0 ){
						setPrintTable(dlist,idx);
					}
					else{
						setDlist(dlist);	
					}		
				},
				error : function(){
					alert("에러발생");
				}
		})
	};
	
	/*프린트 출력시 성적 상세정보 담긴 동적노드 생성*/
	function setPrintTable(list,idx){
		const myTbody = document.getElementById("tbody"+idx);
		const firstTr = document.createElement("tr");
		const firstTd ='<th width="30%">과목명</th>\
						<th>이수구분</th>\
						<th>수강학점</th>\
						<th>점수</th>\
						<th>백분율점수</th>\
						<th>등급</th>';
		firstTr.innerHTML = firstTd;
		myTbody.append(firstTr);
		for(let i in list){
			const d = list[i];
			if (d.class_type=='0'){
				d.class_type='전공필수'
			}else if(d.class_type=='1'){
				d.class_type='전공선택'
			}else if(d.class_type=='10'){
				d.class_type='교양필수'
			}else if(d.class_type=='11'){
				d.class_type='교양선택'
			}else{
				d.class_type='일반선택'
			}
			const tr = document.createElement("tr");
			let str = '<td name="class_name">'+d.class_name+'</td>\
			<td name="class_type">'+d.class_type+'</td>\
			<td name="grade_regcredit">'+d.grade_regcredit+'</td>\
			<td name="grade_getcredit">'+d.grade_getcredit+'</td>\
			<td name="grade_score">'+d.grade_score+'</td>\
			<td name="grade_rank">'+d.grade_rank+'</td>';
			tr.innerHTML = str;
			myTbody.append(tr);
		}
	}
	
	/*구분의 학년-학기 클릭시 성적 상세정보 담긴 동적노드 생성*/
	function setDlist(list){
		tbody.innerHTML = '';
		for(let i in list){
			const d = list[i];
			if (d.class_type=='0'){
				d.class_type='전공필수'
			}else if(d.class_type=='1'){
				d.class_type='전공선택'
			}else if(d.class_type=='10'){
				d.class_type='교양필수'
			}else if(d.class_type=='11'){
				d.class_type='교양선택'
			}else{
				d.class_type='일반선택'
			}
			const tr = document.createElement("tr");
			let str = '<td name="class_name">'+d.class_name+'</td>\
			<td name="class_type">'+d.class_type+'</td>\
			<td name="grade_regcredit">'+d.grade_regcredit+'</td>\
			<td name="grade_getcredit">'+d.grade_getcredit+'</td>\
			<td name="grade_score">'+d.grade_score+'</td>\
			<td name="grade_rank">'+d.grade_rank+'</td>'
			tr.innerHTML = str;
			tbody.append(tr);
		}
	};
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
		<div class="container space-2 space-3-top--lg">
			<h1>성적 조회</h1>
		</div>
		<!-- End Hero Section -->

		<!-- News Blog Content -->
		<div class="container space-3-bottom--lg">
			<div class="row">
				<div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
					<button type="button"
						class="position-absolute-top-right-0 btn btn-xs btn-primary"
						id="submit">성적표 출력</button>
					<br>
					<br>
					<form action="listGrade.do" method="post">
						<input type="hidden" id="token" data="${_csrf.headerName}"
							value="${_csrf.token }">
						<h4>년도·학기별</h4>
						<span style="font-size: small;">* 구분항목 클릭시 해당 년도-학기의 성적
							상세정보 열람 가능</span>
						<div id="printArea">
							<div id="printTable">
								<div id="printAreaTitle"
									style="display: none; text-align: center;">
									<h2>전체학기 성적조회</h2>
								</div>
								<br>
								<br>
								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th scope="col">구분</th>
											<th scope="col">학년</th>
											<th scope="col">총 취득학점</th>
											<th scope="col">평점평균</th>
											<th scope="col">백분율</th>
											<th></th>
										</tr>
									</thead>
									<c:forEach var="g" items="${grade_list}" varStatus="idx"
										begin="0" step="1">
										<tr>
											<th scope="row"><a href='' class="detail"
												idx="${idx.index }" style="font-weight: bold; color: blue;"
												year="${g.grade_year }" semester="${g.grade_semester}">${g.grade_year }-${g.grade_semester}</a></th>
											<td>${g.grade_level }</td>
											<td>${g.sum_grade_regcredit }</td>
											<td>${g.average_grade_getcredit }</td>
											<td>${g.average_grade_score }</td>
										</tr>
										<tr id="tbody${idx.index}" class="printScope w-100"
											style="display: none;">
										</tr>
									</c:forEach>
								</table>
							</div>
							<br>
							<br>
							<div id="printAreaEnd" style="display: none; text-align: center;">
								<p>위의 사실을 증명함.</p>
								<p>2020년 12월 1일</p>
								<div id="image" style="text-align: center;">
									<img src="../image/bitStamp.png" width="70px" height="70px">
									<div id="text" style="font-size: 1.8em; font-weight: bold;">비
										트 대 학 교 교 무 처 장</div>
								</div>
							</div>
						</div>
						<h4>상세정보</h4>
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th width="30%">과목명</th>
									<th>이수구분</th>
									<th>수강학점</th>
									<th>점수</th>
									<th>백분율점수</th>
									<th>등급</th>
								</tr>
							</thead>
							<tbody id="tbody" class="mola" year="${g.grade_year }"
								semester="${g.grade_semester}">
							</tbody>
						</table>
					</form>
					<!-- End Pagination -->
				</div>
				<div class="col-lg-3 order-lg-1">
					<div class="portlet light profile-sidebar-portlet bordered">
						<div class="card-body user-profile-card mb-3">
							<!--     <img src="../upload/${sv.std_fname }" class="user-profile-image rounded-circle" alt="" width="160" height="160"/>  -->
						</div>
						<hr>
						<!-- Categories -->
						<!-- ========== schoolRegi_leftBar_Categories 삽입 ========== -->
						<jsp:include page="../schoolRegi_leftBar_Categories.jsp" />
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