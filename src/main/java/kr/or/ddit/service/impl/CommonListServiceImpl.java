package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.CommonListMapper;
import kr.or.ddit.service.CommonListService;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.PbancVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommonListServiceImpl implements CommonListService{
	
	@Autowired
	CommonListMapper commonListMapper;
	
	//*** 채용정보 리스트
	@Override
	public List<PbancVO> pbancList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.commonListMapper.pbancList(map);
	}
	
	//*** 기업정보 리스트
	@Override
	public List<EnterVO> enterList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.commonListMapper.enterList(map);
	}
	
	//*** 채용정보 총 행 갯수
	@Override
	public int getPbancTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.commonListMapper.getPbancTotal(map);
	}
	
	//*** 기업정보 총 행 갯수
	@Override
	public int getEnterTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.commonListMapper.getEnterTotal(map);
	}

}
