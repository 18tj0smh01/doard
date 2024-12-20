package com.example.board.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.example.board.demo.mapper")
public class DoardApplication {

    public static void main(String[] args) {
        SpringApplication.run(DoardApplication.class, args);
    }

}
