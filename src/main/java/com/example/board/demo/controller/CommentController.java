package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentController {
    private final PostService postService;

    public CommentController(PostService postService) {
        this.postService = postService;
    }

    @PostMapping("/write")
    public ResponseEntity<?> writeComment(@RequestBody CommentVO commentVO, HttpSession session) {
        Long memberId = (Long) session.getAttribute("id");

        if (memberId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        if (commentVO.getPostId() == null) {
            return new ResponseEntity<>("게시글 ID가 누락되었습니다.", HttpStatus.BAD_REQUEST);
        }

        commentVO.setMemberId(memberId);
        postService.uploadComment(commentVO);
        return new ResponseEntity<>(commentVO, HttpStatus.OK);
    }

    @GetMapping("/detail/{postId}/{page}")
    public ResponseEntity<List<CommentVO>> list(@PathVariable Long postId, @PathVariable Integer page) {
        List<CommentVO> comments = postService.selectPostComment(postId);
        return new ResponseEntity<>(comments, HttpStatus.OK);
    }
}
