package com.bit.university.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.university.vo.BoardVo;
import com.bit.university.vo.StudyVo;

public class StudyManager {

	public static SqlSessionFactory sqlSessionFactory;

	static {
		String resource = "com/bit/university/db/sqlMapConfig.xml";
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			System.out.print("���ܹ߻�:" + e.getMessage());
		}
	}

	public static int updateStudy(StudyVo s_vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("study.updateStudy", s_vo);
		session.close();
		return re;
	}
	
	public static int getTotalCount(HashMap for_count_map) {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("study.getTotalCount", for_count_map);
		session.close();
		return n;
	}
	
	public static int deleteStudy(int study_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("study.deleteStudy", study_no);
		session.close();
		return re;
	}
	
	public static StudyVo getOneStudy(int study_no) {
		StudyVo s_vo = null;
		SqlSession session = sqlSessionFactory.openSession();
		s_vo = session.selectOne("study.getOneStudy", study_no);
		session.close();
		return s_vo; 
	}
	
	public static List<StudyVo> findAllStudy(HashMap map) {
		List<StudyVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("study.findAllStudy", map);
		return list;
	}
	
	
	public static int getNextStudyNo() {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("study.getNextStudyNo");
		session.close();
		return n;
	}
	
	public static int insertStudy(StudyVo s_vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("study.insertStudy", s_vo);
		session.close();
		return re;
	}
	
	public static List<StudyVo> getScategoryList() {
		List<StudyVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("study.getScategoryList");
		session.close();
		return list;
	}

	public static int updateApply(StudyVo s_vo) {
		int ret = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		ret = session.update("study.updateStudyApply", s_vo);
		session.close();
		return ret;
	}


	

}
