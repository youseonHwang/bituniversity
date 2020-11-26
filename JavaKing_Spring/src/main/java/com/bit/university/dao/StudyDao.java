package com.bit.university.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.StudyManager;
import com.bit.university.vo.StudyVo;

@Repository
public class StudyDao {
	
	
	public int updateStudy(StudyVo s_vo) {
		return StudyManager.updateStudy(s_vo);
	}
	
	public int deleteStudy(int study_no) {
		return StudyManager.deleteStudy(study_no);
	}
	
	public StudyVo getOneStudy(int study_no) {
		return StudyManager.getOneStudy(study_no);
	}
	
	public List<StudyVo> findAllStudy(HashMap map){
		return StudyManager.findAllStudy(map);
	}
	
	public int getNextStudyNo() {
		return StudyManager.getNextStudyNo();
	}
	
	public int insertStudy(StudyVo s_vo) {
		return StudyManager.insertStudy(s_vo);
	}
	
	public List<StudyVo> getScategoryList() {
		return StudyManager.getScategoryList();
	}
	
	public int updateApply(StudyVo s_vo) {
		return StudyManager.updateApply(s_vo);
	}

	public int getTotalCount(HashMap for_count_map) {
		return StudyManager.getTotalCount(for_count_map);
	}

}
