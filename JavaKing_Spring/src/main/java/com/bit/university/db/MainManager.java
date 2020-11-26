package com.bit.university.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;

import com.bit.university.vo.BoardVo;

public class MainManager {

	public static SqlSessionFactory sqlSessionFactory;

	static {
		String resource = "com/bit/university/db/sqlMapConfig.xml";
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			System.out.print("예외발생:" + e.getMessage());
		}
	}

	public static List<BoardVo> getBoardList(String board_category, int board_boardno) {
		List<BoardVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("board_category", board_category);
		map.put("board_boardno", board_boardno);
		list = session.selectList("main.getBoardList", map);
		session.close();
		return list;
	}

	public static int updatePwd(String new_pwd, String acc_id) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		HashMap map = new HashMap();
		map.put("new_pwd", new_pwd);
		map.put("acc_id", acc_id);
		re = session.update("main.updatePwd", map);
		return re;
	}
	
	public static int updateTempPwd(String temp_pwd, String acc_id) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		HashMap map = new HashMap();
		map.put("temp_pwd", temp_pwd);
		map.put("acc_id", acc_id);
		re = session.update("main.updateTempPwd", map);
		return re;
	}

	public static int isStudentIdTrue(String std_name, String std_email) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("std_name", std_name);
		map.put("std_email", std_email);
		if (session.selectOne("main.isStudentIdTrue", map) != null) {
			re = session.selectOne("main.isStudentIdTrue", map);
		}
		return re;
	}

	public static int isStudentPwdTrue(int std_no, String std_email) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("std_no", std_no);
		map.put("std_email", std_email);
		if (session.selectOne("main.isStudentPwdTrue", map) != null) {
			re = session.selectOne("main.isStudentPwdTrue", map);
		}
		return re;
	}
	
	public static String getStudentId(String std_name, String std_email) {
		String re = "";
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("std_name", std_name);
		map.put("std_email", std_email);
		if (session.selectOne("main.getStudentId", map) != null) {
			re = session.selectOne("main.getStudentId", map);
		}
		return re;
	}
	public static String getMajorName(int major_no) {
		String re = "";
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("major_no", major_no);
		if (session.selectOne("main.getMajorName", map) != null) {
			re = session.selectOne("main.getMajorName", map);
		}
		return re;
	}
	
	public static String getFname(String std_fname) {
		String re = "";
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("std_fname", std_fname);
		re = session.selectOne("main.getFname", map);
		return re;
	}
}
