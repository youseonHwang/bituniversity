package com.bit.university.db;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.university.vo.ChangeVo;

public class ChangeManager {
	
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

	public static List<ChangeVo> getChange(int std_no) {
		List<ChangeVo> cv = null;
		SqlSession session = sqlSessionFactory.openSession();
		cv = session.selectList("change.getChange", std_no);
		return cv;
	}
	
	public static int insert(ChangeVo cd) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("change.insert", cd);
		return re;
	}
	
	public static int nextNum() {
		int re = -1;
		SqlSession session =sqlSessionFactory.openSession();
		re = session.selectOne("change.nextNum");
		return re;
	}
}
