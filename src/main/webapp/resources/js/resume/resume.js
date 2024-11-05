function convertToDateFormat(yyyymm) {
    if (!yyyymm) return '';  // 값이 없으면 빈 문자열 반환
    let year = yyyymm.toString().substring(0, 4);  // yyyy 추출
    let month = yyyymm.toString().substring(4, 6); // MM 추출
    return year+`-`+month+`-01`; // yyyy-MM 형식으로 변환
}
function convertToDateFormat2(yyyymm) {
    if (!yyyymm) return '';  // 값이 없으면 빈 문자열 반환
    let year = yyyymm.toString().substring(0, 4);  // yyyy 추출
    let month = yyyymm.toString().substring(4, 6); // MM 추출
    let day = yyyymm.toString().substring(6, 8); // MM 추출
    return year+`-`+month+`-`+day; // yyyy-MM 형식으로 변환
}

function acbgTransForm(value){
	if(value===""){
		$('#acbgRcognacbgCd').parents(".form-group").attr("hidden", true);
		$('#acbgSchlNm').parents(".form-group").attr("hidden", true);
		$('#acbgMjrNm').parents(".form-group").attr("hidden", true);
		$('#acdmcrGrdtnSeCd').parents(".form-group").attr("hidden", true);
		$('#acbgMtcltnym').parents(".form-group").attr("hidden", true);
		$('#acbgGrdtnym').parents(".form-group").attr("hidden", true);
		$('#acbgPntCd').parents(".form-group").attr("hidden", true);
		$('#acbgPnt').parents(".form-group").attr("hidden", true);
		$('#acbgSeCd').val(null);
	}
	if(value==="ACSE001"){
		$('#acbgRcognacbgCd').parents(".form-group").attr("hidden", true);
		$('#acbgSchlNm').parents(".form-group").attr("hidden", false);
		$('#acbgMjrNm').parents(".form-group").attr("hidden", false);
		$('#acdmcrGrdtnSeCd').parents(".form-group").attr("hidden", false);
		$('#acbgMtcltnym').parents(".form-group").attr("hidden", false);
		$('#acbgGrdtnym').parents(".form-group").attr("hidden", false);
		$('#acbgPntCd').parents(".form-group").attr("hidden", true);
		$('#acbgPnt').parents(".form-group").attr("hidden", true);
		$('#acbgRcognacbgCd').val(null);
		$('#acbgSchlNm').val(null);
		$('#acbgMjrNm').val(null);
		$('#acdmcrGrdtnSeCd').val(null);
		$('#acbgMtcltnym').val(null);
		$('#acbgGrdtnym').val(null);
		$('#acbgPntCd').val(null);
		$('#acbgPnt').val(null);
	}
	if(value==="ACSE002"){
		$('#acbgRcognacbgCd').parents(".form-group").attr("hidden", false);
		$('#acbgSchlNm').parents(".form-group").attr("hidden", false);
		$('#acbgMjrNm').parents(".form-group").attr("hidden", false);
		$('#acdmcrGrdtnSeCd').parents(".form-group").attr("hidden", false);
		$('#acbgMtcltnym').parents(".form-group").attr("hidden", false);
		$('#acbgGrdtnym').parents(".form-group").attr("hidden", false);
		$('#acbgPntCd').parents(".form-group").attr("hidden", false);
		$('#acbgPnt').parents(".form-group").attr("hidden", false);
		$('#acbgRcognacbgCd').val(null);
		$('#acbgSchlNm').val(null);
		$('#acbgMjrNm').val(null);
		$('#acdmcrGrdtnSeCd').val(null);
		$('#acbgMtcltnym').val(null);
		$('#acbgGrdtnym').val(null);
		$('#acbgPntCd').val(null);
		$('#acbgPnt').val(null);
	}
	if(value==="ACSE003"){
		$('#acbgRcognacbgCd').parents(".form-group").attr("hidden", false);
		$('#acbgSchlNm').parents(".form-group").attr("hidden", false);
		$('#acbgMjrNm').parents(".form-group").attr("hidden", false);
		$('#acdmcrGrdtnSeCd').parents(".form-group").attr("hidden", false);
		$('#acbgMtcltnym').parents(".form-group").attr("hidden", false);
		$('#acbgGrdtnym').parents(".form-group").attr("hidden", false);
		$('#acbgPntCd').parents(".form-group").attr("hidden", true);
		$('#acbgPnt').parents(".form-group").attr("hidden", true);
		$('#acbgRcognacbgCd').val(null);
		$('#acbgSchlNm').val(null);
		$('#acbgMjrNm').val(null);
		$('#acdmcrGrdtnSeCd').val(null);
		$('#acbgMtcltnym').val(null);
		$('#acbgGrdtnym').val(null);
		$('#acbgPntCd').val(null);
		$('#acbgPnt').val(null);
	}
}
function crtfctTransForm(value){
	if(value===""){
		$('#crtfctNm').parents(".form-group").attr("hidden", true);
		$('#crtfctPblcnoffic').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsSe').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYm').parents(".form-group").attr("hidden", true);
		$('#crtfctScr').parents(".form-group").attr("hidden", true);
		$('#crtfctLangCd').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYn').parents(".form-group").attr("hidden", true);
		$('#crtfctNm').val(null);
		$('#crtfctPblcnoffic').val(null);
		$('#crtfctAcqsSe').val(null);
		$('#crtfctAcqsYm').val(null);
		$('#crtfctScr').val(null);
		$('#crtfctLangCd').val(null);
		$('#crtfctAcqsYn').val(null);
	}
	if(value==="CLW001"){
		$('#crtfctNm').parents(".form-group").attr("hidden", false);
		$('#crtfctPblcnoffic').parents(".form-group").attr("hidden", false);
		$('#crtfctAcqsSe').parents(".form-group").attr("hidden", false);
		$('#crtfctAcqsYm').parents(".form-group").attr("hidden", false);
		$('#crtfctScr').parents(".form-group").attr("hidden", false);
		$('#crtfctLangCd').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYn').parents(".form-group").attr("hidden", true);
		$('#crtfctNm').val(null);
		$('#crtfctPblcnoffic').val(null);
		$('#crtfctAcqsSe').val(null);
		$('#crtfctAcqsYm').val(null);
		$('#crtfctScr').val(null);
		$('#crtfctLangCd').val(null);
		$('#crtfctAcqsYn').val(null);
	}
	if(value==="CLW002"){
		$('#crtfctNm').parents(".form-group").attr("hidden", false);
		$('#crtfctPblcnoffic').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsSe').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYm').parents(".form-group").attr("hidden", false);
		$('#crtfctScr').parents(".form-group").attr("hidden", false);
		$('#crtfctLangCd').parents(".form-group").attr("hidden", false);
		$('#crtfctAcqsYn').parents(".form-group").attr("hidden", false);
		$('#crtfctNm').val(null);
		$('#crtfctPblcnoffic').val(null);
		$('#crtfctAcqsSe').val(null);
		$('#crtfctAcqsYm').val(null);
		$('#crtfctScr').val(null);
		$('#crtfctLangCd').val(null);
		$('#crtfctAcqsYn').val(null);
	}
	if(value==="CLW003"){
		$('#crtfctNm').parents(".form-group").attr("hidden", false);
		$('#crtfctPblcnoffic').parents(".form-group").attr("hidden", false);
		$('#crtfctAcqsSe').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYm').parents(".form-group").attr("hidden", false);
		$('#crtfctScr').parents(".form-group").attr("hidden", true);
		$('#crtfctLangCd').parents(".form-group").attr("hidden", true);
		$('#crtfctAcqsYn').parents(".form-group").attr("hidden", true);
		$('#crtfctNm').val(null);
		$('#crtfctPblcnoffic').val(null);
		$('#crtfctAcqsSe').val(null);
		$('#crtfctAcqsYm').val(null);
		$('#crtfctScr').val(null);
		$('#crtfctLangCd').val(null);
		$('#crtfctAcqsYn').val(null);
	}
}

