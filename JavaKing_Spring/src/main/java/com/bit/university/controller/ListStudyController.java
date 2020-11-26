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
	
	
	
	/**********************************************************************
	 *  ó�� ���͵� �Խ����� Ŭ������ ����
	 *  ���͵� ī�װ� �޴��� ������ ��� �ش��ϴ� �˻� ���� ��� 
	 * *********************************************************************/
 
	@GetMapping("/login/listStudy.do")
	public void listStudyView(HttpServletRequest request) throws Throwable {

		int scategory_no = 0;

		HttpSession session = request.getSession();

		int std_no=0;

		if(session.getAttribute("std_no") != null) {
			std_no = (int) session.getAttribute("std_no");
		} else {
			std_no = 2014104199;
		}
		request.setAttribute("std_no", std_no);

		//-------------------------------------------------------------------
		if(request.getParameter("scategory_no")!=null) { //ī�װ� �޴� ��ư�� ������ ��쿡
			scategory_no = Integer.parseInt(request.getParameter("scategory_no"));
		}
		request.setAttribute("scategory_no", scategory_no);
	}


	/**********************************************************************
	 *  ajax�� ���ؼ� �˻�� �ְų�
	 *  more ��ư�� ������ ��� ���� ��Ʈ�ѷ�
	 * *********************************************************************/
	@GetMapping("/login/listStudy")
	@ResponseBody
	public HashMap listStudyGet(HttpServletRequest request, int scategory_no, 
			String search, String area, int page_num)
					throws Throwable {
		
		HttpSession session = request.getSession();
		
		System.out.println(scategory_no+"::::::scategory_no");
		System.out.println(search+"::::::search");
		System.out.println(area+"::::::area");
		
		// more��ư Ŭ���� �˻��� ����
		if(search == null && !search.equals("")) {
			session.setAttribute("search", search);
		}
		
		if(session.getAttribute("search")!=null && search == null) {
			search = (String) session.getAttribute("search");
		}
		
		// more��ư Ŭ���� ī�װ� �ѹ� ����
		if(scategory_no == 0) {
			session.setAttribute("search", search);
		}
		
		if(session.getAttribute("scategory_no")!=null) {
			scategory_no = (int) session.getAttribute("scategory_no");
		}
		
		// more��ư Ŭ���� ī�װ� �ѹ� ����
		if(area !=null && !area.equals("")) {
			session.setAttribute("area", area);
		}

		if(session.getAttribute("area")!=null && area==null) {
			area = (String) session.getAttribute("area");
		}


		// count�� ���� ���� DAO�� ���� map����---------------------------------------------------------------
		HashMap for_count_map = new HashMap();

		for_count_map.put("scategory_no", scategory_no);
		for_count_map.put("search", search);
		for_count_map.put("area", area);
		//-------------------------------------------------------------------------------------------

		System.out.println(for_count_map);
		/***************read more ��ư �κ� ����**********************/

		int page_size = 10;
		int study_count = s_dao.getTotalCount(for_count_map);
		
		int start = (page_num-1)*page_size+1;
		int end = start+page_size-1;
		if(end > study_count) {
			end = study_count;
		}   

		/***************read more ��ư �κ� ����**********************/

		//table�� ���� �Խù� list�� ���� map����---------------------------------------------------------------
		HashMap for_list_map = new HashMap();

		for_list_map.put("scategory_no", scategory_no);
		for_list_map.put("search", search);
		for_list_map.put("area", area);
		for_list_map.put("start", start);
		for_list_map.put("end", end);
		
		System.out.println(for_list_map);
		//-------------------------------------------------------------------------------------------


		HashMap all_map =new HashMap();
		all_map.put("list", s_dao.findAllStudy(for_list_map));

		System.out.println(s_dao.findAllStudy(for_list_map));

		return all_map;
	}
}
