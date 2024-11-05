package kr.or.ddit.oustou.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.OutsouMainMapper;
import kr.or.ddit.oustou.controller.OutsouController;
import kr.or.ddit.oustou.service.OutsouMainService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.OutsouVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OutsouMainServiceImpl implements OutsouMainService {
	
	@Inject
	OutsouMainMapper outsouMainMapper;
	
	//서비스 게시판 번호를 가져오기 위함
	@Autowired
	OutsouController outsouController; 
	
	//파일 처리를 위한 
	@Autowired
	UploadController uploadController;

	
	/* 메인 */
	@Override	//조회수가 많은 카테고리 5개 
	public List<OutsouVO> getCategory(){
		return this.outsouMainMapper.getCategory();
	}
	
	@Override	//메인 새로운 게시글 5개 
	public List<OutsouVO> getnewList(){
		return this.outsouMainMapper.getnewList();
	}
	
	@Override	// 조회수 높은거 5개 
	public List<OutsouVO> getBestList(){
		return this.outsouMainMapper.getBestList();
	}
	
	
	/* 카테고리별 화면 */
	// 웹
	@Override	
	public List<OutsouVO> getWebList(Map<String, Object> map) {
		return this.outsouMainMapper.getWebList(map);
	}
	@Override	
	public int getWebTotal(Map<String, Object> map) {
		return this.outsouMainMapper.getWebTotal(map);
	}

	//프로그램
	@Override	// 카테고리별 목록 + 페이지네이션
	public List<OutsouVO> getPGList(Map<String, Object> map) {
		return this.outsouMainMapper.getPGList(map);
	}
	@Override	// 총 글의 갯수
	public int getPGTotal(Map<String, Object> map) {
		return this.outsouMainMapper.getPGTotal(map);
	}
	//데이터
	@Override	// 카테고리별 목록 + 페이지네이션
	public List<OutsouVO> getDataList(Map<String, Object> map) {
		return this.outsouMainMapper.getDataList(map);
	}
	@Override	// 총 글의 갯수
	public int getDataTotal(Map<String, Object> map) {
		return this.outsouMainMapper.getDataTotal(map);
	}
	//AI
	@Override	// 카테고리별 목록 + 페이지네이션
	public List<OutsouVO> getAIList(Map<String, Object> map) {
		return this.outsouMainMapper.getAIList(map);
	}
	@Override	// 총 글의 갯수
	public int getAITotal(Map<String, Object> map) {
		return this.outsouMainMapper.getAITotal(map);
	}
	//직무직군
	@Override	// 카테고리별 목록 + 페이지네이션
	public List<OutsouVO> getJobList(Map<String, Object> map) {
		return this.outsouMainMapper.getJobList(map);
	}
	@Override	// 총 글의 갯수
	public int getJobTotal(Map<String, Object> map) {
		return this.outsouMainMapper.getJobTotal(map);
	}
	//자기소개서
	@Override	// 카테고리별 목록 + 페이지네이션
	public List<OutsouVO> getSIList(Map<String, Object> map) {
		return this.outsouMainMapper.getSIList(map);
	}
	@Override	// 총 글의 갯수
	public int getSITotal(Map<String, Object> map) {
		return this.outsouMainMapper.getSITotal(map);
	}
	
	

	
	
	
	
	
	@Override	// 기술수준 코드
	public List<CodeVO> getSrleList() {
		return this.outsouMainMapper.getSrleList();
	}

	@Override	// 팀규모 수준 콛,
	public List<CodeVO> getSrteList() {
		return this.outsouMainMapper.getSrteList();
	}

	/*검색 결과 목록 */
	@Override
	public List<OutsouVO> getscarchList(Map<String, Object> map){ //검색결과 + 페이지네이션
		return this.outsouMainMapper.getscarchList(map);
	}
	
	@Override
	public int getscarchTotal(Map<String, Object> map) { //전체 행의 수
		return this.outsouMainMapper.getscarchTotal(map);
	}
	

	
	/*리뷰 목록 3개 */
	@Override
	public List<BoardVO> reviewBest(){
		return this.outsouMainMapper.reviewBest();
	}
}
