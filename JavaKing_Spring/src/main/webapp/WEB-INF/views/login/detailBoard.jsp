<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: 비트대학교 ::</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<head>
  <style data-type="text/css">

    .pb-cmnt-container {
        font-family: Lato;
    }

    .pb-cmnt-textarea {
        resize: none;
        padding: 20px;
        height: 130px;
        width: 100%;
        border: 1px solid #F2F2F2;
    }

  </style>

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

  <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  
    <!-- JS Global Compulsory -->
  <script src="../../assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="../../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
  <script src="../../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="../../assets/vendor/bootstrap/bootstrap.min.js"></script>
  
  <!-- bootbox code -->
  <script src="../bootbox/bootbox.min.js"></script>
  <script src="../bootbox/bootbox.locales.min.js"></script>
  
  <script type="text/javascript">   
	$(function() {

		var board_no = '<c:out value="${board_no}"/>';
		var csrf_token = "{{ csrf_token() }}";

		var next_board_no=0;
		var before_board_no=0;
    	
    	$.ajaxSetup({
            beforeSend: function(xhr, settings) {
                if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                    xhr.setRequestHeader("X-CSRFToken", csrf_token);
                }
            }
        });
        
		$(document).on('ready', function () {
		    // initialization of popups
		    $.HSCore.components.HSModalWindow.init('[data-modal-target]');
		  });

		
		//-----------------------게시글 상세 정보 반환---------------------------------------------
		var getDetail = function(board_no){
			$('#reply').empty();
			$('.btn-group').empty();
			var data = {board_no : board_no}
			$.ajax({url:"/login/detailBoard", data:data, success:function(res){
				next_board_no = res.next_board_no;
				before_board_no = res.before_board_no;
				var std_no = res.std_no;
				var b_vo_std_no;
				var b_vo_list = res.b_vo;
				var reply_list = res.r_list;

				$('#board_name').html(res.board_boardname);
				
				$.each(b_vo_list, function(row, item){
					b_vo_std_no = b_vo_list.std_no
					$('#board_no').html(b_vo_list.board_no);
					
					// 익명게시판일 경우 작성자(학번) 나오지 않게 하기
					// 공지사항일 경우 관리자로 나오게 하기
					if(b_vo_list.board_category != '익명게시판'  && b_vo_list.board_category != '공지사항') {
						$('#std_no').html(b_vo_list.std_no);
					} else if (b_vo_list.board_category == '공지사항'){
						$('#std_no').html('관리자');
					} else{
						$('#std_no').html('익명');
					}

					// 삽니다 팝니다 게시판의 경우 image나오게 하기
					if(b_vo_list.board_category=='삽니다' || b_vo_list.board_category=='팝니다'){
						// 첨부파일이 있는 경우에만 나오게 하기
						if(b_vo_list.board_fname!=null && b_vo_list.board_fname.equals('')) {
							$('#board_image').attr('src','../image/'+b_vo_list.board_fname);
						} else{
							$('#board_image_div').remove();
							$('#board_image').remove();
						}
					} else{
						$('#board_image_div').remove();
						$('#board_image').remove();
					}
					
					$('#board_title').html(b_vo_list.board_title)
					$('#board_content').html(b_vo_list.board_content)
					$('#board_hit').html(b_vo_list.board_hit)
					$('#board_regdate').html(b_vo_list.board_regdate)
					if(b_vo_list.board_fname!=null) {
						$('#board_fname').html(b_vo_list.board_fname)
					} else{
						$('#board_fname').html("첨부파일이 없습니다.")
					}
					$('#fname_href').attr('href','../image/'+b_vo_list.board_fname)
					
				})
				
				//-----------------------수정 삭제 버튼 관련---------------------------------------------
				var before = $('<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="이전글" id="btn_before"></button>');
				var before_i = $('<i class="fas fa-reply"></i>');
				before.append(before_i);
					

				var next = $('<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="다음글" id="btn_next"></button>');
				var next_i = $('<i class="fas fa-share"></i>');
				next.append(next_i);
					
				if(std_no == b_vo_std_no) {
					var del = $('<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="삭제" id="btn_delete"></button>');
				    var del_i = $('<i class="far fa-trash-alt"></i>');
				    del.append(del_i);
				    $('.btn-group').append(del,before,next);
				        
						
			        var upd = $('<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="수정" id="btn_update"></button>');
				    var upd_i = $('<i class="fas fa-edit"></i>');
				    upd.append(upd_i);
					$('.btn-group').append(upd)
						
				} else {
					 $('.btn-group').append(before,next);
				}
				
				//-----------------------댓글 리스트 관련---------------------------------------------
				$.each(reply_list, function(row,item){
					var media_mb4 = $('<div class="media mb-4"></div>');
					var media_body = $('<div class="media-body"></div>');
					var reply_no = $('<input type="hidden" name="reply_no" value="'+reply_list[row].reply_no+'">');

					// 익명게시판일 경우 작성자(학번) 나오지 않게 하기
					// 공지사항일 경우 작성자 관리자로 나오게 하기
					var reply_std_no;
					if(b_vo_list.board_category != '익명게시판' && b_vo_list.board_category != '공지사항' ) {
						reply_std_no = $('<h5 class="mt-0"></h5>').html(reply_list[row].std_no);
					} else if(b_vo_list.board_category == '공지사항') {
						reply_std_no = $('<h5 class="mt-0"></h5>').html('관리자');
						
					} else {
						reply_std_no = $('<h5 class="mt-0"></h5>').html('익명');
					}
					
					
					var reply_content = $('<p id="reply_content"></p>').html(reply_list[row].reply_content);
					var reply_date = $('<span></span>').html(reply_list[row].reply_regdate +"&nbsp;&nbsp;&nbsp;&nbsp;");

					media_body.append(reply_no,reply_std_no,reply_content,reply_date);

					 if( reply_list[row].std_no == std_no ) {
						var reply_update =
							 $('<i class="fas fa-pen-nib" id="reply_update_btn"></i>');
						var reply_delete =
							 $('<i class="fas fa-eraser" id="reply_delete_btn"></i>');
						 
						media_body.append(reply_update, reply_delete)
				 	 }  
					media_mb4.append(media_body);
					$('#reply').append(media_mb4);
					
				})
				
			}})

		}

		//뷰롤 키자마자 실행되되록 게시물 상세를 보여주는 함수 실행
		getDetail(board_no)
		
		//-----------------------댓글 등록 관련---------------------------------------------
		
		$('#btn_reply_insert').click(function() {
			var reply_data = $('#reply_form').serialize();
			$.ajax({
				url:"/login/insertReply",
				type:'POST',
				data: reply_data,
				success: function(res){
					if(res != 1){
						setTimeout(function() {
							alert('댓글 등록에 실패하였습니다.')	
						}, 1000);
					} else{
						getDetail(board_no)
					}
				}
				
			})
		})
		
		//-----------------------댓글 수정 관련---------------------------------------------
		
		//댓글 수정 버튼을 눌렀을때 발생하는 이벤트(모달창이 켜지고 현재 댓글 내용이 가져와짐)
		$(document).on('click','#reply_update_btn', function(){
	    
			
			var reply_content = $(this ).parent().find('p').text();
			var reply_no = $(this).parent().find('input').val();

			
			bootbox.prompt({
			    title: "댓글을 수정해주세요!",
			    inputType: 'text',
			    value: reply_content,
			    callback: function (result) {
					
					var replace_content = result;

				    var form_data = new FormData($('#update_reply_form')[0]);

				    form_data.delete("reply_no");
				    form_data.append("reply_no", Number(reply_no));
				    form_data.delete("reply_content");
				    form_data.append("reply_content", replace_content);
				    
					$.ajax({
						url:"/login/updateReply",
						type:'POST',
						data: form_data,
					    processData: false,
					    contentType: false,
						success: function(res){
							if(res == 1) {//수정 성공시
			                 	   var dialog = bootbox.dialog({
				                    	title: '수정',
				                    	message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
			                 		   	buttons: {ok: function () {getDetail(board_no);}}
		                 		   	});
			                 		            
			                 		dialog.init(function(){
			                 		    setTimeout(function(){dialog.find('.bootbox-body').html('수정 완료!');},2000); 
			                    	})
			                    }
			                    else{//수정 실패시
			                 	   var dialog = bootbox.dialog({
			                 		    title: '수정',
			                 		    message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',	                    		  
			                 		});
			                 		            
			                 		dialog.init(function(){
			                 		    setTimeout(function(){ dialog.find('.bootbox-body').html('수정 실패!');}, 2000);
			                 		});
			                   }

						}
					})	
			    }
			});
		}) 
		
		//-------------------------댓글 삭제 관련-------------------------------------
		
		// 댓글 삭제 버튼을 눌렀을때 이벤트
		$(document).on('click','#reply_delete_btn', function(){
			$('.btn-group').empty();
			var reply_no = $(this).parent().find('input').val();
			var data = {reply_no:reply_no}
			var bb = bootbox.confirm({
	               message: "정말로 삭제하시겠습니까? 복원되지 않습니다.",
	               buttons: {
	                   confirm: {label: 'Yes',className: 'btn-success'},
	                   cancel: {label: 'No', className: 'btn-danger'}
	               },
	               callback: function (result) {
	                    if(result == true) { //confirm을 눌렀을때 실행
	                        $.ajax({ url:"/login/deleteReply", type:'GET', data:data, success:function(res){
		                       if(res == 1) {//삭제 성공시
		                    	   var dialog = bootbox.dialog({
			                    	   	title: '삭제',
			                    	   	message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
		                    		   	buttons: {ok: function () {getDetail(board_no)}}
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
		});
		//-------------------------이전글 다음글 관련------------------------------------
		$(document).on('click', '#btn_next', function(){
			window.location.href="/login/detailBoard.do?board_no="+next_board_no;
		})
		
		$(document).on('click', '#btn_before', function(){
			window.location.href="/login/detailBoard.do?board_no="+before_board_no;
		})
		
		
		//-------------------------게시믈 수정 관련-------------------------------------
		
		
		$(document).on('click' , '#btn_update', function(){
			window.location.href="/login/updateBoard.do?board_no="+board_no
		})

		
		//-------------------------게시믈 삭제 관련-------------------------------------
		$(document).on('click', '#btn_delete', function() {
			var data= {board_no: board_no};
			var bb = bootbox.confirm({
	               message: "정말로 삭제하시겠습니까? 복원되지 않습니다.",
	               buttons: {
	                   confirm: {label: 'Yes',className: 'btn-success'},
	                   cancel: {label: 'No', className: 'btn-danger'}
	               },
	               callback: function (result) {
	                    if(result == true) { //confirm을 눌렀을때 실행
		                    
	                        $.ajax({ url:"/login/deleteBoard", data:data, success:function(res){
		                       if(res == 1) {//삭제 성공시
			                       
		                    	   var dialog = bootbox.dialog({
			                    	   	title: '삭제',
			                    	   	message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>',
		                    		   	buttons: {ok: function () {location.href="listBoard.do"}}
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
		})
	
	})

  </script>

</head>
<jsp:include page="../header.jsp"/>
<body>

  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Hero Section -->
    <div class="hanna space-2 space-3-top--lg bg-primary text-white text-center text-weight-bold">
    <h1 class = "h1 hanna" id="board_name"></h1>
    </div>
    <!-- End Hero Section -->
	<!-- News Blog Content -->
    <div class="container space-3-bottom--lg space-2-top">
      <div class="row">
        <div class="col-lg-12 order-lg-2 mb-9 mb-lg-0">
           <!-- Post Content Column -->
        <div class="col-lg-12">
          <!-- Title -->
          <input type="hidden" name="board_no" id="board_no">
          <h1 class="mt-4" id="board_title">${board_no}. </h1>

          <!-- Author -->
          <p class="lead" id="std_no">by</p>
          <hr>
          <!-- Date/Time -->
		  
          Posted on <span id="board_regdate"></span> &nbsp; | &nbsp; 조회수: <span id="board_hit"></span> &nbsp;|&nbsp;
          <!-- Auto width -->
          <i class="fa fa-download"></i><a id="fname_href"><span id="board_fname"></span></a>
          <hr>

          <!-- 삭제, 이전글, 다음글, 수정 -->
          <div class="mailbox-controls with-border text-center">
            <div class="btn-group">
				
            </div>
           <!-- .btn-group -->
          </div>

          <hr>
		  <div style="text-align : center;" id="board_image_div">
			<img class="w-60 h-60" id="board_image">
		  </div>
          <!-- Post Content -->
          <p class="lead" id="board_content" style="white-space: pre-line;"></p>

          <hr>

          <!-- Comments Form -->
          <div class="card my-4">
            <h5 class="card-header">댓글 작성</h5>
            <div class="card-body">
            <!-- 댓글작성 폼 시작! -->
              <form id="reply_form">
              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
                <div class="form-group">
                  <input type="hidden" name="board_no" id="board_no" value="${board_no}">
                  <input type="hidden" name="std_no" id="std_no" value="${std_no}">
                  <textarea class="form-control" rows="3" id="reply_content" name="reply_content"></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-sm" id="btn_reply_insert">등록</button>
              </form>
            <!-- 댓글작성 폼 종료! -->
            </div>
          </div>

          <!-- 댓글 리스트 영역 -->
          <div id="reply"> 
	       
         </div>
         
         <!-- 댓글 수정 모달창 영역 -->


				<div class="reply_modal">
					<form id="update_reply_form">
						<input type="hidden" id="modal_reply_no" name="reply_no">
						<input type="hidden" id="modal_reply_content" name="reply_content">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
					</form>
				</div>
				
			</div>
        </div>
      </div>
    </div>
    <!-- End News Blog Content -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->


	<jsp:include page="../footer.jsp"/>

  </aside>


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