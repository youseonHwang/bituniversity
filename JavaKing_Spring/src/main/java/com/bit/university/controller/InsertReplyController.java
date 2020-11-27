package com.bit.university.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.ReplyVo;

@Controller
public class InsertReplyController {
	
	@Autowired
	private ReplyDao r_dao;
	
	
	@PostMapping("/login/insertReply")
	public int insertReply(HttpServletRequest request,ReplyVo r_vo) throws Throwable {
		
		
		int reply_no = r_dao.getNextReplyNo();
		r_vo.setReply_no(reply_no);
		
		int re = r_dao.insertReply(r_vo);
		

		return re;
	}
}