var Toast = Swal.mixin({
	toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
});
function execDaumPostcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					var fullAddr = data.address;
					var extraAddr = '';

					if (data.addressType === 'R') {
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr
								+ ')' : '');
					}

					$('#mbrZip').val(data.zonecode);
					$('#mbrAddr').val(fullAddr);
					$('#mbrAddrDtl').focus();
				}
			}).open();
}
function handleImg(e) {
	let files = e.target.files; // 선택한 파일들
	let fileArr = Array.prototype.slice.call(files);
	let accumStr = "";
	fileArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("이미지 확장자만 가능합니다");
			return; // 함수 자체가 종료됨
		}
		let reader = new FileReader();
		reader.onload = function(e) {// "+e.target+result+" - 이미지를 다 읽었으면 결과를 가져와라 -> 그것을 누적
			accumStr += "<img src='"+e.target.result+"'/>"; // 누적 String
			$(".pImg").html(accumStr);
		}
		reader.readAsDataURL(f);

	});
}





	$(".warning").hide();
	 // 글자 수 실시간 업데이트
    $(".modalCont").on("input", function() {
        let currentLength = $(this).val().length;
        $(this).parent().find(".charCount").text(currentLength);
        if (currentLength > 2000) {
            $(this).parent().find(".warning").show();  // 경고 메시지 표시
            $(this).val($(this).val().substring(0, 2000));  // 글자 수 제한
            $(this).parent().find(".charCount").text(2000);  // 2000자까지만 표시
        } else {
        	 $(this).parent().find(".warning").hide();  // 경고 메시지 숨김
        }

    });

		
	$("#mbrAddr").on("click", function() {
		execDaumPostcode();
	})

	$(".pImg").on("click", function(e) {
		$("#uploadFile").click();
	})
	$("#uploadFile").on("change", function(e) {
		let file = e.target.files[0];
		if (!file) {
			return;
		}

		if (!file.type.match("image.*")) {
			alert("이미지 파일만 업로드 가능합니다.");
			return;
		}

		let reader = new FileReader();
		reader.onload = function(e) {
			$(".pImg").attr("src", e.target.result);
		}
		reader.readAsDataURL(file);
	});
	
	let skillListRaw = "${codeGrpVOMap.get('SK')}";
    let skillList = [];
	    
    function parseJavaObject(str) {
        let codeVORegex = /CodeVO\(([^)]+)\)/g;
        let codeVOMatches = str.match(codeVORegex);
        
        if (codeVOMatches) {
            skillList = $.map(codeVOMatches, function(match) {
                try {
                    var props = match.slice(7, -1).split(', ');
                    var obj = {};
                    $.each(props, function(i, prop) {
                        var parts = prop.split('=');
                        obj[$.trim(parts[0])] = $.trim(parts[1]);
                    });
                    return {
                        codeNm: obj.comCodeNm || "",  // 값이 없을 경우 빈 문자열 처리
                        codeNo: obj.comCode || ""     // 값이 없을 경우 빈 문자열 처리
                    };
                } catch (e) {
                    console.error("Error parsing CodeVO object:", e);
                    return null;  // 파싱 실패 시 null 리턴
                }
            });
            skillList = $.grep(skillList, function(item) {
                return item !== null;
            });
        }
    }

    try {
        parseJavaObject(skillListRaw);
    } catch (e) {
        console.error("Error parsing skill data:", e);
    }
	
	$("#skillSearch").on("input", function() {
        let searchStr = $("#skillSearch").val().toLowerCase();
        console.log(searchStr);
        if(searchStr==""){
        	$(".search-results").html("");
        	return;
        }
       	$(".search-results").html("");
       	let filteredSkills = [];
       	$.each(skillList, function(index, skill) {
       	    if (skill.codeNm.toLowerCase().indexOf(searchStr.toLowerCase()) !== -1) {
       	        filteredSkills.push(skill);
       	    }
       	});
        updateSearchResults(filteredSkills, searchStr);
    });

	function updateSearchResults(skills, searchStr) {
	    let searchResults = $(".search-results");
	    searchResults.empty();
	    let skillItem = "";

	    $.each(skills, function(index, skill) {
	        skillItem += '<a class="list-group-item" data-code-no="'
	                   + skill.codeNo 
	                   + '" data-code-nm="'
	                   + skill.codeNm
	                   + '"><div class="search-title">'
	                   + skill.codeNm 
	                   + '</div></a>';
	    });


	    // 검색 결과를 추가하고 나서 클릭 이벤트를 함께 바인딩
	    searchResults.html(skillItem);

	    // 리스트 아이템에 클릭 이벤트 핸들러 추가
	    $(".list-group-item").on("click", function() {
	        let codeNm = $(this).data("code-nm");
	        let codeNo = $(this).data("code-no");

	        console.log(codeNm);
	        console.log(codeNo);

	        addSelectedSkill({ codeNm: codeNm, codeNo: codeNo });
	    });
	}
	    
	    
	function addSelectedSkill(skill) {
    	let selectedSkills = $("#selectedSkills"); // 선택된 스킬을 표시할 컨테이너

	    // 이미 선택된 스킬이 아닌 경우에만 추가
	   if ($("#skill-select-box").find('[data-code-no="' + skill.codeNo + '"]').length === 0) {
		    let skillTag = '<span class="selected-skill" data-code-no="'
		                 + skill.codeNo 
		                 + '">'
		                 + skill.codeNm 
		                 + '</span>';
		
		    let save = $("#skill-select-box").html();
		    save += skillTag;
		    $("#skill-select-box").html(save);
		}

    	// 입력 필드와 검색 결과 초기화
	    $("#skillSearch").val("").focus();  // 입력 필드 초기화 후 포커스
	    $(".search-results").empty();
	}
	$("#skill-select-box").on('click', '.selected-skill', function() {
	    $(this).remove(); // 선택된 스킬 삭제
	});
	
	
	$("#basInfoBtn").on("click", function(){
	    if ($('#mbrNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'이름을 입력해 주세요.'
			});
	        $('#mbrNm').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrSexdstncd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'성별을 입력해 주세요.'
			});
	        $('#mbrSexdstncd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrBrdt').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'생년월일을 입력해 주세요.'
			});
	    	$('#mbrBrdt').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#mbrPhone').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'휴대폰번호를 입력해 주세요.'
			});
	        $('#mbrPhone').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrEml').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'이메일을 입력해 주세요.'
			});
	        $('#mbrEml').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#rsmCareerCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'직무능력을 입력해 주세요.'
			});
	        $('#rsmCareerCd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrAddr').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',

				title:'주소를 입력해 주세요.'
			});
	        $('#mbrAddr').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrAddrDtl').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'상세 주소를 입력해 주세요.'
			});
	        $('#mbrAddrDtl').focus();
	        event.preventDefault();
	        return false;
	    }
	    
	    let mbrNm = $("#mbrNm").val();
		let mbrSexdstncd = $("#mbrSexdstncd").val();
		let mbrBrdt = $("#mbrBrdt").val();
		let mbrPhone = $("#mbrPhone").val();
		let mbrTelno = $("#mbrTelno").val();
		let mbrEml = $("#mbrEml").val();
		let rsmCareerCd = $("#rsmCareerCd").val();
		let mbrAddr = $("#mbrAddr").val();
		let mbrZip = $("#mbrZip").val();
		let mbrAddrDtl = $("#mbrAddrDtl").val();
		let rsmTtl = $("#rsmTtl").val();
		let rsmNo = $("#rsmNo").val();
		var uploadFile = $("#uploadFile")[0].files[0];
		// FormData 객체 생성 (필요한 경우)
		let formData = new FormData();

		// FormData에 값 추가
		formData.append("mbrNm", mbrNm);
		formData.append("mbrSexdstncd", mbrSexdstncd);
		formData.append("mbrBrdt", mbrBrdt);
		formData.append("mbrPhone", mbrPhone);
		if(mbrTelno !== null||$('#mbrTelno').val().trim() !== ""){
			formData.append("mbrTelno", mbrTelno);
		}
		formData.append("mbrEml", mbrEml);
		formData.append("rsmCareerCd", rsmCareerCd);
		formData.append("mbrAddr", mbrAddr);
		formData.append("mbrZip", mbrZip);
		formData.append("mbrAddrDtl", mbrAddrDtl);
		if(rsmTtl != null||$('#rsmTtl').val().trim() !== ""){
			formData.append("rsmTtl", rsmTtl);
		}
		if(rsmNo != null||$('#rsmNo').val().trim() !== ""){
			formData.append("rsmNo", rsmNo);
		}
		if(uploadFile != null){
			formData.append("uploadFile", uploadFile);
		}
		$.ajax({
			url : "/member/resumebasInfoPost",
			processData : false,
			contentType : false,
			enctype: 'multipart/form-data',
			data : formData,
			type : "post",
			dataType: "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log("result : " + result);
				// success, error, warning, info, question
				if (result == null) {
					Toast.fire({
						icon : 'error',
						title : '저장 실패'
					});
					return;
				}
				Toast.fire({
					icon : 'success',
					title : '저장 성공'
				});
				let rsmNo = result.rsmNo;
				let mbrId = result.mbrId;
				$("#rsmNo").val(rsmNo);
				$("#mbrId").val(mbrId);
			}
		})
	})
	$("#hopeBtn").on("click",function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#rsmCrdtCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'희망·직무·직업을 선택해 주세요.'
			});
	        $('#rsmCrdtCd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#rsmSalCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'희망 연봉을 선택해 주세요.'
			});
	        $('#rsmSalCd').focus();
	        event.preventDefault();
	        return false;
	    }
	    
	    
	    let rsmCrdtCd = $("#rsmCrdtCd").val();
		let rsmSalCd = $("#rsmSalCd").val();
		let rsmMemo = $("#rsmMemo").val();
		let rsmNo = $("#rsmNo").val();
		let mbrId = $("#mbrId").val();
		
		// FormData 객체 생성 (필요한 경우)
		let formData = new FormData();
		
		// FormData에 값 추가
		formData.append("rsmCrdtCd", rsmCrdtCd);
		formData.append("rsmSalCd", rsmSalCd);
		formData.append("rsmMemo", rsmMemo);
		formData.append("rsmNo", rsmNo);
		formData.append("mbrId", mbrId);
		
		$.ajax({
			url : "/member/hopePost",
			processData : false,
			contentType : false,
			data : formData,
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log("result : " + result);
				// success, error, warning, info, question
				if (result == null) {
					Toast.fire({
						icon : 'error',
						title : '저장 실패'
					});
					return;
				}
				Toast.fire({
					icon : 'success',
					title : '저장 성공'
				});
			}
		})
	})
