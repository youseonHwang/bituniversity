<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <!-- Title -->
  <title>:: 비트대학교 ::</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
  
<!-- JS Global Compulsory -->
	<script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
	<script src="../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
	<script src="../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
	<script src="../assets/vendor/bootstrap/bootstrap.min.js"></script>
<!-- 내꺼 -->
	<script type="text/javascript" src="../script/jquery_classInfo.js"></script>
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
  <jsp:include page="./header.jsp"/>
  <!-- ========== END HEADER ========== -->

  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
   <!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna">학부별 강의 목록</h1>
      <p class="lead">※ 아래 비트대학 교육과정은 2020년 기준입니다.</p>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
     <div class="container space-3-bottom--lg space-2-top">
 <!-- ====== MYMMYMYMYMYMYMYMYMYMY 내꺼 -->     

<div class="card-mb card-sm-columns card-sm-2-count">
        <!-- Blog Grid -->
        <article class="card mb-3">
            <img class="card-img-top" src="../../assets/img/500x250/img6.jpg" alt="Image Description">
          <div class="card-body p-5 title" collegeno="1">
            <h3 class="h5">
              인문학부
            </h3>
            <p>▽ 국어국문학 중어중문학과  영어영문학과  독어독문학과  언어학과 철학과 </p>
          </div>
          <div class="card-footer bg-gray-100 py-4 px-5page page wrap" id="page1">
          </div>
        </article>
        <!-- End Blog Grid -->

        <!-- Blog Grid -->
        <article class="card mb-3">
          <img class="card-img-top" src="../../assets/img/500x250/img8.jpg" alt="Image Description">
          <div class="card-body p-5 title" collegeno="2">
            <h3 class="h5">
                사회경영학부
            </h3>
            <p>▽ 정치외교학과  인류학과   언론정보학과  사회학과  경제학과 경영학과</p>
          </div>
          <div class="card-footer bg-gray-100 py-4 px-5 page wrap" id="page2">
          </div>
        </article>
        <!-- End Blog Grid --> 

        <!-- Blog Grid -->
        <article class="card mb-3">
            <img class="card-img-top" src="../../assets/img/500x250/img7.jpg" alt="Image Description">
            <div class="card-body p-5 title" collegeno="3">
              <h3 class="h5">
                공학부
              </h3>
              <p>▽ 건설환경공학과  에너지자원공학과  컴퓨터공학과  기계항공공학과  건축학과 조선학과</p>
            </div>
            <div class="card-footer bg-gray-100 py-4 px-5 page wrap" id="page3">
            </div>
          </article>
          <!-- End Blog Grid -->

          <!-- Blog Grid -->
        <article class="card mb-3">
            <img class="card-img-top" src="../../assets/img/500x250/img14.jpg" alt="Image Description">
            <div class="card-body p-5 title" collegeno="4">
              <h3 class="h5">
                문화예술학부
              </h3>
              <p>▽ 동양화과  서양화과  조소과  디자인학과  무용과 성악과</p>
            </div>
            <div class="card-footer bg-gray-100 py-4 px-5 page wrap" id="page4">
            </div>
          </article>
          <!-- End Blog Grid -->

          <!-- Blog Grid -->
        <article class="card mb-3">
            <img class="card-img-top" src="../../assets/img/500x250/img4.jpg" alt="Image Description">
            <div class="card-body p-5 title" collegeno="5">
              <h3 class="h5">
                공통
              </h3>
              <p>▽ 일반선택 공통</p>
            </div>
            <div class="card-footer bg-gray-100 py-4 px-5 page wrap" id="page5">
            </div>
          </article>
          <!-- End Blog Grid -->
	</div>

 <!-- ====== END MY END MMYMYMYMYEND MY END MYMYMYMY 내꺼 끝-->     
      <!-- End Pagination -->
    </div>
    <!-- End News Blog Content -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->

  <!-- ========== FOOTER ========== -->
  <jsp:include page="footer.jsp"></jsp:include>
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