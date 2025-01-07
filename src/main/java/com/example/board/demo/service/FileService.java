package com.example.board.demo.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileService {

    private static final String UPLOAD_DIR = "/uploads/";

    public String saveFile(MultipartFile file) throws IOException {
        // 파일 저장 경로 생성
        String originalFilename = file.getOriginalFilename();
        String uniqueFilename = UUID.randomUUID() + "_" + originalFilename;
        Path filePath = Paths.get(UPLOAD_DIR, uniqueFilename);

        // 디렉토리가 없는 경우 생성
        Files.createDirectories(filePath.getParent());

        // 파일 저장
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return filePath.toString();
    }
}