<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
		var board_boardno = $("#board_boardno").val();
		
		$(".custom-file-input").on("change", function() {
		  var fileName = $(this).val().split("\\").pop();
		  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
		});
		
		$('#btn_update').click(function() {
			var form_data = new FormData($('#update_form')[0])		
			alert(form_data)
			$.ajax({
				url: "/login/updateBoard",
				type:'POST',
				data: form_data,
			    processData: false,
			    contentType: false,
				success:function(res){
					if(res != 1) {
						setTimeout(function() {
							alert('게시물 등록에 실패하였습니다.')
							alert(res)
						}, 1000)
					} else{
						window.location.href="/login/listBoard.do?board_boardno="+board_boardno
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
      <h1 class = "h1 hanna">게시물 수정</h1>
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
                <img class="u-lg-avatar rounded" src="../../assets/img/100x100/img5.jpg" alt="Image Description">
              </div>
              <div class="media-body">
                <h4 class="h6 mb-0">어쩌고</h4>
                <small class="d-block text-secondary"> 198 West 21th Street, Suite 721 New York NY 10016</small>
                <small class="d-block text-secondary"> + 1235 2355 98</small>
                <small class="d-block text-secondary">  info@yoursite.com </small>
              </div>
            </div>
            <!-- End Product -->

            <hr class="my-4">

            <!-- Title -->
            <div class="mb-3">
              <h4 class="h6 mb-0">오시는 길</h4>
              <small class="text-secondary">오시는 길 연결</small>
            </div>
            <!-- End Title -->

            <!-- Title -->
            <div class="mb-3">
              <h4 class="h6 mb-0">스터디 찾기</h4>
              <small class="text-secondary">스터디 뷰 연결</small>
            </div>
            <!-- End Title -->


          </div>
          <!-- End Order Summary -->
        </div>

        <div class="col-lg-8 order-lg-1">
          <!-- insert Form -->
          <form class="js-validate js-step-form pr-lg-4"data-progress-id="#stepFormProgress"
                data-steps-id="#stepFormContent"novalidate="novalidate" id="update_form">
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
                  		<input type="hidden" name="board_no" id="board_no" value="${b_vo.board_no }">
                    	<input type="hidden" name="board_boardno" id="board_boardno" value="${b_vo.board_boardno}">
                    	<div class="js-form-message mb-6">
                      		<label class="h6 small d-block text-uppercase">
                        		학번
                        		<span class="text-danger">*</span>
                      		</label>
                      	<!-- 학번 입력 -->
	                      	<div class="js-focus-state input-group form">
	                      		<input type="hidden" name="std_no" id="std_no" value="${b_vo.std_no}">
	                        	<input class="form-control form__input" type="Number"  required
	                               readonly="readonly"
	                               placeholder="${b_vo.std_no}"
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
                               placeholder="${b_vo.board_title}"
                               data-msg="글 제목을 입력하세요"
                               data-error-class="u-has-error"
                               data-success-class="u-has-success">
                      </div>
                    </div>
                  </div>
					
					<!-- 익명게시판일 경우에만 뜨게끔.. -->
                   <div class="col-md-6">
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
                        <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="board_content" id="board_content">${b_vo.board_content}</textarea>
                      </div>
                    </div>
                    <!-- End Input -->
                  </div>

                  <div class="col-md-12">
                    <!-- Input -->
                    <div class="js-form-message mb-6">
                      <!-- file upload -->
                      <div class="custom-file">
                      	<input type="hidden" id="board_fname" name="board_fname" value="${b_vo.board_fname}">
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
                  		data-next-step="#shippingStep" id="btn_update">
                  	게시물 수정
                  </button>
                </div>
                <!-- End Buttons -->

                <hr class="my-9">

                <!-- End Title -->




              <!-- Payment -->
              <div id="paymentStep" style="display: none;">
                <!-- Title -->
                <div class="mb-4">
                  <h2 class="h4">Payment method</h2>
                </div>
                <!-- End Title -->

                <!-- Button Group -->
                <div class="row mb-6">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <a class="js-animation-link media justify-content-center align-items-center u-shopping-cart-step-form__toggler active" href="javascript:;"
                       data-target="#creditCard"
                       data-link-group="paymentMethods">
                      <i class="far fa-credit-card u-shopping-cart-step-form__toggler-icon mr-2"></i>
                      Credit Card
                    </a>
                  </div>
                  <div class="col-sm-6">
                    <a class="js-animation-link u-shopping-cart-step-form__toggler" href="javascript:;"
                       data-target="#payPal"
                       data-link-group="paymentMethods">
                      <img class="u-shopping-cart-step-form__toggler-img" src="../../assets/img/logos/paypal.png" alt="PayPal Logo">
                    </a>
                  </div>
                </div>
                <!-- End Button Group -->

                <!-- Credit Card -->
                <div id="creditCard" data-target-group="paymentMethods">
                  <!-- Input -->
                  <div class="js-form-message mb-6">
                    <label class="h6 small d-block text-uppercase">
                      Card number
                    </label>

                    <div class="js-focus-state input-group form">
                      <input class="form-control form__input" type="text" required
                             placeholder="**** **** **** ***"
                             aria-label="**** **** **** ***"
                             data-msg="Please enter a valid card number."
                             data-error-class="u-has-error"
                             data-success-class="u-has-success">
                    </div>
                  </div>
                  <!-- End Input -->

                  <div class="row">
                    <div class="col-md-6">
                      <!-- Input -->
                      <div class="js-form-message mb-6">
                        <label class="h6 small d-block text-uppercase">
                          Card holder
                        </label>

                        <div class="js-focus-state input-group form">
                          <input class="form-control form__input" type="text" required
                                 placeholder="Jack Wayley"
                                 aria-label="Jack Wayley"
                                 data-msg="Please enter a valid card holder."
                                 data-error-class="u-has-error"
                                 data-success-class="u-has-success">
                        </div>
                      </div>
                      <!-- End Input -->
                    </div>

                    <div class="col-md-3">
                      <!-- Input -->
                      <div class="js-form-message mb-6">
                        <label class="h6 small d-block text-uppercase">
                          Expiration
                        </label>

                        <div class="js-focus-state input-group form">
                          <input class="form-control form__input" type="text" required
                                 placeholder="MM/YY"
                                 aria-label="MM/YY"
                                 data-msg="Please enter a valid date."
                                 data-error-class="u-has-error"
                                 data-success-class="u-has-success">
                        </div>
                      </div>
                      <!-- End Input -->
                    </div>

                    <div class="col-md-3">
                      <!-- Input -->
                      <div class="js-form-message mb-6">
                        <label class="h6 small d-block text-uppercase">
                          CVC
                        </label>

                        <div class="js-focus-state input-group form form--no-addon-brd">
                          <input class="form-control form__input" type="text" required
                                 placeholder="***"
                                 aria-label="***"
                                 data-msg="Please enter a valid CVC number."
                                 data-error-class="u-has-error"
                                 data-success-class="u-has-success">
                          <div class="input-group-append form__append">
                            <span class="input-group-text form__text">
                              <i class="fa fa-info-circle form__text-inner" data-toggle="tooltip" data-placement="top" title="The 3 or 4 digit code usually found on the back of your card"></i>
                            </span>
                          </div>
                        </div>
                      </div>
                      <!-- End Input -->
                    </div>
                  </div>
                </div>
                <!-- End Credit Card -->

                <!-- Credit Card -->
                <div id="payPal" style="display: none; opacity: 0;" data-target-group="paymentMethods">
                  <button type="submit" class="btn btn-block btn-warning mb-6">
                    Pay with
                    <img src="../../assets/img/logos/paypal.png" style="width: 70px;" alt="PayPal logo">
                  </button>
                </div>
                <!-- End Credit Card -->

                <!-- End Buttons -->

                <hr class="my-9">

                <!-- Info -->
                <div class="row">
                  <div class="col-sm-6 mb-7 mb-sm-0">
                    <!-- Icon Block -->
                    <img class="max-width-10 mb-1" src="../../assets/svg/components/safe-information-dark-icon.svg" alt="Image Description">
                    <h3 class="h6 mb-1">Your information is safe</h3>
                    <p class="font-size-14 text-muted">We will not sell your personal contact information for any marketing purposes or whatsoever.</p>
                    <!-- End Icon Block -->
                  </div>

                  <div class="col-sm-6">
                    <!-- Icon Block -->
                    <img class="max-width-10 mb-1" src="../../assets/svg/components/secure-checkout.svg" alt="Image Description">
                    <h3 class="h6 mb-1">Secure checkout</h3>
                    <p class="font-size-14 text-muted">All information is encrypted and transmitted without risk using a <span class="font-weight-medium">Secure Sockets Layer</span> protocol.</p>
                    <!-- End Icon Block -->
                  </div>
                </div>
                <!-- End Info -->
              </div>
              <!-- End Payment -->
            </div>
            <!-- End Step Form Content -->
          
          <!-- End Checkout Form -->
        </div>
      </div>
    </div>
    <!-- End Checkout Form Section -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->
  </div>
<jsp:include page="../footer.jsp"/>
  <!-- End Signup Modal Window -->
  <!-- ========== END SECONDARY CONTENTS ========== -->

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