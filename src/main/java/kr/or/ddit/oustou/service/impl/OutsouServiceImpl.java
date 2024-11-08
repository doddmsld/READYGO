package kr.or.ddit.oustou.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.OutsouMapper;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.oustou.controller.OutsouController;
import kr.or.ddit.oustou.service.OutsouService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.OsClVO;
import kr.or.ddit.vo.OsDevalVO;
import kr.or.ddit.vo.OsKeywordVO;
import kr.or.ddit.vo.OsdeCludVO;
import kr.or.ddit.vo.OsdeDatabaseVO;
import kr.or.ddit.vo.OsdeLangVO;
import kr.or.ddit.vo.OutsouVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OutsouServiceImpl implements OutsouService {
	
	@Inject
	OutsouMapper outsouMapper;
	
	
	//파일 처리를 위한 
	@Autowired
	UploadController uploadController;
	
	//<!--  외주 등록  -->
	@Transactional
	@Override
	public int  registPostAjax(OutsouVO outsouVO) {
		//이미지 저장 
		//0. 메인 이미지 처리 
		MultipartFile[] multipartFiles = outsouVO.getMainFile();
		log.info("multipartFiles == > " + multipartFiles);
		//1. 상세이미지 처리
		MultipartFile[] multipartFiles2 = outsouVO.getDetailFile();
		log.info("multipartFiles2 == > " + multipartFiles2);
		
		// 메인 이미지
		if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
		    log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
		    outsouVO.setOutordMainFile("2"); // fileGroupNo의 값을 세팅
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/outsou/mainFile");
		    log.info("mainFile->fileGroupSn : " + fileGroupSn);
		    outsouVO.setOutordMainFile(fileGroupSn); // fileGroupNo의 값을 세팅
		}

		// 상세 이미지
		if (multipartFiles2 == null || multipartFiles2.length == 0 || multipartFiles2[0].isEmpty()) { 
		    log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
		    outsouVO.setOutordDetailFile("0");
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles2, "/outsou/detailFile");
		    log.info("outsou->fileGroupSn : " + fileGroupSn);
		    outsouVO.setOutordDetailFile(fileGroupSn);
		}
		//정보 저장 
		/*
		 [1.IT프로그래밍]->OUTSOU, OS_DEVAL, OS_KEYWOED
		 OutsouVO(outordNo=null, outordLclsf=OULC01, outordMlsfc=OULC01-002, outordTtl=1, ..., 
		 	osDevalVO=OsDevalVO(srvcNo=null, outordNo=null, srvcLevelCd=SRLE01, srvcTeamscaleCd=SRTE01, srvcLangCd=SRLA16, srvcDatabaseCd=SRDB16, srvcCludCd=SRCL14, srvcEtc=b, ..), 
		 	osClVO=OsClVO(srvcNo=null, ..), 
		 	osKeywordVO=OsKeywordVO(kwrdNo=null, outordNo=null, kwrdNm=a))
		 */
		/*
		 [2.자기소개서]->OUTSOU, OS_CL 이 두 개의 테이블에 insert
		 OutsouVO(outordNo=null, outordLclsf=OULC02, outordMlsfc=OULC02-001, outordTtl=1, ...,
		  	osDevalVO=OsDevalVO(srvcNo=null, outordNo=null, srvcLevelCd=null, srvcTeamscaleCd=null, srvcLangCd=null, srvcDatabaseCd=null, srvcCludCd=null, srvcEtc=, srvcJobpd=null, srvcUpdtnmtm=null, srvcFileprovdyn=null, srvcSklladit=null), 
		  	osClVO=OsClVO(srvcNo=null, outordNo=null, srvcFld=SRFL02, srvcKnd=SRKN03, srvcArctype=SRAR02), 
		  	osKeywordVO=OsKeywordVO(kwrdNo=null, outordNo=null, kwrdNm=))
		 */
		//대분류 를 구별하기 위해 불러옴
		String outordLclsf = outsouVO.getOutordLclsf();
		
		int result = 0;
		
		if(outordLclsf.equals("OULC01")) {//1.IT프로그래밍->mapper호출을 3회
			// 1. Outsou 테이블에 먼저 insert
			result += this.outsouMapper.insertOutsou(outsouVO);
			
			// 2. 외주 테이블에 자동 생성된 outordNo를 OutsouVO에 세팅
			String outordNo = outsouVO.getOutordNo();
			log.info("외주 테이블 자동 생성된 outordNo -> " + outordNo);
			
			// 3. OsDevalVO의 outordNo에도 같은 값 세팅
			if (outsouVO.getOsDevalVO() != null ) {
			    outsouVO.getOsDevalVO().setOutordNo(outordNo);
			 }
			
			result += this.outsouMapper.insertOsDeval(outsouVO.getOsDevalVO());
			
			//언어, 데이터베이스, 클라우드 저장 
			String srvcNo = outsouVO.getOsDevalVO().getSrvcNo();
	        log.info("서비스 테이블 자동 생성된 srvcNo -> " + srvcNo);

			//OsDevalVODP 저장된  외주 번호를 불러오기 
	        String devOutordNo = outsouVO.getOsDevalVO().getOutordNo();
	        
	        //각  항목의의 리스트를 불러오기 
	        
	        //개발 언어 처리 
	        List<OsdeLangVO> osdeLangVOList= outsouVO.getOsDevalVO().getOsdeLangVOList();
	        if(osdeLangVOList != null && !osdeLangVOList.isEmpty()) {
	        	for(OsdeLangVO osdeLangVO :  osdeLangVOList) {
	        		osdeLangVO.setOutordNo(devOutordNo);
	        		osdeLangVO.setSrvcNo(srvcNo);
	        		result += this.outsouMapper.insertOsdeLang(osdeLangVO);
	        		log.info("osdeLangVO -> " + osdeLangVO);
	        	}
	        }
	        
	        //데이터 베이스 처리 
	        List<OsdeDatabaseVO> osdeDatabaseVOList = outsouVO.getOsDevalVO().getOsdeDatabaseVOList();
	        if(osdeDatabaseVOList != null && !osdeDatabaseVOList.isEmpty() ) {
	        	for(OsdeDatabaseVO osdeDatabaseVO : osdeDatabaseVOList) {
	        		osdeDatabaseVO.setOutordNo(devOutordNo);
	        		osdeDatabaseVO.setSrvcNo(srvcNo);
	        		result += this.outsouMapper.insertOsdeDatabase(osdeDatabaseVO);
	        		log.info("osdeDatabaseVO -> " + osdeDatabaseVO);
	        	}
	        }
	        
	        //클라우드 처리 
	        List<OsdeCludVO> OsdeCludVOList = outsouVO.getOsDevalVO().getOsdeCludVOList();
	        if(OsdeCludVOList != null && !OsdeCludVOList.isEmpty() ) {
	        	for(OsdeCludVO osdeCludVO : OsdeCludVOList) {
	        		osdeCludVO.setOutordNo(devOutordNo);
	        		osdeCludVO.setSrvcNo(srvcNo);
	        		result += this.outsouMapper.insertOsdeClud(osdeCludVO);
	        		log.info("osdeCludVO -> " + osdeCludVO);
	        	}
	        }
	        
	        String[] kwrdNmArr = outsouVO.getKwrdNm();
			log.info("kwrdNmArr  -- > " +outsouVO.getKwrdNm()) ;// 잘들어오는 지 확인 
			log.info("OutsouVO keywords: " + Arrays.toString(outsouVO.getKwrdNm()));
			if(kwrdNmArr!=null ) {//JSP에서 넘어온 값들이 있다면 
				for(String kwrdNm : kwrdNmArr) {
					log.info("kwrdNm  -- > " +kwrdNm) ;// 잘들어오는 지 확인 
					// 2) 새로운 값들로 insert
					OsKeywordVO osKeywordVO = new OsKeywordVO();
					osKeywordVO.setOutordNo(outsouVO.getOutordNo());
					osKeywordVO.setKwrdNm(kwrdNm);
					result += this.outsouMapper.insertOsKeywoed(osKeywordVO);
					log.info("osKeywordVO  -- > " +osKeywordVO) ;// 잘들어오는 지 확인 
				}
			}else {
				log.info("데이터 값이 없음") ;// 잘들어오는 지 확인 
			}
	        
		}else {//2.자기소개서->mapper호출을 2회
			result += this.outsouMapper.insertOutsou(outsouVO);
			
			// 2. 자동 생성된 outordNo를 OutsouVO에 세팅
			String outordNo = outsouVO.getOutordNo();
			log.info("자동 생성된 outordNo -> " + outordNo);
			
			// 3. OsDevalVO의 outordNo에도 같은 값 세팅
		    if (outsouVO.getOsClVO() != null ) {
		        outsouVO.getOsClVO().setOutordNo(outordNo);
		    }
			result += this.outsouMapper.insertOsCl(outsouVO.getOsClVO());
		}
		
		return result;
	}
	
	//외주 상세 
	@Transactional
	@Override
	public OutsouVO detail(String outsordNo) {


	    // 쿼리 결과로 OutsouVO를 가져옴 (DB 호출)
	    long dbStartTime = System.currentTimeMillis(); //db를  시작 
	    OutsouVO outsouVO = this.outsouMapper.selectDetail(outsordNo);
	    long dbEndTime = System.currentTimeMillis(); //db 끝
	    log.info("DB 호출 시간: " + (dbEndTime - dbStartTime) + "ms");
	    
	    //조회수 증가 
	    this.outsouMapper.upCnt(outsordNo);
	    
	    // 메인 이미지, 상세 이미지 처리

	    // 콤마로 묶인 DETAIL_FILE_PATHS를 배열로 변환
	    if (outsouVO.getOutordDetailFile() != null) {
	        String detailFilePaths = outsouVO.getOutordDetailFile();
	        
	        // 콤마로 분리하여 경로 문자열을 리스트로 변환
	        List<String> detailFileList = Arrays.asList(detailFilePaths.split(","));
	        
	        // FileDetailVO 객체 리스트 생성
	        List<FileDetailVO> fileDetailVOList = new ArrayList<>();
	        
	        // 각 경로에 대해 FileDetailVO 객체 생성 후 리스트에 추가
	        for (String outordDetailFile : detailFileList) {
	            FileDetailVO fileDetailVO = new FileDetailVO();
	            fileDetailVO.setFilePathNm(outordDetailFile);  // 파일 경로 설정
	            fileDetailVOList.add(fileDetailVO);    // 리스트에 추가
	        }
	        
	        outsouVO.setFileDetailVOList(fileDetailVOList);
	    }

	    // 추가 로깅 (개발언어, 데이터베이스 등)
	    log.info("개발언어 List: " + outsouVO.getOsDevalVO().getSrvcLangCd());
	    log.info("데이터 베이스 List: " + outsouVO.getOsDevalVO().getSrvcDatabaseCd());
	    log.info("클라우드 List: " + outsouVO.getOsDevalVO().getSrvcCludCd());
	    log.info("키워드 List: " + outsouVO.getOsKeywordVOList());


	    return outsouVO;
	}

	//외주 구매페이지 
	@Transactional
	@Override
	public OutsouVO paydetail(String outsordNo) {
		return this.outsouMapper.selectDetail(outsordNo);
	}
	
	//외주 구매 담당자 
	@Override
	public OutsouVO getOutsouMem(String outsordNo) {
		return this.outsouMapper.getOutsouMem(outsordNo);
	}
	
	
	//외주 테이블 업데이트
	/*
	 [대분류]
	 1. IT/프로그래밍
	 	-[필수]외주, 외주개발서비스
	 	-[선택]
	 	  - 언어코드, 데이터베이스 코드, 클라우드코드, 외주 검색 키워즈
	 	  - JSP에서 넘어온 값들이 있다면 1) 기존 데이터를 delete 하고 2) 새로운 값들로 insert
	 	  - JSP에서 넘어온 값들이 없다면 그냥 기존 데이터(없을수도 / 있을수도 있음)를 유지함
	 2. 자기소개서
	 	-[필수]외주, 외주개발서비스
	 	-[선택]
	 	  - 외주 검색 키워즈
	 */
	@Transactional
	@Override
	public int updatePost(OutsouVO outsouVO) {
		//이미지 업데이트 
		
		//기존의 것이 존재 할경우 
		OutsouVO osVO = outsouMapper.selectDetail(outsouVO.getOutordNo());
		
		//0. 메인 이미지 처리 
		MultipartFile[] multipartFiles = outsouVO.getMainFile();
		log.info("multipartFiles == > " + multipartFiles);
		//1. 상세이미지 처리
		MultipartFile[] multipartFiles2 = outsouVO.getDetailFile();
		log.info("multipartFiles2 == > " + multipartFiles2);
		
		// 메인 이미지
		if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
		    log.info("기존의 파일을 세팅함 ");
//		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/outsou/mainFile");
//		    log.info("mainFile->fileGroupSn : " + fileGroupSn);
//		    outsouVO.setOutordMainFile(fileGroupSn); // fileGroupNo의 값을 세팅
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/outsou/mainFile");
		    log.info("mainFile->fileGroupSn : " + fileGroupSn);
		    outsouVO.setOutordMainFile(fileGroupSn); // fileGroupNo의 값을 세팅
		}

		// 상세 이미지
		if (multipartFiles2 == null || multipartFiles2.length == 0 || multipartFiles2[0].isEmpty()) { 
		    log.info("기존의 파일을 세팅함 ");
//		    outsouVO.setOutordDetailFile(osVO.getOutordDetailFile()); // 기존의 파일을 세텅 
//		    log.info("osVO.getOutordMainFile --> " + osVO.getDetailFile());
		} else {
		    // 새로운 파일 업로드 처리
		    String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles2, "/outsou/detailFile");
		    log.info("outsou->fileGroupSn : " + fileGroupSn);
		    outsouVO.setOutordDetailFile(fileGroupSn);
		}
		
		
				
		//대분류 를 구별하기 위해 불러옴
		String outordLclsf = outsouVO.getOutordLclsf();
		
		int result = 0;
		
		if(outordLclsf.equals("OULC01")) {//1.IT프로그래밍->mapper호출을 3회
			/*
			osDevalVO=OsDevalVO(srvcNo=null, outordNo=null, srvcLevelCd=SRLE01, srvcLevelNm=null, 
						srvcLangCd=[SRLA01, SRLA02], 
						srvcDatabaseCd=[SRDB01, SRDB03],
						srvcCludCd=[SRCL01, SRCL05]),
			*/ 
			// 1. Outsou 테이블에 먼저 update
			result += this.outsouMapper.updateOutsou(outsouVO);
			
			//개발서비스 update 
//			outsou
			result += this.outsouMapper.updateOsDeval(outsouVO.getOsDevalVO());
			
			//언어 코드  저장이 되어 있지 않으면 insert 갯수가 다른 경우 
			//srvcLangCd=[SRLA01, SRLA02], 
			String[] srvcLangCdArr = outsouVO.getOsDevalVO().getSrvcLangCd();
			if(srvcLangCdArr!=null) {//JSP에서 넘어온 값들이 있다면 
				//1) 기존 데이터를 delete 하고
				result += this.outsouMapper.deleteOsdeLang(outsouVO.getOsDevalVO().getOutordNo());
				log.info("outsou->deleteOsdeLang : " + outsouVO.getOsDevalVO().getOutordNo());
				for(String srvcLangCd : srvcLangCdArr) {
					// 2) 새로운 값들로 insert
					OsdeLangVO osdeLangVO = new OsdeLangVO();
					osdeLangVO.setOutordNo(outsouVO.getOsDevalVO().getOutordNo());
					osdeLangVO.setSrvcNo(outsouVO.getOsDevalVO().getSrvcNo());
					osdeLangVO.setSrvcLangCd(srvcLangCd);
					result += this.outsouMapper.insertOsdeLang(osdeLangVO);
					log.info("outsou->osdeLangVO : " + osdeLangVO);
				}
			}
			//데이터베이스  update 저장이 되어 있지 않으면 insert 
			//srvcDatabaseCd=[SRDB01, SRDB03],
			String[] srvcDatabaseCdArr = outsouVO.getOsDevalVO().getSrvcDatabaseCd();
			if(srvcDatabaseCdArr!=null) {//JSP에서 넘어온 값들이 있다면
				//1) 기존 데이터를 delete 하고
				result += this.outsouMapper.deleteOsdeDatabase(outsouVO.getOsDevalVO().getOutordNo());
				for(String srvcDatabaseCd : srvcDatabaseCdArr) {
					// 2) 새로운 값들로 insert
					OsdeDatabaseVO osdeDatabaseVO = new OsdeDatabaseVO();
					osdeDatabaseVO.setOutordNo(outsouVO.getOsDevalVO().getOutordNo());
					osdeDatabaseVO.setSrvcNo(outsouVO.getOsDevalVO().getSrvcNo());
					osdeDatabaseVO.setSrvcDatabaseCd(srvcDatabaseCd);
					result += this.outsouMapper.insertOsdeDatabase(osdeDatabaseVO);
					log.info("outsou->osdeDatabaseVO : " + osdeDatabaseVO);
				}
			}
			//클라우드   update 저장이 되어 있지 않으면 insert 
			//srvcCludCd=[SRCL01, SRCL05]),
			String[] srvcCludCdArr = outsouVO.getOsDevalVO().getSrvcCludCd();
			if(srvcCludCdArr!=null) {//JSP에서 넘어온 값들이 있다면 
				//1) 기존 데이터를 delete 하고
				result += this.outsouMapper.deleteOsdeClud(outsouVO.getOsDevalVO().getOutordNo());
				for(String srvcCludCd : srvcCludCdArr) {
					// 2) 새로운 값들로 insert
					OsdeCludVO osdeCludVO = new OsdeCludVO();
					osdeCludVO.setOutordNo(outsouVO.getOsDevalVO().getOutordNo());
					osdeCludVO.setSrvcNo(outsouVO.getOsDevalVO().getSrvcNo());
					osdeCludVO.setSrvcCludCd(srvcCludCd);
					result += this.outsouMapper.insertOsdeClud(osdeCludVO);
					log.info("outsou->osdeCludVO : " + osdeCludVO);
				}
			}
			//키워드  update 저장이 되어 있지 않으면 insert 
			String[] kwrdNmArr = outsouVO.getKwrdNm();
			log.info("kwrdNmArr  -- > " +outsouVO.getKwrdNm()) ;// 잘들어오는 지 확인 
			log.info("OutsouVO keywords: " + Arrays.toString(outsouVO.getKwrdNm()));
			if(kwrdNmArr!=null ) {//JSP에서 넘어온 값들이 있다면 
				//1) 기존 데이터를 delete 하고
				result += this.outsouMapper.deleteOsKeywoed(outsouVO.getOutordNo());
				for(String kwrdNm : kwrdNmArr) {
					log.info("kwrdNm  -- > " +kwrdNm) ;// 잘들어오는 지 확인 
					// 2) 새로운 값들로 insert
					OsKeywordVO osKeywordVO = new OsKeywordVO();
					osKeywordVO.setOutordNo(outsouVO.getOutordNo());
					osKeywordVO.setKwrdNm(kwrdNm);
					result += this.outsouMapper.insertOsKeywoed(osKeywordVO);
					log.info("osKeywordVO  -- > " +osKeywordVO) ;// 잘들어오는 지 확인 
				}
			}else {
				log.info("데이터 값이 없음") ;// 잘들어오는 지 확인 
			}
			
			
			
		}else {//2.자기소개서->mapper호출을 2회
			result += this.outsouMapper.updateOutsou(outsouVO);
			
			// 2. outsou번호는 넣어주기위함
			String outordNo = outsouVO.getOutordNo();
			log.info("자동 생성된 outordNo -> " + outordNo);
			
			// 3. OsDevalVO의 outordNo에도 같은 값 세팅
		    if (outsouVO.getOsClVO() != null ) {
		        outsouVO.getOsClVO().setOutordNo(outordNo);
		    }
			
			result += this.outsouMapper.updateOsCl(outsouVO.getOsClVO());
		}
		
		return result;
	}
	
	//외주 삭제 
	@Override
	public int deletePost(String outsordNo) {
		return this.outsouMapper.deletePost(outsordNo);
	}

	@Override
	public String Writer(String outordNo) {
		return this.outsouMapper.Writer(outordNo);
	}
	
	
	
	
	

}
