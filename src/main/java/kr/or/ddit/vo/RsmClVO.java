package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RsmClVO {
	private String clNo; // 자소서 번호
	private String rsmNo; // 이력서 번호
	private String clTtl; // 자소서 제목
	private String clCn; // 자소서 내용
	private String clWritngYmd; // 자소서 작성 일자
	private int clSn; // 자소서 순번
}
