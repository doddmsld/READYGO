package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.NotificationVO;

public interface NotificationMapper {

	public void sendAlram(NotificationVO notificationVO);

	public List<NotificationVO> alramList(String loggedInUser);

	public int alramDel(String ntcnNo);

	public int alramAllDel(String commonId);

	public int alramTotal(Map<String, Object> map);

	public List<NotificationVO> memAlramList(Map<String, Object> map);

	public int selectAlramAllDel(List<String> ntcnNoList);

	public int alramRealAllDel(String commonId);

	public int alramLinkClick(String ntcnNo);

	public int getAlramCnt(String userId);

}