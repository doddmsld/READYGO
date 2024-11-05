package kr.or.ddit.oustou.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.OutsouReviewMapper;
import kr.or.ddit.oustou.service.OutsouReviewService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BoardOsVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.DeclarationVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.OsAplyVO;
import kr.or.ddit.vo.OutsouVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OutsouReviewServiceImpl implements OutsouReviewService {
	
	@Inject
	OutsouReviewMapper outsouReviewMapper;
	
	//파일 처리를 위함
	@Inject
	UploadController uploadController;
	
	//리뷰 목록 및 페이지네이션 
	@Override
	public List<BoardVO> getReviewList(Map<String, Object> map){
		return this.outsouReviewMapper.getReviewList(map);
	}
	
	//총 개수 
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.outsouReviewMapper.getTotal(map);
	}
	
	
	//회원이 구매한  목록
	@Override
	public List<OsAplyVO> reviewRegist(String mbrId) {
		return this.outsouReviewMapper.getProduct(mbrId);
	}
	
	
	
	//게시글 등록 실행 
	@Transactional
	@Override
	public int reviewRegistPost(BoardVO boardVO, String outordNo) {
		
		int result = 0;
		//0. 메인 이미지 처리 
		MultipartFile[] multipartFiles = boardVO.getPstFileFile();
		log.info("multipartFiles == > " + multipartFiles);
		// 메인 이미지
		if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
		    log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
//		    boardVO.setPstFile(""); // fileGroupNo의 값을 세팅
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/board");
		    log.info("mainFile->fileGroupSn : " + fileGroupSn);
		    boardVO.setPstFile(fileGroupSn); // fileGroupNo의 값을 세팅
		}
	
		
		result += this.outsouReviewMapper.insertReviewRegist(boardVO);
		
		//외주 번호
		//String outsuNo =
		//게시글 번호 
		String PstSn = boardVO.getPstSn();
		BoardOsVO boardOsVO =  new BoardOsVO();
		boardOsVO.setOutordNo(outordNo);
		boardOsVO.setPstSn(PstSn);
		
		
		result += this.outsouReviewMapper.insertoutsouNo(boardOsVO);
		
		return result;
	}
	
	//게시글상세 
	@Override
	public BoardVO reviewDetail(String pstSn) {
		
		//게시글 상세 정보 가져오기
		BoardVO boardVO = this.outsouReviewMapper.getReviewDetail(pstSn);
	    
	    //조회수 증가 
		this.outsouReviewMapper.InqCnt(pstSn);
		
		
		return boardVO;
	}
	
	
	//파일 정보 가져오기 
	@Override
	public List<FileDetailVO> getFileDetailsByPstSn(String pstSn) {
		return this.outsouReviewMapper.getFileDetailsByPstSn(pstSn);
	}
	
	
	//리뷰 업데이트
	@Transactional
	@Override
	public int reviewUpdatePost(BoardVO boardVO) {
		int result = 0; // 잘되었는지 확인 하기 의함 
		
		//파일처리를 위함 
		
		//기존의 파일이 있는 경우 
		BoardVO boVO = outsouReviewMapper.getReviewDetail(boardVO.getPstSn());//기존의 것을 가져온다. 
		log.info("reviewUpdatePost -->> boVO : "+ boVO);
		
		// 이미지 처리 
		MultipartFile[] multipartFiles = boardVO.getPstFileFile(); 
		log.info("multipartFiles == > " + multipartFiles);
		
		// 메인 이미지
		if (multipartFiles[0].getOriginalFilename().length() < 1) {
		    log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
		    boardVO.setPstFile(boVO.getPstFile()); // fileGroupNo의 값을 세팅
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/board");
		    log.info("mainFile->fileGroupSn : " + fileGroupSn);
		    boardVO.setPstFile(fileGroupSn); // fileGroupNo의 값을 세팅
		}
		
		//게시글 업데이트 
		result += this.outsouReviewMapper.reviewUpdate(boardVO);
		log.info("reviewUpdatePost -->> boVO : "+ boVO);
		
		return result;
		
	}
	
	
	
			
	//게시글 삭제
	@Override
	public int reviewDeletePost(String pstSn) {
		return this.outsouReviewMapper.reviewDeletePost(pstSn);
	}
	
	//게시글 신고
	@Override
	public int boardReport(DeclarationVO declarationVO) {
		return this.outsouReviewMapper.boardReport(declarationVO);
	}
	
	
	//댓글 처리
	// 댓글 가져오기 
	 @Override
    public List<CommentVO> getComments(String pstSn) {
        return this.outsouReviewMapper.replyList(pstSn);
    }
	 //댓글 등록
	@Override
	public int registComment(CommentVO commentVO) {
		return this.outsouReviewMapper.insertComment(commentVO);
	}
	//댓글 수정
    @Override
    public int updateComment(CommentVO commentVO) {
        return this.outsouReviewMapper.commentEdit(commentVO);
    }
    //댓글 삭제
	@Override
	public int deleteComment(String cmntNo, String pstSn, String mbrId) {
        CommentVO commentVO = new CommentVO();
        commentVO.setCmntNo(cmntNo);
        commentVO.setPstSn(pstSn);
        commentVO.setMbrId(mbrId);
		return this.outsouReviewMapper.commentDelete(commentVO);
	}

	//관리자 댓글삭제
	@Override
	public int deleteCommentAdm(String cmntNo, String pstSn) {
        CommentVO commentVO = new CommentVO();
        commentVO.setCmntNo(cmntNo);
        commentVO.setPstSn(pstSn);
		return this.outsouReviewMapper.deleteCommentAdm(commentVO);
	}

}
