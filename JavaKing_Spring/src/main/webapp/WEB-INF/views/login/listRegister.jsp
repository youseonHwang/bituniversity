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

.reg_payment{
	color : red;
	font-weight : bold;
	background-color: #bfbfbf;
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
$(function(){
	
	$('#list').empty();

	$.ajax("/login/listRegister",{success:function(arr){
		
		$.each(arr, function(row, item){

			var tr = $('<tr></tr>');
			var payment_td = $('<td></td>');
			var reg_year = $("<td></td>").text(item.reg_year);
			var reg_semester = $("<td></td>").text(item.reg_level);
			var reg_level = $("<td></td>").text(numberWithCommas(item.reg_semester)); 
			var reg_entfee = $("<td></td>").text(numberWithCommas(item.reg_entfee)); 
			var reg_fee = $("<td></td>").text(numberWithCommas(item.reg_fee)); 
			var reg_regfee = $("<td></td>").text(numberWithCommas(item.reg_regfee)); 
			var reg_date = $("<td></td>").text(item.reg_date);

			
			$(payment_td).addClass("reg_payment");
			$(payment_td).attr({
				width:80		
			});
	   		var payment_a = $('<a></a>');
	   		$(payment_a).attr({
	   			style:"color:red"		
			});
	   		payment_a.attr('href', "javascript:fn_pay("+JSON.stringify(item)+")");
	   		payment_a.text("수납")
		    payment_td.append(payment_a);

			
			$(tr).append(reg_year, reg_level, reg_semester, reg_entfee, reg_fee, reg_regfee, reg_date, payment_td);
			$('#list').append(tr); 
		});
	}});

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
		
});

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


function fn_pay (e) {

	if(e.reg_fee == '0'){ 
		alert("(납부완료) 납부할 금액이 없습니다. ");
	} else {
		
		var IMP = window.IMP; // 생략가능
		IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'vbank',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '등록금 납부',
		    amount : e.reg_fee,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : e.std_name,
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
		}, function(rsp) {
		    if ( rsp.success ) {
			    
		        var msg = '결제가 완료되었습니다.';
	
		        var data = "reg_no="+e.reg_no;
		        
	 	        $.ajax("/login/updateRegfee.do",{
					data: data,
					success:function(res){
						console.log(res);
					},
					error : function (res){
						console.log(res);
					}
				})
	
		        msg += '\n\n이름 : ' + e.std_name+"\n";
		        msg += '등록금 금액 : ' + numberWithCommas(e.reg_fee);
		  
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);

		    location.reload(true);
		});
	}
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
    <div class="hanna space-2 space-3-top--lg bg-primary text-white pl-9 text-center text-weight-bold">
      <h1 class = "h1 hanna">등록금 납부 조회</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
        	<div class="row bootstrap snippets bootdeys" id="property-list">
			    <table class="table table-sm" style="text-align: center;">
			            <thead class="thead-dark">
			              <tr>
			                <th scope="col">년도</th>
			                <th scope="col">학년</th>
			                <th scope="col">학기</th>
			                <th scope="col">등록금</th>
			                <th scope="col">미납금액</th>
			                <th scope="col">납부금액</th>
			                <th scope="col">등록일</th>
			                <th scope="col">납부</th>
			              </tr>
			            </thead>
			            <tbody id="list">
			
			            </tbody>
			          </table>
			</div>
        
          <!-- End Pagination -->
        </div>

        <div class="col-lg-3 order-lg-1">
          <div class="portlet light profile-sidebar-portlet bordered">
         <!--   <div class="card-body user-profile-card mb-3">
              <img src="../upload/${sv.std_fname }" class="user-profile-image rounded-circle" alt="" width="160" height="160"/> 
          </div>
          <hr> -->
          <!-- ========== schoolRegi_leftBar_Categories 삽입 ========== -->
		  <jsp:include page="../schoolRegi_leftBar_Categories.jsp"/>
		  <!-- ========== END schoolRegi_leftBar_Categories 삽입 ========== -->
        </div>
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