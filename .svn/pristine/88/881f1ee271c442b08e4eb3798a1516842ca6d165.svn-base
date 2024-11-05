package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.MemAplctMapper;
import kr.or.ddit.mapper.MemProposalMapper;
import kr.or.ddit.service.MemAplctService;
import kr.or.ddit.service.MemProposalService;
import kr.or.ddit.vo.ApplicantVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.ProposalVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemProposalServiceImpl implements MemProposalService {
    
    @Inject
    MemProposalMapper memProposalMapper;

    // 받은 제안 목록 조회
	@Override
	public List<ProposalVO> memProList(Map<String, Object> map) {
		return this.memProposalMapper.memProList(map);
	}
	
	// 받은 제안 전체 행의 수 조회
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memProposalMapper.getTotal(map);
	}
    
    


}
