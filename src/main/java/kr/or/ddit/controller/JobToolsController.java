package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.JobToolsService;
import kr.or.ddit.vo.LanguageVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/common/jobTools")
public class JobToolsController {
	
	@Autowired
	JobToolsService jobToolsService;
	
	@GetMapping(value="/spellingCheck")
	public String spellingCheck() {
		
		return "common/jobTools/spellingCheck";
	}
	
	@GetMapping(value="/salaryCal")
	public String salaryCal() {
		
		return "common/jobTools/salaryCal";
	}
	
	@GetMapping(value="/netPayCal")
	public String netPayCal() {
		
		return "common/jobTools/netPayCal";
	}
	
	@GetMapping(value="/creditTrans")
	public String creditTrans() {
		
		return "common/jobTools/creditTrans";
	}
	
	@GetMapping(value="/languageTrans")
	public String languageTrans() {
		
		return "common/jobTools/languageTrans";
	}
	
	// AJAX 요청 처리 메서드
    @GetMapping("/language")
    public ResponseEntity<List<LanguageVO>> getScore(
            @RequestParam(value = "score", required = false) int score,
            @RequestParam(value = "selectedOption", required = false) String selectedOption) {
    	
    	log.info("score : " + score);
    	log.info("selectedOption : " + selectedOption);
    	
    	Map<String,Object> map = new HashMap<String, Object>();
		map.put("score", score);
		map.put("selectedOption", selectedOption);
		
    	List<LanguageVO> convertScore = this.jobToolsService.getScore(map);
		log.info("convertScore : " + convertScore);
        return ResponseEntity.ok(convertScore);
    }

}