// 	추가버튼 기능
	$(".addBtn").on("click",function(){
		$(this).parent().find(".conBox").attr("hidden", false);
		let skillShowBox = $(this).parent().find("#skill-show-box");
		if(skillShowBox != null){
			let code = skillShowBox.html();
			$("#skill-select-box").html(code);
			$(this).parent().find(".showBox").attr("hidden", true);
		} 
		
	})
	//취소 버튼
	$(".resetBtn").on("click", function(){
		$(this).parents(".conBox").find('input[type="text"],input[type="number"], input[type="date"], select, textarea').val('');
		$(this).parents(".conBox").find('input[type="text"], input[type="number"], input[type="date"],  select, textarea').prop('selectedIndex', 0);
        acbgTransForm("")        
        crtfctTransForm("")
		$(this).parents(".conBox").attr("hidden", true);
		$(this).parents(".conBox").find("#skill-select-box").html(null);
		let skillShowBox = $(this).parent().find("#skill-show-box");
		$(this).parents(".registForm").find(".showBox").attr("hidden", false);
		if(skillShowBox != null){
			let code = skillShowBox.html();
			$("#skill-select-box").html(code);
		} 
	})
	//학력폼 변경 시작
	$("#acbgSeCd").on("change", function(){
		let val = $(this).val();
		acbgTransForm(val);
	})
	//학력폼 변경 끝
	//학력인서트 시작
	$("#acbgSaveBtn").on("click", function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#acbgSeCd').val() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'학력 구분을 선택해 주세요.'
			});
	        $('#acbgSeCd').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#acbgSeCd').val() == "ACSE002" ||$('#acbgSeCd').val() == "ACSE003") {
			if($('#acbgRcognacbgCd').val() == null){
		    	Toast.fire({
					icon:'warning',
					title:'인정 학력을 선택해 주세요.'
				});
		        $('#acbgSeCd').focus();
		        event.preventDefault();
		        return false;
			}
	    }
	    if ($('#acbgSchlNm').val().trim() ===	 "") {
	    	Toast.fire({
				icon:'warning',
				title:'학교명을 입력해 주세요.'
			});
	        $('#acbgSchlNm').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#acbgMjrNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'전공명을 입력해 주세요.'
			});
	        $('#acbgMjrNm').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#acdmcrGrdtnSeCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'졸업 여부를 선택해 주세요.'
			});
	        $('#acdmcrGrdtnSeCd').focus();
	        event.preventDefault();
	        return false;
	    }
        // 학력 정보 추출
        let acbgNo = $("#acbgNo").val();
        let rsmNo = $("#rsmNo").val();
        let acbgSeCd = $("#acbgSeCd").val();
        let acbgRcognacbgCd = $("#acbgRcognacbgCd").val();
        let acbgSchlNm = $("#acbgSchlNm").val();
        let acbgMjrNm = $("#acbgMjrNm").val();
        let acdmcrGrdtnSeCd = $("#acdmcrGrdtnSeCd").val();
        let acbgMtcltnym = $("#acbgMtcltnym").val();
        let acbgGrdtnym = $("#acbgGrdtnym").val();
        let acbgPnt = $("#acbgPnt").val();
        let acbgPntCd = $("#acbgPntCd").val();
        // FormData 객체 생성
        let formData = new FormData();

        // 학력 정보 추가
        if($('#acbgNo').val().trim() !== ""||$('#acbgNo').val()!==null){
	        formData.append("acbgNo", acbgNo);
        }
        formData.append("rsmNo", rsmNo);
        formData.append("acbgSeCd", acbgSeCd);
        formData.append("acbgRcognacbgCd", acbgRcognacbgCd);
        formData.append("acbgSchlNm", acbgSchlNm);
        formData.append("acbgMjrNm", acbgMjrNm);
        formData.append("acdmcrGrdtnSeCd", acdmcrGrdtnSeCd);
        formData.append("acbgMtcltnym", acbgMtcltnym);
        formData.append("acbgGrdtnym", acbgGrdtnym);
        formData.append("acbgPntCd", acbgPntCd);
        formData.append("acbgPnt", acbgPnt);

        $.ajax({
            url: "/member/acbgRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '학력 저장 완료'
                });
                let code = "";
                result.rsmAcademicVOList.forEach(function(item, index) {
                    
                    code += `<tr>
                        <td class="aplct">`+item.acbgSchlNm+`<br>`;
                    if(item.acbgRcognacbgCdNm!=null){
                    	code +=`<span class="aplcont">`+item.acbgRcognacbgCdNm+`</span>`;
                    }
                    code +=`</td>
                        <td class="aplct">`+item.acbgMjrNm+`<br>`;
                    if(item.acbgPnt!=null){
                    	code += `<span class="aplcont">인정 학점 :`+item.acbgPnt+`</span>&nbsp;&nbsp;&nbsp;`;
                    }
                    if(item.acbgPntCdNm!=null){
                    	code += `<span class="aplcont">기준 학점 : `+item.acbgPntCdNm+`</span>`;
                    }
                    code += `</td>
                        <td class="aplct">`+item.acdmcrGrdtnSeCdNm+`<br>`;
                    if(item.acbgMtcltnym!=null){
                    	code += `<span class="aplcont">입학년도 : `+item.acbgMtcltnym.substring(0,4)+`년 `+ item.acbgMtcltnym.substring(4,6)+`월</span>&nbsp;&nbsp;&nbsp;`;                    	
                    }    
                    if(item.acbgGrdtnym!=null){
	                    code += `<span class="aplcont">졸업년도 : `+item.acbgGrdtnym.substring(0,4)+`년 `+ item.acbgGrdtnym.substring(4,6)+`월</span>`;
                    }    
                    code += `</td>
                        <td>
                        	<button type="button" class="btn btn-default aplctCancel acbgDeleteBtn"
                        		data-acbg-no="`+item.acbgNo+`">삭제</button>
                            <button type="button" class="btn btn-default aplctCancel acbgEditBtn"
                               data-acbg-no="`+item.acbgNo+`"
                               data-acbg-se-cd="`+item.acbgSeCd+`" 
                               data-acbg-rcognacbg-cd="`+item.acbgRcognacbgCd+`" 
                               data-acbg-schl-nm="`+item.acbgSchlNm+`" 
                               data-acbg-mjr-nm="`+item.acbgMjrNm+`" 
                               data-acdmcr-grdtn-se-cd="`+item.acdmcrGrdtnSeCd+`" 
                               data-acbg-mtcltnym="`+item.acbgMtcltnym+`" 
                               data-acbg-grdtnym="`+item.acbgGrdtnym+`" 
                               data-acbg-pnt-cd="`+item.acbgPntCd+`" 
                               data-acbg-pnt="`+item.acbgPnt+`">수정</button>
                        </td>
                     </tr>`;
                });
                
                $('#acbgTbody').html(code);
                // hidden 속성을 가진 요소의 초기화
                $('.acbg input[type="text"], .acbg input[type="number"], .acbg input[type="date"], .acbg select').val('');
                
                $('.acbg input[type="text"], .acbg input[type="number"], .acbg input[type="date"], .acbg select').prop('selectedIndex', 0);
                $('.acbg .form-group').attr("hidden", true);
                $('.acbg .nohide').attr("hidden", false); 
                $(".acbg .conBox").attr("hidden", true);
                $(".acbg .showBox").attr("hidden", false);
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	})
// 	학력 인서트 끝
// 학력 삭제
	$(document).on("click", ".acbgDeleteBtn", function() {
	    let acbgNo = $(this).data("acbgNo");
	    let rsmNo = $("#rsmNo").val();
	    let tr = $(this).closest("tr");
	    let formData = new FormData();
	    formData.append("acbgNo", acbgNo);
	    formData.append("rsmNo", rsmNo);
	    
	    console.log("딸깍!")
	    $.ajax({
            url: "/member/acbgDeletePost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '학력 삭제 완료'
                });
                tr.remove();
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	    
	});
