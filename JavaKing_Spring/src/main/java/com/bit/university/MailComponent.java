package com.bit.university;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;

import com.bit.university.vo.StudentVo;

//스터디 메일보내는 클래스
@Component
public class MailComponent {

	@Autowired
	private MailSender javaMailSender;

	public void setJavaMailSender(MailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}
	
	public void sendEmail(StudentVo [] student_vo)
	{	
		
		String study_email_info = "";
		
		for(int i = 0; i<student_vo.length; i++) {
			study_email_info += student_vo[i].getStd_email();
			if(i != student_vo.length-1) {
				study_email_info += "/";
			}
		}
		
		System.out.println(study_email_info);
		for(int i = 0; i<student_vo.length; i++) {
			SimpleMailMessage mailMessage = new SimpleMailMessage();
			mailMessage.setSubject("[비트대학교]스터디 모집 완료 메일입니다."); //메일 제목
			mailMessage.setFrom("bituniversityemail"); //비트대학교 관리자 메일
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
	