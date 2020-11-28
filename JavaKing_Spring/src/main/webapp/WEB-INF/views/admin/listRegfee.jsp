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
  
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

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
 
<style type="text/css">

</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){

	$('#list').empty();

	$.ajax("/admin/listRegfee",{success:function(arr){
		
		$.each(arr, function(row, item){
		
			var tr = $('<tr></tr>');
			var reg_no = $("<td></td>").text(item.reg_no);
			$(reg_no).attr({
				width:80		
			});
			var std_no = $("<td></td>").text(item.std_no);
			var std_name = $("<td></td>").text(item.std_name);
			var reg_entfee = $("<td></td>").text(numberWithCommas(item.reg_entfee)); 
			var reg_fee = $("<td></td>").text(numberWithCommas(item.reg_fee));  
			
				
			$(tr).append(reg_no, std_no, std_name, reg_entfee, reg_fee);
			$('#list').append(tr); 
		});
	}});


	$(document).ready(function() {
        $("#keyword").keyup(function() {
            var k = $(this).val();
            $("#reg_table > tbody > tr").hide();
            var temp = $("#reg_table > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");

            $(temp).parent().show();
        })
    })

     $("th").css("min-width","90px");

        var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
        
        if ( varUA.indexOf('android') > -1) {
            //안드로이드
        	$("table").css("font-size", "10px");
			$("th").css("min-width", '40px');
        } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
            //IOS
        	$("table").css("font-size", "10px");
			$("th").css("min-width", '40px');
        }

 
        $("#addReg").click(function(){

    			var data = $("#insertReg").serialize();
    			$.ajax("/admin/insertRegister",{
    				data:data,
    				success:function(res){
    					console.log(res);
    					$("input").val('');
    					location.reload(true);
    				},
    				error:function(request, status, error){
    					alert("(등록실패) 입력값을 확인하세요.");
    				}		
    			})	
    	})
		
});


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}





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
      <h1 class = "h1 hanna">등록금 관리</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
        	
        	<button type="button" id="btnAdd" class="btn btn-outline-primary"
						data-toggle="modal" data-target="#addModal" >신규 등록</button>
			<br>
        
 
        	<div class="row bootstrap snippets bootdeys" id="property-list">
        	
				<div id="input-form" style="text-align: right;width: -webkit-fill-available;">
				<b>학번검색 :</b> <input type="text" id="keyword" />
				</div>
			    <table class="table table-sm" style="text-align: center;" id="reg_table">
			            <thead class="thead-dark">
			              <tr>
			                <th scope="col">등록번호</th>
			                <th scope="col">학번</th>
			                <th scope="col">이름</th>
			                <th scope="col">등록금</th>
			                <th scope="col">미납금액</th>
			              </tr>
			            </thead>
			            <tbody id="list">
			
			            </tbody>
			          </table>
			</div>
        
    
          <!-- End Pagination -->
        </div>
        
        <!-- 등록금 등록 Modal -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
			aria-labelledby="myLargeModalLabel">
			<div class="modal-dialog " role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">등록금 등록</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form class="js-validate" id="insertReg">
							
								<div class="col-sm-12 mb-3">
									<div class="js-form-message">
										<label class="h6 small d-block text-uppercase"> 학번
											<span class="text-danger">*</span>
										</label>

										<div class="js-focus-state input-group form">
											<input class="form-control form__input" type="number"
												id="std_no" name="std_no" required placeholder="학번입력">
										</div>
									</div>
								</div>

								<div class="col-sm-12 mb-3">
									<div class="js-form-message">
										<label class="h6 small d-block text-uppercase"> 연도
											<span class="text-danger">*</span>
										</label>

										<div class="js-focus-state input-group form">
											<input class="form-control form__input" type="number"
												id="reg_year" name="reg_year" required placeholder="연도입력">
										</div>
									</div>
								</div>	

								<div class="col-sm-12 mb-3">
									<div class="js-form-message">
										<label class="h6 small d-block text-uppercase"> 학년
											<span class="text-danger">*</span>
										</label>

										<div class="js-focus-state input-group form">
											<input class="form-control form__input" type="number"
												id="reg_level" name="reg_level" required
												placeholder="1/2/3/4">
										</div>
									</div>
								</div>

								<div class="col-sm-12 mb-3">
									<div class="js-form-message">
										<label class="h6 small d-block text-uppercase"> 학기
											<span class="text-danger">*</span>
										</label>

										<div class="js-focus-state input-group form">
											<input class="form-control form__input" type="number"
												id="reg_semester" name="reg_semester" required placeholder="1/2">
										</div>
									</div>
								</div>

								<div class="col-sm-12 mb-3">
									<div class="js-form-message">
										<label class="h6 small d-block text-uppercase"> 등록금
											<span class="text-danger">*</span>
										</label>

										<div class="js-focus-state input-group form">
											<input class="form-control form__input" type="number"
												id="reg_entfee" name="reg_entfee" required placeholder="금액입력">
										</div>
									</div>
								</div>

							<div class="text-right">
								<button type="button"
									class="btn btn-primary btn-sm btn-primary" id="addReg">등록</button>
							</div>
						</form>
						<!-- End Hire Us Form -->

					</div>

				</div>
			</div>
		</div>
		<!-- End Pagination -->


        <div class="col-lg-3 order-lg-1">
          <!-- ========== admin_leftBar_Categories 삽입 ========== -->
			 <jsp:include page="../admin_leftBar_Categories.jsp"/>
			 <!-- ========== END admin_leftBar_Categories 삽입 ========== -->
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