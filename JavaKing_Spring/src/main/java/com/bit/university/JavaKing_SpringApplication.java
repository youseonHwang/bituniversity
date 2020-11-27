package com.bit.university;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.bit.university.db.AccountManager;
import com.bit.university.vo.AccountVo;

@SpringBootApplication
public class JavaKing_SpringApplication {

	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	public static void main(String[] args) {
		SpringApplication.run(JavaKing_SpringApplication.class, args);
//		AccountManager.insertAdminAccount(new AccountVo(ACC_NO,"ACC_ID",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("ACC_PWD"),"ACC_ROLE"));
	
	}
}
