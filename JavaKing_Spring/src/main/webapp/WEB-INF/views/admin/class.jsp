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
  <!-- 내꺼 -->
<link rel="stylesheet" href="../css/style_class.css" >

<!-- JS Global Compulsory -->
<script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
<script src="../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
<script src="../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
<script src="../assets/vendor/bootstrap/bootstrap.min.js"></script>

<!-- JS Space -->
<script src="../assets/js/hs.core.js"></script>
<!-- 내꺼 -->
<script type="text/javascript" src="../script/jquery_class.js"></script>
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
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna">강의정보 관리</h1>
      <p class="lead">신규강의 등록과 기존 강의를 수정, 삭제할 수 있습니다.</p>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
<!-- ====== MYMYMYMYMYMYMYMYMY====MYMYMY==MY===MY=== 내 컨텐츠 -->
	<input type="hidden" id="hiddenNo_forEdit" value=''>
			<div class="btns">
				<a href="#insertModal" data-toggle="modal"><button type="button" class="btn btn-outline-success">신규등록</button></a>
				<a id="aEdit" href="#updateModal" data-toggle="modal"><button id="btnEdit" type="button" class="btn btn-outline-success">수정</button></a>
				<a id="aDel" href=""><button type="button" id="btnDel" class="btn btn-outline-success">삭제</button></a>
			</div>
			<br>
		
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
    	
		<table id="table" class="table table-sm">
		 <thead class="thead-dark">
				<tr>
					<th>순번</th>
					<th>학부</th>
					<th>학년</th>
					<th>구분</th>
					<th>과목명(번호)</th>
					<th>학점</th>
					<th>시작/종료일</th>
					<th>시간</th>
					<th>담당교수</th>
					<th>교실</th>
					<th>인원</th>
				</tr>
				</thead>
			<tbody id="tbody" class="clk">
			</tbody>
		</table>
		<br>
		
		<!-- Pagination -->
          <nav aria-label="Page navigation">
            <ul id="paging_button" class="pagination"></ul>
          </nav>
        <!-- End Pagination -->


