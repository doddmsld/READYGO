package kr.or.ddit.impl_DO;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import kr.or.ddit.mapper.AdminMapper;
import kr.or.ddit.service_DO.AdminService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeGrpVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.DeclarationVO;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.FileDetailVO;
import kr.or.ddit.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

    @Inject
    AdminMapper adminMapper;
    
    @Override
    public List<CodeVO> codeManage(String comCodeGrp) {
        // 공통 코드 그룹에 따라 필터링하여 목록을 반환
        return adminMapper.codeManage(comCodeGrp);
    }

	@Override
	public int codeGrpAdd(CodeGrpVO codeGrpVO) {
		return adminMapper.codeGrpAdd(codeGrpVO);
	}

	@Override
	public int codeGrpDel(CodeGrpVO codeGrpVO) {
		return adminMapper.codeGrpDel(codeGrpVO);
	}

	@Override
	public int codeAdd(CodeVO codeVO) {
		return adminMapper.codeAdd(codeVO);
	}

	@Override
	public int codeDel(String comCode) {
		return adminMapper.codeDel(comCode);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.getTotal(map);
	}

	//기업관리 시작
	@Override
	public int entOk(String entId) {
		return adminMapper.entOk(entId);
	}

	@Override
	public int entNo(String entId) {
		return adminMapper.entNo(entId);
	}

	@Override
	public EnterVO entDetail(String entId) {
		return adminMapper.enterDetail(entId);
	}

	@Override
	public String memManage() {
		return adminMapper.memManage();
	}

	@Override
	public String main() {
		return adminMapper.main();
	}

	@Override
	public int memTotal(Map<String, Object> memMap) {
		return adminMapper.memTotal(memMap);
	}

	@Override
	public List<MemberVO> memList(Map<String, Object> memMap) {
		return adminMapper.memList(memMap);
	}

	@Override
	public int entTotal(Map<String, Object> entMap) {
		return adminMapper.entTotal(entMap);
	}

	@Override
	public List<EnterVO> entList(Map<String, Object> entMap) {
		return adminMapper.entList(entMap);
	}

	@Override
	public int reportTotal(Map<String, Object> reportMap) {
		return adminMapper.reportTotal(reportMap);
	}

	@Override
	public List<DeclarationVO> reportList(Map<String, Object> reportMap) {
		return adminMapper.reportList(reportMap);
	}

	@Override
	public int boardReport(Map<String, Object> paramMap) {
		return adminMapper.boardReport(paramMap);
	}

	@Override
	public int reportBoardDel(String dclrNo) {
		DeclarationVO declarationVO = new DeclarationVO();
		declarationVO.setDclrNo(dclrNo);
		return adminMapper.reportBoardDel(declarationVO);
	}


	@Override
	public int mainEntSignTotal() {
		return adminMapper.mainEntSignTotal();
	}
	
	@Override
	public int mainInquiryTotal() {
		return adminMapper.mainInquiryTotal();
	}
	
	@Override
	public int mainReportMemTotal() {
		return adminMapper.mainReportMemTotal();
	}
	
	@Override
	public int mainReportBoardTotal() {
		return adminMapper.mainReportBoardTotal();
	}

	@Override
	public List<DeclarationVO> mainReportList() {
		return adminMapper.mainReportList();
	}

	@Override
	public List<BoardVO> mainNoticeList() {
		return adminMapper.mainNoticeList();
	}

	@Override
	public List<BoardVO> mainInquiryList() {
		return adminMapper.mainInquiryList();
	}

	@Override
	public List<EnterVO> mainEntList() {
		return adminMapper.mainEntList();
	}

	@Override
	public int reportLimit(Map<String, Object> paramMap) {
		return adminMapper.reportLimit(paramMap);
	}

	@Override
	public int codeCodeCh(Map<String, Object> paramMap) {
		return adminMapper.codeCodeCh(paramMap);
	}

    @Override
    public EnterVO getEnterDetail(String entId) {
        EnterVO enterDetail = adminMapper.enterDetail(entId);
        // 파일 정보 가져오기
        List<FileDetailVO> getEntBrFile = this.getEntBrFile(entId);
        // 파일 정보를 EnterVO에 추가
        enterDetail.setFileDetailVOList(getEntBrFile);
        
        return enterDetail;
    }

    @Override
    public List<FileDetailVO> getEntBrFile(String entId) {
        return adminMapper.getEntBrFile(entId); // 파일 정보 매퍼 호출
    }

	@Override
	public List<DeclarationVO> reportBoardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.reportBoardList(map);
	}

	@Override
	public List<EnterVO> enterList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.enterList(map);
	}

}
