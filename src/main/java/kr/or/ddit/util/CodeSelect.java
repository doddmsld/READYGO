package kr.or.ddit.util;

import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Component;

import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.vo.CodeGrpVO;
import kr.or.ddit.vo.CodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CodeSelect {
	
	@Inject
	UserMapper userMapper;
	
	public Map<String, CodeGrpVO> codeGrpSelect(List<String> list) {
	    List<CodeGrpVO> resultList = userMapper.codeGrpSelect(list);
	    return resultList.stream().collect(Collectors.toMap(CodeGrpVO::getComCodeGrp, Function.identity()));
	}
	
	public List<CodeVO> codeSelect(String code) {
		log.debug("code : " + code);
		List<CodeVO> res = userMapper.codeSelect(code);
		return res;
	}
}
