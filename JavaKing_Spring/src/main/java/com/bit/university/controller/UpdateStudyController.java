package com.bit.university.controller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.StudyDao;
import com.bit.university.vo.StudyVo;

@Controller
public class UpdateStudyController {
	
	@Autowired
	private StudyDao s_dao;
	
	
	@GetMapping("/login/updateStudy.do")
	public ModelAndView updateStudyView(HttpServletRequest request) throws Throwable {
		ModelAndView mav = new ModelAndView();
		
	    System.out.println("updateStudyController 입장");
	    
		int study_no = Integer.parseInt(request.getParameter("study_no"));
		
		StudyVo s_vo = s_dao.getOneStudy(study_no);
		
		String lat_lng_area = s_vo.getStudy_area();
		System.out.println(lat_lng_area);
		String lat = lat_lng_area.substring(1, lat_lng_area.indexOf("/"));
		String lng = lat_lng_area.substring( lat_lng_area.indexOf("/", lat_lng_area.indexOf("/"))+1 , lat_lng_area.lastIndexOf("/") );
		
		System.out.println(lat+":::::::::::"+lng);
		
		mav.addObject("lat", lat);
		mav.addObject("lng", lng);
		mav.addObject("s_vo", s_vo);
		
		return mav;
	
	}
	
	@PostMapping("/login/updateStudy")
	@ResponseBody
	public int updateStudyPost(StudyVo s_vo, HttpServletRequest request) throws Throwable {
		
		HttpSession session = request.getSession();
		

		String path = request.getRealPath("image");
		System.out.println(path);
		
		String old_fname = s_vo.getStudy_fname();
		String fname = (s_vo.getUpload_file()).getOriginalFilename();
		String study_fname = fname.substring(fname.lastIndexOf("\\")+1);
		 if(study_fname != null && !study_fname.equals("")) {
	         try {
	            byte[] data = (s_vo.getUpload_file()).getBytes();
	            FileOutputStream fos = new FileOutputStream(path+"/"+study_fname);
	            fos.write(data);
	            fos.close();
	         }catch (Exception e) {
	            System.out.println("���ܹ߻�s : " + e.getMessage());
	         }
	         s_vo.setStudy_fname(study_fname);
	      } else{
	    	  s_vo.setStudy_fname(old_fname);
	      }
		 
		 
		 System.out.println(s_vo);
		 
		int re =s_dao.updateStudy(s_vo);

		if(re<=0) {
			
		} else {
			if( old_fname != null && !old_fname.equals("") && !study_fname.equals("")) {
				File file = new File(path + "/" +old_fname);
				file.delete();
			}

		}

		return re;
		
		
	}

	
	
	
}
