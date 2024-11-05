package kr.or.ddit.impl_DO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.NoticeMapper;
import kr.or.ddit.service_DO.NoticeService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FileDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	NoticeMapper noticeMapper;
	
	@Inject
	UploadController uploadController;
	
	@Override
	public String admRegist() {
		return this.noticeMapper.admRegist();
	}

	@Override
	public int admRegistPost(BoardVO boardVO) {
	    MultipartFile[] multipartFiles = boardVO.getPstFileFile();
	    log.info("multipartFiles == > " + multipartFiles);

	    if (multipartFiles != null && multipartFiles.length > 0 && !multipartFiles[0].isEmpty()) {
	        // 파일 업로드 처리
	        String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/board");
	        log.info("editPost->fileGroupSn : " + fileGroupSn);
	        // 원본 파일명 목록 저장
	        StringBuilder originalFileNames = new StringBuilder();
	        for (MultipartFile file : multipartFiles) {
	            if (originalFileNames.length() > 0) {
	                originalFileNames.append(" ");  // 파일명 구분용 뗘쓰기 추가
	            }
	            originalFileNames.append(file.getOriginalFilename());
	        }
	        boardVO.setPstFile(originalFileNames.toString()); // 원본 파일명을 설정
	    } else {
	        log.info("새로운 파일이 업로드되지 않았습니다.");
	    }

		return this.noticeMapper.admRegistPost(boardVO);
	}
	
	@Override
	public List<BoardVO> admList(Map<String, Object> map) {
		return this.noticeMapper.admList(map);
	}

	@Override
	public int getTotal() {
		return this.noticeMapper.getTotal();
	}
	
	@Override
	public BoardVO admDetail(String pstSn) {
		return this.noticeMapper.admDetail(pstSn);
	}

	@Override
	public void InqCnt(String pstSn) {
		this.noticeMapper.InqCnt(pstSn);
	}

	@Override
	public String update(String pstSn) {
		return this.noticeMapper.update(pstSn);
	}

	@Override
	public int deletePost(String pstSn) {
		return this.noticeMapper.deletePost(pstSn);
	}

	@Override
	public BoardVO getPostDetails(String pstSn) {
		return this.noticeMapper.getPostDetails(pstSn);
	}

	@Override
	public int updatePost(BoardVO boardVO) {
	    MultipartFile[] multipartFiles = boardVO.getPstFileFile();
	    log.info("multipartFiles == > " + multipartFiles);

	    if (multipartFiles != null && multipartFiles.length > 0 && !multipartFiles[0].isEmpty()) {
	        // 파일 업로드 처리
	        String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/board");
	        log.info("editPost->fileGroupSn : " + fileGroupSn);

	        // 원본 파일명 목록 저장
	        StringBuilder originalFileNames = new StringBuilder();
	        for (MultipartFile file : multipartFiles) {
	            if (originalFileNames.length() > 0) {
	                originalFileNames.append(" ");  // 파일명 구분용 띄어쓰기 추가
	            }
	            originalFileNames.append(file.getOriginalFilename());
	        }
	        boardVO.setPstFile(originalFileNames.toString()); // 원본 파일명을 설정
	        boardVO.setFileGroupSn(fileGroupSn);  // 새로운 fileGroupSn 설정
	    } else {
	        log.info("새로운 파일이 업로드되지 않았습니다.");
	        // 파일이 없을 때는 fileGroupSn을 null로 설정
	        boardVO.setFileGroupSn(null);
	        boardVO.setPstFile(null);  // pstFile도 null로 설정
	    }
	    
		return this.noticeMapper.updatePost(boardVO);
	}

	@Override
	public List<FileDetailVO> getFileDetailsByPstSn(String pstSn) {
		return this.noticeMapper.getFileDetailsByPstSn(pstSn);
	}

}
