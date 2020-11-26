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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Favicon -->
<link rel="shortcut icon" href="../../favicon.ico">

<!-- Google Fonts -->
<link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700"
	rel="stylesheet">

<!-- CSS Implementing Plugins -->
  <link rel="stylesheet" href="../../assets/vendor/font-awesome/css/all.min.css">
  <link rel="stylesheet" href="../../assets/vendor/hs-megamenu/src/hs.megamenu.css">
  <link rel="stylesheet" href="../../assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
  <link rel="stylesheet" href="../../assets/vendor/custombox/dist/custombox.min.css">
  <link rel="stylesheet" href="../../assets/vendor/animate.css/animate.min.css">
 

<!-- CSS Space Template -->
<link rel="stylesheet" href="../../assets/css/theme.css">
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

	const tbody = document.getElementById("tbody");
	
	/*프린트 출력 함수*/
	submit.addEventListener("click",function(e){
		document.body.innerHTML = printArea.innerHTML;
		window.print();
		location.reload();
	});

	/*학년 학기 기준으로 구분하기 위해 detail이라는 class name을 붙이고 , 클릭시 detail함수 동작*/
	const detailList = document.querySelectorAll(".detail");
	console.log(detailList);
	for(let i=0; i<detailList.length; i++){
		detailList[i].addEventListener("click",function(e){
			e.preventDefault();
			detail(e.target);
		})
	}

	/*년도와 학기를 매개변수로 ajax연결로 성적 상세정보를 가져온다*/
	function detail(obj){
		const year = obj.getAttribute("year");
		const semester = obj.getAttribute("semester");
		
		$.ajax({
				url : "/login/detailGrade.do",
				type : "POST",
				data : {
					"year":year, 
					"semester":semester
				},
				beforeSend : function(xhr)
				  {
				   //이거 안하면 403 error
				   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				   var token = $("#token");
				   console.log($(token).attr("data"));
				   console.log($(token).val());
				   xhr.setRequestHeader($(token).attr("data"), $(token).val());
				  },
				success : function(dlist){
					console.log(dlist);
					setDlist(dlist);			
				},
				error : function(){
					alert("에러발생");
				}
		})
	};

	/*성적 상세정보 담긴 동적노드 생성*/
	function setDlist(list){
		tbody.innerHTML = '';
		for(let i in list){
			const d = list[i];
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
					<input type="hidden" id="token" data="${_csrf.headerName}" value="${_csrf.token }">
						<h4>년도·학기별</h4>
						<span style="font-size: small;">* 구분항목 클릭시 해당 년도-학기의 성적
							상세정보 열람 가능</span>
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th scope="col">구분</th>
									<th scope="col">학년</th>
									<th scope="col">취득학점</th>
									<th scope="col">평점평균</th>
									<th scope="col">백분율</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="g" items="${grade_list}">
									<tr>
										<th scope="row"><a href='' class="detail"
											style="font-weight: bold; color: blue;"
											year="${g.grade_year }" semester="${g.grade_semester}">${g.grade_year }-${g.grade_semester}</a></th>
										<td>${g.grade_level }</td>
										<td>${g.sum_grade_regcredit }</td>
										<td>${g.average_grade_getcredit }</td>
										<td>${g.average_grade_score }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<!--<br><span class="u-label u-label--sm u-label--purple mb-3">상세정보</span>  -->
						<br>
						<h4>상세정보</h4>
						
						<div id="printArea">
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th width="30%">과목명</th>
									<th>이수</th>
									<th>수강학점</th>
									<th>점수</th>
									<th>백분율점수</th>
									<th>등급</th>
								</tr>
							</thead>
							<tbody id="tbody">
							</tbody>
						</table>
						</div>
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
							<jsp:include page="../schoolRegi_leftBar_Categories.jsp"/>
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