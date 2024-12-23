package com.example.board.demo.service;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.CommentMapper;
import com.example.board.demo.mapper.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PostService {

    private final PostMapper postMapper;
    private final CommentMapper commentMapper;

    public PostService(PostMapper postMapper, CommentMapper commentMapper) {
        this.postMapper = postMapper;
        this.commentMapper = commentMapper;
    }

    // 모든 게시글 조회 (기본 limit과 offset)
    @Transactional(readOnly = true)
    public List<PostVO> getAllPosts(int limit, int offset) {
        return postMapper.selectPostList(limit, offset);
    }

    // 게시글 생성
    @Transactional
    public PostVO createPost(PostVO postVO) {
        postMapper.postUpload(postVO); // 업로드
        return postVO; // 성공 시 저장된 객체 반환
    }

    // 게시글 수정
    @Transactional
    public PostVO editPost(PostVO postVO) {
        postMapper.postEdit(postVO); // 수정
        return postVO; // 성공 시 수정된 객체 반환
    }

    // 게시글 삭제
    @Transactional
    public void deletePost(Long id) {
        postMapper.deletePost(id); // 삭제 수행
    }

    // ID로 게시글 조회
    @Transactional(readOnly = true)
    public PostVO getPostById(Long id) {
        return postMapper.selectPost(id);
    }

    // 제한된 개수의 게시글 목록 조회
    @Transactional(readOnly = true)
    public List<PostVO> getPosts(int limit, int offset) {
        return postMapper.selectPostList(limit, offset);
    }
    
    // 댓글 추가
    public void uploadComment(CommentVO commentVO) {
        commentMapper.commentUpload(commentVO);
    }

    // 대댓글 추가
    public void uploadReply(CommentVO commentVO) {
        commentMapper.replyUpload(commentVO);
    }

    // 댓글 삭제
    public void deleteComment(Long commentId) {
        commentMapper.deleteComment(commentId);
    }

    // 댓글 전체 삭제
    public void deleteAll(Long postId) {
        commentMapper.deleteAll(postId);
    }

    // 댓글 수정
    public void editComment(CommentVO commentVO){
        commentMapper.commentEdit(commentVO);
    }

    // 게시글에 대한 댓글 리스트 조회
    public List<CommentVO> selectPostComment(Long postId){
        return commentMapper.selectPostComment(postId);
    }

    public List<CommentVO> getList(Long commentId) {
        return commentMapper.selectAll(commentId);
    }

    public CommentVO getCommentById(Long id) {
        return commentMapper.findCommentById(id);
    }
}
