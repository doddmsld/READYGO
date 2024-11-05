package kr.or.ddit.security;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/error")
public class ErrorController {

	@GetMapping("/error400")
	public String error400() {
		log.info("error400페이지에 왔따리");
		
		return "error/error400";
	}
	@GetMapping("/error404")
	public String error404() {
		log.info("error404페이지에 왔따리");
		
		return "error/error404";
	}
	@GetMapping("/error500")
	public String error500() {
		log.info("error500페이지에 왔따리");
		
		return "error/error500";
	}
	
}
