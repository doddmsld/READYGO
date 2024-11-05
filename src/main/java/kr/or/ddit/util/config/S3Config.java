package kr.or.ddit.util.config;

import java.io.File;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration
@PropertySource("classpath:application.properties")
public class S3Config {

    @Value("${cloud.aws.credentials.access-key}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secret-key}")
    private String secretKey;

    @Value("${cloud.aws.region.static}")
    private String region;
    
    @PostConstruct
    public void init() {
        String uploadPath = "C:\\upload"; // 고정된 업로드 경로
        File uploadDir = new File(uploadPath);

        // 디렉터리 존재 여부 확인 후 생성
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 디렉터리 생성
        }
    }
    
    @Bean
    public AmazonS3 amazonS3() {
        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
        
        // Credentials 확인 로그
//        System.out.println("Access Key: " + accessKey);
//        System.out.println("Secret Key: " + secretKey);
//        System.out.println("Region: " + region);

        return AmazonS3ClientBuilder.standard()
                .withRegion(region)
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .build();
    }
}