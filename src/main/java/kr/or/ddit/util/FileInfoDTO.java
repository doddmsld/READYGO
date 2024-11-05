package kr.or.ddit.util;

import lombok.Data;

@Data
public class FileInfoDTO {
    private String fileName;
    private String fileSize;
    private String lastModifiedDate;
    private String creationDate;
    private String lastModifiedBy;
    private String thumbnailUrl;
    private String totalFileSize;
    
    // 기본 생성자
    public FileInfoDTO() {}
    
    // 필요한 필드를 포함하는 생성자
    public FileInfoDTO(String fileName, String fileSize, String lastModifiedBy, String lastModifiedDate, 
                       String creationDate, String thumbnailUrl, String totalFileSize) {
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.lastModifiedBy = lastModifiedBy;
        this.lastModifiedDate = lastModifiedDate;
        this.creationDate = creationDate;
        this.thumbnailUrl = thumbnailUrl;
        this.totalFileSize = totalFileSize;
    }
}