// 	학력 수정
	$(document).on("click", ".acbgEditBtn", function(){
		let acbgSeCd = $(this).data("acbgSeCd");
		acbgTransForm(acbgSeCd);
		let acbgNo = $(this).data("acbgNo");
		let acbgRcognacbgCd = $(this).data("acbgRcognacbgCd");
		let acbgSchlNm = $(this).data("acbgSchlNm");
		let acbgMjrNm = $(this).data("acbgMjrNm");
		let acdmcrGrdtnSeCd = $(this).data("acdmcrGrdtnSeCd");
		let acbgMtcltnym = $(this).data("acbgMtcltnym");
		let acbgGrdtnym = $(this).data("acbgGrdtnym");
		let acbgPntCd = $(this).data("acbgPntCd");
		let acbgPnt = $(this).data("acbgPnt");
		console.log(convertToDateFormat(acbgMtcltnym));
		$("#acbgNo").val(acbgNo);
		$("#acbgSchlNm").val(acbgSchlNm);
		$("#acbgMjrNm").val(acbgMjrNm);
		$("#acbgMtcltnym").val(convertToDateFormat(acbgMtcltnym));
		$("#acbgGrdtnym").val(convertToDateFormat(acbgGrdtnym));
		$("#acbgPnt").val(acbgPnt);

		$("#acbgSeCd").val(acbgSeCd).attr('selected', true);
		$("#acbgRcognacbgCd").val(acbgRcognacbgCd).attr('selected', true);
		$("#acdmcrGrdtnSeCd").val(acdmcrGrdtnSeCd).attr('selected', true);
		$("#acbgPntCd").val(acbgPntCd).attr('selected', true);
		$(".acbg .conBox").attr("hidden", false);
		$(".acbg .showBox").attr("hidden", true);
	})
	
