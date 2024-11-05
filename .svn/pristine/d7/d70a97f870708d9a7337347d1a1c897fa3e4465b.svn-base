package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OutsouVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SettlementVO;

public interface MemberService {
	
	// 회원 상세
	public MemberVO detail(String mbrId);
	
	// 개인정보 수정
	public int editPost(MemberVO memberVO);
	
	// 회원 탈퇴
	public int deletePost(String mbrId);
	
	//회원 검색기록
	public List<SearchVO> searchHistory(String mbrId);

	//회원 검색기록 선택 삭제
	public int searchDelete(String searchNo);
	
	//회원 검색기록 전체 삭제
	public int searchDeleteAll(String mbrId);
	
	//회원 검색기록 저장
	public int searchInsert(Map<String, Object> map);
	
	// 프로필 이미지 수정
    public int editPrfImg(MemberVO memberVO);
    
    // 회원 비밀번호 수정
    public int updatePswd(MemberVO memberVO);
    
    // 마이페이지 결제한 외주 목록
    public List<SettlementVO> setleList(Map<String, Object> map);
    
    // 결제한 외주 전체 행의 수
    public int getSetleTotal(Map<String, Object> map);
    
    // 마이페이지 등록한 외주 목록
    public List<OutsouVO> memOutsouList(Map<String, Object> map);
    
    // 등록한 외주 전체 행의 수
    public int getOutsouTotal(Map<String, Object> map);
    
    // 최근 본 공고 조회
    public List<PbancVO> getPbancRecent(@Param("pbancNoList") List<String>pbancNoList);
    

    // 내가 쓴 글 목록 (작성글관리)
 	public List<BoardVO> boardVOList(Map<String, Object> map);
 	
 	// 내가 작성한 글 전체 행의 수
 	public int getTotal(Map<String, Object> map);


}
