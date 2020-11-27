<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>:: 비트대학교 ::</title>
<head>
  <!-- Required Meta Tags Always Come First -->

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
<script type="text/javascript" src = "https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
		
		var page_num = 1
		var page_size =  15
		var page_max = 5
		var keyword
		var search
		var board_boardno=${board_boardno}
		var board_category= '<c:out value="${board_category}"/>'

		var getItems = function(page_num, page_size, keyword, search, board_boardno, board_category){
			var data = {page_num:page_num, page_size:page_size, 
						keyword:keyword, search:search,
						board_boardno:board_boardno,
						board_category:board_category};

			$.ajax({url:"/login/listBoard", data:data, success:function(res){


				$("#h-tab").empty();
				
				// 게시판 카테고리 별 번호에 따라 동적으로 글쓰기 태그 생성---------------------------------------------
				$('.write_tag').empty();
				var a = $('<a style="font-size : 19px"></a>').html('글쓰기');
				a.attr('href', '/login/insertBoard.do?board_boardno='+res.board_boardno);
				$('.write_tag').append(a);

				// 게시판 이름과 카테고리 이름 표시하기---------------------------------------------------------
				$('#board_boardname').empty();
				$('#board_boardname').html(res.board_boardname);
				$('#board_category').empty();
				$('#board_category').html(res.board_category);

				// 페이징 버튼-------------------------------------------------------------------------
				$('.paging_button').empty()
				$('.tbody').empty()
				var total_item = Number(res.board_count);
				var total_page = Math.ceil(total_item/page_size);
				
				var start_page = Math.floor((page_num-1)/page_max+1);
				
				var end_page = start_page + page_max -1;
				if(end_page > total_page) {
					end_page = total_page;
				}

				
				
				var div = $('.paging_button')
				var ul = $('<ul class="pagination"><ul>')
				
				if(start_page > 1) {
					var before_li = $('<li class="page-item"></li>');
					var before_a = $('<a class="page-link"></a>').html("<<").attr('data-page',start_page-1);
					before_li.append(before_a);
					ul.append(before_li);
					
				}

				for(var i=start_page;i<=end_page;i++){
					var li = $('<li class="page-item"></li>')
					var a = $('<a class="page-link"></a>').html(i).attr('data-page',i)
					
					li.append(a)
					ul.append(li)
					
				}

				if(total_page > end_page) {
					var next_li = $('<li class="page-item"></li>');
					var next_a = $('<a class="page-link"></a>').html(">>").attr('data-page', end_page+1);
					next_li.append(next_a);
					ul.append(next_li);
				}

				div.append(ul)

				//게시판 카테고리 메뉴 만들기-----------------------------------------------------------------
				
				var category_list = res.category_list;
				for(var i = 0; i<category_list.length; i++) {
					var category = $('<a class="nav-link h5 tab-modern__nav-link mb-4" id="h-tab-forward-tab" data-toggle="pill" href="#h-tab-forward" role="tab" aria-controls="h-tab-forward" aria-selected="false">t</a>').html(category_list[i]);
					category.attr('board_category', category_list[i]);
					$('#h-tab').append(category);
				}
				
				
				
				// 게시판 리스트 나타내기--------------------------------------------------------------------
				var arr = eval(res)
				
				arr = arr.list
		        $.each(arr, function(row, item) {
			       var tr = $('<tr></tr>')
			       var rn = $("<td></td>").text(item.rn)
			       var category = $("<td></td>").text(item.board_category)
			       var title_td = $('<td></td>')
			       var title_a = $('<a></a>')
				       title_a.attr('href', '/login/detailBoard.do?board_no='+item.board_no)
				       
				       title_a.text(item.board_title)
				       title_td.append(title_a)
				       
				   if(item.board_category != '익명게시판' && item.board_category != '공지사항' ) {
			       		var std_no = $("<td></td>").text(item.std_no);
				   } else if (item.board_category == '공지사항'){
					   var std_no = $("<td></td>").text('관리자');
				   } else {
					   	var std_no = $("<td></td>").text('익명');
				   }
				   
			       var regdate = $("<td></td>").text(item.board_regdate)
			       var hit = $("<td></td>").text(item.board_hit)
			       $(tr).append(rn,category,title_td,std_no,regdate,hit);
			       $('.tbody').append(tr)
		
				})
			}}) //ajax종료
		}

		// 게시판 하위 카테고리 메뉴 버튼을 눌렀을 경우------------------------------------------------------------
		$(document).on("click","#h-tab > a", function(){
			board_category = $(this).attr('board_category');
			page_num = 1;
			
			getItems(page_num, page_size, keyword, search, board_boardno, board_category);
			
		})

		// 페이지 버튼 눌렀을 경우--------------------------------------------------------------------------
 		$(document).on("click",".pagination >> a",function(){
			page_num = $(this).attr("data-page")
			getItems(page_num, page_size, keyword, search, board_boardno, board_category)
		})
		
		// 검색 버튼 눌렀을 경우--------------------------------------------------------------------------
		$(document).on("click", "#btn_search" , function(){
			var keyword = $("#sel_keyword").val()
			var search = $("#txt_search").val()
			page_num = 1
			getItems(page_num, page_size, keyword, search, board_boardno, board_category)
		})
		
		// 게시판을 키자마자 동작하는--------------------------------------------------------------------------			
		getItems(page_num, page_size, keyword, search, board_boardno, board_category);
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

  <link rel="#header" src="./header.html">
  
  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Hero Section -->
    <div class="hanna space-1 space-3-top--lg bg-primary text-white text-center text-weight-bold">
      <h1 class = "h1 hanna mb-5" id="board_boardname"></h1>
      <div class="nav nav-tabs justify-content-center tab-modern" id="h-tab" role="tablist" aria-orientation="vertical">
      </div>
    </div>
    <!-- End Hero Section -->

    <!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-9 order-lg-2 mb-9 mb-lg-0">
          <!-- board table 들어갈 자리-->
          <table class="table table-hover">
            <thead class="thead-dark">
              <tr>
                <th scope="col" width="10%">순번</th>
                <th scope="col" width="10%">분류</th>
                <th scope="col" width="40%">제목</th>
                <th scope="col" width="15%">작성자</th>
                <th scope="col" width="15%">작성일</th>
                <th scope="col" width="10%">조회수</th>
              </tr>
            </thead>
            <tbody class="tbody">

            </tbody>
          </table>

          <div class="mb-0">
          <!-- Pagination -->
	          <nav aria-label="Page navigation" id="Page-navigation">
	          	<div class="paging_button row justify-content-md-center">
	            	
	            </div>
	          </nav>
	          <!-- End Pagination -->
	        </div>
	        
	        <!-- 글쓰기 버튼 영역 -->
	        <div class ="write_tag float-right pr-3 font-weight-bold">

	        </div>
			<br>
			
			<!-- Search Input -->
			<div class="input-group rounded-pill bg-white overflow-hidden p-2 mb-6">
	            <select name="keyword" id="sel_keyword">
					<option value="board_title">제목</option>
					<option value="std_no">작성자</option>
				</select>
	            <input type="text" class="form-control form__input" name="search"
	                   placeholder="Search Space"
	                   aria-label="Search Space"
	                   id="txt_search">
	            <span class="input-group-append form__append">
	              <button class="btn btn-primary" id="btn_search">검색</button>
	            </span>
            </div>
          <!-- End Search Input -->  
          </div>

         

        <div class="col-lg-3 order-lg-1" style="margin-top: 0px;">
                
          <!-- Categories -->
          <jsp:include page="../madang_leftBar_Categories.jsp"/>
          <!-- End Categories -->
        </div>
      </div>
    </div>
    <!-- End News Blog Content -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->
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