// 	경력 인서트 시작
	$("#careerSaveBtn").on("click", function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#careerEntNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기업명을 입력해 주세요.'
			});
	        $('#careerEntNm').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#careerJncmpYmd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'입사일자를 입력해 주세요.'
			});
	        $('#careerJncmpYmd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#careerDtyCd').val() === null) {
	    	Toast.fire({
				icon:'warning',
				title:'직무를 선택해 주세요.'
			});
	        $('#careerDtyCd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#careerTask').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'담당업무 내용을 입력해 주세요.'
			});
	        $('#careerTask').focus();
	        event.preventDefault();
	        return false;
	    }
	   
        // 경력 정보 추출
        let careerNo = $("#careerNo").val();
        let rsmNo = $("#rsmNo").val();
        let careerEntNm = $("#careerEntNm").val();
        let careerJncmpYmd = $("#careerJncmpYmd").val();
        let careerRetireYmd = $("#careerRetireYmd").val();
        let careerDtyCd = $("#careerDtyCd").val();
        let careerDept = $("#careerDept").val();
        let careerJbgdCd = $("#careerJbgdCd").val();
        let careerTask = $("#careerTask").val();
        let careerAnslry = $("#careerAnslry").val();
        let careerWorkRgnCd = $("#careerWorkRgnCd").val();
        // FormData 객체 생성
        let formData = new FormData();

        if(careerAnslry.trim() === "" || careerAnslry.trim() === null){
        	careerAnslry = 0;
        }
        // 경력 정보 추가
        if($('#careerNo').val().trim() !== ""||$('#careerNo').val()!==null){
	        formData.append("careerNo", careerNo);
        }
        formData.append("rsmNo", rsmNo);
        formData.append("careerEntNm", careerEntNm);
        formData.append("careerJncmpYmd", careerJncmpYmd);
        formData.append("careerRetireYmd", careerRetireYmd);
        formData.append("careerDtyCd", careerDtyCd);
        formData.append("careerDept", careerDept);
        formData.append("careerJbgdCd", careerJbgdCd);
        formData.append("careerTask", careerTask);
        formData.append("careerAnslry", careerAnslry);
        formData.append("careerWorkRgnCd", careerWorkRgnCd);
		
        let pat = $(this).parents(".conBox");
        
        $.ajax({
            url: "/member/careerRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '경력 저장 완료'
                });
                let code = "";
                result.rsmCareerVOList.forEach(function(item, index) {
                    code += `<tr>
                        <td class="aplct">`;
                    if(item.careerEntNm.length > 10){
                    	code += item.careerEntNm.substring(0,10)+`...`;
                    }else{
                    	code += item.careerEntNm;
                    } 
                    code +=`</td>
                        <td class="aplct">입사일자 : `+item.careerJncmpYmd.substring(0,4)+`-`+ item.careerJncmpYmd.substring(4,6)+`-`+ item.careerJncmpYmd.substring(6,8);
                    if(item.careerRetireYmd!=null){
                    	code += `<br />퇴사일자 : `+item.careerRetireYmd.substring(0,4)+`-`+ item.careerRetireYmd.substring(4,6)+`-`+ item.careerRetireYmd.substring(6,8);
                    }
                    code += `</td>
                        <td class="aplct">`+item.careerDtyCdNm+`<br>`;
                    if(item.careerDept!=null){
                    	code += `<span class="aplcont">부서 : `+item.careerDept+`</span>&nbsp;&nbsp;&nbsp;`;                    	
                    }    
                    if(item.careerJbgdCdNm!=null){
	                    code += `<span class="aplcont">직급 : `+item.careerJbgdCdNm+`</span>`;
                    }    
                    code += `</td>
                        <td>
                        	<button type="button" class="btn btn-default aplctCancel careerDeleteBtn"
                        		data-career-no="`+item.careerNo+`">삭제</button>
                            <button type="button" class="btn btn-default aplctCancel careerEditBtn"
                               data-career-no="`+item.careerNo+`"
                               data-career-ent-nm="`+item.careerEntNm+`" 
                               data-career-jncmp-ymd="`+item.careerJncmpYmd+`" 
                               data-career-retire-ymd="`+item.careerRetireYmd+`" 
                               data-career-dty-cd="`+item.careerDtyCd+`" 
                               data-career-dept="`+item.careerDept+`" 
                               data-career-jbgd-cd="`+item.careerJbgdCd+`" 
                               data-career-task="`+item.careerTask+`" 
                               data-career-anslry="`+item.careerAnslry+`" 
                               data-career-work-rgn-cd="`+item.careerWorkRgnCd+`">수정</button>
                        </td>
                     </tr>`;
                });
                
                $('#careerTbody').html(code);
                // hidden 속성을 가진 요소의 초기화
                pat.find('input[type="text"],input[type="number"], input[type="date"], select, textarea').val('');
                pat.find('input[type="text"], input[type="number"], input[type="date"],  select, textarea').prop('selectedIndex', 0);
                $(".career .conBox").attr("hidden", true);
                $(".career .showBox").attr("hidden", false);
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	})
	// 경력 인서트 끝
	
	// 경력 삭제
	$(document).on("click", ".careerDeleteBtn", function() {
	    let careerNo = $(this).data("careerNo");
	    let rsmNo = $("#rsmNo").val();
	    let tr = $(this).closest("tr");
	    let formData = new FormData();
	    console.log(careerNo)
	    console.log(rsmNo)
	    formData.append("careerNo", careerNo);
	    formData.append("rsmNo", rsmNo);
	    $.ajax({
            url: "/member/careerDeletePost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '경력 삭제 완료'
                });
                tr.remove();
                
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	    
	});
	//경력 삭제 끝
