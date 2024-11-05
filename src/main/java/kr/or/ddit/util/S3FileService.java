package kr.or.ddit.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.S3ObjectSummary;

import kr.or.ddit.util.FileInfoDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Service
@RequiredArgsConstructor
public class S3FileService {

    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    // 파일 업로드
    public String uploadFile(MultipartFile multipartFile, long localModifiedDate, String empNo, String folderPath) throws IOException {
        String originalFilename = multipartFile.getOriginalFilename();
        
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(multipartFile.getSize());
        metadata.setContentType(multipartFile.getContentType());

        // 클라이언트에서 전달받은 로컬 수정 날짜, 사원번호 메타데이터에 추가
        metadata.addUserMetadata("local-modified-date", String.valueOf(localModifiedDate));
        metadata.addUserMetadata("emp-no", empNo); // 사원 번호를 메타데이터에 추가

        String uploadPath; // 업로드 경로
        String thumbnailPath; // 썸네일 경로 초기화

        // FileInputStream을 사용하여 S3에 파일 업로드
        try (InputStream inputStream = multipartFile.getInputStream()) {
            // folderPath가 비어있지 않다면 해당 경로로 업로드, 원본 파일명 사용
            if (folderPath != null && !folderPath.isEmpty()) {
                // folderPath의 마지막에 "/"가 없는 경우 추가
                if (!folderPath.endsWith("/")) {
                    folderPath += "/";
                }
                uploadPath = folderPath + originalFilename; // 최종 업로드 경로
            } else {
                uploadPath = originalFilename; // 최상위 디렉토리에 저장
            }
            
            // 썸네일 경로는 원본 파일명에서 폴더 이름을 제거하고 "_thumbnail.jpg"로 설정
            thumbnailPath = "thumbnails/" + originalFilename.substring(0, originalFilename.lastIndexOf('.')) + "_thumbnail.jpg";

            // S3에 파일 업로드
            amazonS3.putObject(bucket, uploadPath, inputStream, metadata); // S3에 파일 업로드

            // 이미지 파일인 경우 썸네일 생성
            if (isImageFile(originalFilename)) {
                // 원본 파일의 InputStream을 다시 가져와서 썸네일 생성
                InputStream thumbnailInputStream = new ByteArrayInputStream(multipartFile.getBytes());
                generateThumbnail(thumbnailInputStream, thumbnailPath); // 썸네일 생성 메서드 호출
            }
        } // try-with-resources로 자동으로 닫힘

        return amazonS3.getUrl(bucket, uploadPath).toString(); // uploadPath 사용
    }

    // 이미지 파일인지 확인하는 메서드
    private boolean isImageFile(String filename) {
        String[] imageExtensions = { "jpg", "jpeg", "png", "gif", "bmp" };
        String fileExtension = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
        return Arrays.asList(imageExtensions).contains(fileExtension);
    }
    
    // 썸네일 생성 메서드
    private void generateThumbnail(InputStream inputStream, String thumbnailPath) throws IOException {
        // Thumbnailator를 사용하여 썸네일 생성
        try (OutputStream outputStream = new ByteArrayOutputStream()) {
            Thumbnails.of(inputStream)
                       .size(180, 100) // 크기 조정
                       .outputFormat("jpg") // JPEG 형식으로 저장
                       .toOutputStream(outputStream); // OutputStream에 저장
            
            InputStream thumbnailInputStream = new ByteArrayInputStream(((ByteArrayOutputStream) outputStream).toByteArray());

            // S3에 썸네일 업로드
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(((ByteArrayOutputStream) outputStream).size());
            amazonS3.putObject(bucket, thumbnailPath, thumbnailInputStream, metadata);
        }
    }
    
    // 폴더 생성 메서드 수정
    public void createFolder(String folderPath, String empNo) {
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(0);
        metadata.addUserMetadata("emp-no", empNo); // 사원 번호를 메타데이터에 추가

        // 생성 날짜 추가
        SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm");
        String creationDate = sdf.format(new Date());
        metadata.addUserMetadata("creation-date", creationDate); // 생성 날짜 메타데이터 추가

        try (InputStream emptyContent = new ByteArrayInputStream(new byte[0])) {
            amazonS3.putObject(bucket, folderPath, emptyContent, metadata);
        } catch (IOException e) {
            throw new RuntimeException("Error creating folder in S3", e);
        }
    }
    
//    // 파일 삭제
//    public void deleteFiles(DriveDeleteVO request) {
//        List<String> filenames = request.getFiles(); // 선택된 파일명 리스트
//        String folderPath = request.getFolderPath(); // 폴더 경로
//
//        // 폴더 경로가 제공되고 파일 리스트가 비어있다면 폴더 전체 삭제
//        if (folderPath != null && !folderPath.isEmpty() && (filenames == null || filenames.isEmpty())) {
//            deleteFolderContents(folderPath);
//        } else if (filenames != null && !filenames.isEmpty()) {
//            // 파일 리스트가 있는 경우 각 파일 삭제
//            for (String filename : filenames) {
//                String fullPath;
//                if (folderPath == null || folderPath.isEmpty()) {
//                    // folderPath가 비어있을 경우 최상위 디렉토리에 있는 파일 삭제
//                    fullPath = filename; // filename만 사용
//                } else {
//                    // folderPath가 제공된 경우
//                    fullPath = folderPath + (folderPath.endsWith("/") ? "" : "/") + filename;
//                }
//                deleteFile(fullPath); // 개별 파일 삭제 호출
//            }
//        }
//    }

