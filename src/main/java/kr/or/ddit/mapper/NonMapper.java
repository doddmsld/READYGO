package kr.or.ddit.mapper;

import java.util.Map;

import kr.or.ddit.vo.EnterVO;

public interface NonMapper {

	EnterVO enterSearch(Map<String, Object> map);

	void updateMem(Map<String, Object> map);

	void roleMem(Map<String, Object> map);

	void deleteEntmem(Map<String, Object> map);
	
}