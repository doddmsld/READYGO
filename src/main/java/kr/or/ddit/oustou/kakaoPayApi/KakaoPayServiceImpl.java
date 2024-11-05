package kr.or.ddit.oustou.kakaoPayApi;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.mapper.OutsouPayMapper;
import kr.or.ddit.vo.OsAplyVO;
import kr.or.ddit.vo.SettlementVO;
import lombok.extern.slf4j.Slf4j;
import oracle.security.crypto.core.OAEPAlgorithmIdentifier;


@Slf4j
@Service
public class KakaoPayServiceImpl implements KakaoPayService {
	
	@Autowired
	OutsouPayMapper outsouPayMapper;
	
	// 카카오페이 결제창 연결
	@Override
	public ReadyResponse payReady(String title, int price,String mbrId, String outordNo, String setleMn ) {
	    // 오늘 날짜 가져오기 (주문 날짜)
	    LocalDate today = LocalDate.now();
	    String paymentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

	    // 결제 번호 생성
	    String stlmNo = generatePaymentNumber();

	    
	    
	    // 카카오페이 결제 준비 요청 파라미터 설정
	    Map<String, String> parameters = new HashMap<>();
	    parameters.put("cid", "TC0ONETIME");                                    // 가맹점 코드(테스트용)
	    parameters.put("partner_order_id", stlmNo);                             // 주문번호
	    parameters.put("partner_user_id", mbrId);                              // 회원 아이디
	    parameters.put("item_name", title);                                      // 상품명
	    parameters.put("quantity", "1");                                        // 상품 수량
	    parameters.put("total_amount", String.valueOf(price));             // 상품 총액
	    parameters.put("tax_free_amount", "0");                                 // 상품 비과세 금액
	    parameters.put("approval_url", "http://localhost/outsou/payok?mode=open");        // 결제 성공 시 이동할 URL
	    parameters.put("cancel_url", "http://localhost/outsou/pay/cancel");      // 결제 취소 시 URL
	    parameters.put("fail_url", "http://localhost/outsou/pay/fail");          // 결제 실패 시 URL

	    // HttpEntity : HTTP 요청 또는 응답에 해당하는 Http Header와 Http Body를 포함하는 클래스
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // RestTemplate
        // : Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
        //   REST API 호출 이후 응답을 받을 때까지 기다리는 동기 방식 (json, xml 응답)
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";
        // RestTemplate의 postForEntity : POST 요청을 보내고 ResponseEntity로 결과를 반환받는 메소드
        ResponseEntity<ReadyResponse> responseEntity = template.postForEntity(url, requestEntity, ReadyResponse.class);
        log.info("결제준비 응답객체: " + responseEntity.getBody());

        return responseEntity.getBody();
	}
	

    // 카카오페이 결제 승인
    // 사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
    // 최종적으로 결제 완료 처리를 하는 단계
	// 이곳에서 DB에 저장이 되어야함 
	@Override
	public AproveResponse payApprove(String tid, String pgToken, String mbrId, String outordNo, String setleMn, int price) {
	    // 오늘 날짜 가져오기 (주문 날짜)
	    LocalDate today = LocalDate.now();
	    String paymentDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

	    
	    // 결제 번호 생성
	    String stlmNo = generatePaymentNumber();
	    
	    // 카카오페이 결제 승인 요청 파라미터 설정
	    Map<String, String> parameters = new HashMap<>();
	    parameters.put("cid", "TC0ONETIME");                // 가맹점 코드(테스트용)
	    parameters.put("tid", tid);                         // 결제 고유번호
	    parameters.put("partner_order_id", stlmNo);         // 주문번호
	    parameters.put("partner_user_id", mbrId);          // 회원 아이디
	    parameters.put("pg_token", pgToken);                // 결제승인 요청을 인증하는 토큰

	    HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
        AproveResponse aproveResponse = template.postForObject(url, requestEntity, AproveResponse.class);
        log.info("결제승인 응답객체: " + aproveResponse);
        
        //DB에 외주 신청자 정보 저장 
        
        OsAplyVO osAplyVO = new OsAplyVO();
        osAplyVO.setOutordNo(outordNo); //외주 번호
        osAplyVO.setMbrId(mbrId); //회원 아이디
        osAplyVO.setOsAplyYmd(paymentDate); //외주 신청 날자(오늘 날짜 )
        osAplyVO.setOutordStlmAmt(price); //결제 금액
        
        this.outsouPayMapper.insertOsAplyVO(osAplyVO);
        
        //DB에 결제 정보 저장 
        SettlementVO settlementVO = new SettlementVO();
        settlementVO.setStlmNo(tid); //생성된 결제 번호
        settlementVO.setOutordNo(outordNo); //외주 번호 
        settlementVO.setMbrId(mbrId); // 현재 로그인되어 있는 사용자의 아이디 
        settlementVO.setSetleMn(setleMn); //결제 수단 
        settlementVO.setSetleYmd(paymentDate);//결제일자(오늘 날짜)
        settlementVO.setSetleSttus("결제완료"); //결제 완료 시 (계좌이체인 경우에는 미 입금 시 결제 대기 중으로 해야함 )
        settlementVO.setSetleAmt(price);//결제 금액 
        
        this.outsouPayMapper.insertSettlement(settlementVO);
        
        
		return aproveResponse;
	}
	
    
	// 카카오페이 측에 요청 시 헤더부에 필요한 값
    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization" , "SECRET_KEY DEVB4E51D0683AC7A19D69FFBA85114089962579");
        headers.set("Content-type", "application/json");

        return headers;
    }
    
    
    
//    // 로그인된 사용자 아이디 가져오기
//    private String getCurrentUserId() {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
//            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
//            return userDetails.getUsername();  // 로그인된 사용자의 아이디 반환
//        }
//        return null;
//    }
    
    
    // 주문번호 생성 (날짜 + 0001 형태)
    private String generatePaymentNumber() {
        // 오늘 날짜를 가져옴
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        // 오늘 날짜의 결제 개수 조회
        int paymentCount = outsouPayMapper.getOrderCountForToday();
        
        // 결제 번호 생성 (0001부터 시작)
        String paymentNumber = today + String.format("%04d", paymentCount + 1);
        
        log.info("생성된 결제번호: " + paymentNumber);
        
        return paymentNumber;
    }


	
	

}
