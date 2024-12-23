package com.example.board.demo.mapper;


import com.example.board.demo.domain.PostVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PostMapper {
    List<PostVO> selectPostList(int limit, int offset);

    PostVO postUpload(PostVO postVO);

    void deletePost(Long id);

    PostVO postEdit(PostVO postVO);

    PostVO selectPost(Long id);
}
