package com.bit.university.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.GradeDao;
import com.bit.university.vo.GradeVo;
import com.google.gson.Gson;

import ch.qos.logback.core.rolling.helper.IntegerTokenConverter;

@Controller
public class GradeController {
	
	@Autowired
	private GradeDao dao;

	public void setDao(GradeDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value="/login/listGrade.do", method = RequestMethod.GET)
	public void listAll(HttpServletRequest request, Model model) {
		int std_no = (int)request.getSession().getAttribute("std_no");
		List<GradeVo> list = dao.listAll(std_no);
		model.addAttribute("grade_list",list);
	//	request.getSession().setAttribute("grade_list",list);
	}
	
	@PostMapping(value="/login/printGrade.do")
	public void printAll(HttpServletRequest request,Model model, String year, int semester) {
		int std_no = (int)request.getSession().getAttribute("std_no");
		HashMap map = new HashMap();
		map.put("year", year);
		map.put("semester", semester);
		map.put("std_no", std_no);
		List<GradeVo> list = dao.detail(map);
		model.addAttribute("detail_list",list);
	}
	
	@PostMapping(value = "/login/detailGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String detail(HttpServletRequest request, String year, int semester) {
		int std_no = (int)request.getSession().getAttribute("std_no");
//		String year = request.getParameter("year");
//		int semester = Integer.parseInt(request.getParameter("semester"));
		HashMap map = new HashMap();
		map.put("year", year);
		map.put("semester", semester);
		map.put("std_no", std_no);
		List<GradeVo> list = dao.detail(map);
		Gson gson = new Gson();
//		model.addAttribute("dlist",dao.detail(map));
		return gson.toJson(list);
	}
	
	@RequestMapping(value="/admin/adminGrade.do", method=RequestMethod.GET)
	public void insertForm() {
	}
	
	@RequestMapping(value="/admin/adminGrade.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertSubmit(GradeVo vo) {
		
		int score = vo.getGrade_score();
		if(score>=95) {
			vo.setGrade_rank("A+");
		}else if(score>=90) {
			vo.setGrade_rank("A");
		}else if(score>=85) {
			vo.setGrade_rank("B+");
		}else if(score>=80) {
			vo.setGrade_rank("B");
		}else if(score>=75) {
			vo.setGrade_rank("C+");
		}else if(score>=70) {
			vo.setGrade_rank("C");
		}else if(score>=65) {
			vo.setGrade_rank("D+");
		}else if(score>=60) {
			vo.setGrade_rank("D");
		}else {
			vo.setGrade_rank("F");
		}
		System.out.println(vo);
		int re = dao.insert(vo);

		return Integer.toString(re);
	}
	
	@PostMapping(value="/admin/findByNoGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String findByNo(int grade_no) {
		Gson gson = new Gson();
		return gson.toJson(dao.findByNo(grade_no));
	}
	
	@RequestMapping(value="/admin/updateGrade.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateSubmit(GradeVo vo) {
	//	ModelAndView mav = new ModelAndView("redirect:/login/updateGrade.do");
		int score = vo.getGrade_score();
		if(score>=95) {			vo.setGrade_rank("A+");}
		else if(score>=90) {	vo.setGrade_rank("A");}
		else if(score>=85) {	vo.setGrade_rank("B+");}
		else if(score>=80) {	vo.setGrade_rank("B");}
		else if(score>=75) {	vo.setGrade_rank("C+");}
		else if(score>=70) {	vo.setGrade_rank("C");}
		else if(score>=65) {	vo.setGrade_rank("D+");}
		else if(score>=60) {	vo.setGrade_rank("D");}
		else {	vo.setGrade_rank("F");}
		
		System.out.println(vo);
		int re = dao.update(vo);
//		if(re <= 0) {
//			mav.addObject("msg", "수정에 실패하였습니다.");
//			mav.setViewName("error");
//		}
//		return mav;
		
		return Integer.toString(re);
	}
	
	@RequestMapping(value="/admin/deleteGrade.do", method = RequestMethod.GET)
	public void deleteForm(int grade_no, Model model) {
		model.addAttribute("grade_no",grade_no);
	}
	
	@PostMapping(value="/admin/deleteGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String deleteSubmit(int grade_no) {
		Gson gson = new Gson();
		return gson.toJson(dao.delete(grade_no));
	}
	
	@PostMapping(value="/admin/stdListGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String listAll(int class_no) {
		Gson gson = new Gson();
		return gson.toJson(dao.getStdList(class_no));
	}
	
	
	@PostMapping(value="/admin/getNextNoGrade.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String getNextNo() {
		System.out.println("통과");
		Gson gson = new Gson();
		System.out.println(dao.getNextNo());
		return gson.toJson(dao.getNextNo());
	}
	
}
