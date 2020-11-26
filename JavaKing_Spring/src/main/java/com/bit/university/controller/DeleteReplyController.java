package com.bit.university.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.ReplyDao;

@Controller
public class DeleteReplyController {

	@Autowired
	private ReplyDao r_dao;
	
	
	@GetMapping("/login/deleteReply")
	@ResponseBody
	public int deleteReply(int reply_no) {
		
		r_dao = new ReplyDao();
		int re = r_dao.deleteReply(reply_no);

		return re;
	}
}

