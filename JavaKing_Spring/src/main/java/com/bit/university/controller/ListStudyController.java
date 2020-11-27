package com.bit.university.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.StudyDao;

@Controller
public class ListStudyController {

	@Autowired
	private StudyDao s_dao;
 
	@GetMapping("/login/listStudy.do")
	public void listStudyView(HttpServletRequest request) throws Throwable {

		int scategory_no = 0;
		HttpSession session = request.getSession();
		int std_no=0;

		/**********************************************************************************************************************/
		// 로그인 한 사람의 학번 가져오기 (view에서 본인이 기능을 사용하는 것인지 확인하기 위해)
		if(session.getAttribute("std_no") != null) {
			std_no = (int) session.getAttribute("std_no");
		} 
		request.setAttribute("std_no", std_no);

		/**********************************************************************************************************************/
		// nav 메뉴를 통해서 새로운 view를 요청했는지 확인하기 위해 요청 확인
		if(request.getParameter("scategory_no")!=null) { 
			scategory_no = Integer.parseInt(request.getParameter("scategory_no"));
		}
		request.setAttribute("scategory_no", scategory_no);
	}


	
	@GetMapping("/login/listStudy")
	@ResponseBody
	public HashMap listStudyGet(HttpServletRequest request, int scategory_no, String search, String area, int page_num) throws Throwable {
		
		HttpSession session = request.getSession();

		/**********************************************************************************************************************/
		// more버튼을 눌렀을 경우 필요하여 session에 검색어 저장
		if(search == null && !search.equals("")) {
			session.setAttribute("search", search);
		}
		
		if(session.getAttribute("search")!=null && search == null) {
			search = (String) session.getAttribute("search");
		}
		
		if(scategory_no == 0) {
			session.setAttribute("search", search);
		}
		
		if(session.getAttribute("scategory_no")!=null) {
			scategory_no = (int) session.getAttribute("scategory_no");
		}
		
		if(area !=null && !area.equals("")) {
			session.setAttribute("area", area);
		}

		if(session.getAttribute("area")!=null && area==null) {
			area = (String) session.getAttribute("area");
		}

		/**********************************************************************************************************************/
		// more버튼을 위한 총 스터디 갯수를 세기 위한 map생성 
		HashMap for_count_map = new HashMap();

		for_count_map.put("scategory_no", scategory_no);
		for_count_map.put("search", search);
		for_count_map.put("area", area);
		/**********************************************************************************************************************/

		int page_size = 10;
		int study_count = s_dao.getTotalCount(for_count_map);
		
		int start = (page_num-1)*page_size+1;
		int end = start+page_size-1;
		if(end > study_count) {
			end = study_count;
		}   

		/**********************************************************************************************************************/

		// 스터디 리스트를 만들기 위한 map 생성
		HashMap for_list_map = new HashMap();

		for_list_map.put("scategory_no", scategory_no);
		for_list_map.put("search", search);
		for_list_map.put("area", area);
		for_list_map.put("start", start);
		for_list_map.put("end", end);
		
		System.out.println(for_list_map);
		
		/**********************************************************************************************************************/

		// Json형태로 view로 보내주기 위한 map 생성
		HashMap all_map =new HashMap();
		all_map.put("list", s_dao.findAllStudy(for_list_map));

		/**********************************************************************************************************************/

		return all_map;
	}
}
