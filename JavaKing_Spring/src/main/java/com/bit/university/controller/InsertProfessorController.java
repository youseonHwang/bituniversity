package com.bit.university.controller;



import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.bit.university.dao.ProfessorDao;
import com.bit.university.vo.ProfessorVo;

@Controller
public class InsertProfessorController {

	@Autowired
	private ProfessorDao dao;

	public void setDao(ProfessorDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public void prom() {
	}
	

	@GetMapping("/admin/insertProfessor.do")
	public void insertProfessorDo() {	
	}
	
	@RequestMapping("/admin/insertProfessor")
	public void insertProfessor(HttpServletRequest request, ProfessorVo p) {
		String path = request.getRealPath("/professor");
		System.out.println("path : >>>>>>>>>>>>>>>>" + path);
		
		MultipartFile uploadFile = p.getUploadFile();
		String pro_fname = uploadFile.getOriginalFilename();
	
		if(pro_fname != null && !pro_fname.equals("")) {
			try {
				byte []data = uploadFile.getBytes();
				FileOutputStream fos = new FileOutputStream(path+ "/" +pro_fname);
				fos.write(data);
				fos.close();
			}catch (Exception e) {
				System.out.println("fname예외발생: "+e.getMessage());
			}
		}else {
			pro_fname = "";
			
		}
		p.setPro_fname(pro_fname);
		int re = dao.ProfessorInsert(p);
		if(re >0) {
			System.out.println("교수등록 성공!");
		}
		
	}
	
}
