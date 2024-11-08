package kr.or.ddit.service_DO;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.DeclarationVO;
import kr.or.ddit.vo.FileDetailVO;

public interface FreeBoardService {
	
	// 등록
	public String admRegist();
	
	// 등록POST
	public int admRegistPost(BoardVO boardVO);

	// 목록
	public List<BoardVO> admList(Map<String, Object> map);

	// 페이지 전체 수
	public int getTotal(Map<String, Object> map);
	
	// 상세
	public BoardVO admDetail(String pstSn);	
	
	// 조회수증가
	public void InqCnt(String pstSn);	

	// 댓글등록
	public int registComment(CommentVO commentVO);
	
	// 댓글목록
	public List<CommentVO> getComments(String pstSn);
	
    // 댓글 삭제
    int deleteComment(String cmntNo, String pstSn, String mbrId);

    // 댓글 수정
	public int updateComment(CommentVO commentVO);

	// 게시글 삭제
	public int deletePost(String pstSn);

	//수정사이트
	public String update(String pstSn);
	
	// 수정할때 게시글 데이터 가져오기
	public BoardVO getPostDetails(String pstSn);

	// 수정완료
	public int updatePost(BoardVO boardVO);

	public int deleteCommentAdm(String cmntNo, String pstSn);

	public int boardReport(DeclarationVO declarationVO);

	public int replyReport(DeclarationVO declarationVO);

	public List<FileDetailVO> getFileDetailsByPstSn(String pstSn);

	//소켓
	public String getBoardWriter(String pstSn);

	public String getBoardTitle(String pstSn);

	public List<CommentVO> replyPage(Map<String, Object> paramMap);
    
}
