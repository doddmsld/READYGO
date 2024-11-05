package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommentVO;

public interface InquiryBoardMapper {

	public List<BoardVO> list(Map<String, Object> map);
	
	public String regist();
	
	public int registPost(BoardVO boardVO);
	
	public BoardVO detail(String pstSn);

	public String update(String pstSn);

	public BoardVO getPostDetails(String pstSn);
	
	public int updatePost(BoardVO boardVO);

	public int getTotal();

	public void InqCnt(String pstSn);

	public int deletePost(String pstSn);

	public int insertComment(CommentVO commentVO);

	public List<CommentVO> replyList(String pstSn);

    // 댓글 수정
    int commentEdit(CommentVO commentVO);

    // 댓글 삭제
    int commentDelete(CommentVO commentVO);
//-----------------------------------------------------
    public String listM();

	public String getBoardWriter(String pstSn);
}
