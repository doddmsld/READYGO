package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.CodeGrpVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.UserVO;

public interface UserMapper {
	public UserVO userLogin(String username);
	
	public int idChk(String username);
	
	public List<CodeVO> codeSelect(String comCodeGrp);
	
	public List<CodeGrpVO> codeGrpSelect(List<String> list);
	
	public int insertMember(MemberVO memVO);
	
	public int insertEnter(EnterVO entVO);

	public Integer remainDays(String mbrId);

	public int warnClear(String mbrId);

	public int insertProfile(MemberVO memVO);

	public List<String> selectUserIdList(Map<String, Object> map);

	public String selectUserId(Map<String, Object> map);

	public int updateMemPswd(Map map);

	public int updateEntPswd(Map map);
	
}
