package com.bit.university.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.AccountDao;
import com.bit.university.dao.MainDao;
import com.bit.university.db.AccountManager;
import com.bit.university.vo.AccountVo;
import com.bit.university.vo.BoardVo;

@Controller
public class MainController {

	@Autowired
	private MainDao m_dao;

	public void setM_dao(MainDao m_dao) {
		this.m_dao = m_dao;
	}

	@Autowired
	private AccountDao a_dao;

	public void setA_dao(AccountDao a_dao) {
		this.a_dao = a_dao;
	}

	// 메인페이지
	@RequestMapping("/login/main.do")
	public void main(HttpServletRequest request) {
		// 세션
		HttpSession session = request.getSession();

		// 로그인, 메인에서 사용한 에러메시지 삭제.
		session.removeAttribute("change_pwd_msg");
		session.removeAttribute("login_error");
		session.removeAttribute("result_id");
		session.removeAttribute("result_pwd");

		List<BoardVo> main_notice = m_dao.getBoardList("공지사항", 100);
		List<BoardVo> main_freeboard = m_dao.getBoardList("자유게시판", 300);
		List<BoardVo> main_flee_buy = m_dao.getBoardList("삽니다", 300);
		List<BoardVo> main_flee_sell = m_dao.getBoardList("팝니다", 300);
		List<BoardVo> main_anonymous = m_dao.getBoardList("익명게시판", 300);
		
		// 메인에서 보여줄 게시판 목록 세션에 저장
		session.setAttribute("main_notice", main_notice);
		session.setAttribute("main_freeboard", main_freeboard);
		session.setAttribute("main_flee_buy", main_flee_buy);
		session.setAttribute("main_flee_sell", main_flee_sell);
		session.setAttribute("main_anonymous", main_anonymous);
	}

	// 비밀번호 변경
//	@RequestMapping(value = "/login/changePwd.do", method = RequestMethod.GET)
//	public void updatePwdForm() {
//	}

	@PostMapping("/login/changePwd.do")
	@ResponseBody
	public String updatePwd(HttpServletRequest request) {
		
		// 세션
		HttpSession session = request.getSession();
		
		// 기존 비밀번호, 새 비밀번호, 비밀번호 확인을 받아옴
		String old_pwd = request.getParameter("old_pwd");
		String new_pwd = request.getParameter("new_pwd");
		String new_pwd_check = request.getParameter("new_pwd_check");
		
		// 사용자 학번, 정보 받아옴
		String str_std_no = session.getAttribute("std_no") + "";
		int std_no = Integer.parseInt(str_std_no);
		String acc_id = a_dao.getAccountId(std_no);
		AccountVo a_vo = a_dao.getAccount(acc_id);
		
		// 기존 비밀번호 확인
		Boolean old_pwd_check = false;
		old_pwd_check = 
		PasswordEncoderFactories.createDelegatingPasswordEncoder().matches(old_pwd, a_vo.getAcc_pwd());

		String msg = "";
		int re = -1;

		// 오류발생시 1로 만들어 나머지 if문 실행하지 않게함.
		int stop = 0;

		// 새 비밀번호와 비밀번호 확인이 불일치할경우 에러발생
		if (!new_pwd.equals(new_pwd_check) && stop == 0) {
			msg = "비밀번호 확인이 맞지 않습니다.";
			stop++;
		}
		
		if (!old_pwd_check && stop == 0) {
			msg = "기존 비밀번호가 맞지 않습니다.";
			stop++;
		}
		
		if (old_pwd_check && stop == 0) {
			// 암호화
			String encode_new_pwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(new_pwd);

			// 비밀번호 변경 메소드 실행
			re = m_dao.updatePwd(encode_new_pwd, acc_id);

			// 비밀번호 변경 실패시 리다이렉트
			if (re <= 0) {
				msg = "오류가 발생했습니다.";
			} else {
				msg = "비밀번호가 변경되었습니다.";
			}
		}

//		// 에러 메시지 세션 저장후 출력
//		session.setAttribute("change_pwd_msg", msg);
//		
		return msg;
	}

	@RequestMapping("/")
	public String loginCheck(HttpSession session) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		String id = user.getUsername();
		AccountVo vo = AccountManager.getAccount(id);
		session.setAttribute("user_info", vo);
		return "/login.do";
	}
	
	
	
	
	

}
