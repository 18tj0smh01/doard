package com.example.board.demo.service;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.domain.Pagination;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.CommentMapper;
import com.example.board.demo.mapper.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PostService {

    private final PostMapper postMapper;
    private final CommentMapper commentMapper;

    public PostService(PostMapper postMapper, CommentMapper commentMapper) {
        this.postMapper = postMapper;
        this.commentMapper = commentMapper;
    }

    // 모든 게시글 조회 (기본 recordCountPerPage과 firstRecordIndex)
    @Transactional(readOnly = true)
    public List<PostVO> getAllPosts(Pagination pagination) {
        return postMapper.selectPostList(pagination);
    }

        int recordCountPerPage= 10;
    public int getPostListCnt() {
        return postMapper.getPostListCnt();
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
    public List<PostVO> getPosts(Pagination pagination) {
        return postMapper.selectPostList(pagination);
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
    public CommentVO editComment(CommentVO commentVO) {
        // 댓글 수정
        int updatedRows = commentMapper.commentEdit(commentVO);

        if (updatedRows == 0) {
            throw new RuntimeException("댓글 수정에 실패했습니다. ID: " + commentVO.getId());
        }

        // 수정된 댓글 조회
        CommentVO editedComment = commentMapper.selectCommentResult(commentVO.getId());
        if (editedComment == null) {
            throw new RuntimeException("수정 후 댓글을 조회하지 못했습니다. ID: " + commentVO.getId());
        }

        return editedComment;
    }



    // 게시글에 대한 댓글 리스트 조회
    public List<CommentVO> selectPostComment(Long postId){
        return commentMapper.selectPostComment(postId);
    }

    public int getComListCnt() {
        return commentMapper.getComListCnt();
    }

    public List<CommentVO> getList(Long commentId) {
        return commentMapper.selectAll(commentId);
    }

    public CommentVO getCommentById(Long id) {
        return commentMapper.findCommentById(id);
    }

    public Map<String, Object> getPagedPosts(int page, int size) {
        int offset = (page - 1) * size;
        List<PostVO> posts = postMapper.getPosts(offset, size);
        int totalCount = postMapper.getTotalCount();
        int totalPages = (int) Math.ceil((double) totalCount / size);

        Map<String, Object> response = new HashMap<>();
        response.put("posts", posts);
        response.put("currentPage", page);
        response.put("totalPages", totalPages);
        response.put("totalCount", totalCount);
        return response;
    }

    public List<PostVO> getPaginatedPostList(Pagination postPagination) {
        if (postPagination == null) {
            throw new IllegalArgumentException("Pagination object cannot be null");
        }

        List<PostVO> postList = postMapper.selectPostList(postPagination);

        return postList != null ? postList : new ArrayList<>();
    }
}
