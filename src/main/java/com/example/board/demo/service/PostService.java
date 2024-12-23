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
        int rowsAffected = postMapper.postUpload(postVO); // 게시글 삽입
        if (rowsAffected == 0) {
            throw new RuntimeException("게시글 생성 실패");
        }
        return postVO;
    }

    // 게시글 수정
    @Transactional
    public PostVO editPost(PostVO postVO) {
        int updatedRows = postMapper.postEdit(postVO);

        if (updatedRows == 0) {
            throw new RuntimeException("게시글 수정에 실패했습니다. ID: " + postVO.getId());
        }

        PostVO updatedPost = postMapper.selectPost(postVO.getId());
        if (updatedPost == null) {
            throw new RuntimeException("수정 후 게시글을 조회하지 못했습니다. ID: " + postVO.getId());
        }

        return updatedPost;
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
    @Transactional
    public CommentVO uploadComment(CommentVO commentVO) {
        int rowsAffected = commentMapper.commentUpload(commentVO); // 게시글 삽입
        if (rowsAffected == 0) {
            throw new RuntimeException("댓글 생성 실패");
        }
        return commentVO;
    }

    // 대댓글 추가
    @Transactional
    public CommentVO uploadReply(CommentVO commentVO) {
        int rowsAffected = commentMapper.replyUpload(commentVO); // 게시글 삽입
        if (rowsAffected == 0) {
            throw new RuntimeException("대댓글 생성 실패");
        }
        return commentVO;
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
    @Transactional
    public CommentVO editComment(CommentVO commentVO){
        
        int updatedRows =commentMapper.commentEdit(commentVO);

        if (updatedRows == 0) {
            throw new RuntimeException("댓글 수정에 실패했습니다. ID: " + commentVO.getId());
        }

        CommentVO editComment = (CommentVO) commentMapper.selectPostComment(commentVO.getId());
        if (editComment == null) {
            throw new RuntimeException("수정 후 댓글을 조회하지 못했습니다. ID: " + commentVO.getId());
        }

        return editComment;
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
