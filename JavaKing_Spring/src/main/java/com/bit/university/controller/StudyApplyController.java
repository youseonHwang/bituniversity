package com.bit.university.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.StudentDao;
import com.bit.university.dao.StudyDao;
import com.bit.university.vo.StudentVo;
import com.bit.university.vo.StudyVo;

@Controller
public class StudyApplyController {

	@Autowired
	StudyDao s_dao;

	@Autowired
	StudentDao st_dao;

	@Autowired
	private MailSender javaMailSender;

	public void setJavaMailSender(MailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	@GetMapping("/login/StudyApply")
	@ResponseBody
	public int StudyApply (int study_no, HttpServletRequest request) {

		StudyVo s_vo = s_dao.getOneStudy(study_no);
		int std_no = 0;
		int re = -1;
		/**********************************************************************************************************************/
		HttpSession session = request.getSession();

		if(session.getAttribute("std_no")!=null) {
			std_no = (int) session.getAttribute("std_no");
		}
		/**********************************************************************************************************************/
		// 본인이 신청했을 경우 4를 반환
		if(s_vo.getStd_no() == std_no) { 
			re = 4;
			/**********************************************************************************************************************/
			// 본인이 신청한 것이 아닐때 진행
		} else {

			//limit보다 현재 인원이 적은지 확인하고 진행
			if(s_vo.getStudy_person() < s_vo.getStudy_limit()) {

				//----------------------------------------------------------------------------------------------------------------	
				// 일단 지원자의 학번을 모두 가져와서 배열에 넣기
				int apply1 = s_vo.getStudy_apply1();
				int apply2 = s_vo.getStudy_apply2();
				int apply3 = s_vo.getStudy_apply3();
				int apply4 = s_vo.getStudy_apply4();
				int apply5 = s_vo.getStudy_apply5();

				int [] apply_arr = {apply1, apply2, apply3, apply4, apply5};


				//----------------------------------------------------------------------------------------------------------------	
				// 중복을 확인할 변수
				boolean overlap = false;
				//----------------------------------------------------------------------------------------------------------------		
				// 이미 지원한 사람들 중 본인이 있는지 확인(만약 있다면 0을 가지고 반환
				for(int i =0; i< s_vo.getStudy_limit()-1; i++) {
					if(apply_arr[i] == std_no) {
						overlap = true;
						re = 0;
					}
				}
				//----------------------------------------------------------------------------------------------------------------	
				// 중복되지 않으면 빈 곳을 찾아서 넣기
				if(overlap == false) {


					for(int i =0; i< s_vo.getStudy_limit()-1; i++) {

						// 비어있다면 그 자리에 넣음
						if(apply_arr[i]==0) {
							apply_arr[i] = std_no;

							switch (i) {
							case 0: s_vo.setStudy_apply1(std_no); break;
							case 1: s_vo.setStudy_apply2(std_no); break;
							case 2: s_vo.setStudy_apply3(std_no); break;
							case 3: s_vo.setStudy_apply4(std_no); break;
							case 4: s_vo.setStudy_apply5(std_no); break;
							}
							break;
						}
					}

					re = s_dao.updateApply(s_vo);
					//----------------------------------------------------------------------------------------------------------------

					// 업데이트 확인용 변수들
					int for_confirm_sno = s_vo.getStudy_no();
					StudyVo for_email_svo = s_dao.getOneStudy(for_confirm_sno);

					//----------------------------------------------------------------------------------------------------------------

					// 지원자를 빈 곳에 넣은 뒤 인원 수를 확인하여 꽉찼으면 메일 발송하기
					if(for_email_svo.getStudy_limit() == for_email_svo.getStudy_person()) {

						StudentVo [] student_vo = new StudentVo [for_email_svo.getStudy_limit()];
						student_vo[0] = st_dao.getStudent(std_no);

						// studentVo를 담는 배열 초기화
						for(int i = 0; i<apply_arr.length; i++) {

							//지원자의 배열에 학번이 담겨져 있으면(0이 아니면)
							if(apply_arr[i] != 0) {

								// student_vo[0]번째는 방장의 학번이 담겨져 있기 때문에 [i+1]번째부터 시작
								// apply_arr[i] (지원자 학번 배열)에서 한개씩 가져와서 
								// 방장을 포함한 배열을 완성함.
								student_vo[i+1] = st_dao.getStudent(apply_arr[i]);
							} 
						}

						String study_email_info = "";

						for(int i = 0; i<student_vo.length; i++) {
							study_email_info += student_vo[i].getStd_email();
							if(i != student_vo.length-1) {
								study_email_info += "/";
							}
						}
						
						for(int i = 0; i<student_vo.length; i++) {
							SimpleMailMessage mailMessage = new SimpleMailMessage();

							mailMessage.setSubject("[비트대학교]스터디 모집 완료 메일입니다."); //메일 제목

							mailMessage.setFrom("bituniversityemail@gmail.com"); //비트대학교 관리자 메일

							mailMessage.setText("안녕하세요 " + student_vo[i].getStd_name() + "님이 신청하신 비트대학교 스터디 모집이 완료되어"
									+ "스터디원들의 메일 주소를 전달드립니다. 자세한 스터디 주제 선정 및 일정은 모집된 스터디원들과 의논 바랍니다."
									+ "[email : "+ study_email_info +"]"); //메일 내용

							mailMessage.setTo(student_vo[i].getStd_email()); //받는 사람

							try {
								javaMailSender.send(mailMessage);

							}catch (Exception e) {
								// TODO: handle exception'
								System.out.println(e.getMessage());
							}
						}

					}

				}

			} else {
				re = -2;
			}
		}return re;
	}
}


