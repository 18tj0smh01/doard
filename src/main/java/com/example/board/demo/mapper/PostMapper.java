package com.example.board.demo.mapper;


import com.example.board.demo.domain.PostVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PostMapper {
    List<PostVO> selectPostList(int limit, int offset);

    int postUpload(PostVO postVO);

    void deletePost(Long id);

    int postEdit(PostVO postVO);

    int getPostListCnt();

    PostVO selectPost(Long id);
}
