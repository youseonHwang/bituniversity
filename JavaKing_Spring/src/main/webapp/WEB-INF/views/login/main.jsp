<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Title -->
  <title>:: 비트대학교 ::</title>

  <!-- Required Meta Tags Always Come First -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  
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
  <link rel="stylesheet" href="../../assets/vendor/slick-carousel/slick/slick.css">

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
    <div class="bg-overlay-dark-v1 bg-img-hero-center" style="background-image: url(../image/bg.png);">
      <div class="container space-2 space-3--lg position-relative z-index-2 pb-3">
        <!-- Content -->
        <div class="w-md-80 mx-md-auto text-center mt-4 mb-8">
          <h5 class="text-white letter-spacing-0_06 text-uppercase opacity-lg mb-1 text-left">미래를 선도하는 혁신의 중심</h6>
          <h1 class="text-white mb-0 text-left" style="font-size:8vh; font-weight: bold; text-shadow:4px 2px 2px #083b90;">비트대학교</h1>
        </div>
        <!-- End Content -->
      </div>
      <div class="position-relative z-index-2 text-center">
        <!-- Bottom Content -->
        <div class="container">
          <!-- Slick Carousel -->
          <div class="js-slick-carousel u-slick"
              data-adaptive-height="false"    
              data-arrows-classes="d-none d-lg-inline-block u-slick__arrow-classic u-slick__arrow-centered--y rounded-circle"
              data-arrow-left-classes="fa fa-arrow-left u-slick__arrow-classic-inner u-slick__arrow-classic-inner--left ml-lg-2 ml-xl-0"
              data-arrow-right-classes="fa fa-arrow-right u-slick__arrow-classic-inner u-slick__arrow-classic-inner--right mr-lg-2 mr-xl-0"
              data-infinite="true"
              data-autoplay="true"
              data-speed="4000"
              data-pagi-classes="text-center position-absolute position-absolute-bottom-0 u-slick__pagination u-slick__pagination--white"
              data-slides-show="2"
              data-responsive='[{
                "breakpoint": 1200,
                "settings": {
                  "slidesToShow": 2
                }
              }, {
                "breakpoint": 992,
                "settings": {
                  "slidesToShow": 1
                }
              }, {
                "breakpoint": 768,
                "settings": {
                  "slidesToShow": 1
                }
              }, {
                "breakpoint": 576,
                "settings": {
                  "slidesToShow": 1
                }
              }, {
                "breakpoint": 480,
                "settings": {
                  "slidesToShow": 1
                }
              }]'>
            <div class="js-slide bg-img-hero-center">
              <div class="space-2-bottom">
                <img class="mx-auto banners" src="../image/banner1.png" >
              </div>
            </div>
            <div class="js-slide bg-img-hero-center">
              <div class="space-2-bottom">
                <img class="mx-auto banners" src="../image/banner2.png" >
              </div>
            </div>
            <div class="js-slide bg-img-hero-center">
              <div class="space-2-bottom">
                <img class="mx-auto banners" src="../image/banner3.png">
              </div>
            </div>
            <div class="js-slide bg-img-hero-center">
              <div class="space-2-bottom">
                <img class="mx-auto banners" src="../image/banner4.png">
              </div>
            </div>
          </div>
          <!-- End Slick Carousel -->
        </div>
        <!-- End Bottom Content -->
      </div>
    </div>
    <!-- End Hero Section -->

    <!-- Quick Menu Section -->
    <div class="container space-1 text-center">
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/listRegister.do">
          <span class="fas fa-file-invoice-dollar u-icon__inner my-1"></span>
          <span class="h6 pt-1">등록금조회</span>
        </a>
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/listGrade.do">
          <span class="fas fa-font u-icon__inner my-1"></span>
          <span class="h6 pt-1">성적조회</span>
        </a>
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/classReg.do">
          <span class="far fa-hand-pointer u-icon__inner my-1"></span>
          <span class="h6 pt-1">수강신청</span>
        </a>
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/listProfessor.do">
          <span class="fas fa-user-tie u-icon__inner my-1"></span>
          <span class="h6 pt-1">교수정보</span>
        </a>
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/listBoard.do?board_boardno=200&board_category='학사QNA'">
          <span class="fas fa-question u-icon__inner my-1"></span>
          <span class="h6 pt-1">학사QNA</span>
        </a>
        <a class="u-icon u-icon--xl u-icon--primary mx-5 my-5 pt-1" href="/login/listStudy.do">
          <span class="fas fa-school u-icon__inner"></span>
          <span class="h6 pt-1">비트스터디</span>
        </a>
    </div>
    <!-- End Quick Menu Section -->

    <!-- Popular Companies -->
    <div class="container space-2">
    	<div class="row">
        <!-- Popular Company Item -->
        	<div class="col-sm-6 col-lg-5 mb-4" id="my_info" style="display:block">
        		<div class="card border-0 shadow-sm h-100">
            		<div class="card-body pt-0 px-4 pb-1">
              			
              				<img src=<c:if test="${std_fname != null }">"../upload/${std_fname }"</c:if><c:if test = "${std_fname == null }">"../../image/crown.jpg"</c:if> class="user-profile-image rounded-circle mt-n5 mb-5" width="160" height="160"/>  
              		
              			<h5 class="h5 mb-0">&nbsp;<i class="fas fa-user text-primary"></i>&nbsp;&nbsp;&nbsp;${std_name}</h5>
              			<hr class = "my-2">
             			<h5 class="h5 mb-0"><i class="far fa-id-card text-primary"></i>&nbsp;&nbsp;&nbsp;${std_no }</h5>
              			<hr class = "my-2">
              			<h5 class="h5 mb-0 pb-1"><i class="fas fa-graduation-cap text-primary"></i>&nbsp;&nbsp;${major_name }<c:if test = "${acc_id !='관리자'}">과</c:if>&nbsp;${std_level}&nbsp;${std_semester }</h5>
            		</div>
            		<div class="card-footer text-muted d-md-flex justify-content-between align-items-center mx-4 px-0">
              			<a class="d-flex align-items-center font-weight-bold" href="/login/studentInfo.do">
                			<i class = "fas fa-chalkboard-teacher"></i>&nbsp;내 학적
              			</a>
              			<a class="d-flex align-items-center font-weight-bold no_a_tag" style="color:#083B90; cursor:pointer;" id="btn_change_pwd">
                			<i class = "fas fa-user-lock"></i>&nbsp;비밀번호 변경
              			</a>
              			<a class="d-flex align-items-center font-weight-bold" href="/login/updateStudentInfo.do">
                			<i class = "fas fa-user-cog"></i>&nbsp;내 정보 변경
              			</a>
            		</div>
          		</div>
        	</div>
        	<div class="col-sm-6 col-lg-5 mb-4" id="div_change_pwd" style="display :none;">
        		<div class="card border-0 shadow-sm h-100">
            		<div class="card-body pt-0 px-4 pb-2">
              			<div class="mt-3 mb-3" style="width: 96; height: 96;">
               				<h4 class="h4 mb-0 font-weight-bold pt-2" style = "color:#083B90;">비밀번호 변경</h4>
               				<h6 class="h6 mb-0" style="color:#42bfee" id="cpm"></h6>
                		</div>
                		<form action="/login/changePwd.do" method="POST" id="form_change_pwd" class= "pb-3">
                		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
	                		<div class="js-focus-state input-group form mb-2">
	  							<div class="input-group-prepend form__prepend">
	    							<span class="input-group-text form__text">
	      								<span class="fas fa-user-lock form__text-inner"></span>
	    							</span>
	  							</div>
	  						<input type="password" class="form-control form__input" name="old_pwd" required
						    placeholder="기존 비밀번호"
						    aria-label="기존 비밀번호">
					        </div>
							<div class="js-focus-state input-group form mb-2">
	  							<div class="input-group-prepend form__prepend">
	    							<span class="input-group-text form__text">
	      								<span class="fas fa-lock form__text-inner"></span>
	    							</span>
	  							</div>
	  						<input type="password" class="form-control form__input" name="new_pwd" required
						        placeholder="새 비밀번호"
						        aria-label="새 비밀번호">
					        </div>
					        <div class="js-focus-state input-group form">
	  							<div class="input-group-prepend form__prepend">
	    							<span class="input-group-text form__text">
	      								<span class="fas fa-check-double form__text-inner"></span>
	    							</span>
	  							</div>
	  						<input type="password" class="form-control form__input" name="new_pwd_check" required
						        placeholder="비밀번호 확인"
						        aria-label="비밀번호 확인">
					        </div>
                		</form> 
                	</div>
            		<div class="card-footer text-muted d-md-flex justify-content-between align-items-center mx-4 px-0">
              			<a class="d-flex align-items-center font-weight-bold" href="#" id="btn_main">
                			<i class = "fas fa-user-cog"></i>&nbsp;내 정보
              			</a>
              			<a class="d-flex align-items-center font-weight-bold" href="#" id="btn_ok">
                			<i class="fas fa-check-square"></i>&nbsp;확인
              			</a>
            		</div>
          		</div>
        	</div>
	        <script>
	        $(function(){
	        	var csrf_token = "{{ csrf_token() }}";
	        	
	        	$.ajaxSetup({
	                beforeSend: function(xhr, settings) {
	                    if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
	                        xhr.setRequestHeader("X-CSRFToken", csrf_token);
	                    }
	                }
	            });
	            
	        	$('#btn_change_pwd').click(function(e){
	        		e.preventDefault();
	        		e.stopPropagation();
	        		$('#div_change_pwd').attr('style', 'display : block;');
	        		$('#my_info').attr('style', 'display : none;');
	        		$('#change_pwd_msg').value("");
	        	});
	
	        	$('#btn_main').click(function(e){
	        		e.preventDefault();
	        		e.stopPropagation();
	        		$('#div_change_pwd').attr('style', 'display : none;');
	        		$('#my_info').attr('style', 'display : block;');
	        	});

	        	$('#btn_ok').click(function(e){
		        	e.preventDefault();
        			e.stopPropagation();
	                const formData = new FormData(document.getElementById("form_change_pwd"));
	                $.ajax({
	                    url:"/login/changePwd.do",
	                    type:"post",
	                    data:formData,
	                    contentType: false,
	                    processData: false,
	                    success:function(msg){
	                        console.log(msg);
	                        alert(msg);
	                        if (msg == "비밀번호가 변경되었습니다.") {
	                        	window.location.href = '/login/main.do';
		                    }
	                    },
	                    error:function(){
	                        console.log("ERROR!");
	                    }
	                })
	            });
	        });
	        </script>
        
        <!-- End Popular Company Item -->

        <!-- Featured Job Item  -->
        <div class="card shadow-sm border-0 mb-4 px-4 col-sm-6 col-lg-7">
          <h3 class="h5 mb-5 mt-4">
	          <a class="font-weight-bold" href="/login/listBoard.do?board_boardno=100">
		          <i class="fas fa-exclamation-circle text-primary"></i>
		          &nbsp;&nbsp;공지사항
	          </a>
          </h3>
          <div class="card-body align-items-center py-0 px-0">
          <c:forEach var="i" items="${main_notice }" begin="0" end="4">
			<c:set var = "bt" value ="${i.board_title }"/>
            	<c:set var = "bt2" value ="${fn:length(bt) }"/>
            	<c:if test="${bt2 >= 31 }">
            		<c:set var = "bt" value = "${fn:substring(bt, 0, 31)} ..." />
            	</c:if>
        	 <div class = "pt-2 pb-5">
         	 	<span class="float-left"><a href="detailBoard.do?board_no=${i.board_no }">${bt  }</a></span>
          		<span class="float-right">${ i.board_regdate}</span>
            </div>
            <hr class="my-0">
			</c:forEach>
          </div>
          <div class="py-3 text-muted d-md-flex justify-content-between align-items-center mx-0 px-0">
            <a class="d-flex align-items-center font-weight-bold text-right ml-auto" href="/login/listBoard.do?board_boardno=100">
              더보기&nbsp;
              <i class="fas fa-arrow-right"></i>
            </a>
          </div>
        </div>
        <!-- End Featured Job Item -->
        
        <!-- Popular Company Item -->
        <div class="col-sm-6 col-lg-4 mb-4">
          <div class="card border-0 shadow-sm h-100 px-4">
            <div class="card-body py-0 px-0">
              <h3 class="h5 mb-5 mt-4">
	              <a class="font-weight-bold" href="/login/listBoard.do?board_boardno=300&board_category=삽니다">
		              <i class="fas fa-hand-holding-usd text-primary"></i>
		              &nbsp;&nbsp;삽니다
		          </a>
              </h3>
            </div>
            <div class="card-body align-items-center py-0 px-0">
            	<c:forEach var="i" items="${main_flee_buy }" begin="0" end="3">
            	<c:set var = "bt" value ="${i.board_title }"/>
            	<c:set var = "bt2" value ="${fn:length(bt) }"/>
            	<c:if test="${bt2 >= 11 }">
            	<c:set var = "bt" value = "${fn:substring(bt, 0, 11)} ..." />
            	</c:if>
        	 		<div class = "pt-2 pb-5">
	         	 		<span class="float-left"><a href="detailBoard.do?board_no=${i.board_no }">${bt }</a></span>
	          			<span class="float-right">${ i.board_regdate}</span>
	          		</div>
          		<hr class="my-0">
				</c:forEach>
            </div>
            <div class="py-3 text-muted d-md-flex justify-content-between align-items-center mx-0 px-0">
              <a class="d-flex align-items-center font-weight-bold text-right ml-auto" href="/login/listBoard.do?board_boardno=300&board_category=삽니다">
                더보기&nbsp;
                <i class="fas fa-arrow-right"></i>
              </a>
            </div>  
          </div>
        </div>
        <!-- End Popular Company Item -->

        <!-- Popular Company Item -->
        <div class="col-sm-6 col-lg-4 mb-4">
          <div class="card border-0 shadow-sm h-100 px-4">
            <div class="card-body py-0 px-0">
              <h3 class="h5 mb-5 mt-4 font-weight-bold">
	              <a class="font-weight-bold" href="/login/listBoard.do?board_boardno=300&board_category=팝니다">
		              <i class="fas fa-dolly text-primary"></i>
		              &nbsp;&nbsp;팝니다
	              </a>
              </h3>
            </div>
            <div class="card-body align-items-center py-0 px-0">
              <c:forEach var="i" items="${main_flee_sell }" begin="0" end="3">
            	<c:set var = "bt" value ="${i.board_title }"/>
            	<c:set var = "bt2" value ="${fn:length(bt) }"/>
            	<c:if test="${bt2 >= 11 }">
            	<c:set var = "bt" value = "${fn:substring(bt, 0, 11)} ..." />
            	</c:if>
        	 		<div class = "pt-2 pb-5">
	         	 		<span class="float-left"><a href="detailBoard.do?board_no=${i.board_no }">${bt }</a></span>
	          			<span class="float-right">${ i.board_regdate}</span>
	          		</div>
          		<hr class="my-0">
				</c:forEach>
            </div>
            <div class="py-3 text-muted d-md-flex justify-content-between align-items-center mx-0 px-0">
              <a class="d-flex align-items-center font-weight-bold text-right ml-auto" href="/login/listBoard.do?board_boardno=300&board_category=팝니다">
                더보기&nbsp;<i class="fas fa-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>
        <!-- End Popular Company Item -->

        <!-- Popular Company Item -->
        <div class="col-sm-6 col-lg-4 mb-4">
          <div class="card border-0 shadow-sm h-100 px-4">
            <div class="card-body py-0 px-0">
              <h3 class="h5 mb-5 mt-4 font-weight-bold">
	              <a class="font-weight-bold" href="/login/listBoard.do?board_boardno=300&board_category=자유게시판">
	              <i class="fas fa-list-ol text-primary"></i>
	              &nbsp;&nbsp;자유게시판</a>
              </h3>  
            </div>
            <div class="card-body align-items-center py-0 px-0">
              <c:forEach var="i" items="${main_freeboard }" begin="0" end="3">
            	<c:set var = "bt" value ="${i.board_title }"/>
            	<c:set var = "bt2" value ="${fn:length(bt) }"/>
            	<c:if test="${bt2 >= 11 }">
            	<c:set var = "bt" value = "${fn:substring(bt, 0, 11)} ..." />
            	</c:if>
        	 		<div class = "pt-2 pb-5">
	         	 		<span class="float-left"><a href="detailBoard.do?board_no=${i.board_no }">${bt }</a></span>
	          			<span class="float-right">${ i.board_regdate}</span>
	          		</div>
          		<hr class="my-0">
				</c:forEach>
            </div>
            <div class="py-3 text-muted d-md-flex justify-content-between align-items-center mx-0 px-0">
              <a class="d-flex align-items-center font-weight-bold text-right ml-auto" href="/login/listBoard.do?board_boardno=300&board_category=자유게시판">
                더보기&nbsp;<i class="fas fa-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>
        <!-- End Popular Company Item -->
      </div>
    </div>
    <!-- End Popular Companies -->
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
  <script src="../../assets/vendor/slick-carousel/slick/slick.js"></script>

  <!-- JS Space -->
  <script src="../../assets/js/hs.core.js"></script>
  <script src="../../assets/js/components/hs.header.js"></script>
  <script src="../../assets/js/components/hs.unfold.js"></script>
  <script src="../../assets/js/components/hs.validation.js"></script>
  <script src="../../assets/js/helpers/hs.focus-state.js"></script>
  <script src="../../assets/js/components/hs.malihu-scrollbar.js"></script>
  <script src="../../assets/js/components/hs.modal-window.js"></script>
  <script src="../../assets/js/components/hs.show-animation.js"></script>
  <script src="../../assets/js/components/hs.slick-carousel.js"></script>
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

      // initialization of slick carousel
      $.HSCore.components.HSSlickCarousel.init('.js-slick-carousel');

      // initialization of go to
      $.HSCore.components.HSGoTo.init('.js-go-to');
    });
  </script>
</body>
</html>