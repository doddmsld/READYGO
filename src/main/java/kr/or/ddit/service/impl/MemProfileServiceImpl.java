package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.mapper.MemProfileMapper;
import kr.or.ddit.mapper.MemberMapper;
import kr.or.ddit.service.MemProfileService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.ApplicantVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PrfAcbgVO;
import kr.or.ddit.vo.PrfActVO;
import kr.or.ddit.vo.PrfBusinessVO;
import kr.or.ddit.vo.PrfCareerVO;
import kr.or.ddit.vo.PrfCrtfctVO;
import kr.or.ddit.vo.PrfSkillVO;
import kr.or.ddit.vo.PrfVO;
import kr.or.ddit.vo.PrfWnpzVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemProfileServiceImpl implements MemProfileService {

    @Inject
    MemProfileMapper memProfileMapper;
    
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
    

    // 프로필
	@Override
	public PrfVO profile(String mbrId) {
		return this.memProfileMapper.profile(mbrId);
	}
	// 프로필 수정
	@Override
	public int prfUpdateAjax(Map<String, Object> map) {
		return this.memProfileMapper.prfUpdateAjax(map);
	}
	// 입사 제안 버튼 수정
	@Override
	public int prfUpdateScout(Map<String, Object> map) {
		return this.memProfileMapper.prfUpdateScout(map);
	}

	
    // 경력 목록
    @Override
    public List<PrfCareerVO> careerList(String mbrId) {
        return this.memProfileMapper.careerList(mbrId);
    }
	// 경력 추가
	@Override
	public int careerAddAjax(PrfCareerVO prfCareerVO) {
	    if (prfCareerVO.getCareerBegYm() != null) {
	        // 하이픈 제거
	        String formattedDate = prfCareerVO.getCareerBegYm().replace("-", "");
	        prfCareerVO.setCareerBegYm(formattedDate);
	    }
	    if (prfCareerVO.getCareerEndYm() != null) {
	    	// 하이픈 제거
	    	String formattedDate = prfCareerVO.getCareerEndYm().replace("-", "");
	    	prfCareerVO.setCareerEndYm(formattedDate);
	    }
	    
		return this.memProfileMapper.careerAddAjax(prfCareerVO);
	}
	// 경력 수정
	@Override
	public int careerUpdateAjax(PrfCareerVO prfCareerVO) {
	    if (prfCareerVO.getCareerBegYm() != null) {
	        // 하이픈 제거
	        String formattedDate = prfCareerVO.getCareerBegYm().replace("-", "");
	        prfCareerVO.setCareerBegYm(formattedDate);
	    }
	    if (prfCareerVO.getCareerEndYm() != null) {
	    	// 하이픈 제거
	    	String formattedDate = prfCareerVO.getCareerEndYm().replace("-", "");
	    	prfCareerVO.setCareerEndYm(formattedDate);
	    }
		
		return this.memProfileMapper.careerUpdateAjax(prfCareerVO);
	}
	// 경력 삭제
	@Override
	public int careerDelAjax(Map<String, Object> map) {
		return this.memProfileMapper.careerDelAjax(map);
	}
	

    // 학력 목록 조회
    @Override
    public List<PrfAcbgVO> acbgList(String mbrId) {
    	return this.memProfileMapper.acbgList(mbrId);
    }
    // 학력 추가
	@Override
	public int acbgAddAjax(PrfAcbgVO prfAcbgVO) {
		
		  if (prfAcbgVO.getAcbgMtcltnym() != null) {
		        // 하이픈 제거
		        String formattedDate = prfAcbgVO.getAcbgMtcltnym().replace("-", "");
		        prfAcbgVO.setAcbgMtcltnym(formattedDate);
		    }
		    if (prfAcbgVO.getAcbgGrdtnym() != null) {
		    	// 하이픈 제거
		    	String formattedDate = prfAcbgVO.getAcbgGrdtnym().replace("-", "");
		    	prfAcbgVO.setAcbgGrdtnym(formattedDate);
		    }
		    
		return this.memProfileMapper.acbgAddAjax(prfAcbgVO);
	}
	// 학력 수정
	@Override
	public int acbgUpdateAjax(PrfAcbgVO prfAcbgVO) {
		
		  if (prfAcbgVO.getAcbgMtcltnym() != null) {
		        // 하이픈 제거
		        String formattedDate = prfAcbgVO.getAcbgMtcltnym().replace("-", "");
		        prfAcbgVO.setAcbgMtcltnym(formattedDate);
		    }
		    if (prfAcbgVO.getAcbgGrdtnym() != null) {
		    	// 하이픈 제거
		    	String formattedDate = prfAcbgVO.getAcbgGrdtnym().replace("-", "");
		    	prfAcbgVO.setAcbgGrdtnym(formattedDate);
		    }
		    
		return this.memProfileMapper.acbgUpdateAjax(prfAcbgVO);
	}
	// 학력 삭제
	@Override
	public int acbgDelAjax(Map<String, Object> map) {
		return this.memProfileMapper.acbgDelAjax(map);
	}
	// 프로필 학력 항목
	@Override
	public List<CodeVO> prseList() {
		return this.memProfileMapper.prseList();
	}
	// 학위 항목
	@Override
	public List<CodeVO> acdeList() {
		return this.memProfileMapper.acdeList();
	}
	// 전공계열 항목
	@Override
	public List<CodeVO> acspList() {
		return this.memProfileMapper.acspList();
	}
    
	
    // 자격증 조회
	@Override
	public List<PrfCrtfctVO> crtfctList(String mbrId) {
		return this.memProfileMapper.crtfctList(mbrId);
	}
	// 자격증 추가
	@Override
	public int crtfctAddAjax(PrfCrtfctVO prfCrtfctVO) {
	    if (prfCrtfctVO.getCrtfctAcqsDate() != null) {
	        // 하이픈 제거
	        String formattedDate = prfCrtfctVO.getCrtfctAcqsDate().replace("-", "");
	        prfCrtfctVO.setCrtfctAcqsDate(formattedDate);
	    }
        
		return this.memProfileMapper.crtfctAddAjax(prfCrtfctVO);
	}
	// 자격증 수정
	@Override
	public int crtfctUpdateAjax(PrfCrtfctVO prfCrtfctVO) {
		
	    if (prfCrtfctVO.getCrtfctAcqsDate() != null) {
	        // 하이픈 제거
	        String formattedDate = prfCrtfctVO.getCrtfctAcqsDate().replace("-", "");
	        prfCrtfctVO.setCrtfctAcqsDate(formattedDate);
	    }
	    
		return this.memProfileMapper.crtfctUpdateAjax(prfCrtfctVO);
	}

	// 자격증 삭제
	@Override
	public int crtfctDelAjax(Map<String, Object> map) {
		return this.memProfileMapper.crtfctDelAjax(map);
	}


	
	// 수상 내역 조회
	@Override
	public List<PrfWnpzVO> WnpzList(String mbrId) {
		return this.memProfileMapper.WnpzList(mbrId);
	}
	// 수상 추가
	@Override
	public int WnpzAddAjax(PrfWnpzVO prfWnpzVO) {
		
	    if (prfWnpzVO.getWnpzPssrpYm() != null) {
	        // 하이픈 제거
	        String formattedDate = prfWnpzVO.getWnpzPssrpYm().replace("-", "");
	        prfWnpzVO.setWnpzPssrpYm(formattedDate);
	    }
	    
		return this.memProfileMapper.WnpzAddAjax(prfWnpzVO);
	}

	// 수상 수정
	@Override
	public int wnpzUpdateAjax(PrfWnpzVO prfWnpzVO) {
		
	    if (prfWnpzVO.getWnpzPssrpYm() != null) {
	        // 하이픈 제거
	        String formattedDate = prfWnpzVO.getWnpzPssrpYm().replace("-", "");
	        prfWnpzVO.setWnpzPssrpYm(formattedDate);
	    }
	    
		return this.memProfileMapper.wnpzUpdateAjax(prfWnpzVO);
	}

	// 수상 삭제
	@Override
	public int WnpzDelAjax(Map<String, Object> map) {
		return this.memProfileMapper.WnpzDelAjax(map);
	}

	
	// 활동 내역 조회
	@Override
	public List<PrfActVO> ActList(String mbrId) {
		return this.memProfileMapper.ActList(mbrId);
	}
	// 활동 추가
	@Override
	public int actAddAjax(PrfActVO prfActVO) {
		
	    if (prfActVO.getActBeginYm()!= null) {
	        // 하이픈 제거
	        String formattedDate = prfActVO.getActBeginYm().replace("-", "");
	        prfActVO.setActBeginYm(formattedDate);
	    }
	    if (prfActVO.getActEndYm()!= null) {
	    	// 하이픈 제거
	    	String formattedDate = prfActVO.getActEndYm().replace("-", "");
	    	prfActVO.setActEndYm(formattedDate);
	    }
	    
	    
		return this.memProfileMapper.actAddAjax(prfActVO);
	}
	// 활동 수정
	@Override
	public int actUpdateAjax(PrfActVO prfActVO) {
		
	    if (prfActVO.getActBeginYm()!= null) {
	        // 하이픈 제거
	        String formattedDate = prfActVO.getActBeginYm().replace("-", "");
	        prfActVO.setActBeginYm(formattedDate);
	    }
	    if (prfActVO.getActEndYm()!= null) {
	    	// 하이픈 제거
	    	String formattedDate = prfActVO.getActEndYm().replace("-", "");
	    	prfActVO.setActEndYm(formattedDate);
	    }
	    
		return this.memProfileMapper.actUpdateAjax(prfActVO);
	}
	// 활동 삭제
	@Override
	public int actDelAjax(Map<String, Object> map) {
		return this.memProfileMapper.actDelAjax(map);
	}

	
	// 업종 조회
	@Override
	public List<PrfBusinessVO> BusinessList(String mbrId) {
		return this.memProfileMapper.BusinessList(mbrId);
	}
	
	// 업종 추가
	@Transactional
	@Override
	public int BusinessAdd(PrfBusinessVO prfBusinessVO) {
		List<PrfBusinessVO> businessVOList = new ArrayList<PrfBusinessVO>();
	    
	    int result = 0;

	    ////PrfBusinessVO(tpbizSeCd=null, mbrId=test1, tpbizNm=null, business=[INSE07, INSE11, INSE19], businessStr=null)
	    
	    //1. test1 사용자의 업종 선택 정보를 모두 삭제(3개 -> 0개)
	    //DELETE FROM PRF_BUSINESS WHERE MBR_ID = 샵{mbrId}
	    result += this.memProfileMapper.BusinessDelAjax(prfBusinessVO);
	    
	    // 각각의 업종을 처리하여 DB에 insert
	    //2. 그 다음 insert
	    for (String businessCode : prfBusinessVO.getBusiness()) {
	        PrfBusinessVO vo = new PrfBusinessVO();
	        vo.setMbrId(prfBusinessVO.getMbrId()); 
	        vo.setTpbizSeCd(businessCode);         

	        // DB에 insert 실행 (반복문을 돌면서 여러 번 실행)
	        result += this.memProfileMapper.BusinessAdd(vo);
	        
	        businessVOList.add(vo);
	    }

	    // 삽입된 레코드 수를 반환 (삽입된 업종의 개수)
	    return result;
	}

	// 업종 삭제
	@Override
	public int BusinessDelAjax(PrfBusinessVO prfBusinessVO) {
		return this.memProfileMapper.BusinessDelAjax(prfBusinessVO);
	}
	
	// 스킬 조회
	@Override
	public List<PrfSkillVO> skillList(String mbrId) {
		return this.memProfileMapper.skillList(mbrId);
	}
	
	// 스킬 추가
	@Override
	@Transactional
	public int skillAdd(PrfSkillVO prfSkillVO) {
		int result = 0;
		
			String skCd = prfSkillVO.getSkCd();
			String[] skCdArr = skCd.split(",");
		    //1. test1 사용자의 스킬 선택 정보를 모두 삭제(3개 -> 0개)
		    //DELETE FROM PRF_SKILL WHERE MBR_ID = 샵{mbrId}
			result += this.memProfileMapper.skillDel(prfSkillVO);
			log.error("Failed to add skill with code: " + prfSkillVO.getSkCd());

		    //2. 그 다음 insert
			for(int i = 0; i < skCdArr.length; i++) {
		        PrfSkillVO vo = new PrfSkillVO();
		        vo.setMbrId(prfSkillVO.getMbrId()); 
		        vo.setSkCd(skCdArr[i]);         
		        int addResult = 0;
		     // DB에 insert 실행
		        if(skCdArr[i] != null || skCdArr[i].trim() != "") {
		        	addResult = this.memProfileMapper.skillAdd(vo);
		        }
		        if (addResult > 0) {
		            result += addResult; // 인서트가 성공한 경우에만 결과에 추가
		        } else {
		            log.error("Failed to add skill with code: " + skCd);
		        }
		    }

		return result;
	}
	
	// 스킬 삭제
	@Override
	public int skillDel(PrfSkillVO prfSkillVO) {
		return this.memProfileMapper.skillDel(prfSkillVO);
	}

	
	

}
