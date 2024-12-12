package de.djaeck.project_m.controller;

import de.djaeck.project_m.service.S3Service;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/images")
public class ImageController {

    private final S3Service s3Service;

    public ImageController(S3Service s3Service) {
        this.s3Service = s3Service;
    }

    /**
     * Upload an image to MinIO via API request.
     *
     * @param file The file to upload (multipart)
     * @return ResponseEntity with upload status
     */
    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file) {
        try {
            String keyName = "uploaded-images/" + System.currentTimeMillis() + "-" + file.getOriginalFilename();
            String response = s3Service.uploadFile(file, keyName);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}
