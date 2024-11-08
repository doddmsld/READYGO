package kr.or.ddit.enter.entservice.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.enter.entservice.VideoService;
import kr.or.ddit.mapper.VideoMapper;
import kr.or.ddit.vo.VideoRoomVO;

@Transactional
@Service
public class VideoServiceImpl implements VideoService{
	
	@Inject
	VideoMapper videoMapper;

	@Override
	public void videointrvwPost(VideoRoomVO videoRoomVO) {
		this.videoMapper.videointrvwPost(videoRoomVO);
		
	}

	@Override
	public int deleteVideoRoom(String vcrNo) {
		// TODO Auto-generated method stub
		return this.videoMapper.deleteVideoRoom(vcrNo);
	}
	
}
