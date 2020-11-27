package com.bit.university.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.MailComponent;
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
						}
					}
					re = s_dao.updateApply(s_vo);
					
					//----------------------------------------------------------------------------------------------------------------	
					// 지원자를 빈 곳에 넣은 뒤 인원 수를 확인하여 꽉찼으면 메일 발송하기
					if(s_vo.getStudy_limit()==s_vo.getStudy_person()) {
						MailComponent mail = new MailComponent();
						
						StudentVo [] student_vo = new StudentVo [s_vo.getStudy_limit()-1];
						
						for(int i = 0; i<apply_arr.length; i++) {
							if(apply_arr[i] != 0) {student_vo[i] = st_dao.getStudent(apply_arr[i]);}
						}
						mail.sendEmail(student_vo);
					}
				} 
			/**********************************************************************************************************************/	
			// 인원이 이미 꽉 찼으면 -2반환
			}else {re = -2;}
		}
		/**********************************************************************************************************************/
		return re;
	}
}


