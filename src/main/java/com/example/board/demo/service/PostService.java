package com.example.board.demo.service;

import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PostService {

    private static final int LIMIT = 10; // 기본 페이지 크기
    private static final int OFFSET = 0;

    private final PostMapper postMapper;

    public PostService(PostMapper postMapper) {
        this.postMapper = postMapper;
    }
    public List<PostVO> getAllPosts() {
        return postMapper.selectPostList(LIMIT, OFFSET);
    }

    @Transactional
    public PostVO getPostById(long id) {
        return postMapper.selectPost(id);
    }

    @Transactional
    public List<PostVO> getPosts(int limit, int offset) {
        return postMapper.selectPostList(limit, offset);
    }
}