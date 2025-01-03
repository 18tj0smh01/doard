package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comment")
public class CommentController {
    private final PostService postService;
    private final HttpSession session;

    public CommentController(PostService postService, HttpSession session) {
        this.postService = postService;
        this.session = session;
    }

    // 댓글 작성
    @PostMapping("/writeComment")
    public ResponseEntity<?> writeComment(@RequestBody CommentVO commentVO) {
        Long loggedInMemberId = (Long) session.getAttribute("id");

        if (loggedInMemberId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        if (commentVO.getPostId() == null) {
            return new ResponseEntity<>("게시글 ID가 누락되었습니다.", HttpStatus.BAD_REQUEST);
        }

        commentVO.setMemberId(loggedInMemberId);
        postService.uploadComment(commentVO);
        return new ResponseEntity<>(commentVO, HttpStatus.OK);
    }

    // 대댓글 작성
    @PostMapping("/writeReply")
    public ResponseEntity<?> writeReply(@RequestBody CommentVO commentVO) {
        Long loggedInMemberId = (Long) session.getAttribute("id");

        if (loggedInMemberId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        if (commentVO.getPostId() == null || commentVO.getParentCommentId() == null) {
            return new ResponseEntity<>("게시글 ID 또는 부모 댓글 ID가 누락되었습니다.", HttpStatus.BAD_REQUEST);
        }

        commentVO.setMemberId(loggedInMemberId);
        postService.uploadReply(commentVO);
        return new ResponseEntity<>(commentVO, HttpStatus.OK);
    }

    // 댓글 목록 조회
//    @GetMapping("/detail/{postId}/{page}")
//    public ResponseEntity<List<CommentVO>> list(@PathVariable Long postId, @PathVariable Integer page) {
//        List<CommentVO> comments = postService.selectPostComment(postId);
//        return new ResponseEntity<>(comments, HttpStatus.OK);
//    }

    @GetMapping("/detail/{postId}/{page}")
    public ResponseEntity<List<CommentVO>> selectPostComment(@PathVariable Long postId) {
        List<CommentVO> comments = postService.selectPostComment(postId);
        return ResponseEntity.ok(comments);
    }

    // 댓글 삭제
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable Long id) {
        Long loggedInMemberId = (Long) session.getAttribute("id");

        if (loggedInMemberId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        CommentVO comment = postService.getCommentById(id);
        if (comment == null) {
            return new ResponseEntity<>("댓글을 찾을 수 없습니다.", HttpStatus.NOT_FOUND);
        }

        if (!comment.getMemberId().equals(loggedInMemberId)) {
            return new ResponseEntity<>("본인의 댓글만 삭제할 수 있습니다.", HttpStatus.FORBIDDEN);
        }

        postService.deleteComment(id);
        return new ResponseEntity<>("댓글이 삭제되었습니다.", HttpStatus.OK);
    }

    // 댓글 수정
    @PutMapping("/edit/{id}")
    public ResponseEntity<?> editComment(@PathVariable Long id, @RequestBody Map<String, String> payload) {
        Long loggedInMemberId = (Long) session.getAttribute("id");

        if (loggedInMemberId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        String updatedContent = payload.get("commentContent");
        if (updatedContent == null || updatedContent.trim().isEmpty()) {
            return new ResponseEntity<>("수정할 내용이 없습니다.", HttpStatus.BAD_REQUEST);
        }

        CommentVO comment = postService.getCommentById(id);
        if (comment == null) {
            return new ResponseEntity<>("댓글을 찾을 수 없습니다.", HttpStatus.NOT_FOUND);
        }

        if (!comment.getMemberId().equals(loggedInMemberId)) {
            return new ResponseEntity<>("본인의 댓글만 수정할 수 있습니다.", HttpStatus.FORBIDDEN);
        }

        comment.setCommentContent(updatedContent);
        postService.editComment(comment);
        return new ResponseEntity<>("댓글이 수정되었습니다.", HttpStatus.OK);
    }
}
