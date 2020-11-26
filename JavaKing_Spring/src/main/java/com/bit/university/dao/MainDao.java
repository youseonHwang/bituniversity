package com.bit.university.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.MainManager;
import com.bit.university.vo.BoardVo;

@Repository
public class MainDao {

	public List<BoardVo> getBoardList(String board_category, int board_boardno) {
		return MainManager.getBoardList(board_category, board_boardno);
	}

	public int updatePwd(String new_pwd, String acc_id) {
		return MainManager.updatePwd(new_pwd, acc_id);
	}
	
	public int updateTempPwd(String temp_pwd, String acc_id) {
		return MainManager.updateTempPwd(temp_pwd, acc_id);
	}

	public int isStudentIdTrue(String std_name, String std_email) {
		return MainManager.isStudentIdTrue(std_name, std_email);
	}

	public int isStudentPwdTrue(int std_no, String std_email) {
		return MainManager.isStudentPwdTrue(std_no, std_email);
	}

	public String getStudentId(String std_name, String std_email) {
		return MainManager.getStudentId(std_name, std_email);
	}
	
	public String getMajorName(int major_no) {
		return MainManager.getMajorName(major_no);
	}
	
	public String getFname(String std_fname) {
		return MainManager.getFname(std_fname);
	}
}
