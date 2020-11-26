package com.bit.university.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.university.dao.BoardDao;
import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.BoardVo;
import com.bit.university.vo.ReplyVo;

@Controller
public class DeleteBoardController {

	@Autowired
	private BoardDao b_dao;
	
	@Autowired
	private ReplyDao r_dao;
	
	
	@GetMapping("/login/deleteBoard")
	@ResponseBody
	public int deleteBoard(HttpServletRequest request) throws Throwable {
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		System.out.println(board_no);
		BoardVo b_vo=b_dao.getBoard(board_no);
		System.out.println(b_vo);
		
		// --------------------------------------------------------------------------------------------------
		
		List<ReplyVo> r_list = r_dao.listReply(board_no);
			 
		for (ReplyVo r : r_list) {
				int reply_no = r.getReply_no();
				r_dao.deleteReply(reply_no);
		}

		
		String path = request.getRealPath("image");
		
		int re =b_dao.deleteBoard(board_no);
		
		if(re<=0) {
		} else {
			if( b_vo.getBoard_fname()!=null  && !b_vo.getBoard_fname().equals("") ) {
				File file = new File(path + "/" +b_vo.getBoard_fname());
				file.delete();
			}
		}
		return re;
		
	}
	
}
