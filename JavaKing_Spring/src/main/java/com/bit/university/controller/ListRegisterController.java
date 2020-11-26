package com.bit.university.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.RegisterDao;
import com.bit.university.vo.RegisterVo;



@Controller
public class ListRegisterController {

	@Autowired
	private RegisterDao dao;

	public void setDao(RegisterDao dao) {
		this.dao = dao;
	}
	
	@GetMapping("/login/listRegister.do")
	public void listRegister() {	
	}
	
	
	@GetMapping("/login/listRegister")
	@ResponseBody
	public List<RegisterVo> listRegData(HttpServletRequest request, HttpSession session){
		session = request.getSession();
		int std_no = (Integer) session.getAttribute("std_no");
		List<RegisterVo> list = dao.registerList(std_no);
		return list;
	}
	
	
	
	@GetMapping("/admin/listRegfee.do")
	public void listRegfee() {	
	}
	
	@GetMapping("/admin/listRegfee")
	@ResponseBody
	public List<RegisterVo> listRegfeeData(){
		List<RegisterVo> list = dao.regfeeList();
		return list;
		

	}
}
