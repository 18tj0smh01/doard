package com.example.board.demo.mapper;


import com.example.board.demo.domain.Pagination;
import com.example.board.demo.domain.PostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PostMapper {
    List<PostVO> selectPostList(@Param("Pagination")Pagination pagination);

    int postUpload(PostVO postVO);

    void deletePost(Long id);

    int postEdit(PostVO postVO);

    int getPostListCnt();

    PostVO selectPost(Long id);
}
