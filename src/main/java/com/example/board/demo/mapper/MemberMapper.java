package com.example.board.demo.mapper;

import com.example.board.demo.domain.MemberVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper
public interface MemberMapper {
    // 로그인
    Long login(String memberId, String memberPassword);

    // 회원 조회
    MemberVO findById(Long id);

    MemberVO signUp(MemberVO member);
}
