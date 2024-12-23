package com.example.board.demo.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Data
@Component
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CommentVO {
    private Long id;
    private String commentContent;
    private String commentDate;
    private String commentUpdateTime;
    private Long memberId;
    private Long postId;
    private Long parentCommentId;        // 부모 댓글 ID (NULL이면 일반 댓글)
    private int commentDepth;            // 댓글 깊이 (0: 댓글, 1 이상: 대댓글)

    public Long getId() {
        return id;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public String getCommentDate() {
        return commentDate;
    }

    public String getCommentUpdateTime() {
        return commentUpdateTime;
    }

    public Long getMemberId() {
        return memberId;
    }

    public Long getPostId() {
        return postId;
    }

    public Long getParentCommentId() {
        return parentCommentId;
    }

    public int getCommentDepth() {
        return commentDepth;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }

    public void setCommentUpdateTime(String commentUpdateTime) {
        this.commentUpdateTime = commentUpdateTime;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public void setParentCommentId(Long parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public void setCommentDepth(int commentDepth) {
        this.commentDepth = commentDepth;
    }

}

