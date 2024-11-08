package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.PbancMapper;
import kr.or.ddit.service.PbancService;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.PbancVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PbancServiceImpl implements PbancService{
	@Autowired
	PbancMapper pbancMapper;

	@Override
	public List<PbancVO> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.pbancMapper.list(map);
	}

	@Override
	public int getTotal(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return this.pbancMapper.getTotal(map);
	}
	// 기업 현재 채용중인 공고 리스트
	@Override
	public List<PbancVO> getPbancList(String entId) {
		return this.pbancMapper.getPbancList(entId);
	}
	
	//지역 리스트
	@Override
	public List<CodeVO> regionList() {
		return this.pbancMapper.regionList();
	}

	@Override
	public List<CodeVO> cityList(String comCode) {
		return this.pbancMapper.cityList(comCode);
	}

	@Override
	public List<CodeVO> jobList() {
		return this.pbancMapper.jobList();
	}


}
