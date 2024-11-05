package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.mapper.MemAplctMapper;
import kr.or.ddit.security.SocketHandler;
import kr.or.ddit.service.MemAplctService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.ApplicantVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NotificationVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.ScrapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemAplctServiceImpl implements MemAplctService {

    @Inject
    MemAplctMapper memAplctMapper;
    
    @Inject
	FileDetailMapper fileDetailMapper;
	
	@Inject
	UploadController uploadController;
	
	@Inject
	NotificationService notificationService;
	
	
   // DI, IoC
   // c:\\upload
   @Inject
   String uploadPath;
   
   @Inject
   GetUserUtil getUserUtil;
   
   @Autowired
   private SocketHandler socketHandler; //이거는 알림 보낼때 추가!

    // 입사 지원 목록
	@Override
	public List<ApplicantVO> aplctList(Map<String, Object> map) {
		return this.memAplctMapper.aplctList(map);
	}

	// 전체 입사 행 수 
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memAplctMapper.getTotal(map);
	}

	// 입사 지원 취소 사유 항목
	@Override
	public List<CodeVO> cancelList() {
		return this.memAplctMapper.cancelList();
	}
	
	// 특정 공고 입사 지원 취소 사유 update
	@Override
	@Transactional
	public int aplctDelete(Map<String, Object> map) {
		return this.memAplctMapper.aplctDelete(map);
	}
	
    // 입사 지원 관리 목록
	@Override
	public List<ApplicantVO> aplctManage(Map<String, Object> map) {
		return this.memAplctMapper.aplctManage(map);
	}
	
	// 입사 지원 중복 체크
	@Override
	public ApplicantVO aplctChk(Map<String, Object> map) {
		return this.memAplctMapper.aplctChk(map);
	}
	
	// 입사 지원 관리 전체 행의 수
	@Override
	public int getManTotal(Map<String, Object> map) {
		return this.memAplctMapper.getManTotal(map);
	}

	// 상태 미평가 행의 수
	@Override
	public int getNotTotal(String mbrId) {
		return this.memAplctMapper.getNotTotal(mbrId);
	}
	
	// 상태 서류합격 행의 수
	@Override
	public int getDocTotal(String mbrId) {
		return this.memAplctMapper.getDocTotal(mbrId);
	}

	// 상태 최종합격 행의 수
	@Override
	public int getFinTotal(String mbrId) {
		return this.memAplctMapper.getFinTotal(mbrId);
	}
	
	// 상태 불합격 행의 수
	@Override
	public int getBadTotal(String mbrId) {
		return this.memAplctMapper.getBadTotal(mbrId);
	}
	

	// 내가 스크랩한 공고 조회
	@Override
	public List<PbancVO> scrapList(Map<String, Object> map) {
		return this.memAplctMapper.scrapList(map);
	}

	// 스크랩한 전체 행의 수
	@Override
	public int getScrapTotal(Map<String, Object> map) {
		return this.memAplctMapper.getScrapTotal(map);
	}
	// 공고 스크랩 추가
	@Override
	public int addScrap(ScrapVO scrapVO) {
		return this.memAplctMapper.addScrap(scrapVO);
	}
	// 스크랩한 공고 삭제
	@Override
	public int delScrap(Map<String, Object> map) {
		return this.memAplctMapper.delScrap(map);
	}

	// 공고 스크랩 여부 확인
	@Override
	public int scrapYN(Map<String, Object> map) {
		return this.memAplctMapper.scrapYN(map);
	}

	// 입사 지원
	@Override
	public int aplctAdd(ApplicantVO applicantVO) {
		int result = 0;
		String pbancNo = applicantVO.getPbancNo();
		MemberVO memVO = getUserUtil.getMemVO();
		String mbrId = memVO.getMbrId();
		String memNm = memVO.getMbrNm();
		PbancVO pbancVO = this.memAplctMapper.getPbanc(pbancNo);
		String entId = pbancVO.getEntId();
		String pbancTtl = pbancVO.getPbancTtl();
		
		MultipartFile[] multipartFiles = applicantVO.getUploadFile();

      // 파일이 없으면 fileGroupSn을 설정하지 않음 (자동으로 null 처리됨)
       if (multipartFiles != null && multipartFiles.length > 0 && !multipartFiles[0].isEmpty()) {
           String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/applicant");
           log.info("editPost->fileGroupSn : " + fileGroupSn);
           
           // 파일 그룹 번호 설정
           applicantVO.setFileGroupSn(fileGroupSn);
       }

	    // 데이터 등록
	    result += this.memAplctMapper.aplctAdd(applicantVO);
	    // WebSocketMessage 적기
	    String websocketMessage = String.format("%s님이 %s공고에 지원하였습니다.",memNm, pbancTtl); // <=메세지 내용 적는 곳
	    //메시지 받는사람 id가져오기(이건 이미 만들어놔서 가져올 수 있으면 추가안해도됌)
	    // 알림 목록 눌렀을 때 이동할 링크 각자 알림마다 달라서 어디로 이동할지 설정
	    String currentUrl = "/enter/pbancDetail?pbancNo=" + pbancNo;
	    // WebSocket 세션 체크 후 메시지 전송
	    log.info("현재 등록된 세션 목록: " + socketHandler.getUserSessionsMap().keySet());
			//containsKey() 괄호안에 메시지 받는사람 적기 그 밑에도
				if(!entId.equals(mbrId)){//보내는사람 아이디 ex)mbrId(자기가쓴건 안받기위해서)
		    if (socketHandler.getUserSessionsMap().containsKey(entId)) {
		        socketHandler.sendMessageToUser(entId, websocketMessage);
		    } else {
		        log.warn("WebSocket 세션을 찾을 수 없음, 사용자: " + entId);
		        log.info("현재 등록된 세션 목록: " + socketHandler.getUserSessionsMap().keySet());
		    }
		  //알림 저장
	    NotificationVO notificationVO = new NotificationVO();
	    notificationVO.setCommonId(entId); // 메시지 받는사람 ID
	    notificationVO.setNtcnCn(websocketMessage); // 알림 메시지 내용
	    notificationVO.setNtcnUrl(currentUrl); // 알림과 연결된 URL

	    this.notificationService.sendAlram(notificationVO);  // 알림 저장
	    }
	    
	    // 항상 int 값 반환
	    return result;
	}

	
}
