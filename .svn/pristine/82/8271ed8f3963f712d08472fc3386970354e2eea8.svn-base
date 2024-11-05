package kr.or.ddit.enter.entcontroller;



import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kotlinx.serialization.json.JsonObject;
import kr.or.ddit.enter.entservice.EnterServiceS;
import kr.or.ddit.enter.entservice.VideoService;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.VideoRoomVO;
import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Slf4j
@Controller
@RequestMapping("/video")
public class VideoController {
	
	@Inject
	VideoService videoService;
	
	@Inject
	EnterServiceS enterServiceS;
	
	@Inject
	GetUserUtil getUserUtil;
	
	/*목록창*/
	@GetMapping("/home")
	public String videoHome(Model model) throws Exception{
		OkHttpClient client = new OkHttpClient();
		
		
		//목록 조회
		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
		  .get()
		  .addHeader("accept", "application/json")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();

		Response response = client.newCall(request).execute();
		JSONObject jsonObj;
		try {
		    JSONParser jsonParser = new JSONParser();
		    Object obj = jsonParser.parse(response.body().string());
		    jsonObj = (JSONObject) obj;

		    log.info("jsonObj: " + jsonObj);
		} finally {
		    response.close();  // 명시적으로 응답을 닫음
		}
		model.addAttribute("roomList",jsonObj);
		
		return "video/video";
	}
	
	/*목록창*/
	@GetMapping("/member/home")
	public String memberVideoHome(Model model) throws Exception{
		OkHttpClient client = new OkHttpClient();
		
		
		//목록 조회
		Request request = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
				.get()
				.addHeader("accept", "application/json")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				.build();
		
		Response response = client.newCall(request).execute();
		JSONObject jsonObj;
		try {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse(response.body().string());
			jsonObj = (JSONObject) obj;
			
			log.info("jsonObj: " + jsonObj);
		} finally {
			response.close();  // 명시적으로 응답을 닫음
		}
		model.addAttribute("roomList",jsonObj);
		
		return "video/video";
	}
	
	
	/*화상면접방생성 방생성모달 form태그*/
	@PostMapping("/videointrvwPost")
	public String videointrvwPost(VideoRoomVO videoRoomVO) throws Exception{
		//vo 대입
		log.info("videoRoomVo : " + videoRoomVO);
		//방 생성
		OkHttpClient client = new OkHttpClient();

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, 
				"callType=P2P&liveMode=false&maxJoinCount="+videoRoomVO.getVcrMaxjoincount()
				+"&liveMaxJoinCount=100&layoutType=4&sfuIncludeAll=true&startDate="+videoRoomVO.getVcrStartdate()+
				"&roomTitle="+videoRoomVO.getVcrTitle()+"&roomUrlId="+videoRoomVO.getVcrRoomurlid()
				+"&passwd="+videoRoomVO.getVcrPasswd()+"&endDate="+videoRoomVO.getVcrEnddate());
		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room")
		  .post(body)
		  .addHeader("accept", "application/json")
		  .addHeader("content-type", "application/x-www-form-urlencoded")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();
		
		Response response = client.newCall(request).execute();
		log.info("response : " + response);
		log.info("client : "+ client);
		JSONObject jsonObj;
		JSONParser jsonParser = new JSONParser();
	    Object obj = jsonParser.parse(response.body().string());
	    jsonObj = (JSONObject) obj;
	 // JSON 응답에서 data 객체를 추출
	    JSONObject dataObj = (JSONObject) jsonObj.get("data");
	    log.info("dataObj : "+ dataObj);
	    // dataObj에서 room 객체를 추출
	    JSONObject roomObj = (JSONObject) dataObj.get("room");
	    log.info("roomObj : "+ roomObj);
	    // roomId를 추출
	    String roomId = (String) roomObj.get("roomId");
		
	    // roomId 출력
	    log.info("roomId: " + roomId);
	    videoRoomVO.setVcrRoomid(roomId);
		this.videoService.videointrvwPost(videoRoomVO);
		
		return "redirect:/enter/videointrvw?entId="+videoRoomVO.getEntId();
		
	}
	
	
	@PostMapping("/deleteroom")
	@ResponseBody
	public int deleteroom(@RequestBody Map<String,Object> value) throws Exception{
		String vcrRoomid = value.get("vcrRoomid").toString();
		String vcrNo = value.get("vcrNo").toString();
		
		//방 삭제
		OkHttpClient client = new OkHttpClient();

		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/"+vcrRoomid)
		  .delete(null)
		  .addHeader("accept", "application/json")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();

		Response response = client.newCall(request).execute();
		
		int result = this.videoService.deleteVideoRoom(vcrNo);
		
		return result;
	}
	
	
	@PostMapping("/connectroom")
	@ResponseBody
	public JSONObject connectroom(@RequestBody Map<String,Object> value) throws Exception{
		String roomName = value.get("value").toString();
//		String entId = value.get("entId").toString();
		String entId = "";
		
		MemberVO memVO = getUserUtil.getMemVO();
		EnterVO entVO = getUserUtil.getEntVO();
		if(memVO != null){
			entId = memVO.getMbrNm();
		}
		if(entVO != null) {
			entId = entVO.getEntNm();
		}
		//접속 경로 생성
		OkHttpClient client = new OkHttpClient();
	
		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, "roleId=participant&apiUserId="+entId+"&ignorePasswd=false&roomId="+roomName+"&username="+entId);
		Request request = new Request.Builder()
		  .url("https://openapi.gooroomee.com/api/v1/room/user/otp/url")
		  .post(body)
		  .addHeader("accept", "application/json")
		  .addHeader("content-type", "application/x-www-form-urlencoded")
		  .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
		  .build();
		JSONObject jsonObj;
		Response response = client.newCall(request).execute();
		try {
		    JSONParser jsonParser = new JSONParser();
		    Object obj = jsonParser.parse(response.body().string());
		    jsonObj = (JSONObject) obj;

		    log.info("jsonObj: " + jsonObj);
		} finally {
		    response.close();  // 명시적으로 응답을 닫음
		}
		
		return jsonObj;
	}
	
	
}
