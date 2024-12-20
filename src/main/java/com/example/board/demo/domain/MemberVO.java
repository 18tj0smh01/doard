package com.example.board.demo.domain;

import lombok.*;

@Getter
@Setter
public class MemberVO {
    private long id;
    private String memberId;
    private String memberPassword;
    private String memberName;
    private String createdDate;

    public String getMemberId() {
        return this.memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }
}
