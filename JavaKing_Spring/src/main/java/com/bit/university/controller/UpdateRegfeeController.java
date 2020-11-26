package com.bit.university.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.university.dao.RegisterDao;

@Controller
public class UpdateRegfeeController {

	@Autowired
	private RegisterDao dao;

	public void setDao(RegisterDao dao) {
		this.dao = dao;
	}
	

	
	@RequestMapping("/login/updateRegfee.do")
	public void updateRegfee(int reg_no) {
		int re = dao.regfeeUpdate(reg_no);
		if(re >0) {
			System.out.println("등록금 납부성공!");
		}
	}
	
	
	
}
