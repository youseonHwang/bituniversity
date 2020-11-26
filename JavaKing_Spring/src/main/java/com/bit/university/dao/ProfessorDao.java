package com.bit.university.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.ProfessorManager;
import com.bit.university.vo.ProfessorVo;



@Repository
public class ProfessorDao {

	public List<ProfessorVo> professorList(){
		return ProfessorManager.professorList();
	}
	public List<ProfessorVo> findByType(String pro_type){
		return ProfessorManager.findByType(pro_type);
	}
	
	public int ProfessorInsert(ProfessorVo p) {
		return ProfessorManager.ProfessorInsert(p);
	}
	public ProfessorVo findByNo (int pro_no) {
		return ProfessorManager.findByNo(pro_no);
	}
}
