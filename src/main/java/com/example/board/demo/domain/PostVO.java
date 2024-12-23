package com.example.board.demo.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.util.Date;

@Getter
@Setter
@Data
@Component
@ToString
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PostVO extends PageVO {
//    private Long id;
//    private String postTitle;
//    private String postContent;
//    private String postDate;
//    private String postUpdateTime;
//    private Long memberId;
//    private String memberName;
//    private Long viewCount;
//    private Long commentCount;

    @JsonProperty("id")
    private Long id;
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty("postTitle")
    private String postTitle;
    public String getPostTitle() {
        return postTitle;
    }
    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    @JsonProperty("postContent")
    private String postContent;
    public String getPostContent() {
        return postContent;
    }
    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    @JsonProperty("postDate")
    private Date postDate;

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }
    @JsonProperty("postUpdateTime")
    private String postUpdateTime;
    public String getPostUpdateTime() {
        return postUpdateTime;
    }
    public void setPostUpdateTime(String postUpdateTime) {
        this.postUpdateTime = postUpdateTime;
    }

    @JsonProperty("memberId")
    private Long memberId;
    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    @JsonProperty("memberName")
    private String memberName;
    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    @JsonProperty("viewCount")
    private Long viewCount;
    public Long getViewCount() {
        return viewCount;
    }
    public void setViewCount(Long viewCount) {
        this.viewCount = viewCount;
    }

    @JsonProperty("commentCount")
    private Long commentCount;
    public Long getCommentCount() {
        return commentCount;
    }
    public void setCommentCount(Long commentCount) {
        this.commentCount = commentCount;
    }
}
