package kr.or.ddit.controller_DO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.service_DO.NoticeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.FileDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/adm/notice")
@Controller
public class AdmNoticeController {

	@Inject
	NoticeService noticeService;

	@Autowired
	UserMapper userMapper;

	@Inject
	FileDetailMapper fileDetailMapper;

	@GetMapping("/admNoticeRegist")
	public String admRegist(Model model) {
		List<CodeVO> codeVOList = userMapper.codeSelect("NOCA");
		log.info("codeVOList", codeVOList);

		model.addAttribute("codeVOList", codeVOList);

		return "adm/notice/admNoticeRegist";
	}

	@PostMapping("/admRegistPost")
	public String admRegistPost(@ModelAttribute BoardVO boardVO) {
		// 로그인한 사용자 정보 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String mbrId = authentication.getName(); // 로그인한 사용자 이름 (id)

		// boardVO의 작성자(writer) 필드에 로그인한 사용자 설정
		boardVO.setMbrId(mbrId);

		String fileGroupSn = this.fileDetailMapper.getFileGroupSn();
		boardVO.setFileGroupSn(fileGroupSn);

		log.info("registPost->boardVO : " + boardVO);
		int result = this.noticeService.admRegistPost(boardVO);
		log.info("registPost->result : " + result);

		return "redirect:/adm/notice/admNoticeDetail?seNo=1" + "&pstSn=" + boardVO.getPstSn();
	}

	@RequestMapping(value = "/admNoticeList", method = RequestMethod.GET)
	public ModelAndView admList(ModelAndView mav,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		log.info("list->map : " + map);

		List<BoardVO> boardVOList = this.noticeService.admList(map);

		int total = this.noticeService.getTotal();

		// JSP로 전달하기 위해 Model 객체에 boardVOList 저장
		mav.addObject("boardVOList", boardVOList);

		// 페이지네이션 객체
		ArticlePage<BoardVO> articlePage = new ArticlePage<BoardVO>(total, currentPage, 10, boardVOList, map);
		log.info("articlePage : " + articlePage);

		mav.addObject("articlePage", articlePage);

		mav.setViewName("adm/notice/admNoticeList");

		return mav;
	}

	@GetMapping("/admNoticeDetail")
	public String admDetail(@RequestParam("pstSn") String pstSn, Model model) {
		log.info("detail=> getpstSn : " + pstSn);

		// 조회수 증가 호출
		this.noticeService.InqCnt(pstSn);

		// 상세정보 가져오기
		BoardVO boardVO = this.noticeService.admDetail(pstSn);
		model.addAttribute("boardVO", boardVO);

		// 파일 상세 정보 가져오기
		List<FileDetailVO> fileDetails = this.noticeService.getFileDetailsByPstSn(pstSn);
		model.addAttribute("fileDetails", fileDetails); // 파일 상세 정보 추가

		// 로그인한 사용자 ID 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String mbrId = authentication.getName();
		model.addAttribute("loggedInUser", mbrId);

		return "adm/notice/admNoticeDetail";
	}

	@GetMapping("/admNoticeUpdate")
	public String update(@RequestParam("pstSn") String pstSn, Model model) {
		log.info("update => get pstSn : " + pstSn);
		List<CodeVO> codeVOList = userMapper.codeSelect("NOCA");
		log.info("codeVOList", codeVOList);

		// 게시글 상세 정보 가져오기
		BoardVO boardVO = this.noticeService.getPostDetails(pstSn);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("codeVOList", codeVOList);
		String fileGroupSn = this.fileDetailMapper.getFileGroupSn();
		model.addAttribute(fileGroupSn);
		// 파일 상세 정보 가져오기
		List<FileDetailVO> fileDetails = this.noticeService.getFileDetailsByPstSn(pstSn);
		model.addAttribute("fileDetails", fileDetails); // 파일 상세 정보 추가
		return "adm/notice/admNoticeUpdate"; // 수정 페이지로 이동
	}

	@PostMapping("/deletePost")
	public String deletePost(@RequestParam("pstSn") String pstSn) {
		log.info("deletePost -> getpstSn : " + pstSn);

		// 게시글 삭제
		int result = noticeService.deletePost(pstSn); // 서비스에서 게시글 삭제
		if (result > 0) {
			log.info("게시글 삭제 성공");
		} else {
			log.info("게시글 삭제 실패");
		}

		return "redirect:/adm/notice/admNoticeList"; // 삭제 후 목록 페이지로 리디렉션
	}

	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute BoardVO boardVO) {
		log.info("updatePost -> boardVO : " + boardVO);

	    String fileGroupSn = this.fileDetailMapper.getFileGroupSn();
	    boardVO.setFileGroupSn(fileGroupSn);  
		// 수정된 데이터 업데이트
		int result = this.noticeService.updatePost(boardVO);

		// 수정된 게시글의 세부정보 페이지로 리디렉션
		return "redirect:/adm/notice/admNoticeDetail?seNo=1&pstSn=" + boardVO.getPstSn();

	}

}
