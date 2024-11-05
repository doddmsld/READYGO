package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private String schdlNo;
	private String mbrId;
	private String schdlTtl;
	private String schdlAlldayYn;
	private Date schdlBgnde;
	private Date schdlEndde;
	private String schdlBgndes; //문자형
	private String schdlEnddes;	//문자형
	
	private String schdlBackColor;
	private String schdlTextColor;
}
