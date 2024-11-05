package kr.or.ddit.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.util.IOUtils;

import kr.or.ddit.util.S3FileService;
import kr.or.ddit.security.CustomUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/files")
@RequiredArgsConstructor
public class S3FileController {

    private final S3FileService s3FileService;
    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;
    
    // 파일 업로드
    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(
            @RequestParam("file") MultipartFile[] files, // 다중 파일을 받을 수 있도록 수정
            @RequestParam("localModifiedDate") long localModifiedDate,
            @RequestParam("empNo") String empNo,
            @RequestParam(value = "folderPath", required = false) String folderPath) { // folderPath 추가
        try {
            for (MultipartFile file : files) {
                // 각 파일에 대해 업로드 수행
                String fileUrl = s3FileService.uploadFile(file, localModifiedDate, empNo, folderPath); // folderPath 전달
                // 파일 URL을 처리할 로직 추가 (예: 리스트에 저장하거나 로그 출력)
            }
            return ResponseEntity.ok("파일 업로드 완료"); // 성공 메시지
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    // 폴더 생성
    @PostMapping("/folder")
    public ResponseEntity<Void> createFolder(@RequestBody String folderPath) {
        if (!folderPath.endsWith("/")) {
            folderPath += "/";  // 폴더 경로가 '/'로 끝나지 않으면 추가
        }
        
        // 현재 인증된 사용자 정보 가져오기
 		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
 		
 		// CustomUser로 캐스팅하여 EmployeeVO에 접근
 		CustomUser customUser = (CustomUser) authentication.getPrincipal();
        
//        s3FileService.createFolder(folderPath);
        return ResponseEntity.ok().build();
    }


    // 단일 파일 다운로드
    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(@RequestParam("file") String file) {
        try {
            // 파일 경로와 이름을 모두 처리할 수 있도록 디코딩
            String decodedFilename = URLDecoder.decode(file, StandardCharsets.UTF_8.toString());

            // S3에서 파일을 가져올 때 폴더 구조까지 포함한 경로로 가져오기
            S3Object s3Object = amazonS3.getObject(new GetObjectRequest(bucket, decodedFilename));
            InputStreamResource resource = new InputStreamResource(s3Object.getObjectContent());

            // 파일명 인코딩
            String encodedFilename = URLEncoder.encode(decodedFilename.substring(decodedFilename.lastIndexOf('/') + 1), StandardCharsets.UTF_8.toString())
                                      .replaceAll("\\+", "%20");

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFilename)
                    .body(resource);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 다중 파일 다운로드 (ZIP)
    @GetMapping("/download-multiple")
    public ResponseEntity<Resource> downloadMultipleFiles(@RequestParam("files") String filesParam) {
        try {
            String[] filenames = filesParam.split(",");
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(baos);

            for (String filename : filenames) {
                // 폴더 구조까지 포함하여 파일 경로 디코딩
                String decodedFilename = URLDecoder.decode(filename, StandardCharsets.UTF_8.toString());
                S3Object s3Object = amazonS3.getObject(new GetObjectRequest(bucket, decodedFilename));
                
                // Zip 파일에 추가될 때는 파일 이름만 추가
                String zipEntryName = decodedFilename.substring(decodedFilename.lastIndexOf('/') + 1);
                ZipEntry zipEntry = new ZipEntry(zipEntryName);
                zos.putNextEntry(zipEntry);

                IOUtils.copy(s3Object.getObjectContent(), zos);
                zos.closeEntry();
                s3Object.close();
            }

            zos.close();
            ByteArrayResource resource = new ByteArrayResource(baos.toByteArray());

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"download.zip\"")
                    .body(resource);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }



//    // 파일 목록 가져오기
//    @GetMapping("/list")
//    public ResponseEntity<List<FileInfoDTO>> listFiles(@RequestParam(required = false) String folderPath) {
//        // 현재 인증된 사용자 정보 가져오기
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//
//        // CustomUser로 캐스팅하여 EmployeeVO에 접근
//        CustomUser customUser = (CustomUser) authentication.getPrincipal();
//        
//        log.info("파일 목록 가져오기 경로 : " + folderPath);
//        
//        // 폴더 경로를 사용하여 파일 목록을 가져옵니다.
//        List<FileInfoDTO> fileList = s3FileService.listFiles(employeeVO.getEmpNm(), employeeVO.getEmpNo(), folderPath);
//        return ResponseEntity.ok(fileList);
//    }
}