<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content border-0">
        <div class="modal-header d-block d-lg-flex justify-content-between align-items-center border-darker pt-9 pb-4 px-5">
          <div class="media align-items-center mb-5 mb-lg-0">
            <div class="media-body text-nowrap">
              <h3 class="h5 mb-0">신규 강의 등록</h3>
            </div>
          </div>
		</div>
		
        <div class="modal-body p-lg-5">
         <form action="adminClass.do" method="post">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
          <div class="row">
            <div class="col-lg-7 col-xl-8">
              	<table>
					<tr>
						<td><label title="강의번호">강의번호</label></td>
						<td><input type="number"class="form-control" name="class_no" value="${class_no }"></td>
					</tr>
					<tr>
						<td><label title="강의명">강의명</label></td>
						<td><input type="text"class="form-control" name="class_name" ></td>
					</tr>
					<tr>
						<td><label title="강의시작일">강의시작일</label></td>
						<td><input type="date" class="form-control" name="class_startdate"></td>
					</tr>
					<tr>
						<td><label title="강의종료일">강의종료일</label></td>
						<td><input type="date" class="form-control" name="class_enddate"></td>
					</tr>
					<tr>
						<td><label title="강의요일">강의요일</label></td>
						<td><input type="text" class="form-control" name="class_dayofweek"  placeholder="2일 이상 .으로 구분"></td>
					</tr>
					<tr>
						<td><label title="강의교시">강의교시</label></td>
						<td><input type="text" class="form-control" name="class_time" placeholder="2교시 이상 띄어쓰기없이 입력 / 2일 이상 .으로 구분"></td>
					</tr>
					<tr>
						<td><label title="강의실">강의실</label></td>
						<td><input type="text" class="form-control" name="class_room" ></td>
					</tr>
					<tr>
						<td><label title="학점">학점</label></td>
						<td><input type="number" class="form-control" name="class_credit"></td>
					</tr>
					
				</table>	      
            </div>
            
            <div class="col-lg-5 col-xl-4">
            
            	<table>
					
					<tr>
						<td><label title="이수구분">이수구분</label></td>
						<td><select class="form-control" name="class_type">
							<option selected="selected">선택</option>
							<option value="0">전공필수</option>
							<option value="01">전공선택</option>
							<option value="10">교양필수</option>
							<option value="11">교양선택</option>
							<option value="21">일반선택</option>
						</select></td>
					</tr>
					<tr>
						<td><label title="대상학년">대상학년</label></td>
						<td><select class="form-control" name="class_level">
							<option selected="selected">선택</option>
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
							<option value="4">4학년</option>
						</select></td>
					</tr>
					<tr>
					
					<!-- professor 의 pro_type 은 college_no 와 연동되어있지 않다. 그러므로 pro_type 은 String ! -->
						<td><label title="학부">학부</label></td>
						<td><select class="form-control" name="pro_type" id="pro_type">
							<option selected="selected">선택</option>
							<option value="인문학부">인문학부</option>
							<option value="사회경영학부">사회경영학부</option>
							<option value="공학부">공학부</option>
							<option value="문화예술학부">문화예술학부</option>
							<option value="공통">공통</option>
						<!-- js 에서 처리..college_no 는 숫자이므로 professor 와 별개로 hidden 으로 넘겨줘야한다.. -->
						<input type='hidden' value='' id="college_no" name="college_no">
						</select></td>
					</tr>
					<tr>
						<td><label title="교수번호">교수번호</label></td>
						<td><select class="form-control" id="proList" name="pro_no">
							<option selected="selected">선택</option>
					<!-- ajax 으로 추가 -->
						</select></td>
					</tr>
					<tr>
						<td><label title="제한인원">제한인원</label></td>
						<td><select class="form-control" name="class_max">
							<option selected="selected">선택</option>
							<option value="25">25</option>
							<option value="30">30</option>
							<option value="50">50</option>
							<option value="100">100</option>
							<option value="150">150</option>
						</select></td>
					</tr>
				</table>	
            	<br><br><br>
                <div class="text-center">
                <button type="submit" class="btn btn-block btn-primary font-weight-medium mb-3">강의 등록</button>
              </div>
            </div>

          </div>
         </form>
        </div>

        <button type="button" class="close position-absolute-top-right-0 mt-4 mr-4" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><i class="svg-icon svg-icon-xs text-muted"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></i></span>
        </button>
      </div>
    </div>
  </div>
  <!-- End insert Modal Window-->



