package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.BoardOsVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.DeclarationVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.OsAplyVO;

public interface OutsouReviewMapper {
	
	
	//리뷰 목록 및 페이지네이션 
	public List<BoardVO> getReviewList(Map<String, Object>map);
	
	//총 개수 
	public int getTotal(Map<String, Object> map);
	
	//회원이 구매한 목록 
	public List<OsAplyVO> getProduct(String mbrId);
	
	//게시글 등록 
	public int insertReviewRegist(BoardVO boardVO);
	//게시글에 외주번호 등록
	public int insertoutsouNo(BoardOsVO boardOsVO);

	//리뷰 게시글 상세 
	public BoardVO getReviewDetail(String pstSn);
	//파일 정보 가져오기 
	public List<FileDetailVO> getFileDetailsByPstSn(@Param("pstSn") String pstSn);
	
	//조회수 증가	
	public void InqCnt(String pstSn);
	
	//게시글 신고
	public int boardReport(DeclarationVO declarationVO);
	
	//게시글 삭제
	public int reviewDeletePost(String pstSn);

	//게시글 수정 
	public int reviewUpdate(BoardVO boardVO);

	
	//댓글 관련 
	
	//댓글 리스트 
	public List<CommentVO> replyList(String pstSn);

	//댓글 등록 
	public int insertComment(CommentVO commentVO);

	//댓글 삭제 
	int commentDelete(CommentVO commentVO);

	//댓글 수정
	int commentEdit(CommentVO commentVO);

	//관리자 댓글삭제
	public int deleteCommentAdm(CommentVO commentVO);
	
	
}
