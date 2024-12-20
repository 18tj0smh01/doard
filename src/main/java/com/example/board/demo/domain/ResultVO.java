package com.example.board.demo.domain;

import lombok.Data;

@Data
public class ResultVO {

    Object result;
    boolean success;

    public ResultVO(boolean success, Object result) {
        this.result = result;
        this.success = false;
    }
}
