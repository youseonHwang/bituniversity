package com.bit.university.controller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.BoardDao;
import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.BoardVo;

@Controller
public class UpdateBoardController {
	
	@Autowired
	private BoardDao b_dao;
	
	
	@GetMapping("/login/updateBoard.do")
	public ModelAndView updateBoardView(HttpServletRequest request) throws Throwable {
		ModelAndView mav = new ModelAndView();
		b_dao = new BoardDao();
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		
		//가져온 글 번호로 board vo 생성
		BoardVo b_vo = b_dao.getBoard(board_no);
		
		int board_boardno= b_vo.getBoard_boardno();
		String board_boardname ="";
		switch (board_boardno) {
			case 100: board_boardname = "알림마당"; break;
			case 200: board_boardname = "도움마당"; break;
			case 300: board_boardname = "참여마당"; break;
		}
		
		mav.addObject("board_boardname", board_boardname);
		mav.addObject("b_vo", b_dao.getBoard(board_no));
		mav.addObject("category_list", b_dao.getBoardCategory(b_vo.getBoard_boardno()));
		
		return mav;
	
	}
	
	@PostMapping("/login/updateBoard")
	@ResponseBody
	public int updateBoardPost(BoardVo b_vo, HttpServletRequest request) throws Throwable {
		System.out.println(b_vo.toString());
		
		//-----------------------------------------------------------------------
		
		System.out.println("b_vo.boardcategory::::::::" +b_vo.getBoard_category());
		System.out.println(b_vo.getBoard_no()+"/"+ b_vo.getBoard_boardno()+"/"+b_vo.getBoard_content()+"/"+b_vo.getBoard_title()
		+"/"+b_vo.getBoard_pwd());
		String path = request.getRealPath("image");
		System.out.println(path);
		
		String old_fname = b_vo.getBoard_fname();
		
		String fname = (b_vo.getUpload_file()).getOriginalFilename();
		String board_fname = fname.substring(fname.lastIndexOf("\\")+1);
		
		 if(board_fname != null && !board_fname.equals("")) {
	         try {
	            byte[] data = (b_vo.getUpload_file()).getBytes();
	            FileOutputStream fos = new FileOutputStream(path+"/"+board_fname);
	            fos.write(data);
	            fos.close();
	         }catch (Exception e) {
	            System.out.println("예외발생s : " + e.getMessage());
	         }
	         b_vo.setBoard_fname(board_fname);
	      } else{
	    	  b_vo.setBoard_fname(old_fname);
	      }
		 
		 
		int re =b_dao.updateBoard(b_vo);

		if(re<=0) {
			
		} else {
			if( old_fname != null && !old_fname.equals("") && !board_fname.equals("")) {
				File file = new File(path + "/" +old_fname);
				file.delete();
			}
		}

		return re;
		
		
	}

	
	
	
}
