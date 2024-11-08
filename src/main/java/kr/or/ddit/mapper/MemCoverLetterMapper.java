package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CoverLetterSaveVO;

public interface MemCoverLetterMapper {
	public List<CoverLetterSaveVO> selectCoverLetterList(Map<String, Object> map);
	
	public CoverLetterSaveVO selectOneCoverLetter(Map<String, Object> map);
	
	public int selectCLTotal(Map<String, Object> map);
	
	public int insertCoverLetter(CoverLetterSaveVO coverLetterVO);
	
	public int updateCoverLetter(CoverLetterSaveVO coverLetterVO);
	
	public int deleteCoverLetter(Map<String, Object> map);

	public List<CoverLetterSaveVO> selectCoverLetterListNonePaging(Map<String, Object> map);
	
}
