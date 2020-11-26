package com.bit.university;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class FailureHandler implements AuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		HttpSession session = request.getSession();
		// 실패할 경우 메시지 출력
		String fail_id = request.getParameter("acc_id");
		Cookie[] cookies = request.getCookies();
		boolean is_retry = false;

		// 학번 저장이 되어있는 상태에서 만약에 다른아이디를 입력할 경우 쿠키 삭제
		// 저장된 아이디로 계속 시도할경우 저장 남김

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Object cv = cookies[i].getValue();
				if (cv.equals(fail_id)) {
					is_retry = true;
				}
			}
		}
		
		Cookie re_id = new Cookie("re_id", null);
		
		if (is_retry == false) {
			re_id.setValue(null);
			re_id.setMaxAge(0);
			response.addCookie(re_id);
		}
		
		// 메시지 출력을 위해 request, session 을 전부 사용해보았으나
		// request 는 값 전달이 안되고
		// session 은 값 전달은 되나 새로고침때 그대로 유지되서 cookie를 사용함.
		// cookie 의 MaxAge 를 1로 설정해서 값만 보여주고 쿠키를 바로 삭제해버림
		Cookie fail_id_cookie = new Cookie("fail_id", fail_id);
		Cookie login_error = new Cookie("login_error","true");
		fail_id_cookie.setMaxAge(1);
		login_error.setMaxAge(1);
		response.addCookie(fail_id_cookie);
		response.addCookie(login_error);
//		request.setAttribute("failId", fail_id);
//		request.setAttribute("loginError", "학번이나 비밀번호를 확인해주세요");
//		session.setAttribute("fail_id", fail_id);
//		session.setAttribute("login_error", "학번이나 비밀번호를 확인해주세요");
		response.sendRedirect("/login.do");
	}
}
