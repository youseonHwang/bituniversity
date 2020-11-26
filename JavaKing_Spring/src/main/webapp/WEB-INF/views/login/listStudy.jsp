<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

		var scategory_no = '<c:out value="${scategory_no}"/>';
		var search="";
		var area="";
		var std_no = ${std_no}; //현재 로그인 한 사람의 학번		
		var page_num =1;
		

		//스터디 리스트를 가져오는 함수만들기
		var getStudy = function(scategory_no, search, area, page_num) {
			
			var data = {scategory_no:scategory_no, search:search, area: area, page_num:page_num }
			
			  $.ajax({url:"/login/listStudy", data:data, success:function(res){

				  var list = res.list;
					
				  $.each(list, function(row, item) {

					var card_shadow = $('<div class="card shadow-sm border-0 mb-4 px-4"></div>');

					var card_body =$('<div class="card-body d-md-flex justify-content-between align-items-center py-4 px-0"></div>');

					var media_align = $('<div class="media align-items-center mb-5 mb-md-0"></div>');
					var media_body = $('<div class="media-body text-nowrap"></div>');
					var scategory_name = $('<a class="small text-uppercase text-secondary letter-spacing-0_06 mb-1"></a>').html(item.scategory_name);
					var study_name = $('<h3 class="h5 mb-0"></h3>').html(item.study_title);

					//1
					media_body.append(scategory_name, study_name);
					//2
					media_align.append(media_body);
					//3
					card_body.append(media_align);

					var text_md = $('<div class="text-md-right text-secondary"></div>');
					var study_regdate = $('<small class="d-block mb-2 mb-md-1"></small>').html(item.study_regdate);
					var d_flex = $('<a class="d-flex align-items-center text-secondary"></a>')
					var icon = $('<i class="svg-icon svg-icon-xs text-secondary mt-n1 mr-2"></i>');
					
					if(item.study_area != null) {
						var study_area_index = item.study_area.lastIndexOf("/");
						var map = $('<span></span>').html(item.study_area.substring(study_area_index +1));
					}
					
					//1
					d_flex.append(icon,map);
					//2
					text_md.append(study_regdate,d_flex);
					//3
					card_body.append(text_md);

					//--------------카드 푸터부분 시작 --------------------------------------------

					var card_footer = $('<div class="card-footer d-md-flex justify-content-between align-items-center px-0"></div>');

					var mb_4 = $('<div class="mb-4 mb-md-0"></div>')
					
					if(item.study_explain1 != null) {
						var study_explain1 = $('<a class="u-label u-label--xs u-label--primary text-uppercase letter-spacing-0_06 mr-2 mb-2"></a>').html(item.study_explain1);
						mb_4.append(study_explain1);
					}
					if(item.study_explain2 != null) {
						var study_explain2 = $('<a class="u-label u-label--xs u-label--primary text-uppercase letter-spacing-0_06 mr-2 mb-2"></a>').html(item.study_explain2);
						mb_4.append(study_explain2);
					}
					if(item.study_explain3 != null) {
						var study_explain3 = $('<a class="u-label u-label--xs u-label--primary text-uppercase letter-spacing-0_06 mr-2 mb-2"></a>').html(item.study_explain3);
						mb_4.append(study_explain3);
					}
					
					//1
					card_footer.append(mb_4);

					var detail_a = $('<a class="d-flex align-items-center font-weight-bold mb-2" data-toggle="modal">');
					detail_a.attr('href', '#modal'+item.study_no);
					var detail_text =$('<span></span>').html('Details');
					var detail_icon = $('<i class="svg-icon svg-icon-xs text-primary mt-n1 ml-2">');
					detail_a.append(detail_text,detail_icon);

					card_footer.append(detail_a);

					//--------------카드 바디와 푸터 넣기 --------------------------------------
					card_shadow.append(card_body, card_footer)
					
					$('#study_list_div').append(card_shadow);

					//---------------------스터디 리스트 종료-------------------------------------------------------------------------------
					
					
					//---------------------스터디 Detail모달창 시작------------------------------------------------------------------------------

		               var modal_fade = $('<div class="modal fade" tabindex="-1" role="dialog" id ="modal'+item.study_no+'" aria-hidden="true"></div>');
		               var modal_dialog = $('<div class="modal-dialog modal-xl" role="document"></div>');
		               var modal_content = $('<div class="modal-content border-0"></div>');

		               //모달 헤더 영역 시작
		               var modal_header = $('<div class="modal-header d-block d-lg-flex justify-content-between align-items-center border-darker pt-9 pb-4 px-5"></div>');

		                  // modal_header ⊃ modal_center ⊃ media_body
		                  var modal_center = $('<div class="media align-items-center mb-5 mb-lg-0"></div>');
		                     var media_body = $('<div class="media-body text-nowrap"></div>');
		                     
		                     // media_body ⊃ modal_category, modal_title
		                     var modal_category = $('<a class="small text-uppercase text-secondary letter-spacing-0_06 mb-1"></a>').html(item.scategory_name);
		                     var modal_title = $('<h3 class="h5 mb-0"></h3>').html(item.study_title+"("+item.study_person+"\\"+item.study_limit+")");

		                     media_body.append(modal_category, modal_title);
		                     
		                  
		                  
		                  modal_center.append(media_body);

		               
		                  // reg_area_div ⊃  modal_regdate , modal_area_a
		                  var reg_area_div = $('<div class="text-lg-right text-secondary bg-light p-3 p-lg-0 bg-lg-transparent"></div>');
		                     var modal_regdate = $('<small class="d-block mb-2 mb-md-1"></small>').html(item.study_regdate);
		                     var modal_area_a = $('<a class="d-flex align-items-center text-secondary"></a>');
		                     
		                        // modal_area_a ⊃  modal_area_i , modal_area
		                        var modal_area_i = $('<i class="svg-icon svg-icon-xs text-secondary mt-n1 mr-2"></i>');
		                        if(item.study_area != null) {
		                           var study_area_index = item.study_area.lastIndexOf("/");
		                           var modal_area = $('<span></span>').html(item.study_area.substring(study_area_index +1));
		                        }
		                        

		                     modal_area_a.append(modal_area_i, modal_area);
		                  reg_area_div.append(modal_regdate, modal_area_a);

		               modal_header.append(modal_center, reg_area_div);

		               //모달 바디 영역 시작
		               var modal_body = $('<div class="modal-body p-lg-5 text-center"></div>');
		                  var row = $('<div class="row justify-content-center"></div>');
		                  var modal_image;
		                     if(item.study_fname !=null) { //파일이 있으면
		                        modal_image= $('<img class="img-thumbnail mb-2" src="../webapp/image/'+item.fname+'" alt="Responsive image" width="60%" height="60%"/>')
		                     } else {
		                        modal_image= $('<img class="img-thumbnail mb-2" src="../../image/study.jpg" alt="Responsive image" width="60%" height="60%"/>')
		                     }
		                     var w = $('<div class="w-100"></div>');
		                     var modal_body_content = $('<p></p>').html(item.study_content);
		                     var apply_btn = $('<a class="btn btn-block btn-primary font-weight-medium mb-3" id="apply_btn"></a>').html('스터디 신청하기');
		                     apply_btn.attr("apply_study_no", item.study_no);

		                  row.append(modal_image, w, modal_body_content, apply_btn);
		               modal_body.append(row);

		               //모달 버튼 영역 시작
		               var modal_footer = $('<div class="modal-footer col-md-12 text-center"></div>');
		               
		               if(std_no == item.std_no) {

		                  var edit_a = $('<a id="edit_btn"></a>').attr('href', '/updateStudy.do?study_no='+item.study_no);
		                  var edit_icon = $('<button type="button" class="btn btn-xs btn-icon btn-warning"></button>').append('<i class="fas fa-highlighter"></i>');
		                     
		                  edit_a.append(edit_icon);
		                  
		                  var del_a = $('<a id="del_btn"></a>').attr('study_no_idx', item.study_no);
		                  var del_icon = $('<button type="button" class="btn btn-xs btn-icon btn-warning"></button>').append('<i class="far fa-trash-alt"></i>');

		                  del_a.append(del_icon);
		                  
		                  modal_footer.append(edit_a,del_a);
		               }
		               
		               var close_btn = $('<button type="button" class="close position-absolute-top-right-0 mt-4 mr-4" data-dismiss="modal" aria-label="Close"></button>');
		                  var close_span = $('<span aria-hidden="true"></span>');
		                     var close_icon = $('<i class="fas fa-times"></i>');
		                     
		                        close_span.append(close_icon);
		                     
		                  
		               close_btn.append(close_span);

		               modal_content.append(modal_header,close_btn, modal_body, modal_footer);
		               
		               modal_dialog.append(modal_content);
		               modal_fade.append(modal_dialog);
		   
		               $('#detail_Modal').append(modal_fade);
					
				  })
			}})  
		}
		//---------------------------------------------------------------------------------------------------------
		
		getStudy(scategory_no,search,area,1); //최초로 스터디게시판이 켜졌을때 동작
		
		//--------------삭제 버튼을 눌렀을때의 기능-------------------------------------------------------------------------
		
		 $(document).on('click', '#del_btn', function(){
        
         	var study_no = $('#del_btn').attr('study_no_idx');   
           	var data = {study_no : study_no};
           	var bb = bootbox.confirm({
               message: "정말로 삭제하시겠습니까? 복원되지 않습니다.",
               buttons: {
                   confirm: {label: 'Yes',className: 'btn-success'},
                   cancel: {label: 'No', className: 'btn-danger'}
               },
               callback: function (result) {
                    if(result == true) { //confirm을 눌렀을때 실행
                        $.ajax({ url:"/login/deleteStudy", data:data, success:function(res){
	                       if(res == 1) {//삭제 성공시
	                    	   var dialog = bootbox.dialog({
		                    	   	title: '삭제',
		                    	   	message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
	                    		   	buttons: {ok: function () {location.href="listStudy.do"}}
                   		    	});
	                    		            
	                    		dialog.init(function(){
	                    		    setTimeout(function(){dialog.find('.bootbox-body').html('삭제 완료!');},2000); 
	                       		})
	                       }
	                       else{//삭제 실패시
	                    	   var dialog = bootbox.dialog({
	                    		    title: '삭제',
	                    		    message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',	                    		  
	                    		});
	                    		            
	                    		dialog.init(function(){
	                    		    setTimeout(function(){ dialog.find('.bootbox-body').html('삭제 실패!');}, 2000);
	                    		});
	                      }
                       }})
               		}}
           }); //삭제 확인 박스 종료

           //삭제 확인 박스 css
           bb.find('.modal-content').css({
							        	   	'border' : '1px black',
							            	'font-weight' : 'bold',
							              	'margin-top':'250px'
           })
           bb.find('.modal-content').css({
	                                    	'border' : '1px black',
	                                     	'font-weight' : 'bold',
	                                       	'margin-top':'250px'
           });

      });

		//--------------신청 버튼을 눌렀을때의 기능-------------------------------------------------------------------------

		$(document).on('click', '#apply_btn', function() {
			var study_no = $(this).attr('apply_study_no');

			var data = {study_no: study_no};

			alert(study_no);

			$.ajax({url:"/login/StudyApply", data:data, success: function(res){
				if(res == 1) {
					bootbox.confirm({
					    title: "신청되었습니다.",
					    message: "모집 완료시 메일로 스터디원들의 정보를 전달드립니다.",
					    buttons: {
					        confirm: {
					            label: '<i class="fa fa-check"></i> Confirm'
					        }
					    },
					    callback: function (result) {
						     location.href="listStudy.do"
					    }
					});
				} else if(res == 4) {
					alert('스터디 방장은 이미 참가자입니다.');
				} else if(res == -2) {
					alert('인원이 모두 꽉찼습니다.')
				} else if(res == 0) {
					alert('이미 신청하셨습니다.')
				} else{
					alert('실패 왜?')
				}
			}})
		})

		//--------------검색 버튼을 눌렀을때의 기능-------------------------------------------------------------------------
		
		 $(document).on('click', '#btn_search', function(){

			var search = $('#search').val()+"";
			var area = $('#area').val()+"";
			var scategory = $('input:checked').val();
			if(scategory==null) {scategory = 0};

			alert(search);
			alert(area);
			alert(scategory);

			$('#study_list_div').empty(); //검색어가 있을 경우엔 현재의 리스트를 모두 지우고  검색

			
			getStudy(scategory,search,area,1); //검색했을 경우 검색어를 가지고 페이지 넘버 1을 가지고 컨트롤러로
		});

		//--------------더보기(more)버튼을 눌렀을때의 기능-------------------------------------------------------------------------
		
		$('#more_btn').click( function(){
			page_num += 1;
			
			getStudy(scategory_no,search,area,page_num);
			
		})

		
	});

	//검색어 박스 안에서의 체크 박스가 오직 한개만 체크 될 수 있도록 하는 함수
	function check_only(chk){
	    var obj = document.getElementsByName("scategory_no");
	    for(var i=0; i<obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	            
	        }
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

  <jsp:include page="../header.jsp"/>

  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Hero Section -->
    <div class="bg-overlay-dark-v1 bg-img-hero-center" style="background-image: url(../../image/library.jpg);">
      <div class="container space-2 space-3--lg position-relative z-index-2">
        <!-- Content -->
        <div class="w-md-80 mx-md-auto text-center mt-4 mb-8">
          <h6 class="text-white letter-spacing-0_06 text-uppercase opacity-lg mb-1">Just explore then apply</h6>
          <h1 class="text-white mb-0"></h1>
        </div>

        <!-- <form class="w-lg-80 mx-auto bg-white rounded shadow-sm" action="/listStudy"> -->
        <div class="w-lg-80 mx-auto bg-white rounded shadow-sm">
          <div class="d-md-flex justify-content-between align-items-stretch">
            <div class="flex-grow-1">
              <div class="row no-gutters">
                <div class="col-md-6">
                  <input type="text" class="form-control form-control-lg rounded-bottom-0 rounded-md-right-0 border-left-0 border-top-0" placeholder="검색어를 입력하세요" id="search" name="search">
                </div>
                <div class="col-md-6">
                  <input type="text" class="form-control form-control-lg rounded-0 border-left-0 border-right-0 border-top-0" placeholder="장소를 검색하세요" id="area" name="area">
                </div>
              </div>

              <div class="d-lg-flex justify-content-between px-3 px-lg-4 py-3">
                <!-- Checboxes 한개만 선택 할 수 있도록 하기-->
                <div class="mb-3 mb-lg-0">
                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="1000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_1000">
                    	 <label class="custom-control-label text-gray-700" for="scategory_no_1000">
	                     	자기계발
	                    </label>
                  </div>

                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="2000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_2000">
                     	<label class="custom-control-label text-gray-700" for="scategory_no_2000">
                     	 공모전
                    </label>
                  </div>

                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="3000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_3000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_3000">
                      	취준/면접
                    </label>
                  </div>

                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="4000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_4000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_4000">
                      	연구 및 개발
                    </label>
                  </div>
                  
                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="5000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_5000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_5000">
                     	 언어
                    </label>
                  </div>
                  
                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="6000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_6000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_6000">
                      	운동
                    </label>
                  </div>
                  
                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="7000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_7000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_7000">
                      	학부 및 학과 시험
                    </label>
                  </div>
                  
                  <div class="custom-control custom-checkbox custom-control-inline w-40 w-lg-auto mr-4">
                    <input name="scategory_no" type="checkbox" value="8000" class="custom-control-input" onclick="check_only(this);" id="scategory_no_8000">
                      	<label class="custom-control-label text-gray-700" for="scategory_no_8000">
                      	기타
                    </label>
                  </div>
                </div>
                <!-- End Checboxes -->
              </div>
            </div>

            <!-- Submit -->
            <div class="px-3 pb-3 px-md-0 pb-md-0">
              <button type="button" class="btn btn-primary d-block w-100 h-md-100 rounded-md-left-0" id="btn_search">
                <i class="svg-icon svg-icon-2xs text-white">
                  <svg xmlns="http://www.w3.org/2000/svg" width="17.998" height="17.967" viewBox="0 0 17.998 17.967">
                    <g transform="translate(0 0)">
                      <path d="M16.161,17.967a.839.839,0,0,1-.6-.248l-3.506-3.5a.838.838,0,0,1-.246-.6v-.572a7.3,7.3,0,1,1,1.265-1.264h.573a.842.842,0,0,1,.6.246l3.506,3.5a.848.848,0,0,1,0,1.193l-1,.993A.83.83,0,0,1,16.161,17.967ZM7.312,2.807a4.491,4.491,0,1,0,4.5,4.491A4.5,4.5,0,0,0,7.312,2.807Z" fill="#000000"></path>
                    </g>
                  </svg>
                </i>
              </button>
            </div>
            <!-- End Submit -->
          </div>
        <!-- </form> -->
        </div>
        <!-- End Content -->
      </div>

      
    </div>
    <!-- End Hero Section -->

    <!-- Popular Jobs -->
    <div class="gradient-light-v1">
      <div class="container space-2 space-3-top--lg">
        <!-- Title -->
        <div class="row align-items-end mb-6">
          <div class="col-sm-8">
            <h2 class="text-lh-xs">스터디 카테고리</h2>
            <p class="mb-sm-0">찾으시는 스터디 분류를 선택하세요</p>
          </div>
          
          
          
        </div>
        <!-- End Title -->

        <div class="row">
          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=1000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>자기계발</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=2000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>공모전</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=3000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>취준/면접</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=4000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>연구 및 개발</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->


          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=5000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>언어</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=6000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>운동</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=7000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>학부 및 학과 시험</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->

          <!-- Popular Job Item -->
          <div class="col-sm-6 col-lg-3 mb-3">
            <a class="card lift link-dark shadow-sm border-0" href="/login/listStudy.do?scategory_no=8000">
              <div class="card-body d-flex justify-content-between align-items-center px-4">
                <span>기타</span>
                <i class="fas fa-chevron-right opacity ml-2"></i>
              </div>
            </a>
          </div>
          <!-- End Popular Job Item -->
        </div>
      </div>
    </div>
    <!-- End Popular Jobs -->

    <!-- Featured Jobs -->
    <div class="gradient-light-v2">
      <div class="container space-2 space-3-bottom--lg">
        <!-- Title -->
        <div class="row align-items-end mb-6">
          <div class="col-sm-8">
            <h2 class="text-lh-xs">최신 스터디</h2>
            <p class="mb-sm-0">We're so passionate about what we're doing for this</p>
          </div>

          <div class="col-sm-4 text-sm-right">
            <a class="btn btn-sm btn-primary" href="/login/insertStudy.do">new Study</a>
          </div>
          
          
          
        </div>
        <div id="study_list_div">
        	
          </div>
        <!-- End Title -->
		<div id="more_btn_div">
			 <div class="col-sm-12 text-sm-center">
            <a class="btn btn-sm btn-primary text-white" id="more_btn">M O R E</a>
          </div>
		</div>
    </div>
    <!-- End Featured Jobs -->

    
  </main>
  <!-- ========== END MAIN CONTENT ========== -->

 <!-- ======== Detail Modal Window =========-->
     <div id="detail_Modal">
   
     </div>
  <!-- ======== End Detail Modal Window ========-->


  <!-- ========== FOOTER ========== -->
  	<jsp:include page="../footer.jsp"/>
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


  <!-- JS Implementing Plugins -->
  <script src="../../assets/vendor/hs-megamenu/src/hs.megamenu.js"></script>
  <script src="../../assets/vendor/jquery-validation/dist/jquery.validate.min.js"></script>
  <script src="../../assets/vendor/slick-carousel/slick/slick.js"></script>

  <!-- JS Space -->
  <script src="../../assets/js/hs.core.js"></script>
  <script src="../../assets/js/components/hs.header.js"></script>
  <script src="../../assets/js/components/hs.unfold.js"></script>
  <script src="../../assets/js/components/hs.validation.js"></script>
  <script src="../../assets/js/helpers/hs.focus-state.js"></script>
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
</body>
</html>