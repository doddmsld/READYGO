package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 스크랩
@Data
public class ScrapVO {
	private int rnum;     
	private String pbancNo;
	private String mbrId;
	
	//공고
	private String pbancTtl;           // 공고제목
	private String pbancBgngDt;        // 공고시작일(date)
	private String pbancDdlnDt;        // 공고마감일(date)
}
