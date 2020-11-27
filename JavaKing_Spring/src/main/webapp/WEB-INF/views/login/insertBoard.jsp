<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>:: 비트대학교 ::</title>
<!-- Required Meta Tags Always Come First -->
<meta charset="UTF-8">
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

 <!-- jquery  -->
  <script type="text/javascript" src = "https://code.jquery.com/jquery-3.5.1.min.js"></script>  

  <!-- JS Global Compulsory -->
  <script src="../../assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="../../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
  <script src="../../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="../../assets/vendor/bootstrap/bootstrap.min.js"></script>
  
  <!-- bootbox code -->
  <script src="../bootbox/bootbox.min.js"></script>
  <script src="../bootbox/bootbox.locales.min.js"></script>
  
  <script type="text/javascript">   
	$(function(){
		var csrf_token = "{{ csrf_token() }}";
    	
    	$.ajaxSetup({
            beforeSend: function(xhr, settings) {
                if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                    xhr.setRequestHeader("X-CSRFToken", csrf_token);
                }
            }
        });

        // 파일 선택하면 파일 라벨에 파일 이름 들어가는 부분-------------------------------------------------------
		$(".custom-file-input").on("change", function() {
		  var fileName = $(this).val().split("\\").pop();
		  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
		});

		// 등록 버튼을 눌렀을 때 실행하는 동작----------------------------------------------------------------
		$('#btn_insert').click(function() {
			var form_data = new FormData($('#insert_form')[0])
			var board_category = $("#board_category option:selected").val();
			form_data.delete("board_category");
			form_data.append("board_category", board_category);
			$.ajax({
				url: "/login/insertBoard",
				type:'POST',
				data: form_data,
			    processData: false,
			    contentType: false,
				success:function(res){
					if(res == 1) {//등록 성공시
					   
                 	   var dialog = bootbox.dialog({
	                    	title: '등록',
	                    	message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
                 		   	buttons: {ok: function () {location.href="/login/listBoard.do?board_boardno="+${board_boardno}+"&board_category="+board_category}}
            		    	});
                 		            
                 		dialog.init(function(){
                 		    setTimeout(function(){dialog.find('.bootbox-body').html('등록 완료!');},2000); 
                    		})
                    }
                    else{//등록 실패시
                 	   var dialog = bootbox.dialog({
                 		    title: '등록',
                 		    message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',	                    		  
                 		});
                 		            
                 		dialog.init(function(){
                 		    setTimeout(function(){ dialog.find('.bootbox-body').html('등록 실패!');}, 2000);
                 		});
                   }

			}})
		})
	})
  
  </script>

