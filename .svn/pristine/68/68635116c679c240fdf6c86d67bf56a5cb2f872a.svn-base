package kr.or.ddit.kakaoLogin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.KakaoLoginMapper;
import kr.or.ddit.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequiredArgsConstructor
@Service
public class KakaoLoginServiceImpl implements KakaoLoginService {
	
	
	@Autowired
	KakaoLoginMapper kakaoLoginMapper ;
	
	// 이메일로 사용자를 찾는 메서드
	@Override
    public MemberVO getMemEmail(String email) {
        return kakaoLoginMapper.getMemEmail(email);
    }
	
	
	
}
