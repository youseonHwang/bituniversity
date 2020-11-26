package com.bit.university.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.CalendarDao;
import com.bit.university.vo.CalendarVo;
import com.google.gson.Gson;


@Controller
public class CalendarController {
	
	@Autowired
	public CalendarDao dao;
	
	public void setDao(CalendarDao dao) {
		this.dao = dao;
	}
	
	@GetMapping(value = "/login/calendar.do", produces = "Application/json; charset=utf-8")
	public void calendar() {
	}
	
	@GetMapping(value = "/login/loadCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String listAll() {
		Gson gson = new Gson();
		return gson.toJson(dao.listAll());
	}
	
	@GetMapping(value = "/admin/adminCalendar.do", produces = "Application/json; charset=utf-8")
	public void adminCalendar(Model model) {
		model.addAttribute("calendarNo", dao.getNextNo());
	}
	
	@GetMapping(value = "/admin/adminLoadCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String adminListAll() {
		
		Gson gson = new Gson();
		return gson.toJson(dao.listAll());
	}
	
	@GetMapping(value="/admin/insertCalendar.do")
	public void insertForm() {
	}
	
	@PostMapping(value="/admin/insertCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String insertSubmit(CalendarVo vo) {
		Gson gson = new Gson();
		System.out.println(vo);
		System.out.println(vo.getEnd_date().getClass().getName());
		return gson.toJson(dao.insert(vo));
	}
	
	@PostMapping(value="/admin/updateCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String updateSubmit(CalendarVo vo) {
		Gson gson = new Gson();
		return gson.toJson(dao.update(vo));
	}
	
	@PostMapping(value="/admin/deleteCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String deleteSubmit(int no) {
		Gson gson = new Gson();
		return gson.toJson(dao.delete(no));
	}
	
	@PostMapping(value="/admin/getNextNoCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String getNextNo() {
		Gson gson = new Gson();
		return gson.toJson(dao.getNextNo());
	}
	
	
	
	@PostMapping(value = "/admin/searchCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String searchList(String start_date,String end_date) {
		HashMap map = new HashMap();
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		System.out.println("시작일 : "+start_date);
		System.out.println(start_date.getClass().getName());
		System.out.println("종료일 : "+end_date);
		System.out.println(end_date.getClass().getName());
		Gson gson = new Gson();
		return gson.toJson(dao.searchList(map));
	}
	
	@PostMapping(value = "/admin/detailCalendar.do", produces = "Application/json; charset=utf-8")
	@ResponseBody
	public String listOne(int no) {
		Gson gson = new Gson();
		return gson.toJson(dao.listOne(no));
	}
}
