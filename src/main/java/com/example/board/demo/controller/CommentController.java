package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    private final PostMapper postMapper;
    private final MemberService memberService;
    private final PostService postService;

    public CommentController(PostMapper postMapper, MemberService memberService, PostService postService) {
        this.postMapper = postMapper;
        this.memberService = memberService;
        this.postService = postService;
    }

    @PostMapping("/uploadComment")
    public List<CommentVO> uploadComment(
            @RequestParam Long postId,
            @RequestParam String commentContent,
            HttpSession session) {

        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            throw new RuntimeException("로그인이 필요합니다.");
        }

        CommentVO commentVO = new CommentVO();
        commentVO.setPostId(postId);
        commentVO.setCommentContent(commentContent);
        commentVO.setMemberId(memberId);

        postService.uploadComment(commentVO);

        // 해당 게시글에 작성된 최신 댓글 리스트 반환
        return postService.selectPostComment(postId);
    }
}