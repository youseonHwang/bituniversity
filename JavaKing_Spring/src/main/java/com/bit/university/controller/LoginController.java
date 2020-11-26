package com.bit.university.controller;

import java.io.IOException;
import java.util.Random;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.university.dao.AccountDao;
import com.bit.university.dao.MainDao;

@Controller
public class LoginController {

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

	@Autowired
	private MailSender javaMailSender;

	public void setJavaMailSender(MailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	// 로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public void loginForm() {
	}

	// 메일 발송 시 WARNING: An illegal reflective access operation has occurred ...
	// 메시지 콘솔에 출력되지만 단순 경고라 구동, 실행에는 아무 영향 없어서 무시해도 됨.

	// 아이디 찾기
	@RequestMapping(value = "/findId.do", method = RequestMethod.GET)
	public void findIdForm() {
	}

	@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
	public void findId(HttpServletRequest request, HttpServletResponse response) {
		// 메일 제목
		String title_msg = "비트대학교 학번 찾기 메일입니다.";

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("result_id", null);

		// findId.jsp 에서 이름과 이메일을 받아옴
		String std_name = request.getParameter("std_name");
		String std_email = request.getParameter("std_email");
		std_name = std_name.trim();
		std_email = std_email.trim();

		// 정규표현식 확인 처리
		boolean name_check = Pattern.matches("^[가-힣]*$", std_name);
		boolean email_check = Pattern.matches("\\w+@\\w+\\.\\w+(\\.\\w+)?", std_email);

		// false == redirect
		if (!name_check || !email_check) {
			session.setAttribute("result_id", "잘못된 형식의 이름 또는 이메일입니다.");
			try {
				response.sendRedirect("/findId.do");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			// DB 등록 여부 확인
			int check = m_dao.isStudentIdTrue(std_name, std_email);

			// 이름이나 이메일이 틀릴경우 에러메시지, 맞을 경우 이메일을 전송한다.
			if (check != 1) {
				session.setAttribute("result_id", "등록되지 않은 이름 또는 이메일입니다.");
			} else {
				// 메일 전송시 필요한 정보
				SimpleMailMessage mailMessage = new SimpleMailMessage();

				// 메일 내용
				String text_msg = "학번은 다음과 같습니다.\n" + m_dao.getStudentId(std_name, std_email);

				mailMessage.setSubject(title_msg);
				mailMessage.setFrom("bituniversityemail@gmail.com");
				mailMessage.setText(text_msg);
				mailMessage.setTo(std_email);
				try {
					javaMailSender.send(mailMessage);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				session.setAttribute("result_id", "등록된 이메일로 아이디를 전송했습니다.");
			}

			try {
				response.sendRedirect("/findId.do");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/findPwd.do", method = RequestMethod.GET)
	public void findPwdForm() {

	}

	@RequestMapping(value = "/findPwd.do", method = RequestMethod.POST)
	public void findPwd(HttpServletRequest request, HttpServletResponse response) {
		// 메일 제목
		String title_msg = "비트대학교 비밀번호 찾기 메일입니다.";

		// 임시 비밀번호 객체
		String temp_pwd = "";
		String text_msg = "임시비밀번호는 다음과 같습니다.\n";

		// 세션
		HttpSession session = request.getSession();
		session.setAttribute("result_pwd", null);

		// findPwd.jsp 에서 아이디와 이메일을 받아옴
		String std_no_check = request.getParameter("std_no");
		String std_email = request.getParameter("std_email");
		std_email = std_email.trim();

		// 정규표현식 확인 처리
		boolean no_check = Pattern.matches("^[0-9]*$", std_no_check);
		boolean email_check = Pattern.matches("\\w+@\\w+\\.\\w+(\\.\\w+)?", std_email);

		// false == redirect
		if (!no_check || !email_check) {
			session.setAttribute("result_pwd", "잘못된 형식의 학번 또는 이메일입니다.");
			try {
				response.sendRedirect("/findPwd.do");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			int std_no = Integer.parseInt(request.getParameter("std_no"));

			// DB 등록 여부 확인
			int check = m_dao.isStudentPwdTrue(std_no, std_email);

			// 이름이나 이메일이 틀릴경우 에러메시지, 맞을 경우 이메일을 전송한다.
			if (check != 1) {
				session.setAttribute("result_pwd", "등록되지 않은 학번 또는 이메일입니다");
			} else {
				// 비밀번호 난수 생성
				String[] auth_alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q",
						"R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
				Random ran = new Random();

				for (int i = 0; i <= 9; i++) {
					int num = ran.nextInt(34);
					if (num >= 10) {
						temp_pwd += auth_alphabet[num - 10] + "";
					} else {
						temp_pwd += num + "";
					}
				}

				// 암호화
				String encode_pwd = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(temp_pwd);

				// 임시 비밀번호로 비밀번호 변경
				m_dao.updateTempPwd(encode_pwd, a_dao.getAccountId(std_no));

				// 메일 전송시 필요한 정보
				SimpleMailMessage mailMessage = new SimpleMailMessage();

				// 메일 내용
				text_msg += temp_pwd + "\n로그인 후 반드시 비밀번호를 변경하시기 바랍니다.";

				mailMessage.setSubject(title_msg);
				mailMessage.setFrom("bituniversityemail@gmail.com");
				mailMessage.setText(text_msg);
				mailMessage.setTo(std_email);
				try {
					javaMailSender.send(mailMessage);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println(e.getMessage());
				}
				session.setAttribute("result_pwd", "등록된 이메일로 임시비밀번호를 전송했습니다.");
			}

			try {
				response.sendRedirect("/findPwd.do");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/start.do")
	public void start() {
	}

	@RequestMapping("/loginTest.do")
	public void lt() {
	}
}