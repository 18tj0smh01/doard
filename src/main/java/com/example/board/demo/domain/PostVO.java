package com.example.board.demo.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PostVO {
    private long id;
    private String postTitle;
    private String postContent;
    private String postDate;
    private String postUpdateTime;
    private long memberId;
    private String memberName;
    private long viewCount;
    private long commentCount;
}
