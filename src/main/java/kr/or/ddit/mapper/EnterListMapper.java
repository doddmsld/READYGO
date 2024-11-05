package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.EnterVO;

public interface EnterListMapper {
	
	//공고목록
	public List<EnterVO> list(Map<String, Object> map);
	
	//전체 행의 수
	public int getTotal(Map<String, Object> map);



}
