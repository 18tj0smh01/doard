package com.example.board.demo.mapper;

import com.example.board.demo.domain.CommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {

    int commentUpload(CommentVO commentVO);

    int replyUpload(CommentVO commentVO);

    int deleteComment(Long commentId);

    int deleteAll(Long postId);

    int commentEdit(CommentVO commentVO);

    List<CommentVO> selectPostComment(Long postId);

    CommentVO findCommentById(Long commentId);

    CommentVO selectCommentResult(Long commentId);

    public List<CommentVO> selectAll(Long commentId);

    int getComListCnt();
    int getCommentCountByPostId(Long postId);
}