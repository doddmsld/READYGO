package kr.or.ddit.security;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.EnterMapper;
import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class UserServiceImpl implements UserService {
	@Inject
	UserMapper userMapper;
	
	@Inject
	FileDetailMapper fileDetailMapper;
	
	@Inject
	UploadController uploadController;
	
	@Inject
	String uploadPath;
	
	@Override
	public int insertMember(MemberVO memVO) {
		int result = 0;

	    MultipartFile[] multipartFiles = memVO.getUploadFile();
	    log.info("multipartFiles == > " + multipartFiles);
	    
	    if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
	        log.info("새로운 파일이 업로드되지 않았습니다. 기존 파일을 유지합니다.");
	        
	        memVO.setFileGroupSn("1");
	    } else {
	        // 새로운 파일 업로드 처리
	        String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/member");
	        log.info("editPost->fileGroupSn : " + fileGroupSn);
	        
	        // 새로운 파일 그룹 번호 설정
	        memVO.setFileGroupSn(fileGroupSn);
	    }
	    result = userMapper.insertMember(memVO);
	    result += userMapper.insertProfile(memVO);
		return result;
	}
	
	@Override
	public int insertEnter(EnterVO entVO) {
		int result = 0;
		//사업자등록증
		MultipartFile[] multipartFiles = entVO.getEntBrFileFile();
		//로고
		MultipartFile[] multipartFiles2 = entVO.getEntLogoFile();
		log.info("multipartFiles == > " + multipartFiles);
		log.info("multipartFiles == > " + multipartFiles2);
		
		//사업자 등록증 파일처리
		if (multipartFiles == null || multipartFiles.length == 0 || multipartFiles[0].isEmpty()) {
			log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
			entVO.setEntBrFile("2");
			
		} else {
			// 새로운 파일 업로드 처리
			String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles, "/enter/brFile");
			log.info("editPost->fileGroupSn : " + fileGroupSn);
			
			// 새로운 파일 그룹 번호 설정
			entVO.setEntBrFile(fileGroupSn);
		}
		//로고 파일처리
		if (multipartFiles2 == null || multipartFiles.length == 0 || multipartFiles2[0].isEmpty()) {
			log.info("새로운 파일이 업로드되지 않았습니다. 세팅 안해");
			entVO.setEntLogo("1");
			
		} else {
			// 새로운 파일 업로드 처리
			String fileGroupSn = this.uploadController.multiImageUpload(multipartFiles2, "/enter/logoFile");
			log.info("editPost->fileGroupSn : " + fileGroupSn);
			
			// 새로운 파일 그룹 번호 설정
			entVO.setEntLogo(fileGroupSn);
		}
		result = userMapper.insertEnter(entVO);
		return result;
	}

	@Override
	public int upDateUserPassword(Map<String, Object> map) {
		String username = (String) map.get("userId");
		UserVO userVO = userMapper.userLogin(username);
		  switch (userVO.getUserType()) {
          case "1":
              return userMapper.updateMemPswd(map); 
          case "2":
              return userMapper.updateEntPswd(map);
          default:
              throw new UsernameNotFoundException("유효하지 않은 사용자 유형입니다.");
      }
	}

	@Override
	public List<String> idFindPost(Map<String, Object> map) {
		List<String> idList = userMapper.selectUserIdList(map);
		List<String> setIdList = new ArrayList<String>(); 
		for(String id : idList){
			String setId = "";
			if(id.length()>5) {
				for(int i = 0; i < id.length()-4; i++) {
					setId+= id.charAt(i);
				}
				setId += "****";
			}else {
				setId += id.substring(0, 3)+"**";
			}
			setIdList.add(setId);
		}
		return setIdList;
	}
}
