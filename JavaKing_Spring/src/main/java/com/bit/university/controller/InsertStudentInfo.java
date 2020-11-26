package com.bit.university.controller;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.AccountDao;
import com.bit.university.dao.ChangeDao;
import com.bit.university.dao.StudentDao;
import com.bit.university.vo.AccountVo;
import com.bit.university.vo.ChangeVo;
import com.bit.university.vo.StudentVo;

@Controller
@RequestMapping("/admin/adminStudentInfo.do")
public class InsertStudentInfo {

	@Autowired
	private StudentDao s_dao;

	public void setS_dao(StudentDao s_dao) {
		this.s_dao = s_dao;
	}
	
	@Autowired
	private AccountDao a_dao;

	public void setA_dao(AccountDao a_dao) {
		this.a_dao = a_dao;
	}
	
	@Autowired
	private ChangeDao cd;
	
	
	@RequestMapping(method = RequestMethod.GET)
	public void form() {	
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public String submit(StudentVo sv3, HttpServletRequest request) {
		ChangeVo cv = new ChangeVo();
		cv.setChange_no(cd.nextNum());
		cv.setChange_year(Integer.parseInt((String.valueOf(sv3.getStd_startdate()).substring(0, 4))));
		cv.setChange_semester(sv3.getStd_semester());
		cv.setChange_level(sv3.getStd_level());
		cv.setChange_sub(sv3.getStd_status());
		cv.setStd_no(sv3.getStd_no());
		cd.insert(cv);
		
		
		String path = request.getRealPath("upload");
		System.out.println("path:"+path);
		MultipartFile uploadFile = sv3.getUploadFile();
		String fname = uploadFile.getOriginalFilename();
		if (fname != null && !fname.equals("")) {
			try {
				byte []data = uploadFile.getBytes();
				FileOutputStream fos = new FileOutputStream(path+"/"+fname);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				System.out.println("InsertStudentInfoError:"+e.getMessage());
			}
		}else {
			fname = "";
		}
		sv3.setStd_fname(fname);
		//ModelAndView mav = new ModelAndView("redirect:/login/main.do");
		int re = s_dao.insertStudent(sv3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		System.out.println(sdf.format(sv3.getStd_birthday()));
		AccountVo account_vo = new AccountVo(a_dao.getLastAccountNo()+1,sv3.getStd_no()+"",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(sdf.format(sv3.getStd_birthday())),"STUDENT",sv3.getStd_no());
		System.out.println(a_dao.getLastAccountNo()+1);
		a_dao.insertStudentAccount(account_vo);
		return Integer.toString(re);
	}
}
