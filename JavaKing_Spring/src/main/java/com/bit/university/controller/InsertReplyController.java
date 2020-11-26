package com.bit.university.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.BoardDao;
import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.BoardVo;
import com.bit.university.vo.ReplyVo;

@Controller
public class InsertReplyController {
	
	@Autowired
	private BoardDao b_dao;
	private ReplyDao r_dao;
	
	public void setBoardDao(BoardDao b_dao) {
		this.b_dao = b_dao;
	}
	
	public void setReplyDao(ReplyDao r_dao) {
		this.r_dao = r_dao;
	}
	
	@PostMapping("/login/insertReply")
	public int insertReply(HttpServletRequest request,ReplyVo r_vo) throws Throwable {
		
		b_dao = new BoardDao();
		r_dao = new ReplyDao();
		
		int board_no= r_vo.getBoard_no();
		
		int reply_no = r_dao.getNextReplyNo();
		r_vo.setReply_no(reply_no);
		
		int re = r_dao.insertReply(r_vo);
		System.out.println(r_vo.getBoard_no()+"/"+r_vo.getReply_content()+"/"+r_vo.getReply_no()+"/"+r_vo.getStd_no()+"/"+r_vo.getReply_regdate());
		

		return re;
	}
}
