$("#mg1").on("click",function(){
	console.log("아나왜 안됨???")
	$("#rsmCareerCd").val("RSCA02").attr('selected', true);
	$("#rsmCrdtCd").val("CRDT007").attr('selected', true);
	$("#rsmSalCd").val("SAL14").attr('selected', true);
	$("#rsmMemo").val("405호 모두 화이팅!!!~~~");
}
$("#mg2").on("click",function(){
	$("#acbgSchlNm").val(acbgSchlNm);
	$("#acbgMjrNm").val(acbgMjrNm);
	$("#acbgMtcltnym").val(convertToDateFormat3(acbgMtcltnym));
	$("#acbgGrdtnym").val(convertToDateFormat3(acbgGrdtnym));
	$("#acbgPnt").val(acbgPnt);

	$("#acbgSeCd").val(acbgSeCd).attr('selected', true);
	$("#acbgRcognacbgCd").val(acbgRcognacbgCd).attr('selected', true);
	$("#acdmcrGrdtnSeCd").val(acdmcrGrdtnSeCd).attr('selected', true);
	$("#acbgPntCd").val(acbgPntCd).attr('selected', true);
	$(".acbg .conBox").attr("hidden", false);
	$(".acbg .showBox").attr("hidden", true);
}