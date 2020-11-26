<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 템플릿 씌운거 ~!~! -->
<!DOCTYPE html>
<html>
<head>
  <!-- Title -->
  <title>:: 비트대학교 ::</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
 <!--  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->

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
<!-- 내꺼css -->


<!-- JS Global Compulsory -->
<script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
<script src="../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
<script src="../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
<script src="../assets/vendor/bootstrap/bootstrap.min.js"></script>


	<!-- JS Global Compulsory -->
	<script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
	<script src="../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
	<script src="../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
	<script src="../assets/vendor/bootstrap/bootstrap.min.js"></script>
<!-- 내꺼 JQ-->
	<script type="text/javascript" src="../script/jquery_classSearch.js"></script>

	<!-- JS Space -->
	<script src="../assets/js/hs.core.js"></script>
</head>

<body>
  <!-- Skippy -->
  <a id="skippy" class="sr-only sr-only-focusable u-skippy" href="#content">
    <div class="container">
      <span class="u-skiplink-text">Skip to main content</span>
    </div>
  </a>
  <!-- End Skippy -->
  <!-- ========== HEADER ========== -->
  <jsp:include page="../header.jsp"/>
  <!-- ========== END HEADER ========== -->
 
  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white pl-9 text-center text-weight-bold">
      <h1 class = "h1 hanna">통합 강의 정보</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
<!-- =====MYMYMYMY==========MYMYMYMY========MYMYMYMY========== MYMYMYMY  내 컨텐츠 -->
	
	<div class="totalWrap" style="text-align:center">
        <div class="wrap">
            <div class="main">
                <div class="js-focus-state input-group input-group-sm form form--sm mb-7">
							<select class="form-control" id="option" name="option">
								<option selected value="class_name">선택</option>
								<option value="class_name">강의명</option>
								<option value="class_type">이수구분</option>
								<option value="college_no">수강학부</option>
							</select> 
				        	<%-- <input type="text" id="search" name="search" value="${search }"> --%>
				        	<input type="text" id="search" name="search" 
				        		   value="${search }"
				        		   class="form-control form__input" 
				                   placeholder="검색"
				                   aria-label="Search Space">
				            <span class="input-group-append form__append">
					      		<button id="btnSearch" class="btn btn-primary" type="button">
						        	<span class="fa fa-search"></span>
						     	</button>
					     	 </span>
				    	</div>
				    	<font style="font-size:12px">
							※ 0:전공필수 1:전공선택 10:교양필수 11:교양선택 21:일반선택 <br>
							※ 1:인문학부 2:사회경영학부 3:공학부 4:문화예술학부 5:공통학부
						</font>
						<br><br>
                 
					
                <div class="mainTable">
                    <!--  ajax 로 불러오기. 처음엔 전체내역이 보이도록. 스크롤바넣기. style > overflow -->
                    <table id="table" class="table table-sm">
                     <thead class="thead-dark">
						<tr>
							<th>순번</th>
							<th>수강학부</th>
							<th>대상학년</th>
							<th>이수구분</th>
							<th>과목명(강의번호)</th>
							<th>학점</th>
							<th>시작일/종료일</th>
							<th>시간(요일,시간)</th>
							<th>담당교수</th>
							<th>강의교실</th>
							<th>제한인원</th>
						</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
                    <br>
					<!-- Pagination -->
			          <nav aria-label="Page navigation">
			            <ul id="paging_button" class="pagination"></ul>
			          </nav>
			        <!-- End Pagination -->
					<br>
                 </div>
            </div>     
        </div>     
    </div>

<!-- =========END=MYMYMYMY========END==MYMYMYMY======END==MYMYMYMY========END== MYMYMYMY= 내 컨텐츠 끝-->
          
        </div>

        <div class="col-lg-3 order-lg-1">
            <!-- ========== schoolRegi_leftBar_Categories 삽입 ========== -->
			  <jsp:include page="../schoolRegi_leftBar_Categories.jsp"/>
			  <!-- ========== END schoolRegi_leftBar_Categories 삽입 ========== -->
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