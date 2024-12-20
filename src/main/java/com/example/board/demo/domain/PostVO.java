package com.example.board.demo.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PostVO {
    @JsonProperty("id")
    private long id;

    @JsonProperty("postTitle")
    private String postTitle;

    @JsonProperty("postContent")
    private String postContent;

    @JsonProperty("postDate")
    private String postDate;

    @JsonProperty("postUpdateTime")
    private String postUpdateTime;

    @JsonProperty("memberId")
    private long memberId;

    @JsonProperty("memberName")
    private String memberName;

    @JsonProperty("viewCount")
    private long viewCount;

    @JsonProperty("commentCount")
    private long commentCount;
}
