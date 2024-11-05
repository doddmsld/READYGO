package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.LanguageVO;

public interface JobToolsService {
	
	//변환 점수 불러오기
	List<LanguageVO> getScore(Map<String, Object> map);

}
