package com.bit.university.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.RegisterDao;
import com.bit.university.vo.RegisterVo;


@Controller
public class InsertRegisterController {

	@Autowired
	private RegisterDao dao;

	public void setDao(RegisterDao dao) {
		this.dao = dao;
	}
	

	@GetMapping("/admin/insertRegister.do")
	public void insertRegisterDo() {	
	}
	
	

	@RequestMapping("/admin/insertRegister")
	@ResponseBody
	public int insertRegister(RegisterVo r) {
		int no = dao.registerNextNo();
		r.setReg_no(no);
		int re = dao.registerInsert(r);
		if(re>0) {
			System.out.println("등록금 등록성공!");
		}
		return re;
	}
	
}
