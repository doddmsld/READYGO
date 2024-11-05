package kr.or.ddit.mapper;

import kr.or.ddit.vo.VideoRoomVO;

public interface VideoMapper {
	
	//화상방 생성
	void videointrvwPost(VideoRoomVO videoRoomVO);
	//화상방 삭제
	int deleteVideoRoom(String vcrNo);

}
