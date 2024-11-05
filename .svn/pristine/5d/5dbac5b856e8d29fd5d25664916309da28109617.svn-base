
package kr.or.ddit.service.impl;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.mapper.MemberMapper;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OutsouVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SettlementVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberMapper memberMapper;
	
	@Inject
	FileDetailMapper fileDetailMapper;
	
	@Inject
	UploadController uploadController;
	
   // DI, IoC
   // c:\\upload
   @Inject
   String uploadPath;

   @Inject
   GetUserUtil getUserUtil;
   
	// 회원 상세
	@Override
	public MemberVO detail(String mbrId) {
		return this.memberMapper.detail(mbrId);
	}

	// 개인정보 수정
	@Override
	public int editPost(MemberVO memberVO) {
	    int result = 0;
        String formattedDate = memberVO.getMbrBrdt().replace("-", "");
        memberVO.setMbrBrdt(formattedDate);
        
        String formattedTelNo = memberVO.getMbrTelno().replace("-", "");
        memberVO.setMbrTelno(formattedTelNo);
        
        

	    MultipartFile[] multipartFiles = memberVO.getUploadFile();

	    // 파일이 없을 경우 기존 파일 유지
	    if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
	        log.info("새로운 파일이 업로드되지 않았습니다. 기존 파일을 유지합니다.");
	        
	        // 기존 회원 정보 가져오기
	        MemberVO existingMemberVO = this.memberMapper.detail(memberVO.getMbrId());
	        
	        // 기존 파일 그룹 번호 유지
	        memberVO.setFileGroupSn(existingMemberVO.getFileGroupSn());
	    } else {
	        // 새로운 파일 업로드 처리
	        String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/member");
	        log.info("editPost->fileGroupSn : " + fileGroupSn);
	        
	        // 새로운 파일 그룹 번호 설정
	        memberVO.setFileGroupSn(fileGroupSn);
	    }

	    // 데이터 등록
	    result += this.memberMapper.editPost(memberVO);
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        customUser.setMemVO(this.memberMapper.selectOne(memberVO.getMbrId()));
	    
	    // 항상 int 값 반환
	    return result;
	}

	@Override
	public int deletePost(String mbrId) {
		return this.memberMapper.deletePost(mbrId);
	}
	
	//회원 검색기록 불러오기
	@Override
	public List<SearchVO> searchHistory(String mbrId) {
		return this.memberMapper.searchHistory(mbrId);
	}
	
	//회원 검색기록 선택 삭제
	@Override
	public int searchDelete(String searchNo) {
		return this.memberMapper.searchDelete(searchNo);
	}
	
	//회원 검색기록 전체 삭제
	@Override
	public int searchDeleteAll(String mbrId) {
		return this.memberMapper.searchDeleteAll(mbrId);
	}
	
	//회원 검색기록 저장
	@Override
	public int searchInsert(Map<String, Object> map) {
		return this.memberMapper.searchInsert(map);
	}

	// 프로필에서 이미지 수정 -> 멤버에 있는 파일 그룹번호 수정
	@Override
	public int editPrfImg(MemberVO memberVO) {
		int result = 0;

	    MultipartFile[] multipartFiles = memberVO.getUploadFile();

	    // 파일이 없을 경우 기존 파일 유지
	    if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
	        log.info("새로운 파일이 업로드되지 않았습니다. 기존 파일을 유지합니다.");
	        
	        // 기존 회원 정보 가져오기
	        MemberVO existingMemberVO = this.memberMapper.detail(memberVO.getMbrId());
	        
	        // 기존 파일 그룹 번호 유지
	        memberVO.setFileGroupSn(existingMemberVO.getFileGroupSn());
	    } else {
	        // 새로운 파일 업로드 처리
	        String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/member");
	        log.info("editPost->fileGroupSn : " + fileGroupSn);
	        
	        // 새로운 파일 그룹 번호 설정
	        memberVO.setFileGroupSn(fileGroupSn);
	    }

	    // 데이터 등록
	    result += this.memberMapper.editPrfImg(memberVO);
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        customUser.setMemVO(this.memberMapper.selectOne(memberVO.getMbrId()));

	    // 항상 int 값 반환
	    return result;
	}

	// 회원 비밀번호 변경
	@Override
	public int updatePswd(MemberVO memberVO) {
		int resykt = this.memberMapper.updatePswd(memberVO);
		getUserUtil.getMemVO().setMbrPswd(memberVO.getMbrPswd());
		return resykt;
	}

	// 마이페이지 결제한 외주 목록
	@Override
	public List<SettlementVO> setleList(Map<String, Object> map) {
		return this.memberMapper.setleList(map);
	}

	// 결제한 외주 전체 행의 수
	@Override
	public int getSetleTotal(Map<String, Object> map) {
		return this.memberMapper.getSetleTotal(map);
	}

	// 마이페이지 등록한 외주 목록 
	@Override
	public List<OutsouVO> memOutsouList(Map<String, Object> map) {
		return this.memberMapper.memOutsouList(map);
	}

	// 등록한 외주 전체 행의 수
	@Override
	public int getOutsouTotal(Map<String, Object> map) {
		return this.memberMapper.getOutsouTotal(map);
	}

	// 최근 본 공고
	@Override
	public List<PbancVO> getPbancRecent(List<String> pbancNoList) {
		if (pbancNoList == null || pbancNoList.isEmpty()) {
            return Collections.emptyList();
        }
		return this.memberMapper.getPbancRecent(pbancNoList);
	}
	
	// 내가 쓴 글 목록 (작성글관리)
	@Override
	public List<BoardVO> boardVOList(Map<String, Object> map) {
		return this.memberMapper.boardVOList(map);
	}
	
	// 내가 작성한 글 전체 행의 수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memberMapper.getTotal(map);
	}
	

}
