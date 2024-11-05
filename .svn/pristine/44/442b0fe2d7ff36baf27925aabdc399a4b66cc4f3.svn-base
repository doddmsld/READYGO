package kr.or.ddit.security;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.service.LoginService;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/security")
public class LoginController {
	
	//<security:form-login login-page="/login" />
	//요청URI : /login
	//요청방식 : get
	//오류 메시지와 로그아웃 메시지를 파라미터로 사용해보자(없을 수도 있음)
	
	@Inject
	LoginService loginService;
	
	@Inject
	UserMapper userMapper;
	
	@Inject
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Inject
	UserService userService;
	
	//회원 로그인폼
	@GetMapping("/login")
	public String loginForm(String error, String logout, Model model, HttpSession session) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		log.info("logout : " + model);
		// 로그인 실패시 메시지
		String prevPage = "";
		if(session.getAttribute("prevPage")!= null) {
			prevPage = (String) session.getAttribute("prevPage");
		}
		
		if(error != null) {
			model.addAttribute("error", "로그인 실패");
			if(prevPage.equals("enter")) {
				return "enter/main/entLoginForm";
			}
			if(prevPage.equals("admin")) {
				return "security/admLoginForm";
			}
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃");
		}
		//forwarding
		session.removeAttribute("prevPage");
		return "security/loginForm";
	}
	// 기업 로그인 폼
	@GetMapping("/entLogin")
	public String entLoginForm(String error, String logout, Model model, HttpSession session) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		log.info("logout : " + model);
		session.setAttribute("prevPage", "enter");
		if(error != null) {
			model.addAttribute("error", "로그인 실패");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
		//forwarding
		return "enter/main/entLoginForm";
	}
	
	// 관리자 로그인폼
	@GetMapping("/admLogin")
	public String admLoginForm(String error, String logout, Model model, HttpSession session) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		log.info("logout : " + model);
		session.setAttribute("prevPage", "admin");

		if(error != null) {
			model.addAttribute("error", "로그인 실패");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
		//forwarding
		return "security/admLoginForm";
	}
	
	// 회원 회원가입 폼
	@GetMapping("/memSignin")
	public String memSignIn(Model model) {
		log.info("회원가입 페이지에 왔다");
		List<CodeVO> codeVOList = userMapper.codeSelect("GEND");
		//forwarding
		model.addAttribute("codeVOList", codeVOList);
		return "security/memSignin";
	}
	
	// 아이디 중복검사 ajax
	@ResponseBody
	@PostMapping("/idChkAjax")
	public boolean idChkAjax(@RequestBody String username) {
		log.info("아이디 체크 => " + username);
		boolean chk = true;
		int result = loginService.idChk(username);
		if(result > 0) chk = false;
		//forwarding
		return chk;
	}
	
	// 회원 회원가입 post ajax
	@ResponseBody
	@PostMapping("/memSigninPostAjax")
	public String memSigninPost(@ModelAttribute MemberVO memVO,
			Model model) {
		log.info("memVO => " + memVO);
		String encodePWd = bcryptPasswordEncoder.encode(memVO.getMbrPswd());
		memVO.setMbrPswd(encodePWd);
		userService.insertMember(memVO);
		
		//forwarding
		return memVO.getMbrId();
	}
	
	// 기업 회원가입 폼
	@GetMapping("/entSignin")
	public String entSignIn(Model model) {
		log.info("기업 회원가입 페이지에 왔다");
		List<CodeVO> codeVOList = userMapper.codeSelect("ENST");
		List<CodeVO> codeVOList2 = userMapper.codeSelect("INSE");
		//forwarding
		model.addAttribute("codeVOList", codeVOList);
		model.addAttribute("codeVOList2", codeVOList2);
		return "enter/main/entSignin";
	}
	
	// 기업 회원가입 post ajax
	@ResponseBody
	@PostMapping("/entSigninPostAjax")
	public String entSigninPostAjax(@ModelAttribute EnterVO entVO,
			Model model) {
		log.info("entVO => " + entVO);
		String encodePWd = bcryptPasswordEncoder.encode(entVO.getEntPswd());
		entVO.setEntPswd(encodePWd);
		userService.insertEnter(entVO);
		
		//forwarding
		return entVO.getEntNm();
	}

	// 비밀번호 찾기 폼
	@GetMapping("/bibunFind")
	public String bibunFind() {
		return "security/bibunFind";
	}
	
	// 아이디 불러오기
	@ResponseBody
	@PostMapping("/bibunFindPostAjax")
	public String bibunFindPost(String userId, String userName, String phoneNum){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userName", userName);
		map.put("phoneNum", phoneNum);
		String id = userMapper.selectUserId(map);
		
		return id;
	}
	// 비밀번호 재설정
	@ResponseBody
	@PostMapping("/bibunChangePostAjax")
	public int bibunChangePostAjax(String userId, String password){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		password = bcryptPasswordEncoder.encode(password);
		map.put("password", password);
		int result = userService.upDateUserPassword(map);
		
		return result;
	}
	
	// 아이디 찾기 폼
	@GetMapping("/idFind")
	public String idFind() {
		return "security/idFind";
	}
	// 아이디 리스트 불러오기
	@ResponseBody
	@PostMapping("/idFindPostAjax")
	public List<String> idFindPostAjax(String userId, String userName, String phoneNum){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userName", userName);
		map.put("phoneNum", phoneNum);
		List<String> idList = userService.idFindPost(map);
		
		return idList;
	}
}
