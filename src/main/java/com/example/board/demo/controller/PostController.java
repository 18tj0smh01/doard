package com.example.board.demo.controller;

import com.example.board.demo.domain.MemberVO;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import com.example.board.demo.domain.ResultVO;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {
    private final PostMapper postMapper;
    private final MemberService memberService;
    private final PostService postService;

    public PostController(PostMapper postMapper, MemberService memberService, PostService postService) {
        this.postMapper = postMapper;
        this.memberService = memberService;
        this.postService = postService;
    }

//@RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
//@ResponseBody
//public ModelAndView getAllPosts(HttpSession session) {
//
//    ModelAndView redirectView = new ModelAndView("redirect:/login");
//
//    // 세션에서 사용자 ID 가져오기
//    Long memberId = (Long) session.getAttribute("id");
//    if (memberId == null) {
//        return redirectView; // 세션이 없으면 로그인 페이지로
//    }
//
//    // 게시글 리스트 가져오기
//    List<PostVO> postList = postService.getAllPosts();
//    postList.forEach(System.out::println); // 로그 출력 (디버깅용)
//    MemberVO memberVO = new MemberVO();
//
//    // 메인 페이지로 이동하기 위한 ModelAndView
//    ModelAndView listView = new ModelAndView("list");
//
//    listView.addObject("memberVO", memberVO); // 회원 정보
//    listView.addObject("postList", postList); // 게시글 리스트
//
//    return listView;
//}
@RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
@ResponseBody
public List<PostVO> getAllPosts(HttpSession session) {

    Long memberId = (Long) session.getAttribute("id");
    if (memberId == null) {
        return new ArrayList<>();
    }

    List<PostVO> postList = postService.getAllPosts();

    return postList;
}

}