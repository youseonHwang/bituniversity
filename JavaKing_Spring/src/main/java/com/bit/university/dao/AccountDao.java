package com.bit.university.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.AccountManager;
import com.bit.university.vo.AccountVo;

@Repository
public class AccountDao {
	public List<AccountVo> getAccountList(String acc_id) {
		return AccountManager.getAccountList(acc_id);
	}

	public AccountVo getAccount(String acc_id) {
		return AccountManager.getAccount(acc_id);
	}

	public int insertStudentAccount(AccountVo vo) {
		return AccountManager.insertStudentAccount(vo);
	}

	public int insertAdminAccount(AccountVo vo) {
		return AccountManager.insertAdminAccount(vo);
	}
	
	public String getAccountId (int std_no) {
		return AccountManager.getAccountId(std_no);
	}
	
	public int getLastAccountNo () {
		return AccountManager.getLastAccountNo();
	}
}
