<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
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
  <link rel="stylesheet" href="../../assets/vendor/animate.css/animate.min.css">

  <!-- CSS Space Template -->
  <link rel="stylesheet" href="../../assets/css/theme.css">
  <link rel="stylesheet" href="../../assets/css/signin.css">
</head>

<body>

  <!-- ========== MAIN CONTENT ========== -->
  <form action="/login.do" method="post" class="js-validate form-signin p-5">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
    <!-- Logo -->
    <div class="text-center">
      <a href="/login.do" aria-label="Space">
      	<img src="/image/logo1.png" alt="Logo" width="100" height="100">
        <img class="mb-3" src="/image/logo4.png" alt="Logo">
      </a>
    </div>
    <!-- End Logo -->

    <!-- Title -->
    <div class="text-center mb-4">
      <h1 class="h3 mb-0">로그인</h1>
      <p class="m-0 font-size-13">비밀번호 초기값은 생년월일 6자리입니다</p>
    </div>
    <!-- End Title -->

    <!-- Input -->
    <div class="js-form-message mb-3">
      <div class="js-focus-state input-group form">
        <div class="input-group-prepend form__prepend">
          <span class="input-group-text form__text">
            <i class="fa fa-id-card form__text-inner"></i>
          </span>
        </div>
        <input type="text" class="form-control form__input" name="acc_id" required
               placeholder="학번"
               aria-label="acc_id"
               data-msg="학번을 입력해주세요"
               data-error-class="u-has-error"
               data-success-class="u-has-success"
               value="<c:if test="${cookie.re_id.value != null }">${cookie.re_id.value }</c:if><c:if test="${cookie.re_id.value == null }">${cookie.fail_id_cookie.value}</c:if>">
      </div>
    </div>
    <!-- End Input -->

    <!-- Input -->
    <div class="js-form-message mb-3">
      <div class="js-focus-state input-group form">
        <div class="input-group-prepend form__prepend">
          <span class="input-group-text form__text">
            <i class="fa fa-lock form__text-inner"></i>
          </span>
        </div>
        <input type="password" class="form-control form__input" name="acc_pwd" required
               placeholder="비밀번호"
               aria-label="acc_pwd"
               data-msg="비밀번호를 입력해주세요"
               data-error-class="u-has-error"
               data-success-class="u-has-success">
      </div>
    </div>
    <!-- End Input -->

    <div class="row mb-3">
      <div class="col-12">
        <!-- Checkbox -->
        <div class="custom-control custom-checkbox d-flex align-items-center text-muted">
          <input type="checkbox" class="custom-control-input" id="cb_id" name="cb_id" value="checked"
			<c:if test="${cookie.re_id.value != null }">checked="checked"</c:if>>
          <label class="custom-control-label" for="cb_id">
            학번 저장
          </label>
        </div>
        <!-- End Checkbox -->
      </div>
		 <div class = "col-12 text-center text-danger" id="login_error"><c:if test="${cookie.login_error.value != null}">학번이나 비밀번호를 확인해주세요</c:if></div>
		 
      <div class="col-12 text-right">
        <a href="findId.do">학번 찾기</a>
        &nbsp;
        <a href="findPwd.do">비밀번호 찾기</a>
      </div>
    </div>

    <div class="mb-3">
      <button type="submit" class="btn btn-block btn-primary">로그인</button>
    </div>
	<div style="display: inline-block;" class="text-left pt-1 pb-2 mx-auto">
        <span class="small text-muted mb-0" style="display: inline-block;">
        <i class="fas fa-map-marked-alt min-width-3 mr-2"></i>
        	<span>주소 … 서울특별시 마포구 백범로 23 구프라자 B1</span>
		</span>
		<br>
        <span class="small text-muted text-center mb-0" style="display: inline-block;">
        	<i class="fas fa-phone-square-alt min-width-3 mr-2"></i>
        	<span>연락처 … 02-707-1480</span>
        </span>
		<br>
        <span class="small text-muted text-center mb-0" style="display: inline-block;">
        	<i class="fas fa-envelope-square min-width-3 mr-2"></i>
        	<span>이메일 … bituniversityemail@gmail.com</span>
        </span>
		<br>
    </div>
    <p class="small text-center text-muted mb-0">All rights reserved. &copy; 비트대학교.</p>
  </form>
  <!-- ========== END MAIN CONTENT ========== -->
  
  <!-- JS Global Compulsory -->
  <script src="../../assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="../../assets/vendor/jquery-migrate/dist/jquery-migrate.min.js"></script>
  <script src="../../assets/vendor/popper.js/dist/umd/popper.min.js"></script>
  <script src="../../assets/vendor/bootstrap/bootstrap.min.js"></script>

  <!-- JS Implementing Plugins -->
  <script src="../../assets/vendor/jquery-validation/dist/jquery.validate.min.js"></script>

  <!-- JS Space -->
  <script src="../../assets/js/hs.core.js"></script>
  <script src="../../assets/js/components/hs.validation.js"></script>
  <script src="../../assets/js/helpers/hs.focus-state.js"></script>

  <!-- JS Plugins Init. -->
  <script>
    $(document).on('ready', function () {
      // initialization of forms
      $.HSCore.helpers.HSFocusState.init();

      // initialization of form validation
      $.HSCore.components.HSValidation.init('.js-validate');
    });
  </script>
</body>
</html>