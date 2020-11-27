package com.bit.university.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.ReplyVo;


@Controller
public class UpdateReplyController {

	@Autowired
	private ReplyDao r_dao;
	
	@PostMapping("/login/updateReply")
	@ResponseBody
	public int udpateReply(HttpServletRequest request, ReplyVo r_vo) throws Throwable {

		int re = r_dao.updateReply(r_vo.getReply_content(), r_vo.getReply_no());

		return re;
	}
}
