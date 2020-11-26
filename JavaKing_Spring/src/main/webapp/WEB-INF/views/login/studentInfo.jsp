<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
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
  <jsp:include page="../header.jsp"></jsp:include>
  <!-- ========== END HEADER ========== -->

  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna">학적 조회</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
          <form class="js-validate">
            <div class="row">
              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    학번
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_no" required
                           value="${sv.std_no }"
                           readonly = readonly>
                  </div>
                </div>
              </div>
          
              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    성명
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_name" required
                           value="${sv.std_name }"
                           readonly = readonly>
                  </div>
                </div>
              </div>
          
              <div class="w-100"></div>
          
              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    학과
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_major" required
                           value="${sv.major_name }"
                           readonly = readonly>
                  </div>
                </div>
              </div>
          
              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    생년월일
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_birthday" required
                           value="${sv.std_birthday }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    학적상태
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_status" required
                           value="${sv.std_status }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    이메일
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_email" required
                           value="${sv.std_email }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    학년
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_level" required
                           value="${sv.std_level }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    학기
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_semester" required
                           value="${sv.std_semester }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    입학일
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_startdate" required
                           value="${sv.std_startdate }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    졸업일
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_enddate" required
                           value="${sv.std_enddate }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              <div class="col-sm-6 mb-6">
                <div class="js-form-message">
                  <label class="h6 small d-block text-uppercase">
                    성별
                    <span class="text-danger">*</span>
                  </label>
          
                  <div class="js-focus-state input-group form">
                    <input class="form-control form__input" type="text" name="std_gender"" required
                           value="${sv.std_gender }"
                           readonly = readonly>
                  </div>
                </div>
              </div>

              
            </div>
          
            <div class="js-form-message mb-5">
              <label class="h6 small d-block text-uppercase">
                특이사항
                <span class="text-danger">*</span>
              </label>
          
              <div class="js-focus-state input-group form">
                <textarea class="form-control form__input" rows="4" name="std_etc" required readonly=readonly>${sv.std_etc }</textarea>
              </div>
            </div>
          </form>
         
          <!-- End Pagination -->
        </div>

        <div class="col-lg-3 order-lg-1">
          <div class="portlet light profile-sidebar-portlet bordered">
            <div class="card-body user-profile-card mb-3 text-center">
              <img src=<c:if test="${sv.std_fname != null }">"../upload/${sv.std_fname }"</c:if><c:if test = "${sv.std_fname == null }">"../../image/crown.jpg"</c:if> class="user-profile-image rounded-circle" alt="" width="160" height="160"/>
          </div>
          <hr>
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