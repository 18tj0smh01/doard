package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
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
import org.springframework.web.servlet.view.RedirectView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {
    private final PostMapper postMapper;
    private final MemberService memberService;
    private final PostService postService;
    private final PostVO postVO;

    public PostController(PostMapper postMapper, MemberService memberService, PostService postService, PostVO postVO) {
        this.postMapper = postMapper;
        this.memberService = memberService;
        this.postService = postService;
        this.postVO = postVO;
    }

    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView list(HttpSession session) {

        ModelAndView redirectView = new ModelAndView("redirect:/login");
        Long memberId = (Long) session.getAttribute("id");

    if (memberId == null) {
        return redirectView; // 세션이 없으면 로그인 페이지로
    }

        List<PostVO> list =postMapper.selectPostList(10, 0);
       return new ModelAndView("list","postList",list);

    }

    // 게시글 쓰는 창으로 가기
    @GetMapping("/write")
    public String writeform() {
        return "write";
    }

    // 게시글 쓰기
    @PostMapping("/write")
    public String write(PostVO postVO) {
        // 게시글 등록
        postService.createPost(postVO);


        return "redirect:detail?id=" + postVO.getId();
    }

    // 게시글 상세보기
    @GetMapping("/detail")
    public String detail(HttpSession session, Model model, Long id, boolean notModify) {
        PostVO postVO = postService.getPostById(id);
        List<CommentVO> comments = postService.selectPostComment(id);

        if (notModify) {
            session.removeAttribute("modifyReview");
        }

        model.addAttribute("post", postVO);
        model.addAttribute("comments", comments);

        return "/postDetail";
    }

    // 게시글 삭제 기능 (본인만 삭제 가능)
    @GetMapping("/delete")
    public String delete(HttpSession session, Model model, Long id, String writer) {
        Long memberId = (Long) session.getAttribute("id");

        // 관리자나 소유자가 아닐 경우
        if (!(memberId.equals(writer))) {
            model.addAttribute("id", id);
            model.addAttribute("msg", "본인만 삭제가 가능합니다");
            return "redirect:detail";
        }

        postService.deletePost(id);
        return "redirect:list";
    }

    // 업데이트 폼으로 가기 (본인만 수정 가능)
    @GetMapping("/updateform")
    public String updateform(HttpSession session, Model model, Long id, String writer) {

        Long memberId = (Long) session.getAttribute("id");

        if (!(memberId.equals(writer))) {
            model.addAttribute("id", id);
            model.addAttribute("msg", "본인만 수정 가능합니다");
            return "redirect:detail";
        }

        PostVO postVO = postService.getPostById(id);
        postVO.setPostContent(postVO.getPostContent().replace("<br>", "\r\n"));


        model.addAttribute("post", postVO);
        model.addAttribute("comments", postService.getCommentById(id));

        return "/edit";
    }

    // 업데이트 기능(파일도 업데이트 가능)
    @PostMapping("/update")
    public String update(PostVO postVO){

        postService.editPost(postVO);


        return "redirect:detail?id=" + postVO.getId();
    }


//    @GetMapping("/detail")
//    public ModelAndView gotoDetail(@RequestParam("id") Long id, HttpSession session) {
//        Long memberId = (Long) session.getAttribute("id");
//
//        if (memberId == null) {
//            return new ModelAndView(new RedirectView("/login"));
//        }
//
//        PostVO post = postService.getPostById(id);
//        if (post == null) {
//            return new ModelAndView("redirect:/post/list");
//        }
//
//        List<CommentVO> commentList = postService.getCommentsByPostId(id);
//
//        ModelAndView detailView = new ModelAndView("postDetail");
//        detailView.addObject("post", post);
//        detailView.addObject("comments", commentList);
//
//        return detailView;
//    }
//
//
//
//    @GetMapping("/write")
//    public ModelAndView getWritePage() {
//        ModelAndView mav = new ModelAndView("write");
//        mav.addObject("postVO", new PostVO());
//        return mav; // 작성 페이지로 이동
//    }
//
//    /**
//     * 게시글 작성 처리
//     */
//    @PostMapping("/write")
//    public ModelAndView createPost(@ModelAttribute PostVO postVO, HttpSession session) {
//        ModelAndView mav = new ModelAndView();
//
//        Long memberId = (Long) session.getAttribute("id");
//        if (memberId == null) {
//            mav.setViewName("redirect:/login");
//            return mav;
//        }
//
//        // 게시글 작성자의 ID 설정
//        postVO.setMemberId(memberId);
//        postService.createPost(postVO);
//
//
//        // 작성 완료 후 상세 페이지로 리다이렉트
//        mav.setViewName("redirect:/post/detail");
//        mav.addObject("id", postVO.getId());
//        return mav;
//    }
//
//
//
//    @GetMapping("/delete")
//    public String delete(@RequestParam("id") Long id) {
//        postService.deletePost(id);
//        return "redirect:/list";
//    }
//
//    @GetMapping("/update")
//    public String updateForm(@RequestParam("id") Long id, Model model) {
//        PostVO postVO = postService.getPostById(id);
//        model.addAttribute("post", postVO);
//        return "update";
//    }
//
//    @PostMapping("/update")
//    public String update(@ModelAttribute PostVO postVO, Model model) {
//        postService.editPost(postVO);
//        postVO = postService.getPostById(postVO.getId());
//        model.addAttribute("post", postVO);
//        return "postDetail";
//    }

//    @RequestMapping("/write")
//    public ModelAndView goToWrite(PostVO postVO, Model model, HttpSession session) {
//        ModelAndView redirectView = new ModelAndView("redirect:/login");
//        Long memberId = (Long) session.getAttribute("id");
//
//        if (memberId == null) {
//            return redirectView; // 세션이 없으면 로그인 페이지로
//        }
//        model.addAttribute("memberName", memberService.findById(memberId).get().getMemberName());
//
//        ModelAndView writeView = new ModelAndView("write");
//        return writeView;
//    }
//
//    @RequestMapping("/writeInsert")
//    public String insertPost(PostVO postVO) {
//        postService.createPost(postVO);
//        return "redirect:list";
//    }


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


//    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
//    @ResponseBody
//    public List<PostVO> getAllPosts(HttpSession session) {
//
//        Long memberId = (Long) session.getAttribute("id");
//        if (memberId == null) {
//            return new ArrayList<>();
//        }
//
//        List<PostVO> postList = postService.getAllPosts();
//
//        return postList;
//    }


}