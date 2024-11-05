package kr.or.ddit.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.service.LoginService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	UserMapper userMapper;
	
	@Override
	public int idChk(String username) {
		int result = userMapper.idChk(username); 
		log.info("result => " + result);
		
		return result;
	}
}
