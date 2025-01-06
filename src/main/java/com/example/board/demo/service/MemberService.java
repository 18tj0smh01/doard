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

    public Optional<MemberVO> findById(Long id) {
        return Optional.ofNullable(memberMapper.findById(id));
    }

    public boolean findByMemberId(String memberId) {
        return memberMapper.findByMemberId(memberId) > 0;
    }
    public boolean findByMemberName(String memberName) {
        return memberMapper.findByMemberName(memberName) > 0;
    }

    public Optional<Long> login(String memberId, String memberPassword) {
        return Optional.ofNullable(memberMapper.login(memberId, memberPassword));
    }

    public MemberVO signUp(MemberVO memberVO) {
        memberMapper.signUp(memberVO);
        return memberVO;
    }
//    public MemberVO getMemberId(Long id) {}

}
