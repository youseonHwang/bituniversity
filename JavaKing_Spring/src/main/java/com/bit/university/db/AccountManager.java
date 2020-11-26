package com.bit.university.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.university.vo.AccountVo;

public class AccountManager {

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

	public static List<AccountVo> getAccountList(String acc_id) {
		List<AccountVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("acc_id", acc_id);
		list = session.selectList("account.getAccountList", map);
		session.close();
		return list;
	}

	public static AccountVo getAccount(String acc_id) {
		AccountVo vo = null;
		SqlSession session = sqlSessionFactory.openSession();
		HashMap map = new HashMap();
		map.put("acc_id", acc_id);
		vo = session.selectOne("account.getAccount", map);
		session.close();
		return vo;
	}

	public static int insertStudentAccount(AccountVo vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("account.insertStudentAccount", vo);
		session.close();
		return re;

	}

	public static int insertAdminAccount(AccountVo vo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("account.insertAdminAccount", vo);
		session.close();
		return re;

	}

	public static String getAccountId(int std_no) {
		String re = "";
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("account.getAccountId", std_no);
		session.close();
		return re;
	}

	public static int getLastAccountNo() {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("account.getLastAccountNo");
		session.close();
		return re;
	}

}