// 	경력 수정
	$(document).on("click", ".careerEditBtn", function(){
		let careerNo = $(this).data("careerNo");
		let careerEntNm = $(this).data("careerEntNm");
		let careerJncmpYmd = $(this).data("careerJncmpYmd");
		let careerRetireYmd = $(this).data("careerRetireYmd");
		let careerDtyCd = $(this).data("careerDtyCd");
		let careerDept = $(this).data("careerDept");
		let careerJbgdCd = $(this).data("careerJbgdCd");
		let careerTask = $(this).data("careerTask");
		let careerAnslry = $(this).data("careerAnslry");
		let careerWorkRgnCd = $(this).data("careerWorkRgnCd");
		$("#careerNo").val(careerNo);
		$("#careerEntNm").val(careerEntNm);
		$("#careerJncmpYmd").val(convertToDateFormat2(careerJncmpYmd));
		$("#careerRetireYmd").val(convertToDateFormat2(careerRetireYmd));
		$("#careerDept").val(careerDept);
		$("#careerTask").val(careerTask);
		$("#careerAnslry").val(careerAnslry);

		$("#careerDtyCd").val(careerDtyCd).attr('selected', true);
		$("#careerJbgdCd").val(careerJbgdCd).attr('selected', true);
		$("#careerWorkRgnCd").val(careerWorkRgnCd).attr('selected', true);
		$(".career .conBox").attr("hidden", false);
		$(".career .showBox").attr("hidden", true);
	})
	
// 	스킬 인서트 시작
	$("#skillSaveBtn").on("click", function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		let skillCodes = $(".conBox .selected-skill").map(function() {
		    return $(this).attr('data-code-no');
		}).get().filter(function(code) {
		    return code;
		});

		// 중복 제거
		skillCodes = $.unique(skillCodes);
	
		// 쉼표로 구분된 문자열로 변환
		let skCd = skillCodes.join(',');
	
		// rsmNo 값 설정 (고정 값)
		let rsmNo = $("#rsmNo").val();
	
		// FormData 객체 생성
		let formData = new FormData();
	
		// FormData에 값 추가
		formData.append("skCd", skCd);
		formData.append("rsmNo", rsmNo);
		
		// FormData 내용 확인 (선택적)
        let pat = $(this).parents(".conBox");
        
        $.ajax({
            url: "/member/skillRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '스킬 저장 완료'
                });
                let code = "";
                result.rsmSkillVOList.forEach(function(item, index) {
                    code += `<span class="selected-skill" data-code-no="`+item.skCd+`">`+item.skCdNm+`</span>`;
                });
                
                $('#skill-show-box').html(code);
                // hidden 속성을 가진 요소의 초기화
                pat.find('input[type="text"],input[type="number"], input[type="date"], select, textarea').val('');
                pat.find('input[type="text"], input[type="number"], input[type="date"],  select, textarea').prop('selectedIndex', 0);
                $(".skill .conBox").attr("hidden", true);
                $(".skill .showBox").attr("hidden", false);
                $("#skill-select-box").html("");
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	})
	// 스킬 인서트 끝
	
	// 	경험/활동/교육 인서트 시작
	$("#actSavaBtn").on("click", function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#actSeCd').val() === null) {
	    	Toast.fire({
				icon:'warning',
				title:'활동구분을 선택해 주세요.'
			});
	        $('#actSeCd').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#actEngn').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기관/장소명을 입력해 주세요.'
			});
	        $('#actEngn').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#actNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'활동명을 입력해 주세요.'
			});
	        $('#actNm').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#actBeginYmd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'시작년월을 입력해 주세요.'
			});
	        $('#actBeginYmd').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#actEndYmd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'종료년월을 입력해 주세요.'
			});
	        $('#actEndYmd').focus();
	        event.preventDefault();
	        return false;
	    }
	   
        // 경험/활동/교육 정보 추출
        let actNo = $("#actNo").val();
        let rsmNo = $("#rsmNo").val();
        let actSeCd = $("#actSeCd").val();
        let actNm = $("#actNm").val();
        let actEngn = $("#actEngn").val();
        let actBeginYmd = $("#actBeginYmd").val();
        let actEndYmd = $("#actEndYmd").val();
        let actCn = $("#actCn").val();
        
        // FormData 객체 생성
        let formData = new FormData();

        // 경험/활동/교육 정보 추가
        if($('#actNo').val().trim() !== ""||$('#actNo').val()!==null){
	        formData.append("actNo", actNo);
        }
        formData.append("rsmNo", rsmNo);
        formData.append("actSeCd", actSeCd);
        formData.append("actNm", actNm);
        formData.append("actEngn", actEngn);
        formData.append("actBeginYmd", actBeginYmd);
        formData.append("actEndYmd", actEndYmd);
        formData.append("actCn", actCn);
		
        let pat = $(this).parents(".conBox");
        
        $.ajax({
            url: "/member/actRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '경험/활동/교육 저장 완료'
                });
                let code = "";
                result.rsmExpactEDCVOList.forEach(function(item, index) {
                	code += '<tr>';
                	code +=     '<td class="aplct">';
                	// 활동 구분
                	code += item.actSeCdNm;
                	code += '</td>';
                	// 활동 명
                	code += '<td class="aplct">'+item.actNm;
                	// 활동 기관명
                	if (item.actEngn != null) {
                	    code += '<br><span class="aplcont">기관명 : '+item.actEngn+'</span>';
                	}
                	// 활동기간
                    code +=  '<td class="aplct">시작일자 : '+item.actBeginYmd.substring(0,4)+'-'+ item.actBeginYmd.substring(4,6)+'-'+ item.actBeginYmd.substring(6,8);
                    code += '<br />종료일자 : '+item.actEndYmd.substring(0,4)+'-'+ item.actEndYmd.substring(4,6)+'-'+ item.actEndYmd.substring(6,8);
                	code += '</td>';
                	// 버튼들 추가
                	code += '<td>';
                	code +=     '<button type="button" class="btn btn-default aplctCancel actDeleteBtn"';
                	code +=     'data-act-no="' + item.actNo + '">삭제</button>';
                	code +=     '<button type="button" class="btn btn-default aplctCancel actEditBtn"';
                	code +=     'data-act-no="' + item.actNo + '"';
                	code +=     'data-act-se-cd="' + item.actSeCd + '"';
                	code +=     'data-act-nm="' + item.actNm + '"';
                	code +=     'data-act-engn="' + item.actEngn + '"';
                	code +=     'data-act-begin-ymd="' + item.actBeginYmd + '"';
                	if (item.actEndYmd != null) {
                	    code += 'data-act-end-ymd="' + item.actEndYmd + '"';
                	}
                	if (item.actCn != null) {
                	    code += 'data-act-cn="' + item.actCn + '"';
                	}
                	code += '>수정</button>';
                	code += '</td>';
                	code += '</tr>';
                });
                
                $('#actTbody').html(code);
                // hidden 속성을 가진 요소의 초기화
                pat.find('input[type="text"],input[type="number"], input[type="date"], select, textarea').val('');
                pat.find('input[type="text"], input[type="number"], input[type="date"],  select, textarea').prop('selectedIndex', 0);
                $(".act .conBox").attr("hidden", true);
                $(".act .showBox").attr("hidden", false);
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	})
	// 경험/활동/교육 인서트 끝
	
	// 경험/활동/교육 삭제
	$(document).on("click", ".actDeleteBtn", function() {
	    let actNo = $(this).data("actNo");
	    let rsmNo = $("#rsmNo").val();
	    let tr = $(this).closest("tr");
	    let formData = new FormData();
	    console.log(careerNo)
	    console.log(rsmNo)
	    formData.append("actNo", actNo);
	    formData.append("rsmNo", rsmNo);
	    $.ajax({
            url: "/member/actDeletePost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '경력 삭제 완료'
                });
                tr.remove();
                
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	    
	});
	//경험/활동/교육 삭제 끝
