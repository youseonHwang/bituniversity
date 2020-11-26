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
<!-- 내꺼 CSS -->
<!-- <link rel="stylesheet" href="../css/style_classDetail.css"></script> -->

  <!-- CSS Space Template -->
  <link rel="stylesheet" href="../../assets/css/theme.css">
	
<!-- JS Global Compulsory -->
	<script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
	<script src="../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
	<script src="../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
	<script src="../assets/vendor/bootstrap/bootstrap.min.js"></script>
	<!-- JS Space -->
	<script src="../assets/js/hs.core.js"></script>

<!-- 내꺼 -->
	<script type="text/javascript" src="../script/jquery_classDetail.js"></script>
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
      <h1 class = "h1 hanna">수강 내역 조회</h1>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
         <!-- ========mymymymymymymymymymy 내꺼 ====================== --> 
      
         <input id="hiddenStdID" type="hidden" value="${std_no}">

    <div class="totalWrap" style="text-align:center">

        <div class="wrap stdCredit">
            <h3>학점취득내역</h3>
            
            <!--table 시작-->
            <div class="stdCredit_innerWrap">
                <table class="table table-sm stdCreditTable" style="overflow:auto">
                    <thead class="thead-dark">
                        <tr class="tr">
                            <th class="th">전공구분</th>
                            <th class="th">이수구분</th>
                            <th class="th">취득학점</th>
                        </tr>
                    </thead>
                    <tbody class="stdCreditTable_tbody">
                        <tr class="tr general">
                            <th class="th general" rowspan="2">교양</th>
                            <th class="th general">교양필수</th>
                            <td class="td general-req"></td>
                        </tr>
                        <tr class="tr general">
                            <th class="th general">교양선택</th>
                            <td class="td general-elec"></td>
                        </tr>
                        <tr class="tr">
                            <th class="th major" rowspan="2">전공</th>
                            <th class="th major">전공필수</th>
                            <td class="td major-req"></td>
                        </tr>
                        <tr class="tr general">
                            <th class="th">전공선택</th>
                            <td class="td major-elec"></td>
                        </tr>
                        <tr class="tr common">
                            <th class="th common">일반선택</th>
                            <th class="th common">일반선택</th>
                            <td class="td commonTd"></td> 
                        </tr>
                    </tbody>
                </table>
            </div>
        
            <div class="stdCredit_innerWrap">
                <table class="table table-sm">
                    <tr class="tr">
                        <th class="th">졸업취득학점</th>
                        <td class="td">140</td>
                    </tr>
                    <tr class="tr">
                        <th class="th">취득학점</th>
                        <td class="td getTtl"></td>
                    </tr>
                </table>
            </div>
        </div>
			<br><br>
            <h3>필수과목 취득내역</h3>
	            <font style="font-size:11px">
						※ 0:전공필수 1:전공선택 10:교양필수 11:교양선택 21:일반선택 <br>
				</font>
			<br>
        <div class="wrap stdCompulsorySubject js-scrollbar" style="overflow:auto; height:300px;">
            <div class="subjectTable">
	            <table class="table table-sm reqTable" style="overflow:auto;height:300px;">
	                <thead class="thead-dark">
	                    <tr class="tr">
	                        <th class="th">전공구분</th>
	                        <th class="th">이수구분</th>
	                        <th class="th">학년</th><!-- 과목의 타겟학년 -->
	                        <th class="th">교과목명</th>
	                        <th class="th">학점</th>
	                        <th class="th">취득여부</th>
	                        <th class="th">이수날짜</th>
	                    </tr>
	                </thead>
	                <tbody class="tbody reqTbody">
	                    <!-- ajax 로 창 열자마자 보이게 하기 -->
	                </tbody>
            	</table>
            </div>
        </div>
        <br><br>
        <div class="wrap stdSubject">
        <br><br>
            <div class="searchSection">
             <div class="js-focus-state input-group input-group-sm form form--sm mb-7">
                 <!--    <span class="span">년도</span> -->
                    <select id="selectYear" class="selectYear form-control">
                        <option >== 년도 ==</option>
                        <option value="2014" class="selectYear">2014</option>
                        <option value="2015" class="selectYear">2015</option>
                        <option value="2016" class="selectYear">2016</option>
                        <option value="2017" class="selectYear">2017</option>
                        <option value="2018" class="selectYear">2018</option>
                        <option value="2019" class="selectYear">2019</option>
                        <option value="2020" class="selectYear">2020</option>
                    </select>
                  <!--   <span class="span">학기</span> -->
                    <select id="selectSemester" class="selectSemester form-control">
                        <option >== 학기 ==</option>
                        <option value="1" class="selectSemester">1</option>
                        <option value="2" class="selectSemester">2</option>
                    </select>
                     <span class="input-group-append form__append">
			      		<button id="btnSearch" class="btn btn-primary" type="button">
				        	<span class="fa fa-search"></span>
				     	</button>
			     	 </span>
              </div>  
             <font style="font-size:12px">
						※ 0:전공필수 1:전공선택 10:교양필수 11:교양선택 21:일반선택 <br>
			</font>
			<br>
            </div>
            <div class="tableSection js-scrollbar" style="overflow:auto; height:300px;">
                <table class="table table-sm">
                   <thead class="thead-dark">
                        <tr class="tr">
                            <th class="th">년도</th>
                            <th class="th">학기</th>
                            <th class="th">전공구분</th>
                            <th class="th">이수구분</th>
                            <th class="th">과목명</th>
                            <th class="th">담당교수</th>
                            <th class="th">학점</th>
                            <th class="th">강의시간</th>
                        </tr>
                    </thead>
                    <tbody class="SearchTbody">
                          <!-- ajax 로 연결. 창 열자마자는 전체내역 보이게 하기 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
         <!-- ========END mymymymymENDymymymymymy 내꺼 끝====================== -->
          <!-- End Pagination -->
        </div>

        <div class="col-lg-3 order-lg-1">
          <div class="portlet light profile-sidebar-portlet bordered">
            
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