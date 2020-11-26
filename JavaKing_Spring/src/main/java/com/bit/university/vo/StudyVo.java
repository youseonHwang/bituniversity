package com.bit.university.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudyVo {
	
	private int rn;
	private int study_no;
	private int scategory_no;
	private String scategory_name;
	private String study_title;
	private String study_explain1;
	private String study_explain2;
	private String study_explain3;
	private String study_content;
	private Date study_regdate;
	private int study_person;
	private int study_limit;
	private String study_fname;
	private MultipartFile upload_file;
	private int std_no;
	private int study_apply1;
	private int study_apply2;
	private int study_apply3;
	private int study_apply4;
	private int study_apply5;
	private String study_area;
	
	
	public StudyVo(int study_no, int scategory_no, String study_title, String study_explain1, String study_explain2,
			String study_explain3, String study_content, Date study_regdate, int study_person, int study_limit,
			String study_fname, MultipartFile upload_file, int std_no, int study_apply1, int study_apply2,
			int study_apply3, int study_apply4, int study_apply5, String study_area) {
		super();
		
		this.study_no = study_no;
		this.scategory_no = scategory_no;
		this.study_title = study_title;
		this.study_explain1 = study_explain1;
		this.study_explain2 = study_explain2;
		this.study_explain3 = study_explain3;
		this.study_content = study_content;
		this.study_regdate = study_regdate;
		this.study_person = study_person;
		this.study_limit = study_limit;
		this.study_fname = study_fname;
		this.upload_file = upload_file;
		this.std_no = std_no;
		this.study_apply1 = study_apply1;
		this.study_apply2 = study_apply2;
		this.study_apply3 = study_apply3;
		this.study_apply4 = study_apply4;
		this.study_apply5 = study_apply5;
		this.study_area = study_area;
	}


	public StudyVo(int study_no, int scategory_no, String study_title, String study_explain1, String study_explain2,
			String study_explain3, String study_content, Date study_regdate, int study_person, int study_limit,
			String study_fname, MultipartFile upload_file, int std_no, String study_area) {
		super();
		this.study_no = study_no;
		this.scategory_no = scategory_no;
		this.study_title = study_title;
		this.study_explain1 = study_explain1;
		this.study_explain2 = study_explain2;
		this.study_explain3 = study_explain3;
		this.study_content = study_content;
		this.study_regdate = study_regdate;
		this.study_person = study_person;
		this.study_limit = study_limit;
		this.study_fname = study_fname;
		this.upload_file = upload_file;
		this.std_no = std_no;
		this.study_area = study_area;
	}
	
	
	
	
	
	
	
}
