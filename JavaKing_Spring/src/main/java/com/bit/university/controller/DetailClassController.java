package com.bit.university.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.ClassregDao;
import com.bit.university.vo.ClassregVo;
import com.bit.university.vo.StudentVo;


@Controller
public class DetailClassController {

	private HttpSession session;
	
	@Autowired
	private ClassregDao dao;
	
	public void setDao (ClassregDao dao) {
		this.dao=dao;
	}
	

	/********** 기본뷰 *********/	
	@RequestMapping(value="/login/detailClass.do")
	public void classregView(HttpServletRequest request) {
		session = request.getSession();
		int std_no = (int) session.getAttribute("std_no");
//		int std_no = 2014104195;
		session.setAttribute("std_no",std_no);
	}
	
	/********** 학생정보 가져오기classregController (value="/callStdInfo.do")*********/

	/********** 학점취득내역 가져오기 *********/	
	@RequestMapping(value="/login/detailClassGetCrd.do")
	@ResponseBody
	public int detailClassGetCrd (int std_no, String class_type) {
		
		
		//화면에서 class_type 구분해서 받아오기
		HashMap map = new HashMap();
		map.put("std_no",std_no);
		if(class_type.equals("")) {
			map.put("classtype",null);
		}else {
			map.put("classtype",class_type);
		}
		return dao.detailClassGetCrd(map);
	}
	
	
	@RequestMapping(value="/login/detailClassRegListYS.do")
	@ResponseBody
	public List<ClassregVo> detailClassSubmit(int std_no, String class_year, String classreg_semester){ 
		System.out.println();
		HashMap map = new HashMap ();
		map.put("std_no", std_no);
		//화면에서 null 구분해서 받아오기
		if(class_year.equals("")) {
			map.put("class_year",null);
			map.put("classreg_semester",null);
		}else {
			map.put("class_year", class_year);
			map.put("classreg_semester", classreg_semester);
			
		}

		
		return dao.detailClassregList(map);
		
	}
	
	@PostMapping(value="/admin/detailClassGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public List<ClassregVo> detailClassGrade(HttpServletRequest request, String class_year, String classreg_semester){ 
		int std_no = Integer.parseInt(request.getSession().getAttribute("std_no")+"");
		System.out.println(std_no);
		System.out.println(class_year);
		System.out.println(classreg_semester);
		HashMap map = new HashMap();
		map.put("std_no", std_no);
		//화면에서 null 구분해서 받아오기
		if(class_year.equals("")) {
			map.put("class_year",null);
			map.put("classreg_semester",null);
		}else {
			map.put("class_year", class_year);
			map.put("classreg_semester", classreg_semester);
		}
		List<ClassregVo> list = dao.detailClassregList(map);
		System.out.println(list);
		return list;
	}
	
}
