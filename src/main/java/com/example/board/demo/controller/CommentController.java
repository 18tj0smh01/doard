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

    // 댓글 작성
    @PostMapping("write")
    public ResponseEntity<CommentVO> writeComment(@RequestBody CommentVO commentVO, HttpSession session) {
        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        commentVO.setMemberId(memberId);
        postService.uploadComment(commentVO);
        return new ResponseEntity<>(commentVO, HttpStatus.OK);
    }

    // 댓글 리스트
    @GetMapping("/detail/{postId}/{page}")
    public ResponseEntity<List<CommentVO>> list(@PathVariable Long postId, @PathVariable Integer page) {
        List<CommentVO> comments = postService.selectPostComment(postId);
        return new ResponseEntity<>(comments, HttpStatus.OK);
    }

    // 댓글 수정
    @PutMapping("edit")
    public ResponseEntity<?> editComment(@RequestBody CommentVO commentVO, HttpSession session) {
//        Long memberId = (Long) session.getAttribute("id");
//        if (memberId == null || !memberId.equals(commentVO.getMemberId())) {
//            return new ResponseEntity<>("수정 권한이 없습니다.", HttpStatus.FORBIDDEN);
//        }
        postService.editComment(commentVO);
        return new ResponseEntity<>("댓글이 수정되었습니다.", HttpStatus.OK);
    }

    // 댓글 삭제
    @DeleteMapping("delete")
    public ResponseEntity<?> deleteComment(@RequestBody CommentVO commentVO, HttpSession session) {
//        Long memberId = (Long) session.getAttribute("id");
//        if (memberId == null || !memberId.equals(commentVO.getMemberId())) {
//            return new ResponseEntity<>("삭제 권한이 없습니다.", HttpStatus.FORBIDDEN);
//        }
        postService.deleteComment(commentVO.getId());
        return new ResponseEntity<>("댓글이 삭제되었습니다.", HttpStatus.OK);
    }
}
