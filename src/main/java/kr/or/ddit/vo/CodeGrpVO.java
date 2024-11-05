package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class CodeGrpVO {
	private String comCodeGrp;
	private String comCodeGrpNm;
	private String codeGrpDesc;
	private String useYn;
	private int rnum;
	
	private List<CodeVO> codeVOList;
}
