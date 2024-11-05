package kr.or.ddit.oustou.kakaoPayApi;

public interface KakaoPayService {

	public ReadyResponse payReady(String title, int price,String mbrId, String outordNo, String setleMn );
	
	public AproveResponse payApprove(String tid, String pgToken, String mbrId, String outordNo, String setleMn, int price);

	

}
