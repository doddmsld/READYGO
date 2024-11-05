package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileDetailVO;

public interface NoticeMapper {

	public String admRegist();

	public int admRegistPost(BoardVO boardVO);
	
	public List<BoardVO> admList(Map<String, Object> map);

	public int getTotal();
	
	public BoardVO admDetail(String pstSn);

	public void InqCnt(String pstSn);

	public String update(String pstSn);

	public int deletePost(String pstSn);

	public BoardVO getPostDetails(String pstSn);

	public int updatePost(BoardVO boardVO);

	public List<FileDetailVO> getFileDetailsByPstSn(String pstSn);
}
