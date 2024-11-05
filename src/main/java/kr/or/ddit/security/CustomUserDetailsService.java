package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mapper.AdminMapper;
import kr.or.ddit.mapper.EnterMapper;
import kr.or.ddit.mapper.MemberMapper;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.vo.AdminVO;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    UserMapper userMapper;
    @Autowired
    MemberMapper memMapper;
    @Autowired
    EnterMapper enterMapper;
    @Autowired
    AdminMapper adminMapper;
    
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserVO userVO = userMapper.userLogin(username);
        
        if (userVO == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        }

        switch (userVO.getUserType()) {
            case "1":
                return getCustomUserFromMember(username);
            case "2":
                return getCustomUserFromEnter(username);
            case "3":
                return getCustomUserFromAdmin(username);
            default:
                throw new UsernameNotFoundException("유효하지 않은 사용자 유형입니다.");
        }
    }

    private UserDetails getCustomUserFromMember(String username) {
        MemberVO memVO = memMapper.selectOne(username);
        if (memVO == null) {
            throw new UsernameNotFoundException("회원 정보를 찾을 수 없습니다.");
        }
        return new CustomUser(memVO);
    }

    private UserDetails getCustomUserFromEnter(String username) {
        EnterVO entVO = enterMapper.selectOne(username);
        if (entVO == null) {
            throw new UsernameNotFoundException("기업 정보를 찾을 수 없습니다.");
        }
        return new CustomUser(entVO);
    }

    private UserDetails getCustomUserFromAdmin(String username) {
        AdminVO admVO = adminMapper.selectOne(username);
        if (admVO == null) {
            throw new UsernameNotFoundException("관리자 정보를 찾을 수 없습니다.");
        }
        return new CustomUser(admVO);
    }
}
