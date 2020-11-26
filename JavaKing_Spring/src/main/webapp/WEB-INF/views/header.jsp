<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- ========== HEADER ========== -->
  <header id="header" class="u-header u-header--bordered u-header--sticky-top-lg">
    <div class="u-header__section">
      <div id="logoAndNav" class="container-fluid">
        <!-- Nav -->
        <nav class="js-mega-menu navbar navbar-expand-lg u-header__navbar">
          <!-- Logo -->
          <div class="u-header__navbar-brand-wrapper">
          <a href = "/login/main.do">
            <img class="u-header__navbar-brand-default" src="../../image/logo1.png"  width = 71 height = 71 alt="Logo">
            <img class="u-header__navbar-brand-default pb-1" src="../../image/logo4.png" alt="Logo" height = 71>
            <img class="u-header__navbar-brand-mobile" src="../../image/logo1.png" width = 50 height = 50 alt="Logo">
        	</a>
         </div>
          <!-- End Logo -->

          <!-- Responsive Toggle Button -->
          <button type="button" class="navbar-toggler btn u-hamburger u-header__hamburger"
                  aria-label="Toggle navigation"
                  aria-expanded="false"
                  aria-controls="navBar"
                  data-toggle="collapse"
                  data-target="#navBar">
            <span class="d-none d-sm-inline-block">메뉴</span>
            <span id="hamburgerTrigger" class="u-hamburger__box ml-3">
              <span class="u-hamburger__inner"></span>
            </span>
          </button>
          <!-- End Responsive Toggle Button -->

  		<!-- Navigation -->
          <div id="navBar" class="collapse navbar-collapse u-header__navbar-collapse py-0">
            <ul class="navbar-nav u-header__navbar-nav">
              <!-- Pages -->
              <li class="nav-item hs-has-mega-menu u-header__nav-item"
                  data-event="hover"
                  data-animation-in="fadeIn"
                  data-animation-out="fadeOut"
                  data-position="right">
                <a id="PagesMegaMenu" class="nav-link u-header__nav-link" href="javascript:;"
                   aria-haspopup="true"
                   aria-expanded="false">
                  <span class= "font-weight-bold h5 mx-auto">학사정보
                  <i class="fa fa-angle-down u-header__nav-link-icon"></i>
                  </span>
                </a>

                <!-- Pages - Mega Menu -->
                <div class="hs-mega-menu w-100 u-header__sub-menu" aria-labelledby="PagesMegaMenu">
                  <div class="u-header__mega-menu-wrapper-v1">
                    <ul class="row list-unstyled u-header__mega-menu-list">
                      <li class="col-sm-6 col-lg-2 u-header__mega-menu-col mb-3 mb-lg-0">
                        <span class="u-header__sub-menu-title font-weight-bold">학적</span>

                        <!-- Links -->
                        <ul class="list-unstyled">
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/studentInfo.do">학적조회</a></li>
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/change.do">학적변동</a></li>
                        </ul>
                        <!-- End Links -->
                      </li>
                      
                      <li class="col-sm-6 col-lg-2 u-header__mega-menu-col mb-3 mb-lg-0">
                        <span class="u-header__sub-menu-title font-weight-bold">성적</span>
                        <!-- Links -->
                        <ul class="list-unstyled">
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/listGrade.do">성적조회</a></li>                          
                        </ul>
                        <!-- End Links -->
                      </li>  

                      <li class="col-sm-6 col-lg-2 u-header__mega-menu-col mb-3 mb-lg-0">
                        <span class="u-header__sub-menu-title font-weight-bold">등록금</span>
                        <!-- Links -->
                        <ul class="list-unstyled">
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/listRegister.do">등록금납부조회</a></li>                          
                        </ul>
                        <!-- End Links -->
                      </li>  

                      <li class="col-sm-6 col-lg-2 u-header__mega-menu-col mb-3 mb-lg-0">
                        <span class="u-header__sub-menu-title font-weight-bold">수강신청</span>

                        <!-- Links -->
                        <ul class="list-unstyled">
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/classSearch.do">통합강의정보</a></li>
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/detailClass.do">수강내역조회</a></li>
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/classReg.do">수강신청</a></li>
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/classRegCheck.do">수강신청확인</a></li>
                        </ul>
                        <!-- End Links -->
                      </li>

                      <li class="col-sm-6 col-lg-2 u-header__mega-menu-col mb-3 mb-lg-0">
                        <span class="u-header__sub-menu-title font-weight-bold">대학정보</span>
                        <!-- Links -->
                        <ul class="list-unstyled">
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/classInfo.do">학부별강의목록</a></li>
                          <li><a class="nav-link u-header__sub-menu-nav-link px-0" href="/login/listProfessor.do">교수진소개</a></li>                          
                        </ul>
                        <!-- End Links -->
                      </li>                                          
                                        
                </ul>
                <!-- End Home - Submenu -->
              </li>
              <!-- End Home -->

                <!-- 알림마당 -->
                    <li class="nav-item hs-has-sub-menu u-header__nav-item"
                    data-event="hover"
                    data-animation-in="fadeIn"
                    data-animation-out="fadeOut">
                    <a id="worksMegaMenu" class="nav-link u-header__nav-link" href="javascript:;"
                    aria-haspopup="true"
                    aria-expanded="false"
                    aria-labelledby="worksSubMenu">
                    <span class= "font-weight-bold h5 mx-auto">알림마당
                        <i class="fa fa-angle-down u-header__nav-link-icon"></i>
                    </span>
                    </a>
                    <!-- Blog - Submenu -->
                    <ul id="blogSubMenu" class="list-inline hs-sub-menu u-header__sub-menu mb-0" style="min-width: 220px;"
                        aria-labelledby="blogMegaMenu">
                    <!-- Classic -->
                    <li class="dropdown-item u-header__sub-menu-list-item py-0">
                        <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=100">공지사항</a>
                    </li>
                    <!-- Classic -->
                     <!-- Classic -->
                    <li class="dropdown-item u-header__sub-menu-list-item py-0">
                        <a class="nav-link u-header__sub-menu-nav-link" href="/login/calendar.do">학사일정</a>
                    </li>
                    <!-- Classic -->
                     <!-- Classic -->
                    <li class="dropdown-item u-header__sub-menu-list-item py-0">
                        <a class="nav-link u-header__sub-menu-nav-link" href="/login/map.do">오시는길</a>
                    </li>
                    <!-- Classic -->
                    </ul>
                    <!-- End Submenu -->
                </li>
              <!-- End 알림마당 -->

              <!-- 참여마당 -->
              <li class="nav-item hs-has-sub-menu u-header__nav-item"
                  data-event="hover"
                  data-animation-in="fadeIn"
                  data-animation-out="fadeOut">
                <a id="worksMegaMenu" class="nav-link u-header__nav-link font-weight-bold" href="javascript:;"
                   aria-haspopup="true"
                   aria-expanded="false"
                   aria-labelledby="worksSubMenu">
                   <span class= "font-weight-bold h5 mx-auto">참여마당
                    <i class="fa fa-angle-down u-header__nav-link-icon"></i>
                    </span>
                </a>
                <!-- Blog - Submenu -->
                <ul id="blogSubMenu" class="list-inline hs-sub-menu u-header__sub-menu mb-0" style="min-width: 220px;"
                    aria-labelledby="blogMegaMenu">
                  <!-- List -->
                     <li class="dropdown-item hs-has-sub-menu">
                        <a id="navLinkBlogList" class="nav-link u-header__sub-menu-nav-link"
                           aria-haspopup="true"
                           aria-expanded="false"
                           aria-controls="navSubmenuBlogList">
                           중고장터
                          <i class="fa fa-angle-right u-header__sub-menu-nav-link-icon"></i>
                        </a>
    
                        <!-- Submenu (level 2) -->
                        <ul id="navSubmenuBlogList" class="hs-sub-menu list-unstyled u-header__sub-menu u-header__sub-menu-offset" style="min-width: 220px;"
                            aria-labelledby="navLinkBlogList">
                          <li class="dropdown-item u-header__sub-menu-list-item">
                            <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=300&board_category=삽니다">삽니다</a>
                          </li>
                          <li class="dropdown-item u-header__sub-menu-list-item">
                            <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=300&board_category=팝니다">팝니다</a>
                          </li>                      
                        </ul>
                        <!-- End Submenu (level 2) -->
                      </li>
                  <!-- List -->
                  
                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/login/listStudy.do">비트스터디</a>
                  </li>
                  <!-- Classic -->
                  
                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=300&board_category=자유게시판">자유게시판</a>
                  </li>
                  <!-- Classic -->

                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=300&board_category=익명게시판">익명게시판</a>
                  </li>
                  <!-- Classic -->
                </ul>
                <!-- End Submenu -->
              </li>
              <!-- End 참여마당 -->

              <!-- 도움마당 -->
              <li class="nav-item hs-has-sub-menu u-header__nav-item"
                  data-event="hover"
                  data-animation-in="fadeIn"
                  data-animation-out="fadeOut">
                <a id="worksMegaMenu" class="nav-link u-header__nav-link font-weight-bold" href="javascript:;"
                   aria-haspopup="true"
                   aria-expanded="false"
                   aria-labelledby="worksSubMenu">
                   <span class= "font-weight-bold h5 mx-auto">도움마당
                    <i class="fa fa-angle-down u-header__nav-link-icon"></i>
                    </span>
                </a>
                <!-- Blog - Submenu -->
                <ul id="blogSubMenu" class="list-inline hs-sub-menu u-header__sub-menu mb-0" style="min-width: 220px;"
                    aria-labelledby="blogMegaMenu">
                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=200&board_category=시설QNA">시설Q&A</a>
                  </li>
                  <!-- Classic -->

                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/login/listBoard.do?board_boardno=200&board_category=학사QNA">학사Q&A</a>
                  </li>
                  <!-- Classic -->
                </ul>
                <!-- End Submenu -->
              </li>
              <!-- End 도움마당 -->

              <!-- 관리자 -->
              <c:if test="${acc_id == '관리자'}">
              <li class="nav-item hs-has-sub-menu u-header__nav-item"
                  data-event="hover"
                  data-animation-in="fadeIn"
                  data-animation-out="fadeOut">
                <a id="worksMegaMenu" class="nav-link u-header__nav-link font-weight-bold" href="javascript:;"
                   aria-haspopup="true"
                   aria-expanded="false"
                   aria-labelledby="worksSubMenu">
                   <span class= "font-weight-bold h5 mx-auto">관리자
                    <i class="fa fa-angle-down u-header__nav-link-icon"></i>
                    </span>
                </a>

                <!-- Blog - Submenu -->
                <ul id="blogSubMenu" class="list-inline hs-sub-menu u-header__sub-menu mb-0" style="min-width: 220px;"
                    aria-labelledby="blogMegaMenu">
                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/admin/adminStudentInfo.do">학생기본정보관리</a>
                  </li>
                  <!-- Classic -->
                  
                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/admin/adminCalendar.do">학사일정관리</a>
                  </li>
                  <!-- Classic -->

                  <!-- List -->
                  <li class="dropdown-item hs-has-sub-menu">
                    <a id="navLinkBlogList" class="nav-link u-header__sub-menu-nav-link"
                       aria-haspopup="true"
                       aria-expanded="false"
                       aria-controls="navSubmenuBlogList">
                      등록금관리
                      <i class="fa fa-angle-right u-header__sub-menu-nav-link-icon"></i>
                    </a>

                    <!-- Submenu (level 2) -->
                    <ul id="navSubmenuBlogList" class="hs-sub-menu list-unstyled u-header__sub-menu u-header__sub-menu-offset" style="min-width: 220px;"
                        aria-labelledby="navLinkBlogList">
                      <li class="dropdown-item u-header__sub-menu-list-item">
                        <a class="nav-link u-header__sub-menu-nav-link" href="/admin/insertRegister.do">등록금등록</a>
                      </li>
                      <li class="dropdown-item u-header__sub-menu-list-item">
                        <a class="nav-link u-header__sub-menu-nav-link" href="/admin/listRegfee.do">등록금미납관리</a>
                      </li>                      
                    </ul>
                    <!-- End Submenu (level 2) -->
                  </li>
                  <!-- List -->

                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/admin/insertProfessor.do">교수정보관리</a>
                  </li>
                  <!-- Classic -->

                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/admin/adminGrade.do">성적정보관리</a>
                  </li>
                  <!-- Classic -->

                  <!-- Classic -->
                  <li class="dropdown-item u-header__sub-menu-list-item py-0">
                    <a class="nav-link u-header__sub-menu-nav-link" href="/admin/class.do">강의정보관리</a>
                  </li>
                  <!-- Classic -->

                </ul>
                <!-- End 관리자 -->
                
              </li>
              </c:if>
              <!-- End Works -->

              <!-- Button -->
              <li class="nav-item u-header__nav-item-btn">
                <a class="btn btn-sm btn-primary" href="/logout.do" role="button">
                  <i class="fas fa-sign-out-alt"></i>
                  로그아웃
                </a>
              </li>
              <!-- End Button -->
            </ul>
          </div>
          <!-- End Navigation -->
        </nav>
        <!-- End Nav -->
      </div>
    </div>
  </header>
  <!-- ========== END HEADER ========== -->