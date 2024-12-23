package com.example.board.demo.mapper;

import com.example.board.demo.domain.CommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {

    void commentUpload(CommentVO commentVO);

    void replyUpload(CommentVO commentVO);

    void deleteComment(Long commentId);

    void deleteAll(Long postId);

    void commentEdit(CommentVO commentVO);

    List<CommentVO> selectPostComment(Long postId);

    CommentVO findCommentById(Long commentId);

    public List<CommentVO> selectAll(Long commentId);

}