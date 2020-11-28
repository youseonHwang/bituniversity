package com.bit.university.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.ChangeDao;
import com.bit.university.dao.StudentDao;
import com.bit.university.vo.ChangeVo;
import com.bit.university.vo.StudentVo;

@Controller
@RequestMapping("/login/updateStudentInfo.do")
public class updateStudentController {

	@Autowired
	private StudentDao dao;

	public void setDao(StudentDao dao) {
		this.dao = dao;
	}
	
	@Autowired
	private ChangeDao cd;

	@RequestMapping(method = RequestMethod.GET)
	public void form(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int std_no = Integer.parseInt(session.getAttribute("std_no")+"");
		model.addAttribute("sv4", dao.getStudent(std_no));
	}

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public String submit(@RequestParam(defaultValue = "0")String std_enddateCheck ,StudentVo sv4, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int std_level = Integer.parseInt(session.getAttribute("std_level")+"");
		int std_semester = Integer.parseInt(session.getAttribute("std_semester")+"");
		if (!sv4.getStd_status().equals(session.getAttribute("std_status")) || sv4.getStd_level()!=std_level || sv4.getStd_semester()!= std_semester) {
			ChangeVo cv = new ChangeVo();	
			cv.setChange_no(cd.nextNum());
			cv.setChange_year(Integer.parseInt((String.valueOf(sv4.getStd_startdate()).substring(0, 4))));
			cv.setChange_semester(sv4.getStd_semester());
			cv.setChange_level(sv4.getStd_level());
			cv.setChange_sub(sv4.getStd_status());
			cv.setStd_no(sv4.getStd_no());
			cd.insert(cv);
			
		}
		
		
		
		if(!std_enddateCheck.equals("0")) {
			sv4.setStd_enddate(null);
		}
		
		
		String path = request.getRealPath("upload");
		String oldFname = sv4.getStd_fname();
		MultipartFile uploadFile = sv4.getUploadFile();
		String fname = uploadFile.getOriginalFilename();
		if (fname != null && !fname.equals("")) {
			try {
				byte[] data = uploadFile.getBytes();
				FileOutputStream fos = new FileOutputStream(path+"/"+fname);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				System.out.println("예외발생:"+e.getMessage());
			}
			sv4.setStd_fname(fname);
		}else {
			sv4.setStd_fname(oldFname);
		}

//		ModelAndView mav = new ModelAndView("redirect:/login/main.do");
		int re = dao.updateStudent(sv4);
		if (fname != null && !fname.equals("") && oldFname !=null &&!oldFname.equals("")) {
			File file = new File(path+"/"+oldFname);
			file.delete();
		}
		return Integer.toString(re);
	}


}
