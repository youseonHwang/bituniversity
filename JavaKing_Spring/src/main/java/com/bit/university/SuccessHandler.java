package com.bit.university;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.bit.university.dao.AccountDao;
import com.bit.university.dao.MainDao;
import com.bit.university.dao.StudentDao;
import com.bit.university.vo.AccountVo;
import com.bit.university.vo.StudentVo;

public class SuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		AccountDao a_dao = new AccountDao();
		StudentDao s_dao = new StudentDao();
		MainDao m_dao = new MainDao();
		// 세션
		HttpSession session = request.getSession();

		// 입력한 acc_id
		String acc_id = request.getParameter("acc_id");

		// 계정정보 불러옴
		AccountVo a_vo = a_dao.getAccount(acc_id);

		// std_no
		int std_no = 0;

		// 학생일 경우 데이터 불러옴
		if (a_vo.getAcc_role().equals("STUDENT")) {
			std_no = a_vo.getStd_no();
		}

		// 학생정보 생성
		StudentVo s_vo = s_dao.getStudent(std_no);

		// 아이디 저장 체크 여부 확인. 기본값은 체크하지 않은걸로 함
		Cookie re_id = null;
		String cb_id = "notChecked";

		if (request.getParameter("cb_id") != null && !request.getParameter("cb_id").equals("")) {
			cb_id = request.getParameter("cb_id");
		}
		session.setAttribute("cb_id", cb_id);

		// 아이디 저장 체크일 경우 login.jsp 에서 사용할 id 값을 반환해줌
		if (cb_id.equals("checked")) {
			re_id = new Cookie("re_id", acc_id);
			re_id.setMaxAge(60 * 60 * 24 * 30);
		} else {
			re_id = new Cookie("re_id", null);
			re_id.setMaxAge(0);
		}
		response.addCookie(re_id);
		
		// 메인에서 사용할 학생정보 세션에 저장
		if (std_no == 0) {
			session.setAttribute("acc_id", "관리자");
			session.setAttribute("std_no", std_no);
			session.setAttribute("std_name", s_vo.getStd_name());
			session.setAttribute("major_name", "현재 관리자 계정입니다.");
			session.setAttribute("std_email", s_vo.getStd_email());
			session.setAttribute("std_fname", s_vo.getStd_fname());
		} else {
			session.setAttribute("acc_id", acc_id);
			session.setAttribute("std_no", std_no);
			session.setAttribute("std_name", s_vo.getStd_name());
			session.setAttribute("std_major", s_vo.getStd_major());
			session.setAttribute("std_email", s_vo.getStd_email());
			session.setAttribute("std_semester", s_vo.getStd_semester() + "학기");
			session.setAttribute("std_level", s_vo.getStd_level() + "학년");
			session.setAttribute("major_name", m_dao.getMajorName(s_vo.getStd_major()));
			session.setAttribute("std_fname", s_vo.getStd_fname());
		}

		// 메인페이지로 이동
		response.sendRedirect("/login/main.do");
	}
}