    // 개별 파일 삭제
    public void deleteFile(String originalFilename) {
        // 원본 파일 삭제
        if (originalFilename.endsWith("/")) {
            // 폴더의 모든 파일 삭제
            deleteFolderContents(originalFilename);
        } else {
            // 개별 파일 삭제
            amazonS3.deleteObject(bucket, originalFilename);
        }

        // 이미지 파일 삭제 처리
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.') + 1).toLowerCase();
        List<String> imageExtensions = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp", "tiff");
        if (imageExtensions.contains(fileExtension)) {
            String thumbnailFilename = getThumbnailFilename(originalFilename); // 썸네일 경로 생성
            try {
                amazonS3.deleteObject(bucket, thumbnailFilename); // 썸네일 삭제
                System.out.println("Thumbnail deleted: " + thumbnailFilename);
            } catch (AmazonS3Exception e) {
                System.err.println("Error deleting thumbnail: " + e.getMessage());
            }
        }
    }

    // 폴더 내 모든 파일 삭제
    public void deleteFolderContents(String folderPath) {
        ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
            .withBucketName(bucket)
            .withPrefix(folderPath);  // 폴더 경로를 prefix로 설정

        ObjectListing objectListing = amazonS3.listObjects(listObjectsRequest);

        // 폴더 내 모든 객체 삭제
        for (S3ObjectSummary summary : objectListing.getObjectSummaries()) {
            amazonS3.deleteObject(bucket, summary.getKey());
        }

        // 추가적으로, 하위 폴더가 있는 경우 재귀적으로 삭제
        for (String commonPrefix : objectListing.getCommonPrefixes()) {
            deleteFolderContents(commonPrefix);
        }
    }

    // 썸네일 파일명 생성
    private String getThumbnailFilename(String originalFilename) {
        // 원본 파일명에서 경로와 확장자를 제외한 파일명 추출
        String fileNameWithoutPath = originalFilename.substring(originalFilename.lastIndexOf("/") + 1);
        // 썸네일 파일 경로를 'thumbnails/파일명_thumbnail.확장자' 형식으로 반환
        return "thumbnails/" + fileNameWithoutPath.substring(0, fileNameWithoutPath.lastIndexOf('.')) + "_thumbnail.jpg";
    }
    