<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content border-0">
        <div class="modal-header d-block d-lg-flex justify-content-between align-items-center border-darker pt-9 pb-4 px-5">
          <div class="media align-items-center mb-5 mb-lg-0">
            <div class="media-body text-nowrap">
              <h3 class="h5 mb-0">강의 수정</h3>
            </div>
          </div>
		</div>
		
       <div class="modal-body p-lg-5">
          <form action="adminClassEdit.do" method="post">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
         	 <div class="row">
	          <div class="col-lg-7 col-xl-8">
				<table>
					<tr>
						<td><label title="강의번호">강의번호</label></td>
						<td><input type="text" class="form-control" name="class_no" id="class_no_update" val="" readonly="readonly"></td>
					</tr>
					<tr>
						<td><label title="강의명">강의명</label></td>
						<td><input type="text" class="form-control" name="class_name" id="class_name_update" value=""></td>
					</tr>
					<tr>
						<td><label title="강의시작일">강의시작일</label></td>
						<td><input type="date" class="form-control" name="class_startdate" id="class_startdate_update" value=""></td>
					</tr>
					<tr>
						<td><label title="강의종료일">강의종료일</label></td>
						<td><input type="date" class="form-control" name="class_enddate" id="class_enddate_update" value=""></td>
					</tr>
					<tr>
						<td><label title="강의요일">강의요일</label></td>
						<td><input type="text" class="form-control" name="class_dayofweek" id="class_dayofweek_update" value="" placeholder="2일 이상 .으로 구분"></td>
					</tr>
					<tr>
						<td><label title="강의교시">강의교시</label></td>
						<td><input type="text" class="form-control" name="class_time" id="class_time_update" value="" placeholder="2교시 이상 띄어쓰기없이 입력 / 2일 이상 .으로 구분"></td>
					</tr>
					<tr>
						<td><label title="강의실">강의실</label></td>
						<td><input type="text" class="form-control" name="class_room" id="class_room_update" value=""></td>
					</tr>
					<tr>
						<td><label title="학점">학점</label></td>
						<td><input type="number" class="form-control" name="class_credit" id="class_credit_update" value=""></td>
					</tr>
				</table>
            </div>
            <!-- table first part end -->
            
            <div class="col-lg-5 col-xl-4">
				<table>
					<tr>
						<td><label title="이수구분">이수구분</label></td>
						<td><select class="form-control" name="class_type" id="class_type_update">
							<option id="class_type_update_op" selected disable hidden value=""></option>
							<option value="0">전공필수</option>
							<option value="1">전공선택</option>
							<option value="10">교양필수</option>
							<option value="11">교양선택</option>
							<option value="21">일반선택</option>
						</select></td>
					</tr>
					<tr>
						<td><label title="대상학년">대상학년</label></td>
						<td><select class="form-control" name="class_level">
							<option id="class_level_update" selected disable hidden value=""></option>
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
							<option value="4">4학년</option>
						</select></td>
					</tr>
					<tr>
					
					<!-- professor 의 pro_type 은 college_no 와 연동되어있지 않다. 그러므로 pro_type 은 String ! -->
						<td><label title="학부">학부</label></td>
						<td><select class="form-control" name="pro_type" id="pro_type_update">
							<option id="changeProType" selected disable hidden value=""></option>
							<option value="인문학부">인문학부</option>
							<option value="사회경영학부">사회경영학부</option>
							<option value="공학부">공학부</option>
							<option value="문화예술학부">문화예술학부</option>
							<option value="공통">공통</option>
						<!-- college_no 는 숫자이므로 professor 와 별개로 hidden 으로 넘겨줘야한다.. -->
						<input type='hidden' value='' id="college_no_update" name="college_no">
						</select></td>
					</tr>
					<tr>
						<td><label title="교수번호">교수번호</label></td>
					<!-- <td><input type="number" id="div교수번호" class="form-control" name="pro_no"></td> -->
						<td><select class="form-control" id="proList_update" name="pro_no">
							<option id="pro_no_update" selected disable hidden value=""></option>
					<!-- ajax 으로 추가 -->
						</select></td>
					</tr>
					<tr>
						<td><label title="제한인원">제한인원</label></td>
						<td><select class="form-control" name="class_max">
							<option id="class_max_update" selected disable hidden value=""></option>
							<option value="25">25</option>
							<option value="30">30</option>
							<option value="50">50</option>
							<option value="100">100</option>
							<option value="150">150</option>
						</select></td>
				
					</tr>
				</table>	
            	<br><br><br>
                <div class="text-center">
                <button type="submit" class="btn btn-block btn-primary font-weight-medium mb-3">강의 수정</button>
               </div>
            </div>

          </div>
         </form>
        </div>

        <button type="button" class="close position-absolute-top-right-0 mt-4 mr-4" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><i class="svg-icon svg-icon-xs text-muted"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></i></span>
        </button>
      </div>
    </div>
  </div>
  <!-- End Info Modal Window for update-->

<!-- =================MY END= MY END = MY END = MY END ======================  내 컨텐츠 끝-->
          
        </div>

        <div class="col-lg-3 order-lg-1">
          <!-- ========== admin_leftBar_Categories 삽입 ========== -->
			 <jsp:include page="../admin_leftBar_Categories.jsp"/>
			 <!-- ========== END admin_leftBar_Categories 삽입 ========== -->
            </div>
          </div>
          <!-- End Categories -->
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