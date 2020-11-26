package com.bit.university.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.bit.university.db.AccountManager;
import com.bit.university.vo.AccountVo;

@Service
public class LoginService implements UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String acc_id) throws UsernameNotFoundException {
		AccountVo vo = null;
		vo = AccountManager.getAccount(acc_id);
		if (vo == null) {
			throw new UsernameNotFoundException(acc_id);
		}
		return User.builder().username(acc_id).password(vo.getAcc_pwd()).roles(vo.getAcc_role()).build();
	}

}
