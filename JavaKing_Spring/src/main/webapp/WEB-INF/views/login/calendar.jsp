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
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
</style>
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
			url : '/login/loadCalendar.do',
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
			editable : true,
			locale : 'ko'
		});
		calendar.render();	
	});
</script>
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
      <h1 class = "h1 hanna">학사 일정</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
		<div id='calendar'></div>
         
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
			<jsp:include page="../madang_leftBar_Categories.jsp"/>
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