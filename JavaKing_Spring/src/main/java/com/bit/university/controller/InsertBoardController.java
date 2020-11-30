package com.bit.university.controller;

import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.BoardDao;
import com.bit.university.vo.BoardVo;

@Controller
public class InsertBoardController {
	
	@Autowired
	private BoardDao b_dao;
	
	
	@GetMapping("/login/insertBoard.do")
	public ModelAndView insertBoardGet(HttpServletRequest request) throws Throwable {
		
		// 변수 초기화
		int std_no = 0;
		int board_boardno =0;
		String board_category = "공지사항";
		String board_boardname = "알림마당";

		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		/******************************************************************************/
		
		// 하위 게시판 번호를 가져오면 해당 번호로 데이터 변경
		if((request.getParameter("board_boardno"))!=null) {
			board_boardno = Integer.parseInt(request.getParameter("board_boardno"));
			System.out.println("board_boardno는 " + board_boardno);
			session.setAttribute("board_boardno", board_boardno);
		}
		
		switch (board_boardno){
			case 100: board_boardname = "알림마당";break;
			case 200: board_boardname = "도움마당";break;
			case 300: board_boardname = "참여마당";break;
		}
		
		// 로그인 한 사람의 학번 가져오기
		if(session.getAttribute("std_no")!=null) {
			std_no = (int) session.getAttribute("std_no");
		}
		
		mav.addObject("std_no", std_no);
		mav.addObject("board_boardname", board_boardname);
		mav.addObject("category_list", b_dao.getBoardCategory(board_boardno));
		return mav;
	}
	
	@RequestMapping(value ="/login/insertBoard", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public int insertBoardPost(BoardVo b_vo, HttpServletRequest request) {
		
		// 다음 글 번호를 반환하는 변수 no
		int no = (int)(b_dao.getNextNo());
		b_vo.setBoard_no(no);
		/******************************************************************************/
		
		// 파일 처리
		String path = request.getRealPath("image");
		
		String board_fname ="";
		
		System.out.println(path);
		if(b_vo.getUpload_file() != null) {
			String fname = b_vo.getUpload_file().getOriginalFilename();
			board_fname = fname.substring(fname.lastIndexOf("\\")+1);
		
		
			if(board_fname != null && !board_fname.equals("")) {
		         try {
		            byte[] data = b_vo.getUpload_file().getBytes();
		            FileOutputStream fos = new FileOutputStream(path+"/"+board_fname);
		            fos.write(data);
		            fos.close();
		         }catch (Exception e) {
		            System.out.println("예외발생s : " + e.getMessage());
		         }
		      }
		}
		b_vo.setBoard_fname(board_fname);
		
		/******************************************************************************/
		int re =b_dao.insertBoard(b_vo);
		
		
		return re;
	}
}
