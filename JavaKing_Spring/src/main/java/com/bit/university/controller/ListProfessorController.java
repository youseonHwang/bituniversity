package com.bit.university.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.ProfessorDao;
import com.bit.university.vo.ProfessorVo;


@Controller
public class ListProfessorController {
	
	@Autowired
	private ProfessorDao dao;

	public void setDao(ProfessorDao dao) {
		this.dao = dao;
	}
	
	
	@GetMapping("/login/listProfessor.do")
	public void listProfessor() {	
	}
	
	@GetMapping("/login/listProfessor")
	@ResponseBody
	public List<ProfessorVo> listProfessorData(){
		List<ProfessorVo> list = dao.professorList();
		return list;
	}
}
