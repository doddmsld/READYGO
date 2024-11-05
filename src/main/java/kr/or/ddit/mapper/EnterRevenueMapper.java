package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.EnterEmpYcntVO;
import kr.or.ddit.vo.EnterRevenueVO;

public interface EnterRevenueMapper {
	//매출액
	List<EnterRevenueVO> revenue(String entId);

	int insertRevenues(EnterRevenueVO enterRevenueVO);

	int updateRevenues(EnterRevenueVO enterRevenueVO);

	int updateYcnt(EnterEmpYcntVO enterEmpYcntVO);

	int insertYcnt(EnterEmpYcntVO enterEmpYcntVO);

}
