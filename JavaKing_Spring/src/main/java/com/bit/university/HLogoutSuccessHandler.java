package com.bit.university;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class HLogoutSuccessHandler implements LogoutSuccessHandler {
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		if (authentication != null && authentication.getDetails() != null) {
			try {
				String re_id = "";
				HttpSession session = request.getSession();
				String cb_id = session.getAttribute("cb_id")+"";
				if (session.getAttribute("cb_id").equals("checked")) {
					if (session.getAttribute("re_id") != null && !session.getAttribute("re_id").equals("")) {
						re_id = session.getAttribute("re_id")+"";
						session.invalidate();
						HttpSession n_session = request.getSession();
						n_session.setAttribute("cb_id", "checked");
						n_session.setAttribute("re_id", re_id);
					}
				} else {
					session.invalidate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.setStatus(HttpServletResponse.SC_OK);
		response.sendRedirect("/login.do");
	}
}
