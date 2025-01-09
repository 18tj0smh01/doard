package com.example.board.demo.domain;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Data
@Component
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FileVO {
    @JsonProperty("id")
    private Long id;

    @JsonProperty("filePath")
    private String filePath;       // 파일 경로

    @JsonProperty("fileUuid")
    private String fileUuid;       // 파일 UUID

    @JsonProperty("fileName")
    private String fileName;       // 파일 이름

    @JsonProperty("fileType")
    private String fileType;       // 확장자

    @JsonProperty("fileSize")
    private Long fileSize;         // 파일 크기

    @JsonProperty("filePurpose")
    private String filePurpose;    // 용도 ('POST', 'COMMENT', 'MEMBER')

    @JsonProperty("postId")
    private Long postId;           // 게시글 ID

    @JsonProperty("commentId")
    private Long commentId;        // 댓글 ID

    @JsonProperty("memberId")
    private Long memberId;         // 회원 ID

    public FileVO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileUuid() {
        return fileUuid;
    }

    public void setFileUuid(String fileUuid) {
        this.fileUuid = fileUuid;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFilePurpose() {
        return filePurpose;
    }

    public void setFilePurpose(String filePurpose) {
        this.filePurpose = filePurpose;
    }

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    @Override
    public String toString() {
        return "FileVO{" +
                "id=" + id +
                ", filePath='" + filePath + '\'' +
                ", fileUuid='" + fileUuid + '\'' +
                ", fileName='" + fileName + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileSize=" + fileSize +
                ", filePurpose='" + filePurpose + '\'' +
                ", postId=" + postId +
                ", commentId=" + commentId +
                ", memberId=" + memberId +
                '}';
    }
}