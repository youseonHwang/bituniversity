package com.bit.university.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClassVo {

	private int class_no;
	private String class_name;
	private Date class_startdate;
	private Date class_enddate;
	private String class_dayofweek;
	private String class_time;
	private String class_room;
	private int class_credit;
	private int class_type;
	private int pro_no;
	private int class_level;
	private int college_no;
	private int class_max;
	private int class_nowcnt;
	
	private int rn;
	private String pro_name;
	private String college_name;
}
