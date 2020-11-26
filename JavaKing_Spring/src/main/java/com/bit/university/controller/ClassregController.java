package com.bit.university.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.InternalResourceView;

import com.bit.university.dao.ClassDao;
import com.bit.university.dao.ClassregDao;
import com.bit.university.dao.StudentDao;
import com.bit.university.vo.ClassVo;
import com.bit.university.vo.ClassregVo;
import com.bit.university.vo.StudentVo;
import com.google.gson.Gson;

@Controller
public class ClassregController {
	
	private  int pageSize = 5;	//한 화면에 몇개 레코드가 보일지
	private  int pageMax= 5;		//몇개까지 보이고 이전,다음 보일지
	private  int totalRecord;	//db상 총 레코드가 몇갠지
	private  int totalPage;		//총 몇쪽인지
	private  HttpSession session;
	
	@Autowired
	private ClassregDao crdao;
	@Autowired
	private ClassDao cdao;
	@Autowired
	private StudentDao sdao;
	
	public void setDao (ClassregDao crdao) {
		this.crdao=crdao;
	}
	public void setDao (ClassDao cdao) {
		this.cdao=cdao;
	}
	public void setDao (StudentDao sdao) {
		this.sdao=sdao;
	}
	
	/********** 기본뷰 *********/	
	@RequestMapping(value="/login/classReg.do") //기본뷰
	public void classregView(HttpServletRequest request) {
		session = request.getSession();
		int std_no = (int) session.getAttribute("std_no");
//		int std_no = 2014104195;
		session.setAttribute("std_no",std_no);
	}
	/********* 수강내역 확인뷰 *********/
	@RequestMapping(value="/login/classRegCheck.do")
	public void classregCheck(HttpServletRequest request) {
		session = request.getSession();
		int std_no = (int) session.getAttribute("std_no");
//		int std_no = 2014104195;
		session.setAttribute("std_no",std_no);
	}
	
	
	
	
	
	
	/********** 학생정보 가져오기 *********/
	@RequestMapping(value="/callStdInfo.do")
	@ResponseBody
	public StudentVo callStdInfo(int std_no) {
		StudentVo s = sdao.getStudent(std_no);
		return s;
	}
	
	/********** 신청내역 가져오기 (신청날짜 당일 기준) *********/
	@RequestMapping(value="/login/getRegList.do")
	@ResponseBody
	public List<ClassregVo> getRegList(int std_no, int pageSize, int pageNum) {
				
		totalRecord = crdao.classregCountlRecord(std_no);		
		int start = (pageNum-1)*pageSize+1;
		int end = start+pageSize-1;
		if(end > totalRecord) {
			end = totalRecord;
		}	
		System.out.println("신청내역 시작번호/끝번호: "+start+"/"+end);

		HashMap map = new HashMap();
		map.put("std_no", std_no);
		map.put("start", start);
		map.put("end", end);

		return crdao.classregList(map);
	}
	
	
	
	/********** 신청학점 가져오기 (신청날짜 당일 기준) *********/
	@RequestMapping(value="/login/getRegCredit.do")
	@ResponseBody
	public int getRegCredit(int std_no) {
		//신청 점수
		return crdao.classregCountCredit(std_no);
	}
	
	/********** 신청갯수 가져오기 (신청날짜 당일 기준) ********/
	@RequestMapping(value="/login/getRegCnt.do")
	@ResponseBody
	public int getRegCnt(int std_no) {
		return crdao.classregCountlRecord(std_no);
	}
	
		
	/********** 신청 ********/
	@RequestMapping(value="/login/classregInsert.do") //insert뷰
	@ResponseBody
	public int classregInsert(int std_no, int class_no) {
		int re = cdao.addNowCnt(class_no); //수강인원 증가가 되면!!
		if(re > 0 ) {
			HashMap map = new HashMap();
			map.put("std_no", std_no);
			map.put("class_no", class_no);
			int r =  crdao.classregInsert(map);
			if(r > 0) {
				return r;
			}else {
				return -1;
			}
		}else {
			return -1;
		}
		
	}
	
	
	/********** 신청내역 삭제 ********/
	@RequestMapping(value="/login/classregDel.do")
	@ResponseBody
	public int classregDel(int class_no, int std_no, int classreg_no) {
		
		int re = cdao.subNowCnt(class_no); //수강인원 감소가 되면!!
		if(re > 0){
			HashMap map = new HashMap();
			map.put("std_no", std_no);
			map.put("classreg_no",classreg_no);
			int r = crdao.classregDelete(map);	
			if(r > 0) {
				return r;
			}else {
				return -1;
			}
		}else {
			return -1;
		}
		
	}

	
}
