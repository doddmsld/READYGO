package kr.or.ddit.mapper;

import kr.or.ddit.vo.OsAplyVO;
import kr.or.ddit.vo.SettlementVO;

public interface OutsouPayMapper {

	//구매한 사람 내용 저장 
	public int insertOsAplyVO(OsAplyVO osAplyVO );
	
	//결제 정보 저장 
	public int insertSettlement(SettlementVO settlementVO );
	
	//날짜 갯수 구하기
	public int getOrderCountForToday( );
	

	
	
}
