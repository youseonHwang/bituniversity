package com.bit.university.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit.university.db.CalendarManager;
import com.bit.university.vo.CalendarVo;

@Repository
public class CalendarDao {
	public List<CalendarVo> listAll(){
		return CalendarManager.listAll();
	}
	
	public int insert(CalendarVo vo) {
		return CalendarManager.insert(vo);
	}
	
	public int update(CalendarVo vo) {
		return CalendarManager.update(vo);
	}
	
	public int delete(int no) {
		return CalendarManager.delete(no);
	}
	
	public int getNextNo() {
		return CalendarManager.getNextNo();
	}
	
	public List<CalendarVo> searchList(HashMap map){
		return CalendarManager.searchList(map);
	}
	public CalendarVo listOne(int no){
		return CalendarManager.listOne(no);
	}
}
