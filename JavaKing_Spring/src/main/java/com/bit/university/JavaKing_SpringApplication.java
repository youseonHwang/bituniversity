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
//		AccountManager.insertAdminAccount(new AccountVo(1,"admin",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("admin"),"ADMIN"));
//		AccountManager.insertStudentAccount(new AccountVo(2,"2014104194",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm0"),"STUDENT",2014104194));
//		AccountManager.insertStudentAccount(new AccountVo(3,"2014104195",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm1"),"STUDENT",2014104195));
//		AccountManager.insertStudentAccount(new AccountVo(4,"2014104196",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm2"),"STUDENT",2014104196));
//		AccountManager.insertStudentAccount(new AccountVo(5,"2014104197",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm3"),"STUDENT",2014104197));
//		AccountManager.insertStudentAccount(new AccountVo(6,"2014104198",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm4"),"STUDENT",2014104198));
//		AccountManager.insertStudentAccount(new AccountVo(7,"2014104199",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm5"),"STUDENT",2014104199));
//		AccountManager.insertStudentAccount(new AccountVo(8,"2014104200",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm6"),"STUDENT",2014104200));
//		AccountManager.insertStudentAccount(new AccountVo(9,"2014104201",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm7"),"STUDENT",2014104201));
//		AccountManager.insertStudentAccount(new AccountVo(10,"2014104202",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm8"),"STUDENT",2014104202));
//		AccountManager.insertStudentAccount(new AccountVo(11,"2014104203",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("qlxm9"),"STUDENT",2014104203));
//		AccountManager.insertStudentAccount(new AccountVo(12,"1",PasswordEncoderFactories.createDelegatingPasswordEncoder().encode("1"),"STUDENT",2022123412));
//		System.out.println("데이터 추가");
	}

}
