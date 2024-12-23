package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
    @ResponseBody
    public List<CommentVO> uploadComment(
            @RequestBody Map<String, Object> requestData,
            HttpSession session) {

        Object postIdObject = requestData.get("postId");
        Long postId;
        if (postIdObject instanceof String) {
            postId = Long.valueOf((String) postIdObject);
        } else if (postIdObject instanceof Number) {
            postId = ((Number) postIdObject).longValue();
        } else {
            throw new IllegalArgumentException("postId 형식이 올바르지 않습니다.");
        }

        String commentContent = requestData.get("commentContent").toString();

        // ID 확인
        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }



        CommentVO commentVO = new CommentVO();
        commentVO.setPostId(postId);
        commentVO.setCommentContent(commentContent);
        commentVO.setMemberId(memberId);

        postService.uploadComment(commentVO);

        // 해당 게시글의 댓글 리스트 반환
        return postService.selectPostComment(postId);
    }
}