package com.bit.university.controller;

import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.StudyDao;
import com.bit.university.vo.StudyVo;

@Controller
public class InsertStudyController {


	@Autowired
	private StudyDao s_dao;
	
	@GetMapping("/login/insertStudy.do")
	public void insertStudyView() {
	
	}
	
	@PostMapping("/login/insertStudy")
	@ResponseBody
	public int insertStudyPost(StudyVo s_vo, HttpServletRequest request) {
		int re = -1;
		int std_no;
		
		System.out.println(s_vo.toString()); 
		
		System.out.println(s_vo.getScategory_no());
		
		

		HttpSession session = request.getSession();
		
		if(session.getAttribute("std_no") != null) {
			std_no = (int) session.getAttribute("std_no");
		} else {
			std_no = 2014104199;
		}
		s_vo.setStd_no(std_no);
		
		

		int study_no = (int)(s_dao.getNextStudyNo());
		s_vo.setStudy_no(study_no);
		

		String path = request.getRealPath("image");
		
		String study_fname ="";
		
		if(s_vo.getUpload_file() != null) {
			String fname = s_vo.getUpload_file().getOriginalFilename();
			study_fname = fname.substring(fname.lastIndexOf("\\")+1);
		
		
			if(study_fname != null && !study_fname.equals("")) {
		         try {
		            byte[] data = s_vo.getUpload_file().getBytes();
		            FileOutputStream fos = new FileOutputStream(path+"/"+study_fname);
		            fos.write(data);
		            fos.close();
		         }catch (Exception e) {
		            System.out.println("���ܹ߻�s : " + e.getMessage());
		         }
		      }
		}
		
		System.out.println(s_vo);
		
		s_vo.setStudy_fname(study_fname);
		re = s_dao.insertStudy(s_vo);
		
		return re;
	}
}
