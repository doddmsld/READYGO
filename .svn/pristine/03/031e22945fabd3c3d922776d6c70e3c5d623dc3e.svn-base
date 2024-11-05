package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.CalendarMapper;
import kr.or.ddit.service.CalendarService;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.ScrapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	CalendarMapper calendarMapper;
	
	//스크랩 목록
	@Override
	public List<PbancVO> scrapList(Map<String, Object> map) {
		return calendarMapper.scrapList(map);
	}
	
	//캘린더 표시정보(스크랩)
	@Override
	public List<PbancVO> calendarList(String mbrId) {
		return calendarMapper.calendarList(mbrId);
	}
	
	//일정 목록
	@Override
	public List<ScheduleVO> scheduleList(Map<String, Object> map) {
		return calendarMapper.scheduleList(map);
	}
	
	//캘린더 표시정보(일정)
	@Override
	public List<ScheduleVO> calendarList2(String mbrId) {
		return calendarMapper.calendarList2(mbrId);
	}
	
	//일정 등록
	@Override
	public int scheduleInsert(Map<String, Object> map) {
		return calendarMapper.scheduleInsert(map);
	}
	//일정 삭제
	@Override
	public int deleteEvent(Map<String, Object> map) {
		return calendarMapper.deleteEvent(map);
	}
	
	


}
