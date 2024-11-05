package kr.or.ddit.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;

import kr.or.ddit.mapper.FileDetailMapper;
import kr.or.ddit.vo.FileDetailVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//자바빈 객체로 등록
@Slf4j
@Controller
@RequiredArgsConstructor
public class UploadController {
	
	//DI, IoC
	//root-context.xml에 <bean.. 으로 존재함 c:\\upload
	@Autowired
	String uploadPath;
	
	@Autowired
	FileDetailMapper fileDetailMapper;
	
	@Value("${cloud.aws.s3.bucket}")
    private String bucket;
	
	private final AmazonS3 amazonS3;
	
	/**다중 이미지 업로드
	 * return : 20240808001(FILE_GROUP.FILE_GROUP_NO)
	 */	
	@Transactional
	public String multiImageUpload(MultipartFile[] multipartFiles, String subPath) {
		String fileGroupSn = this.fileDetailMapper.getFileGroupSn();
		int result = 0;
		int counter = 1;//FILE_SN 컬럼을 위함(20240808001의1)(20240808001의2)
		//연월일 폴더 설정
		// C:\\upload
		// + "\\" + 
		// 2024\\08\\08
		File uploadPath = new File(this.uploadPath+subPath, this.getFolder());
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		//원본 파일명
		String strgFileNm = "";
		//MIME(Multipurpost Internet Mail Extension) 타입
		String contentType = "";
		//파일 크기
		long fileSz = 0L; 
		
		//1) FILE_DT 테이블에 insert
//		FileDetailVO fileDetailVO = new FileDetailVO();
		//실행전 {fileGroupNo=0,fileRegdate=null}
//		result += this.fileDetailMapper.insertFileDetail(fileDetailVO);
		//실행후 {fileGroupNo=20240808001,fileRegdate=null}
		
		//향상된 for문(multipartFiles : 파일들)
		for(MultipartFile multipartFile : multipartFiles) {
			strgFileNm = multipartFile.getOriginalFilename();
			contentType = multipartFile.getContentType();
			fileSz = multipartFile.getSize();
			
			UUID uuid = UUID.randomUUID();
			strgFileNm = uuid.toString() + "_" + strgFileNm;
			
			//File객체 설계(복사할 대상 경로, 파일명)
			// C:\\upload\\2024\\08\\08 + "\\" + asdfasdf_개똥이.jpg
			File saveFile = new File(uploadPath,strgFileNm);
			
			try {
				//파일 복사 실행
				//파일객체.transferTo(설계)
				multipartFile.transferTo(saveFile);
				
				//2) FILE_DETAIL 테이블에 insert
				FileDetailVO fileDetailVO = new FileDetailVO();
				fileDetailVO.setFileSn(counter++);
				fileDetailVO.setFileGroupSn(fileGroupSn);
				fileDetailVO.setOrgnlFileNm(multipartFile.getOriginalFilename());
				fileDetailVO.setStrgFileNm(strgFileNm);//uuid + 파일명
				// /upload/ == C:\\upload\\ + 2024\\08\\08 + "\\" + asdfasdf_파일명.jpg
				fileDetailVO.setFilePathNm("https://readygo0729.s3.ap-northeast-2.amazonaws.com" +subPath+"/"+
							this.getFolder().replace("\\", "/") +
							"/" + strgFileNm
						);
				fileDetailVO.setFileSz(fileSz);
				fileDetailVO.setFileExtnNm(
						strgFileNm.substring(strgFileNm.lastIndexOf(".")+1));//asdfasdf_파일명.jpg
				fileDetailVO.setFileMime(contentType);
				fileDetailVO.setFileFancysize(
					makeFancySize(String.valueOf(fileSz))
				);//bytes -> MB
				fileDetailVO.setFileStrgYmd(null);
				fileDetailVO.setFileDwnldCnt(0);
				
				log.info("multiImageUpload->fileDetailVO : " + fileDetailVO);
				amazonS3.putObject(bucket, subPath.substring(1)+"/"+this.getFolder().replace("\\", "/") +"/"+strgFileNm, saveFile);
				result += this.fileDetailMapper.insertFileDetail(fileDetailVO);
				
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		
		log.info("result : " + result);
		
		return fileGroupSn;
	}
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-11-16 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2022-11-16
		String str = sdf.format(date);
		//2024-01-30 -> 2024\\01\\30
		return str.replace("-", File.separator);
	}
	
	//이미지인지 판단. 썸네일은 이미지만 가능하므로..
	public boolean checkImageType(File file) {
		//MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		//MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	//fancySize 리턴("1059000")	
	public String makeFancySize(String bytes) {
		log.info("bytes : " + bytes);
		String retFormat = "0";
		//숫자형문자->실수형으로 형변환(1059000)
		Double size = Double.parseDouble(bytes);
		
		String[] s = { "bytes", "KB", "MB", "GB", "TB", "PB" };
		
		if (bytes != "0") {
		  //bytes->KB
		  int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
		  DecimalFormat df = new DecimalFormat("#,###.##");
		  double ret = ((size / Math.pow(1024, Math.floor(idx))));
		  retFormat = df.format(ret) + " " + s[idx];
		} else {
		  retFormat += " " + s[0];
		}
		
		return retFormat;
	}

}





