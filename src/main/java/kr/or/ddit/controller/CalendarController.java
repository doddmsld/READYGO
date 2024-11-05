package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.CalendarService;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_MEMENTER')")
@RestController
@Controller
@Slf4j
@RequestMapping("/member")
public class CalendarController {
	
	@Inject
	CalendarService calendarService;
	
    @Inject
    GetUserUtil getUserUtil;

	//목록 불러오기
	@RequestMapping(value="/calendar",method=RequestMethod.GET)
	public ModelAndView calendar(ModelAndView mav) {
		
		String mbrId = getUserUtil.getLoggedInUserId();
		
		Map<String, Object> map = new HashMap<String,Object>();
        map.put("mbrId", mbrId);
		List<PbancVO> scrapList = this.calendarService.scrapList(map);
		List<ScheduleVO> scheduleList = this.calendarService.scheduleList(map);
		
		List<PbancVO> calendarList = this.calendarService.calendarList(mbrId);
		List<ScheduleVO> calendarList2 = this.calendarService.calendarList2(mbrId);
		log.info("calendarList : "+calendarList);
		
		
		mav.addObject("mbrId", mbrId);
		mav.addObject("scrapList",scrapList);
		mav.addObject("scheduleList",scheduleList);
		
		mav.addObject("calendarList",calendarList);
		mav.addObject("calendarList2",calendarList2);
		
		mav.setViewName("member/mypage/calendar");
		
		return mav;
	}
	
	//일정 저장
	@ResponseBody
	@RequestMapping(value="/saveEvent", method=RequestMethod.POST)
	public ResponseEntity<Integer> saveEvent(
			@RequestBody Map<String, Object> event) {
		log.info("Received event: " + event);
		
		String mbrId = getUserUtil.getLoggedInUserId();
		
		// 필요한 정보 추출
		String title = (String) event.get("title");
		String start = (String) event.get("start");
		String end = (String) event.get("end");
		boolean allDay = (Boolean) event.get("allDay");
		String backgroundColor = (String) event.get("backgroundColor");
		String textColor = (String) event.get("textColor");
		
		log.info("Received allDay: " + allDay);
		// allDay 값을 "Y" 또는 "N"으로 변환
	    String allDayValue = allDay ? "Y" : "N";
	    
		// scheduleList 메서드 호출하여 DB에 저장
		Map<String, Object> map = new HashMap<>();
		map.put("mbrId", mbrId);
		map.put("title", title);
		map.put("start", start);
		map.put("end", end);
		map.put("allDay", allDayValue);
		map.put("backgroundColor", backgroundColor);
		map.put("textColor", textColor);

		// DB에 저장하는 메서드 호출
		int result = this.calendarService.scheduleInsert(map);
	    return ResponseEntity.ok(result);
	}
	
	// 일정 업데이트
    @GetMapping("/getScheduleList")
    public ResponseEntity<List<ScheduleVO>> getScheduleList() {
        
    	String mbrId = getUserUtil.getLoggedInUserId();
    	
    	Map<String, Object> map = new HashMap<>();
		map.put("mbrId", mbrId);
		
    	List<ScheduleVO> scheduleList = this.calendarService.scheduleList(map);
		log.info("scheduleList-dd : " + scheduleList);
        return ResponseEntity.ok(scheduleList);
    }
    
    //일정 삭제
    @ResponseBody
    @RequestMapping(value = "/deleteEvent", method = RequestMethod.DELETE)
    public int deleteEvent(@RequestBody Map<String, Object> request) {
    	String mbrId = getUserUtil.getLoggedInUserId();
        String eventId = (String) request.get("id"); // 요청에서 ID 가져오기
        
        Map<String, Object> map = new HashMap<>();
		map.put("mbrId", mbrId);
		map.put("eventId", eventId);
		
        // 이벤트 삭제 서비스 호출
        int result = this.calendarService.deleteEvent(map);
        return result;
    }

}
