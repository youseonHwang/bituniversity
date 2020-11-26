<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <link rel="shortcut icon" href="../image/favicon.ico">

  <!-- Google Fonts -->
  <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">

  <!-- CSS Implementing Plugins -->
  <link rel="stylesheet" href="../../assets/vendor/font-awesome/css/all.min.css">
  <link rel="stylesheet" href="../../assets/vendor/hs-megamenu/src/hs.megamenu.css">
  <link rel="stylesheet" href="../../assets/vendor/animate.css/animate.min.css">
  <link rel="stylesheet" href="../../assets/vendor/slick-carousel/slick/slick.css">

  <!-- CSS Space Template -->
  <link rel="stylesheet" href="../../assets/css/theme.css">
  <style type="text/css">
  	.explain_map {
  		text-align: center;
  	}
  	
  	.explain_area > .col-mr-3, .col-mx-3 {
  		margin-bottom: 2.5rem;
  		margin-left: 2.5rem;
  		margin-right: 2.5rem;
  	}
  	
  	.map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
  </style>
  <script type="text/javascript" src = "https://code.jquery.com/jquery-3.5.1.min.js"></script>
  
  
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dab7038698ec6fb3a777bf332d640350&libraries=services"></script>
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
		
		//파일 선택시 이름 변경되는 부분
		$(".custom-file-input").on("change", function() {
			  var fileName = $(this).val().split("\\").pop();
			  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
			});
		
		//********************************************************************************
		
		//지도를 표시하고 경도와 위도를 가져오는
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 1 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);


		var lat;
		var lng;
		var area_address; 
		
        // 지도에 클릭 이벤트를 등록합니다
        // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {   
            
	       // 클릭한 위도, 경도 정보를 가져옵니다 
	       var latlng = mouseEvent.latLng; 
	            
	       // 마커 위치를 클릭한 위치로 옮깁니다
	       marker.setPosition(latlng);
				
	       //경도, 위도
	       lat = latlng.getLat();
	       lng = latlng.getLng();

	       searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	           if (status === kakao.maps.services.Status.OK) {
		           
	                var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	                detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

	                area_address = result[0].address.address_name;
	                
	                var content = '<div class="bAddr">' +
	                              '<span class="title">법정동 주소정보</span>' + 
	                                detailAddr + 
	                              '</div>';

	                // 마커를 클릭한 위치에 표시합니다 
	                marker.setPosition(mouseEvent.latLng);
	                marker.setMap(map);

	                // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	                infowindow.setContent(content);
	                infowindow.open(map, marker);

	                console.log (detailAddr);
	                console.log (area_address);
	     	       	
	            }   
	       });    
        });

     	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
        });

        function searchAddrFromCoords(coords, callback) {
            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
        }

        function searchDetailAddrFromCoords(coords, callback) {
            // 좌표로 법정동 상세 주소 정보를 요청합니다
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }

        // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
        function displayCenterInfo(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var infoDiv = document.getElementById('centerAddr');

                for(var i = 0; i < result.length; i++) {
                    
                    if (result[i].region_type === 'H') {
                        infoDiv.innerHTML = result[i].address_name;
                        break;
                    }
                }
            }
        }    

    	
		// study 등록 버튼을 누를 경우의 기능
        $(document).on('click','#btn_insert', function(){
            
        	var form_data = new FormData($('#insert_form')[0])			

        	form_data.append("study_area", lat+"/"+lng+"/"+area_address);	
			
			$.ajax({
				url: "/login/insertStudy",
				type:'POST',
				data: form_data,
			    processData: false,
			    contentType: false,
				success:function(res){
					if(res != 1) {
						setTimeout(function() {
							alert('스터디 등록에 실패하였습니다.')	
						}, 1000)
					} else{
						window.location.href="/login/listStudy.do"
					}
			}})
        })
	});
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
    <div class="bg-overlay-dark-v1 bg-img-hero-center" style="background-image: url(../../assets/img/demo/job/hero.jpg);">
      <div class="container space-2 space-3--lg position-relative z-index-2">
        <!-- Content -->
        <div class="w-md-80 mx-md-auto text-center mt-4 mb-8">
          <h6 class="text-white letter-spacing-0_06 text-uppercase opacity-lg mb-1">Just explore then apply</h6>
          <h1 class="text-white mb-0">Find your study in a quick way</h1>
        </div>

        
        <!-- End Content -->
      </div>

      
    </div>
    <!-- End Hero Section -->

    <!-- Featured Jobs -->
    <div class="gradient-light-v2">
      <div class="container space-2 space-3--lg">
      <!-- Title -->
      <div class="w-md-80 w-lg-60 text-center mx-md-auto mb-9">
        <span class="u-label u-label--sm u-label--purple mb-3">Insert your study information</span>
        <h2 class="h3">스터디 정보를 입력하세요</h2>
        <p>※주의 사항※</p>
        <p>스터디 인원이 모두 구해지면 개인정보 보호 정책으로 인해 
            본인의 학사정보에 등록되어 있는 메일 주소로 
             스터디원들의 메일주소가 발송됩니다.<br>
            정확한 스터디 내용은 메일을 통해 서로 연락 바랍니다.</p>
      </div>
      <!-- End Title -->

      <div class="w-lg-80 mx-auto">
        <form class="js-validate" id="insert_form" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
          <div class="row">
            <!-- Input -->
            <div class="col-sm-12 mb-12">
              <div class="js-form-message">
                <div class="js-focus-state input-group form">
                  <input class="form-control form__input" type="text" name="study_title" id="study_title" required
                         placeholder="스터디 제목"
                         aria-label="스터디 제목"
                         data-msg="스터디 제목을 입력하세요"
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
            </div>
            <!-- End Input -->
            <div class="text-center u-divider-wrapper my-3">
  				<span class="u-divider u-divider--xs u-divider--text"></span>
			</div>
            
            <div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <div class="hAddr">
			        <span class="title">지도중심기준 행정동 주소정보</span>
			        <span id="centerAddr"></span>
			    </div>
			</div>
            
            <div class="text-center u-divider-wrapper my-3">
  				<span class="u-divider u-divider--xs u-divider--text"></span>
			</div>
			
            <p class="explain_map"><em> 스터디 진행 예정 장소를 스터디원들이 알 수 있도록 지도에 클릭해주세요!! </em></p>
           	<input type="hidden" name="study_area" id="study_area">

            <div class="w-100"></div>

            
            <div class="col-sm-6 mb-6">
                   <div class="form-group">
	    			<label class="h6 small d-block text-uppercase" for="exampleFormControlSelect1">카테고리</label>

                        <select class="form-control" data-size="5" name="scategory_no" id="scategory_no">
							<option value=1000>자기계발</option>
							<option value=2000>공모전</option>
							<option value=3000>취준/면접</option>
							<option value=4000>연구 및 개발</option>
							<option value=5000>언어</option>
							<option value=6000>운동</option>
							<option value=7000>학부 및 학과 시험</option>
							<option value=8000>기타</option>
                        </select>

                    </div>
             </div>
             
             
			<div class="col-sm-6 mb-6">
	            <div class="form-group">
	    			<label class="h6 small d-block text-uppercase" for="exampleFormControlSelect1">인원수</label>
	    				<select class="form-control" id="study_limit" name="study_limit">
					      <option>2</option>
					      <option>3</option>
					      <option>4</option>
					      <option>5</option>
					      <option>6</option>
					    </select>
				</div>
			</div>
	            
	        
	    
		        <div class="col-sm-4 mb-4">
	             
	                  <input class="form-control form__input" type="text" name="study_explain1" id ="study_explain1" required
	                         placeholder="설명1"
	                         aria-label="설명1"
	                         data-msg="스터디 이해를 돕기 위한 설명을 단어로 적어주세요."
	                         data-error-class="u-has-error"
	                         data-success-class="u-has-success">
	                
	            </div>
	            <div class="col-sm-4 mb-4">
	             
	                  <input class="form-control form__input" type="text" name="study_explain2" id ="study_explain2" required
	                         placeholder="설명2"
	                         aria-label="설명2"
	                         data-msg="스터디 이해를 돕기 위한 설명을 단어로 적어주세요."
	                         data-error-class="u-has-error"
	                         data-success-class="u-has-success">
	                
	            </div>
	            <div class="col-sm-4 mb-4">
	             
	                  <input class="form-control form__input" type="text" name="study_explain3" id ="study_explain3" required
	                         placeholder="설명3"
	                         aria-label="설명3"
	                         data-msg="스터디 이해를 돕기 위한 설명을 단어로 적어주세요."
	                         data-error-class="u-has-error"
	                         data-success-class="u-has-success">
	                
	            </div>
	            <!-- End Input -->

           
          </div>
          
          <!-- Input -->
          <div class="js-form-message mb-9">
            <div class="js-focus-state input-group form">
              <textarea class="form-control form__input" rows="6" name="study_content" id="study_content" required
                        placeholder="스터디 정보(장소, 시간대, 구체적인 목표, 기간 등) 입력하세요"
                        aria-label="스터디 정보를 최대한 세부적으로 작성해주세요"
                        data-msg="스터디 정보를 최대한 세부적으로 작성해주세요"
                        data-error-class="u-has-error"
                        data-success-class="u-has-success"></textarea>
            </div>
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

            
          <!-- End Input -->

          <div class="text-center">
            <button type="submit" class="btn btn-primary btn-wide mb-4" id="btn_insert">등록</button>
            <p class="small">등록 후 모집 완료시 메일 전달됩니다.<br>
                			메일 수시 확인 바랍니다.</p>
          </div>
        </form>
      </div>
    </div>
    <!-- End Contact Us Form Section -->
    </div>
    <!-- End Featured Jobs -->

    
  </main>
  <!-- ========== END MAIN CONTENT ========== -->



  <!-- ========== FOOTER ========== -->
  	<jsp:include page="../footer.jsp"/>
  <!-- ========== END FOOTER ========== -->



  <!-- ========== SECONDARY CONTENTS ========== -->
  <!-- Signup Modal Window -->
  <div class="modal fade" id="signinModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content border-0">
        <div class="modal-body p-5">
          <form class="js-validate">
            <!-- Signin -->
            <div id="signin" data-target-group="idForm">
              <!-- Title -->
              <header class="text-center mb-5">
                <h2 class="h4 mb-0">Please sign in</h2>
                <p>Signin to manage your account.</p>
              </header>
              <!-- End Title -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="email" class="form-control form__input" name="email" required
                         placeholder="Email"
                         aria-label="Email"
                         data-msg="Please enter a valid email address."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="password" class="form-control form__input" name="password" required
                         placeholder="Password"
                         aria-label="Password"
                         data-msg="Your password is invalid. Please try again."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <div class="row mb-3">
                <div class="col-6">
                  <!-- Checkbox -->
                  <div class="custom-control custom-checkbox d-flex align-items-center text-muted">
                    <input type="checkbox" class="custom-control-input" id="rememberMeCheckbox">
                    <label class="custom-control-label" for="rememberMeCheckbox">
                      Remember Me
                    </label>
                  </div>
                  <!-- End Checkbox -->
                </div>

                <div class="col-6 text-right">
                  <a class="js-animation-link float-right" href="javascript:;"
                     data-target="#forgotPassword"
                     data-link-group="idForm"
                     data-animation-in="fadeIn">Forgot Password?</a>
                </div>
              </div>

              <div class="mb-3">
                <button type="submit" class="btn btn-block btn-primary">Signin</button>
              </div>

              <div class="text-center mb-3">
                <p class="text-muted">
                  Do not have an account?
                  <a class="js-animation-link" href="javascript:;"
                     data-target="#signup"
                     data-link-group="idForm"
                     data-animation-in="fadeIn">Signup
                  </a>
                </p>
              </div>

              <!-- Divider -->
              <div class="text-center u-divider-wrapper my-3">
                <span class="u-divider u-divider--xs u-divider--text">OR</span>
              </div>
              <!-- End Divider -->

              <!-- Signin Social Buttons -->
              <div class="row mx-gutters-2 mb-4">
                <div class="col-sm-6 mb-2 mb-sm-0">
                  <button type="button" class="btn btn-block btn-facebook text-nowrap">
                    <i class="fab fa-facebook-f mr-2"></i>
                    Signin with Facebook
                  </button>
                </div>
                <div class="col-sm-6">
                  <button type="button" class="btn btn-block btn-twitter">
                    <i class="fab fa-twitter mr-2"></i>
                    Signin with Twitter
                  </button>
                </div>
              </div>
              <!-- End Signin Social Buttons -->
            </div>
            <!-- End Signin -->

            <!-- Signup -->
            <div id="signup" style="display: none; opacity: 0;" data-target-group="idForm">
              <!-- Title -->
              <header class="text-center mb-5">
                <h2 class="h4 mb-0">Please sign up</h2>
                <p>Fill out the form to get started.</p>
              </header>
              <!-- End Title -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="email" class="form-control form__input" name="email" required
                         placeholder="Email"
                         aria-label="Email"
                         data-msg="Please enter a valid email address."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="password" class="form-control form__input" name="password" id="password" required
                         placeholder="Password"
                         aria-label="Password"
                         data-msg="Your password is invalid. Please try again."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="password" class="form-control form__input" name="confirmPassword" required
                         placeholder="Confirm Password"
                         aria-label="Confirm Password"
                         data-msg="Password does not match the confirm password."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <div class="mb-3">
                <button type="submit" class="btn btn-block btn-primary">Signup</button>
              </div>

              <div class="text-center mb-3">
                <p class="text-muted">
                  Have an account?
                  <a class="js-animation-link" href="javascript:;"
                     data-target="#signin"
                     data-link-group="idForm"
                     data-animation-in="fadeIn">Signin
                  </a>
                </p>
              </div>

              <!-- Divider -->
              <div class="text-center u-divider-wrapper my-3">
                <span class="u-divider u-divider--xs u-divider--text">OR</span>
              </div>
              <!-- End Divider -->

              <!-- Signup Social Buttons -->
              <div class="row mx-gutters-2 mb-4">
                <div class="col-sm-6 mb-2 mb-sm-0">
                  <button type="button" class="btn btn-block btn-facebook text-nowrap">
                    <i class="fab fa-facebook-f mr-2"></i>
                    Signup with Facebook
                  </button>
                </div>
                <div class="col-sm-6">
                  <button type="button" class="btn btn-block btn-twitter">
                    <i class="fab fa-twitter mr-2"></i>
                    Signup with Twitter
                  </button>
                </div>
              </div>
              <!-- End Signup Social Buttons -->
            </div>
            <!-- End Signup -->

            <!-- Forgot Password -->
            <div id="forgotPassword" style="display: none; opacity: 0;" data-target-group="idForm">
              <!-- Title -->
              <header class="text-center mb-5">
                <h2 class="h4 mb-0">Recover account</h2>
                <p>Enter your email address and an email with instructions will be sent to you.</p>
              </header>
              <!-- End Title -->

              <!-- Input -->
              <div class="js-form-message mb-3">
                <div class="js-focus-state form">
                  <input type="email" class="form-control form__input" name="email" required
                         placeholder="Email"
                         aria-label="Email"
                         data-msg="Please enter a valid email address."
                         data-error-class="u-has-error"
                         data-success-class="u-has-success">
                </div>
              </div>
              <!-- End Input -->

              <div class="mb-3">
                <button type="submit" class="btn btn-block btn-primary">Recover Account</button>
              </div>

              <div class="text-center mb-3">
                <p class="text-muted">
                  Have an account?
                  <a class="js-animation-link" href="javascript:;"
                     data-target="#signin"
                     data-link-group="idForm"
                     data-animation-in="fadeIn">Signin
                  </a>
                </p>
              </div>
            </div>
            <!-- End Forgot Password -->
          </form>
        </div>

        <button type="button" class="close position-absolute-top-right-0 mt-4 mr-4" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><i class="svg-icon svg-icon-xs text-muted"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></i></span>
        </button>
      </div>
    </div>
  </div>
  <!-- End Signup Modal Window -->


  <!-- End Detail Modal Window -->
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