// 	경험/활동/교육 수정
	$(document).on("click", ".actEditBtn", function(){
		let actNo = $(this).data("actNo");
		let actSeCd = $(this).data("actSeCd");
		let actNm = $(this).data("actNm");
		let actEngn = $(this).data("actEngn");
		let actBeginYmd = $(this).data("actBeginYmd");
		let actEndYmd = $(this).data("actEndYmd");
		let actCn = $(this).data("actCn");
		
		$("#actNo").val(actNo);
		$("#actNm").val(actNm);
		$("#actEngn").val(actEngn);
		$("#actBeginYmd").val(convertToDateFormat2(actBeginYmd));
		$("#actEndYmd").val(convertToDateFormat2(actEndYmd));
		$("#actCn").val(actCn);

		$("#actSeCd").val(actSeCd).attr('selected', true);
		$(".act .conBox").attr("hidden", false);
		$(".act .showBox").attr("hidden", true);
	})
	
	//자격증폼 변경 시작
	$("#crtfctAcqsSeCd").on("change", function(){
		let val = $(this).val();
		crtfctTransForm(val);
	})
	//자격증폼 변경 끝
	//자격증인서트 시작
	$("#crtfctSaveBtn").on("click", function(){
		if ($('#rsmNo').val().trim()==="") {
	    	Toast.fire({
				icon:'warning',
				title:'기본정보를 먼저 저장해 주세요.'
			});
	        $('#rsmNo').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#crtfctAcqsSeCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'자격·어학·수상 구분을 선택해 주세요.'
			});
	        $('#crtfctAcqsSeCd').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#crtfctAcqsSeCd').val() == "CLW002") {
			if($('#crtfctLangCd').val() == null){
		    	Toast.fire({
					icon:'warning',
					title:'언어구분을 선택해 주세요.'
				});
		        $('#crtfctLangCd').focus();
		        event.preventDefault();
		        return false;
			}
			if($('#crtfctAcqsYn').val() == null){
		    	Toast.fire({
					icon:'warning',
					title:'합격여부를 선택해 주세요.'
				});
		        $('#crtfctAcqsYn').focus();
		        event.preventDefault();
		        return false;
			}
	    }
	    if ($('#crtfctNm').val().trim() ===	 "") {
	    	Toast.fire({
				icon:'warning',
				title:'자격·어학·수상명을 입력해 주세요.'
			});
	        $('#crtfctNm').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#crtfctAcqsSeCd').val() == "CLW001"||$('#crtfctAcqsSeCd').val() == "CLW003") {
		   if ($('#crtfctPblcnoffic').val().trim() ===	 "") {
		    	Toast.fire({
					icon:'warning',
					title:'발행처·기관을 입력해 주세요.'
				});
		        $('#crtfctPblcnoffic').focus();
		        event.preventDefault();
		        return false;
		    }
	    }
		if ($('#crtfctAcqsSeCd').val() == "CLW001") {
			if($('#crtfctAcqsSe').val() == null){
		    	Toast.fire({
					icon:'warning',
					title:'합격구분을 선택해 주세요.'
				});
		        $('#crtfctAcqsSe').focus();
		        event.preventDefault();
		        return false;
			}
	    }
        // 자격증 정보 추출
        let acbgNo = $("#acbgNo").val();
        let rsmNo = $("#rsmNo").val();
        let acbgSeCd = $("#acbgSeCd").val();
        let acbgRcognacbgCd = $("#acbgRcognacbgCd").val();
        let acbgSchlNm = $("#acbgSchlNm").val();
        let acbgMjrNm = $("#acbgMjrNm").val();
        let acdmcrGrdtnSeCd = $("#acdmcrGrdtnSeCd").val();
        let acbgMtcltnym = $("#acbgMtcltnym").val();
        let acbgGrdtnym = $("#acbgGrdtnym").val();
        let acbgPnt = $("#acbgPnt").val();
        let acbgPntCd = $("#acbgPntCd").val();
        // FormData 객체 생성
        let formData = new FormData();

        // 학력 정보 추가
        if($('#acbgNo').val().trim() !== ""||$('#acbgNo').val()!==null){
	        formData.append("acbgNo", acbgNo);
        }
        formData.append("rsmNo", rsmNo);
        formData.append("acbgSeCd", acbgSeCd);
        formData.append("acbgRcognacbgCd", acbgRcognacbgCd);
        formData.append("acbgSchlNm", acbgSchlNm);
        formData.append("acbgMjrNm", acbgMjrNm);
        formData.append("acdmcrGrdtnSeCd", acdmcrGrdtnSeCd);
        formData.append("acbgMtcltnym", acbgMtcltnym);
        formData.append("acbgGrdtnym", acbgGrdtnym);
        formData.append("acbgPntCd", acbgPntCd);
        formData.append("acbgPnt", acbgPnt);

        $.ajax({
            url: "/member/acbgRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '학력 저장 완료'
                });
                let code = "";
                result.rsmAcademicVOList.forEach(function(item, index) {
                    
                    code += `<tr>
                        <td class="aplct">`+item.acbgSchlNm+`<br>`;
                    if(item.acbgRcognacbgCdNm!=null){
                    	code +=`<span class="aplcont">`+item.acbgRcognacbgCdNm+`</span>`;
                    }
                    code +=`</td>
                        <td class="aplct">`+item.acbgMjrNm+`<br>`;
                    if(item.acbgPnt!=null){
                    	code += `<span class="aplcont">인정 학점 :`+item.acbgPnt+`</span>&nbsp;&nbsp;&nbsp;`;
                    }
                    if(item.acbgPntCdNm!=null){
                    	code += `<span class="aplcont">기준 학점 : `+item.acbgPntCdNm+`</span>`;
                    }
                    code += `</td>
                        <td class="aplct">`+item.acdmcrGrdtnSeCdNm+`<br>`;
                    if(item.acbgMtcltnym!=null){
                    	code += `<span class="aplcont">입학년도 : `+item.acbgMtcltnym.substring(0,4)+`년 `+ item.acbgMtcltnym.substring(4,6)+`월</span>&nbsp;&nbsp;&nbsp;`;                    	
                    }    
                    if(item.acbgGrdtnym!=null){
	                    code += `<span class="aplcont">졸업년도 : `+item.acbgGrdtnym.substring(0,4)+`년 `+ item.acbgGrdtnym.substring(4,6)+`월</span>`;
                    }    
                    code += `</td>
                        <td>
                        	<button type="button" class="btn btn-default aplctCancel acbgDeleteBtn"
                        		data-acbg-no="`+item.acbgNo+`">삭제</button>
                            <button type="button" class="btn btn-default aplctCancel acbgEditBtn"
                               data-acbg-no="`+item.acbgNo+`"
                               data-acbg-se-cd="`+item.acbgSeCd+`" 
                               data-acbg-rcognacbg-cd="`+item.acbgRcognacbgCd+`" 
                               data-acbg-schl-nm="`+item.acbgSchlNm+`" 
                               data-acbg-mjr-nm="`+item.acbgMjrNm+`" 
                               data-acdmcr-grdtn-se-cd="`+item.acdmcrGrdtnSeCd+`" 
                               data-acbg-mtcltnym="`+item.acbgMtcltnym+`" 
                               data-acbg-grdtnym="`+item.acbgGrdtnym+`" 
                               data-acbg-pnt-cd="`+item.acbgPntCd+`" 
                               data-acbg-pnt="`+item.acbgPnt+`">수정</button>
                        </td>
                     </tr>`;
                });
                
                $('#acbgTbody').html(code);
                // hidden 속성을 가진 요소의 초기화
                $('.acbg input[type="text"], .acbg input[type="number"], .acbg input[type="date"], .acbg select').val('');
                
                $('.acbg input[type="text"], .acbg input[type="number"], .acbg input[type="date"], .acbg select').prop('selectedIndex', 0);
                $('.acbg .form-group').attr("hidden", true);
                $('.acbg .nohide').attr("hidden", false); 
                $(".acbg .conBox").attr("hidden", true);
                $(".acbg .showBox").attr("hidden", false);
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	})
// 	자격증 인서트 끝
// 자격증 삭제
	$(document).on("click", ".crtfctDeleteBtn", function() {
	    let acbgNo = $(this).data("acbgNo");
	    let rsmNo = $("#rsmNo").val();
	    let tr = $(this).closest("tr");
	    let formData = new FormData();
	    formData.append("acbgNo", acbgNo);
	    formData.append("rsmNo", rsmNo);
	    
	    console.log("딸깍!")
	    $.ajax({
            url: "/member/acbgDeletePost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                Toast.fire({
                    icon: 'success',
                    title: '학력 삭제 완료'
                });
                tr.remove();
            },
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                Toast.fire({
                    icon: 'error',
                    title: 'Ajax 요청 실패'
                });
            }
        });
	    
	});
