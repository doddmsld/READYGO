package kr.or.ddit.api;


import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;

public class CommonsMail_Gmail {
	public static void main(String[] args) {
		Email email = new SimpleEmail();
		// 이메일 객체 생성
//		MultiPartEmail email = new MultiPartEmail();
		// 첨부파일 생성을 위한 EmailAttachment 객체 생성
//	      EmailAttachment attachment = new EmailAttachment();
//	      attachment.setName("첨부파일.png"); //첨부파일의 이름설정
//	      attachment.setDescription("이미지 입니다.");
	      
		// SMTP 서버 설정
		email.setHostName("smtp.gmail.com");
		email.setSmtpPort(587); // Gmail SMTP 포트
		email.setAuthenticator(new DefaultAuthenticator("minju990219@gmail.com", "cj o i i n f s w u d e c e n l")); // 발신자 Gmail 계정 인증
		email.setStartTLSRequired(true); // TLS 사용
		try {
			email.setFrom("minju990219@gmail.com");
		} catch (EmailException e1) {
			e1.printStackTrace();
		}

		try {
			
			// 이메일 내용 설정
			email.setSubject("메일 제목");
			email.setMsg("메일 내용");

			// 수신자 이메일 설정
			email.addTo("tjdqo13579@naver.com");			
//			email.attach(attachment);
			// 이메일 전송
			email.send();

			System.out.println("Email sent successfully!");
		} catch (EmailException e) {
			e.printStackTrace();
		}
	}
}




