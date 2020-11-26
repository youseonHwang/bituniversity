package com.bit.university.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.university.dao.BoardDao;
import com.bit.university.dao.ReplyDao;
import com.bit.university.vo.BoardVo;

@Controller
public class DetailBoardController {

	@Autowired
	private BoardDao b_dao;
	@Autowired
	private ReplyDao r_dao;
	
	@GetMapping("/login/detailBoard.do")
	public void detailBoardView(HttpServletRequest request,Model model) throws Throwable {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		model.addAttribute("board_no", board_no);
	}
	
	@GetMapping("/login/detailBoard")
	@ResponseBody
	public HashMap detailBoardGet(HttpServletRequest request, int board_no) throws Throwable {
		
		System.out.println(board_no);
		
		//json형태로 반환해줄 hashmap생성
		HashMap map_all = new HashMap();
		
		/**************************************************************/
		// 추후에 수정,삭제 버튼이 보일지 확인할 용도 std_no 세션에서 받아오기
		HttpSession session = request.getSession();
		int std_no = (int) session.getAttribute("std_no");
			
		/**************************************************************/
		
		// 조회수 증가
		int hit_re = b_dao.increaseHit(board_no);
		
		// 게시글 번호에 해당하는 게시글 정보 가져오기
		BoardVo b_vo = b_dao.getBoard(board_no);
		System.out.println(b_vo);
		/**************************************************************/
		
		//게시판 대분류를 뷰에 표시하기 위해서 번호를 가져와서 확인하기
		int board_boardno= b_vo.getBoard_boardno();
		String board_boardname ="";
		switch (board_boardno) {
			case 100: board_boardname = "알림마당"; break;
			case 200: board_boardname = "도움마당"; break;
			case 300: board_boardname = "참여마당"; break;
		}
		
		/**************************************************************/
		
		// 다음글, 이전글 번호 생성하기
		List<HashMap<String, Integer>> for_board_no_list =  b_dao.getNextOrBeforeNo(board_no);
		HashMap<String, Integer> for_b_map = new HashMap<String, Integer>();
		for_b_map = for_board_no_list.get(0);
		
		int next_board_no = Integer.parseInt(String.valueOf(for_b_map.get("NEXT_BOARD_NO")+""));
		int before_board_no = Integer.parseInt(String.valueOf(for_b_map.get("BEFORE_BOARD_NO")+""));
		/**************************************************************/
		// 제이슨 형태로 view에 보내줄 데이터들 모두 map_all에 담기
		map_all.put("std_no", std_no);
		map_all.put("board_boardname", board_boardname);
		map_all.put("reply_count", r_dao.getTotalReply(board_no));
		map_all.put("b_vo", b_vo);
		map_all.put("r_list", r_dao.listReply(board_no));
		map_all.put("next_board_no", next_board_no);
		map_all.put("before_board_no", before_board_no);
		
		return map_all;
	}
	
}