</head>
<jsp:include page="../header.jsp"/>
<body>
  <!-- Skippy -->
  <a id="skippy" class="sr-only sr-only-focusable u-skippy" href="#content">
    <div class="container">
      <span class="u-skiplink-text">Skip to main content</span>
    </div>
  </a>
  <!-- End Skippy -->
  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
   
    <!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna">게시물 작성</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css" rel="stylesheet">
    <!-- Checkout Form Section -->
    <div class="container">
      <div class="row">
        <div class="col-lg-4 order-lg-2 mb-9 mb-lg-0">
          <!-- Order Summary -->
          <div class="bg-gray-100 border rounded p-5">
            <!-- Title -->
            <h2 class="h5 mb-0">Contact Information</h2>
            <!-- End Title -->

            <hr class="my-4">

            <!-- Product -->
            <div class="media mb-4">
              <div class="d-flex position-relative mr-3">
                <img class="u-lg-avatar rounded" src="../image/university_insert.jpg" alt="Image Description">
              </div>
              <div class="media-body">
                <h4 class="h6 mb-0">비트 대학교</h4>
                <small class="d-block text-secondary"> 서울특별시 마포구 백범로 23 구프라자 B1</small>
                <small class="d-block text-secondary"> +02-707-1480</small>
                <small class="d-block text-secondary"> bituniversityemail@gmail.com </small>
              </div>
            </div>
            <!-- End Product -->

            <hr class="my-4">
			<!-- Video Block -->
			<div id="youTubeVideoPlayer" class="u-video-player">
			  <!-- Cover Image -->
			  <img class="img-fluid u-video-player__preview" src="../assets/img/img41-lg.jpg" alt="Image" >
			  <!-- End Cover Image -->
			
			  <!-- Play Button -->
			  <a class="js-inline-video-player u-video-player__btn u-video-player__centered" href="https://youtu.be/5nqUaVh11XI"
			     data-parent="youTubeVideoPlayer"
			     data-target="youTubeVideoIframe"
			     data-classes="u-video-player__played">
			    <span class="u-video-player__icon">
			      <span class="fa fa-play u-video-player__icon-inner"></span>
			    </span>
			  </a>
			  <!-- End Play Button -->
			
			  <!-- Video Iframe -->
			  <div class="embed-responsive embed-responsive-16by9">
			    <iframe id="youTubeVideoIframe" class="embed-responsive-item" src="https://www.youtube.com/embed/5nqUaVh11XI"></iframe>
			  </div>
			  <!-- End Video Iframe -->
			</div>
			<!-- End Video Block -->
			
			<hr class="my-4">
				
            <!-- Title -->
            <div class="mb-3">
              <h4 class="h6 mb-0">오시는 길</h4>
              <a href="/login/map.do"><small class="text-secondary">클릭하면 오시는 길로 연결됩니다.</small></a>
            </div>
            <!-- End Title -->

            <!-- Title -->
            <div class="mb-3">
              <h4 class="h6 mb-0">스터디 찾기</h4>
              <a href="/login/listStudy.do"><small class="text-secondary">클릭하면 스터디로 연결됩니다.</small></a>
            </div>
            <!-- End Title -->
				

          </div>
          <!-- End Order Summary -->
        </div>

        <div class="col-lg-8 order-lg-1">
          <!-- insert Form -->
          <form class="js-validate js-step-form pr-lg-4"data-progress-id="#stepFormProgress"
                data-steps-id="#stepFormContent"novalidate="novalidate" id="insert_form" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
            <!-- Form Content -->
            <div id="stepFormContent">
            
              <!-- Customer Info -->
              <div id="insert_form_div" class="active">
              
                <!-- Title -->
                <div class="mb-4">
                  <h4 class="h4"> ${board_boardname} </h4>
                </div>
                <!-- End Title -->

                <!-- insert Board Form -->
                <div class="row">
                  <div class="col-md-6">
                    	<input type="hidden" name="board_boardno" id="board_boardno" value="${board_boardno}">
                    	<div class="js-form-message mb-6">
                      		<label class="h6 small d-block text-uppercase">
                        		학번
                        		<span class="text-danger">*</span>
                      		</label>
                      	<!-- 학번 입력 -->
	                      	<div class="js-focus-state input-group form">
	                      		<input type="hidden" name="std_no" id="std_no" value="${ std_no }">
	                        	<input class="form-control form__input" type="Number"  required
	                               readonly="readonly"
	                               placeholder="${ std_no }"
	                               data-msg="작성자는 수정 할 수 없습니다."
	                               data-error-class="u-has-error"
	                               data-success-class="u-has-success">
	                      	</div>
                    	</div>
                  	</div>
                  
                  <div class="w-100"></div>
                  <div class="col-md-6">

                    <div class="js-form-message mb-6">
                      <label class="h6 small d-block text-uppercase">
                        	제목
                        <span class="text-danger">*</span>
                      </label>

                      <div class="js-focus-state input-group form">
                        <input class="form-control form__input" type="text"" name="board_title" id="board_title" required
                               placeholder="제목을 입력하세요"
                               data-msg="글 제목을 입력하세요"
                               data-error-class="u-has-error"
                               data-success-class="u-has-success">
                      </div>
                    </div>
                  </div>

                  <div class="col-md-6">
                    <!-- Input -->
                    <div class="js-form-message mb-6">
                      <label class="h6 small d-block text-uppercase">
                      	  비밀번호
                        <span class="text-danger">*</span>
                      </label>

                      <div class="js-focus-state input-group form">
                        <input class="form-control form__input" name="board_pwd" id="board_pwd" type="password" required
                               placeholder="비밀번호 입력"
                               data-msg="작성글 수정&삭제를 위한 비밀번호를 입력하세요."
                               data-error-class="u-has-error"
                               data-success-class="u-has-success">
                      </div>
                    </div>
                    <!-- End Input -->
                  </div>

                  <div class="w-100"></div>

                  <div class="col-md-8">
                    <!-- Input -->
                    <div class="js-form-message mb-6">
                      <label class="h6 small d-block text-uppercase">
                        	카테고리
                        <span class="text-danger">*</span>
                      </label>

                      <div class="js-focus-state input-group form">
                        <select class="custom-select" data-size="5" name="board_category" id="board_category">
                        	<c:forEach var="cl" items="${category_list}" begin="0" end="${category_list.size()}">
								<option value="${cl}">${cl}</option>
							</c:forEach>
                        </select>
                      </div>
                    </div>
                    <!-- End Input -->
                  </div>

                  <div class="col-md-12">
                    <!-- Input -->
                    <div class="js-form-message mb-6">
                      <label class="h6 small d-block text-uppercase">
                      	  내용
                        <span class="text-danger">*</span>
                      </label>

                      <div class="form-group">
                        <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="board_content" id="board_content"></textarea>
                      </div>
                    </div>
                    <!-- End Input -->
                  </div>

                  <div class="col-md-12">
                    <!-- Input -->
                    <div class="js-form-message mb-6">
                      <!-- file upload -->
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="upload_file" name="upload_file">
                        <label class="custom-file-label" for="customFile"> 파일을 선택하세요 </label>
                      </div>
                    </div>
                    <!-- End Input -->
                  </div>
                  <div class="w-100"></div>
                  </div>
                </div>
               </form>
                <!-- End Form -->

                <!-- Buttons -->
                <div class="d-sm-flex justify-content-sm-between align-items-sm-center">
                  <a class="d-block mb-3 mb-sm-0" href="classic.html">
                    <i class="fa fa-arrow-left mr-2"></i>
                   	 목록으로 돌아가기
                  </a>

                  <button type="button" class="btn btn-primary" 
                  		 id="btn_insert">
                  	게시물 등록
                  </button>
                </div>
                <!-- End Buttons -->

                <hr class="my-9">

                <!-- End Title -->

          
          <!-- End Checkout Form -->
        </div>
      </div>
    </div>
    <!-- End Checkout Form Section -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->
  </div>
  
<jsp:include page="../footer.jsp"/>
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


  <!-- JS Implementing Plugins -->
  <script src="../../assets/vendor/hs-megamenu/src/hs.megamenu.js"></script>
  <script src="../../assets/vendor/jquery-validation/dist/jquery.validate.min.js"></script>
  <script src="../../assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
  <script src="../../assets/vendor/custombox/dist/custombox.min.js"></script>
  <script src="../../assets/vendor/custombox/dist/custombox.legacy.min.js"></script>
  <script src="../../assets/vendor/instafeed.js/instafeed.min.js"></script>
  <script src="../../assets/vendor/player.js/dist/player.min.js"></script>

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
  <script src="../../assets/js/components/hs.video-player.js"></script>

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
      $(document).on('ready', function () {
    	    // initialization of video player
    	    $.HSCore.components.HSVideoPlayer.init('.js-inline-video-player');
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