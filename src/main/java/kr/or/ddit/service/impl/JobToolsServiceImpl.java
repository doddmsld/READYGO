package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.JobToolsMapper;
import kr.or.ddit.service.JobToolsService;
import kr.or.ddit.vo.LanguageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JobToolsServiceImpl implements JobToolsService {
	
	@Autowired
	private JobToolsMapper jobToolsMapper;

	//변환 점수 불러오기
	@Override
	public List<LanguageVO> getScore(Map<String, Object> map) {
		return this.jobToolsMapper.getScore(map);
	}
	
}
