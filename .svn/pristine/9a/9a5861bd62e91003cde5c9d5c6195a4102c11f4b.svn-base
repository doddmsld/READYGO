package kr.or.ddit.impl_DO;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.FAQMapper;
import kr.or.ddit.service_DO.FAQService;
import kr.or.ddit.vo.BoardVO;

@Service
public class FAQServiceImpl implements FAQService {

	@Inject
	FAQMapper faqMapper;

	@Override
	public String admRegist() {
		return this.faqMapper.admRegist();
	}

	@Override
	public int admRegistPost(BoardVO boardVO) {
		int result=0;
		return this.faqMapper.admRegistPost(boardVO);
	}

	@Override
	public List<BoardVO> admList() {
		return this.faqMapper.admList();
	}

	@Override
	public int getTotal() {
		return this.faqMapper.getTotal();
	}

	@Override
	public int deletePost(String pstSn) {
		return this.faqMapper.deletePost(pstSn);
	}

	@Override
	public BoardVO getPostDetails(String pstSn) {
		return this.faqMapper.getPostDetails(pstSn);
	}

	@Override
	public int updatePost(BoardVO boardVO) {
		return this.faqMapper.updatePost(boardVO);
	}

	@Override
	public String update(String pstSn) {
		return this.faqMapper.update(pstSn);
	}
}
