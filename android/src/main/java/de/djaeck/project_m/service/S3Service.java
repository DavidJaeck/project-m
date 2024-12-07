package de.djaeck.project_m.service;

import de.djaeck.project_m.config.S3Properties;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@Service
public class S3Service {

    private final S3Client s3Client;
    private final S3Properties s3Properties;

    public S3Service(S3Client s3Client, S3Properties s3Properties) {
        this.s3Client = s3Client;
        this.s3Properties = s3Properties;
    }

    /**
     * Upload file to MinIO bucket.
     *
     * @param file The file to upload
     * @param keyName The key (path) where the file will be stored
     * @return The ETag for the uploaded file
     */
    public String uploadFile(MultipartFile file, String keyName) {
        try {
            // Convert MultipartFile to a temporary file
            Path tempFilePath = Files.createTempFile("upload-", file.getOriginalFilename());
            file.transferTo(tempFilePath.toFile());

            // Create a PutObjectRequest for S3
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(s3Properties.getBucketName())
                    .key(keyName)
                    .contentType(file.getContentType())
                    .build();

            PutObjectResponse response = s3Client.putObject(putObjectRequest, tempFilePath);

            // Clean up temporary file
            Files.deleteIfExists(tempFilePath);

            return "File uploaded successfully. ETag: " + response.eTag();
        } catch (IOException e) {
            throw new RuntimeException("File upload failed: " + e.getMessage(), e);
        }
    }
}