    // 파일 리스트 가져오기
    public List<FileInfoDTO> listFiles(String empNm, String empNo, String folderPath) {
        final long[] totalFileSizeInBytes = {0};
        List<FileInfoDTO> fileList = new ArrayList<>();

        // folderPath가 주어지지 않으면 최상위 디렉토리의 모든 파일과 폴더를 가져옴
        if (folderPath == null || folderPath.isEmpty()) {
            folderPath = "";  // 최상위 디렉토리를 가리킴
        } else {
            // folderPath가 주어진 경우, 해당 폴더의 경로를 prefix로 설정
            folderPath = folderPath.endsWith("/") ? folderPath : folderPath + "/";
        }

        // S3에서 파일 및 폴더 목록 가져오기
        ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
                .withBucketName(bucket)
                .withPrefix(folderPath)
                .withDelimiter("/");  // 하위 디렉토리를 구분

        ObjectListing objectListing = amazonS3.listObjects(listObjectsRequest);

        // S3에서 반환된 객체 목록을 처리
        for (S3ObjectSummary summary : objectListing.getObjectSummaries()) {
            log.info("S3 Key: " + summary.getKey());  // 반환된 S3 키를 출력

            // folderPath가 null이 아닐 때만 해당 폴더의 파일 가져오기
            if (folderPath.isEmpty() || summary.getKey().startsWith(folderPath)) {
                FileInfoDTO fileInfoDTO = new FileInfoDTO();
                ObjectMetadata metadata = amazonS3.getObjectMetadata(bucket, summary.getKey());
                String empNoCheck = metadata.getUserMetaDataOf("emp-no");

                // empNo와 메타데이터의 empNo가 일치하는 경우만 처리
                if (empNo != null && empNoCheck != null && empNoCheck.equals(empNo)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm");

                    // 파일 리스트 가져오기 메서드 수정 (일부만)
                    if (summary.getKey().endsWith("/")) { // 폴더일 경우
                        fileInfoDTO.setFileName(summary.getKey());
                        fileInfoDTO.setFileSize("-");
                        fileInfoDTO.setTotalFileSize("-");
                        fileInfoDTO.setLastModifiedDate("");
                        fileInfoDTO.setThumbnailUrl("");

                        // 생성 날짜 메타데이터에서 가져오기
                        String creationDate = metadata.getUserMetaDataOf("creation-date");
                        fileInfoDTO.setCreationDate(creationDate != null ? creationDate : "-"); // null이면 "-"로 설정
                        
                        fileInfoDTO.setLastModifiedBy(empNm);
                        fileList.add(fileInfoDTO); // 폴더 정보 추가
                    } else {
                        // 파일인 경우
                        String fileName = summary.getKey().substring(summary.getKey().lastIndexOf("/") + 1); // 파일 이름만 추출
                        fileInfoDTO.setFileName(fileName); // 파일 이름만 설정

                        long fileSizeInBytes = metadata.getContentLength();
                        String readableFileSize = (fileSizeInBytes < 1024) ? fileSizeInBytes + " B" :
                                (fileSizeInBytes < (1024 * 1024)) ? (fileSizeInBytes / 1024) + " KB" :
                                        String.format("%.1f MB", fileSizeInBytes / (1024.0 * 1024.0));
                        fileInfoDTO.setFileSize(readableFileSize);

                        totalFileSizeInBytes[0] += fileSizeInBytes;

                        fileInfoDTO.setCreationDate(sdf.format(summary.getLastModified()));
                        String localModifiedDate = metadata.getUserMetaDataOf("local-modified-date");
                        if (localModifiedDate != null) {
                            fileInfoDTO.setLastModifiedDate(new SimpleDateFormat("yy.MM.dd HH:mm").format(new Date(Long.parseLong(localModifiedDate))));
                        }

                        // 원본 파일의 경로에서 파일 이름만 추출 (파일명만 남기기) 
                        String fileNameWithoutPath = summary.getKey().substring(summary.getKey().lastIndexOf("/") + 1);

                        // 썸네일 파일 경로 설정 (항상 "thumbnails/파일명_thumbnail.jpg"로 저장됨)
                        String thumbnailKey = "thumbnails/" + fileNameWithoutPath.substring(0, fileNameWithoutPath.lastIndexOf('.')) + "_thumbnail.jpg";

                        // S3에 썸네일이 존재하는지 확인
                        if (amazonS3.doesObjectExist(bucket, thumbnailKey)) {
                            fileInfoDTO.setThumbnailUrl(amazonS3.getUrl(bucket, thumbnailKey).toString());
                        } else {
                            fileInfoDTO.setThumbnailUrl("썸네일 없음");
                        }

                        fileInfoDTO.setLastModifiedBy(empNm);

                        // totalFileSize 설정
                        String readableTotalFileSize = (totalFileSizeInBytes[0] < 1024) ? totalFileSizeInBytes[0] + " B" :
                                (totalFileSizeInBytes[0] < (1024 * 1024)) ? (totalFileSizeInBytes[0] / 1024) + " KB" :
                                        String.format("%.1f MB", totalFileSizeInBytes[0] / (1024.0 * 1024.0));
                        fileInfoDTO.setTotalFileSize(readableTotalFileSize);

                        fileList.add(fileInfoDTO); // 파일 정보 추가
                    }
                }
            }
        }

        // 하위 폴더 목록 추가 (folderPath가 비어 있을 때만)
        if (folderPath.isEmpty()) {
            for (String prefix : objectListing.getCommonPrefixes()) {
                // 메타데이터에서 사원 번호 가져오기
                ObjectMetadata folderMetadata = amazonS3.getObjectMetadata(bucket, prefix);
                String empNoCheck = folderMetadata.getUserMetaDataOf("emp-no");

                // empNo와 메타데이터의 empNo가 일치하는 경우만 추가
                if (empNo != null && empNoCheck != null && empNoCheck.equals(empNo)) {
                	
                	String creationDate = folderMetadata.getUserMetaDataOf("creation-date");
                	
                    FileInfoDTO folderInfoDTO = new FileInfoDTO();
                    folderInfoDTO.setFileName(prefix);
                    folderInfoDTO.setFileSize("-");
                    folderInfoDTO.setTotalFileSize("-");
                    folderInfoDTO.setLastModifiedDate("");
                    folderInfoDTO.setThumbnailUrl("");
                    folderInfoDTO.setCreationDate(creationDate != null ? creationDate : "-");
                    folderInfoDTO.setLastModifiedBy(empNm);
                    fileList.add(folderInfoDTO); // 하위 폴더 정보 추가
                }
            }
        }

        // 파일과 폴더 정렬
        return fileList.stream()
                .sorted((f1, f2) -> {
                    boolean isFolder1 = f1.getFileName().endsWith("/");
                    boolean isFolder2 = f2.getFileName().endsWith("/");

                    if (isFolder1 && !isFolder2) {
                        return -1; // 폴더는 파일보다 상단에 위치
                    } else if (!isFolder1 && isFolder2) {
                        return 1; // 파일은 폴더보다 하단에 위치
                    }

                    if (isFolder1 && isFolder2) {
                        return f1.getFileName().compareTo(f2.getFileName());
                    } else {
                        return f2.getCreationDate().compareTo(f1.getCreationDate());
                    }
                })
                .collect(Collectors.toList());
    }
}