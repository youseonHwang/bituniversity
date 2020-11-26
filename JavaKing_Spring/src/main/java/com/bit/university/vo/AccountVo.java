package com.bit.university.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountVo {
	private int acc_no;
	private String acc_id;
	private String acc_pwd;
	private String acc_role;
	private int std_no;
	
	public AccountVo(int acc_no, String acc_id, String acc_pwd, String acc_role) {
		super();
		this.acc_no = acc_no;
		this.acc_id = acc_id;
		this.acc_pwd = acc_pwd;
		this.acc_role = acc_role;
	}
}
