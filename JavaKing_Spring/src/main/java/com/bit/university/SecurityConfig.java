package com.bit.university;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	public void configure(WebSecurity web) throws Exception {
		// static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
		web.ignoring().antMatchers("ajax/**","css/**","image/**","img/**","include/**","js/**","scss/**","svg/**","vendor/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.mvcMatchers("/").permitAll()
			.mvcMatchers("/admin/**").hasRole("ADMIN")
			.mvcMatchers("/login/**").authenticated();
		
		http.formLogin().loginPage("/login.do").permitAll()
			.usernameParameter("acc_id")
			.passwordParameter("acc_pwd")
			.successHandler(new SuccessHandler())
			.failureHandler(new FailureHandler());
			
		http.logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout.do"))
			.logoutSuccessHandler(new HLogoutSuccessHandler())
			.invalidateHttpSession(false);
//			.logoutSuccessUrl("/login.do");
//			.and()
//			// 403 예외처리 핸들링
//			.exceptionHandling().accessDeniedPage("/denied");
	
		http.httpBasic();
	}
}
