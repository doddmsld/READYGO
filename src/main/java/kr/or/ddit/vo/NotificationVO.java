package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NotificationVO {
	private int rnum;
	private String ntcnNo;
	private String commonId;
	private String ntcnCn;
	private String ntcnUrl;
	private String ntcnIdntyYn;
	private Date ntcnYmd;
	private String ntcnTrgettblNm;
	private String ntcnTrgettblPk;
	private String ntcnTrgettblAsstnfrmlasprgrp;
	private String ntcnRsvtYmday;
	private String ntcnDelYn;
}
