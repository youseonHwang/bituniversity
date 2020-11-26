package com.bit.university.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.BoardDao;
import com.bit.university.dao.ReplyDao;
import com.bit.university.dao.StudyDao;
import com.bit.university.vo.BoardVo;
import com.bit.university.vo.ReplyVo;
import com.bit.university.vo.StudyVo;

@Controller
public class DeleteStudyController {

	@Autowired
	private StudyDao s_dao;
	

	@GetMapping("/login/deleteStudy")
	@ResponseBody
	public int deleteStudyGet(HttpServletRequest request, int study_no) throws Throwable {
		
		String path = request.getRealPath("image");
		
		StudyVo s_vo = s_dao.getOneStudy(study_no);
		int re =s_dao.deleteStudy(study_no);
		
		if(re<=0) {
		} else {
			if(s_vo.getStudy_fname()!=null) {
				File file = new File(path + "/" +s_vo.getStudy_fname());
				file.delete();
			}
		}
		return re;
		
	}
	
}
