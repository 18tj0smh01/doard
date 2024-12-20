package com.example.board.demo.controller;

import com.example.board.demo.domain.MemberVO;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import com.example.board.demo.domain.ResultVO;
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


//    @ResponseBody
//    @RequestMapping(value = "/list", method = RequestMethod.GET)
//    public ResultVO getBoardList(@RequestParam(defaultValue = "10") int limit,
//                                 @RequestParam(defaultValue = "0") int offset,
//                                 Model model,
//                                 HttpSession session) {
//
//        Long memberId = (Long) session.getAttribute("id");
//
//        // 결과 값을 담을 ResultVO를 선언한 생성자를 통해서 만드는데 기본값은 success는 false, result는 null로 세팅
//        ResultVO result = new ResultVO(false, null);
//
//            result.setResult(postService.getPosts(limit, offset));
//            result.setSuccess(true);
//
//
//        return result;
//
//    }



//    @GetMapping("/list")
//    @PostMapping("/list")
    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public String getAllPosts(@RequestParam(defaultValue = "10") int limit,
                               @RequestParam(defaultValue = "0") int offset,
                               Model model,
                               HttpSession session) {

        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }

        List<PostVO> postList = postService.getPosts(limit, offset);
        postList.forEach(post -> System.out.println(post));
        postList.forEach(System.out::println);

        MemberVO memberVO = new MemberVO();
        if (memberId != null) {
            memberVO = memberService.findById(memberId).orElse(new MemberVO());
        }

        model.addAttribute("memberVO", memberVO);
        model.addAttribute("postList", postList);

        return "list";
    }

//    @PostMapping("/list")
//    @GetMapping("/list")
//@RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
//@ResponseBody
//public List<PostVO> getAllPosts(@RequestParam(defaultValue = "10") int limit,
//                                @RequestParam(defaultValue = "0") int offset,
//                                HttpSession session) {
//    Long memberId = (Long) session.getAttribute("id");
//    if (memberId == null) {
//        return new ArrayList<>();
//    }
//
//    List<PostVO> postList = postService.getPosts(limit, offset);
//    postList.forEach(post -> System.out.println(post));
//    postList.forEach(System.out::println);
//    return postList;
//}


}