// 	자격증 수정
	$(document).on("click", ".crtfctEditBtn", function(){
		let acbgSeCd = $(this).data("acbgSeCd");
		acbgTransForm(acbgSeCd);
		let acbgNo = $(this).data("acbgNo");
		let acbgRcognacbgCd = $(this).data("acbgRcognacbgCd");
		let acbgSchlNm = $(this).data("acbgSchlNm");
		let acbgMjrNm = $(this).data("acbgMjrNm");
		let acdmcrGrdtnSeCd = $(this).data("acdmcrGrdtnSeCd");
		let acbgMtcltnym = $(this).data("acbgMtcltnym");
		let acbgGrdtnym = $(this).data("acbgGrdtnym");
		let acbgPntCd = $(this).data("acbgPntCd");
		let acbgPnt = $(this).data("acbgPnt");
		console.log(convertToDateFormat(acbgMtcltnym));
		$("#acbgNo").val(acbgNo);
		$("#acbgSchlNm").val(acbgSchlNm);
		$("#acbgMjrNm").val(acbgMjrNm);
		$("#acbgMtcltnym").val(convertToDateFormat(acbgMtcltnym));
		$("#acbgGrdtnym").val(convertToDateFormat(acbgGrdtnym));
		$("#acbgPnt").val(acbgPnt);

		$("#acbgSeCd").val(acbgSeCd).attr('selected', true);
		$("#acbgRcognacbgCd").val(acbgRcognacbgCd).attr('selected', true);
		$("#acdmcrGrdtnSeCd").val(acdmcrGrdtnSeCd).attr('selected', true);
		$("#acbgPntCd").val(acbgPntCd).attr('selected', true);
		$(".acbg .conBox").attr("hidden", false);
		$(".acbg .showBox").attr("hidden", true);
