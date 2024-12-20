package com.example.board.demo.service;

import com.example.board.demo.domain.MemberVO;
import com.example.board.demo.mapper.MemberMapper;
import org.springframework.stereotype.Service;

import java.util.Optional;

//enum LoginResult {
//    SUCCESS,
//    ID_MISMATCH,
//    PASSWORD_MISMATCH
//}

@Service
public class MemberService {

    private final MemberMapper memberMapper;

    public MemberService(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    public Optional<MemberVO> findById(long id) {
        return Optional.ofNullable(memberMapper.findById(id));
    }

    public Optional<Long> login(String memberId, String memberPassword) {
        return Optional.ofNullable(memberMapper.login(memberId, memberPassword));
    }
}
