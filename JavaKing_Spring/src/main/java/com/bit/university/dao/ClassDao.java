package com.bit.university.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.ClassManager;
import com.bit.university.db.ClassregManager;
import com.bit.university.vo.ClassVo;
import com.bit.university.vo.ClassregVo;

@Repository
public class ClassDao {

	public List<ClassVo> classList(HashMap map){
		return ClassManager.classList(map);
	}
	
	//**학사정보 필수교과 이수여부
	public List<ClassVo> detailClassGetReq(int std_no) {
		return ClassManager.detailClassGetReq(std_no);
	}
	
	public List<ClassVo> findByColNo(int colNo){
		return ClassManager.findByColNo(colNo);
	}
	
	public int classTotalRecord(HashMap map) {
		return ClassManager.classTotalRecord(map);
	}
	
	public ClassVo classFindByNo(int class_no) {
		return ClassManager.classFindByNo(class_no);
	}
	
	public int classInsert(ClassVo c_vo) {
		return ClassManager.classInsert(c_vo);
	}
	
	public int classUpdate(ClassVo c_vo) {
		return ClassManager.classUpdate(c_vo);
	}
	
	public int classDelete(int class_no) {
		return ClassManager.classDelete(class_no);
	}
		
	public int classNextNo() {
		return ClassManager.classNextNo();
	}
	
	/********************** 수강인원증가 ************************/
	public int addNowCnt(int class_no) {
		ClassVo c= classFindByNo(class_no);
		int max = c.getClass_max();
		int nowcnt = c.getClass_nowcnt();
		System.out.println("======== nowcnt / max  "+nowcnt+" / "+max);
		
		if(nowcnt < max) {
			int re = ClassManager.addNowCnt(class_no); //성공 1 실패 -1
			 return re;
		}else {
			return -1;
		}
	}
	/********************** 수강인원감소 ************************/
	public int subNowCnt(int class_no) {
		ClassVo c= classFindByNo(class_no);
		return ClassManager.subNowCnt(class_no); //성공 1 실패 -1
		
	}
}
