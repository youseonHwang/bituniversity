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

import com.bit.university.dao.ClassDao;
import com.bit.university.vo.ClassVo;
import com.bit.university.vo.ClassregVo;
import com.google.gson.Gson;


@Controller
public class ClassController {

	//private int pageMax= 5;		//몇개까지 보이고 이전,다음 보일지 ajax로 이동
	private int totalRecord;	//db상 총 레코드가 몇갠지
	private int totalPage;		//총 몇쪽인지
	private HttpSession session;
	
	@Autowired
	private ClassDao dao;
	
	public void setDao (ClassDao dao) {
		this.dao=dao;
	}
		
		
	/********************** classSearch 뷰************************/
	@RequestMapping(value="/login/classSearch.do")
	public void showViewSearch() {}
	
	/********************** 오픈 classInfo 뷰,data************************/
	@RequestMapping(value="/classInfo.do")
	public void showViewInfo() {}
	
	@RequestMapping(value="/classInfoList.do")
	@ResponseBody
	public List<ClassVo> getClassInfoList (int colNo) {
		
		return dao.findByColNo(colNo);
	}
	
	/********************** admin 영역의 class 관련************************/
	@RequestMapping(value="/admin/class.do")
	public void showView (Model model) {
		model.addAttribute("class_no", dao.classNextNo());
	}
	
	
	@RequestMapping(value="/getTotalRecord.do")
	@ResponseBody
	public String getTotalRecord(String search, String option, HttpServletRequest request) {
		System.out.println("======== getrecord : search/option: "+search+", "+option);
		
		session = request.getSession();
		//search, option 값 저장. 화면에 뿌려줘야하므로 ajax를 해도 아직 필요하다	
		if(!search.equals("")) {
			search = search.trim();
			option = option.trim();
			session.setAttribute("search", search);
			session.setAttribute("option", option);
		}
		
		if(session.getAttribute("search")!=null) {
			search = (String)session.getAttribute("search");
			option = (String)session.getAttribute("option");
		}
		HashMap mapRecord = new HashMap();
		mapRecord.put("search", search);
		mapRecord.put("option", option);
		totalRecord = dao.classTotalRecord(mapRecord);
		
		return dao.classTotalRecord(mapRecord)+"";
	} 
	
	//detailClass 에서 학부별 필수강의 목록
	@RequestMapping(value="/login/detailClassGetReq.do")
	@ResponseBody
	public List<ClassVo> detailClassGetReq(int std_no){
		return dao.detailClassGetReq(std_no);
	}
	
	
	@RequestMapping(value="/classList.do")
	@ResponseBody
	public List<ClassVo> listClass( int pageSize, int pageNum,String search, String option,HttpServletRequest request, Model model) {
		System.out.println("list 에서 pagenum: "+pageNum);
		session = request.getSession();
		
		//search, option 값 저장. 화면에 뿌려줘야하므로 ajax를 해도 아직 필요하다	
		if(!search.equals("")) {
			search = search.trim();
			option = option.trim();
			session.setAttribute("search", search);
			session.setAttribute("option", option);
		}
		
		if(session.getAttribute("search")!=null) {
			search = (String)session.getAttribute("search");
			option = (String)session.getAttribute("option");
		}
				
		//레코드번호 ok
		HashMap mapRecord = new HashMap();
		mapRecord.put("search", search);
		mapRecord.put("option", option);
		System.out.println("search,option: "+mapRecord.get("search")+","+mapRecord.get("option"));
		totalRecord = dao.classTotalRecord(mapRecord);
		int start = (pageNum-1)*pageSize+1;
		int end = start+pageSize-1;
		if(end > totalRecord) {
			end = totalRecord;
		}	
		System.out.println("시작번호/끝번호: "+start+"/"+end);

		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		map.put("option", option);

		return dao.classList(map);

		
	}
	
	
}
