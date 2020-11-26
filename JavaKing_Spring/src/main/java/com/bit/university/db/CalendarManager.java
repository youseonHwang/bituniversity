package com.bit.university.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.university.vo.CalendarVo;

public class CalendarManager {
	public static SqlSessionFactory sqlSessionFactory;//객체없이 쓰려고 static
	
	static {
		try {
			String resource = "com/bit/university/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("예외발생 : "+e.getMessage());
		}
	}
	
	public static List<CalendarVo> listAll(){
		List<CalendarVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("calendar.selectAll");
		session.close();
		return list;
	}
	
	public static int insert(CalendarVo vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		System.out.println("manager :"+vo);
		re = session.insert("calendar.insert",vo);
		System.out.println("re :"+re);
		session.close();
		return re;
	}
	
	public static int update(CalendarVo vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("calendar.update",vo);
		session.close();
		return re;
	}
	
	public static int delete(int no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("calendar.delete",no);
		session.close();
		return re;
	}
	
	public static int getNextNo() {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("calendar.getNextNo");
		session.close();
		return re;
	}
	
	public static List<CalendarVo> searchList(HashMap map){
		List<CalendarVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("calendar.searchAll",map);
		session.close();
		return list;
	}
	
	public static CalendarVo listOne(int no){
		CalendarVo vo = null;
		SqlSession session = sqlSessionFactory.openSession();
		vo = session.selectOne("calendar.selectOne",no);
		session.close();
		return vo;
	}
}
