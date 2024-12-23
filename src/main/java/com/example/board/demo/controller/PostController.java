package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.domain.Pagination;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {
    private final HttpSession session;
    private final PostMapper postMapper;
    private final MemberService memberService;
    private final PostService postService;
    private final PostVO postVO;

    public PostController(HttpSession session, PostMapper postMapper, MemberService memberService, PostService postService, PostVO postVO) {
        this.session = session;
        this.postMapper = postMapper;
        this.memberService = memberService;
        this.postService = postService;
        this.postVO = postVO;
    }

    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView list(@ModelAttribute("postVO") PostVO postVO, HttpSession session, Model model) {

        ModelAndView redirectView = new ModelAndView("redirect:/login");
        Long memberId = (Long) session.getAttribute("id");



    if (memberId == null) {
        return redirectView; // 세션이 없으면 로그인 페이지로
    }

        List<PostVO> list = postMapper.selectPostList(10, 0);

        //페이징[s]
        Pagination pagination = new Pagination();
        pagination.setCurrentPageNo(postVO.getPageIndex());
        pagination.setRecordCountPerPage(postVO.getPageUnit());
        pagination.setPageSize(postVO.getPageSize());

        postVO.setFirstIndex(pagination.getFirstRecordIndex());
        postVO.setRecordCountPerPage(pagination.getRecordCountPerPage());

        int totPostCnt = postService.getPostListCnt();

        pagination.setTotalRecordCount(totPostCnt);

        postVO.setEndDate(pagination.getLastPageNoOnPageList());
        postVO.setStartDate(pagination.getFirstPageNoOnPageList());
        postVO.setPrev(pagination.getXprev());
        postVO.setNext(pagination.getXnext());

//        model.addAttribute("boardList",boardList);
        model.addAttribute("totPostCnt",totPostCnt);
        model.addAttribute("totalPageCnt",(int)Math.ceil(totPostCnt / (double)postVO.getPageUnit()));
        model.addAttribute("pagination",pagination);
        //페이징[e]

       return new ModelAndView("list","postList",list);

    }

    // 게시글 쓰는 창으로 가기
    @GetMapping("/write")
    public ModelAndView gotoWrite(Model model) {
        ModelAndView redirectView = new ModelAndView("redirect:/login");
        Long memberId = (Long) session.getAttribute("id");

        if (memberId == null) {
            return redirectView; // 세션이 없으면 로그인 페이지로
        }

        model.addAttribute("postVO", postVO);

        ModelAndView writeView = new ModelAndView("write");

        return writeView;
    }

    // 게시글 쓰기
    @PostMapping("/write")
    public ModelAndView write(@ModelAttribute PostVO postVO) {
        Long memberId = (Long) session.getAttribute("id");

        postVO.setMemberId(memberId);
        postService.createPost(postVO);

        ModelAndView redirectDetailView = new ModelAndView("redirect:/post/detail?id=" + postVO.getId());

        return redirectDetailView;
    }

    // 게시글 상세보기
    @RequestMapping("detail")
    public ModelAndView gotoDetail(@ModelAttribute("postVO") PostVO postVO, CommentVO commentVO, HttpSession session, Model model,@RequestParam("id") Long id) {
        ModelAndView redirectView = new ModelAndView("redirect:/login");
        Long memberId = (Long) session.getAttribute("id");

        if (memberId == null) {
            return redirectView; // 세션이 없으면 로그인 페이지로
        }

        List<CommentVO> commentList = postService.selectPostComment(id);
        PostVO post = postService.getPostById(id);
        List<PostVO> postList = postService.getAllPosts(10, 0);

        //댓글 페이징[s]
        Pagination ComPagination = new Pagination();
        ComPagination.setCurrentPageNo(commentVO.getPageIndex());
        ComPagination.setRecordCountPerPage(commentVO.getPageUnit());
        ComPagination.setPageSize(commentVO.getPageSize());

        commentVO.setFirstIndex(ComPagination.getFirstRecordIndex());
        commentVO.setRecordCountPerPage(ComPagination.getRecordCountPerPage());

        int totComCnt = postService.getComListCnt();

        ComPagination.setTotalRecordCount(totComCnt);

        postVO.setEndDate(ComPagination.getLastPageNoOnPageList());
        postVO.setStartDate(ComPagination.getFirstPageNoOnPageList());
        postVO.setPrev(ComPagination.getXprev());
        postVO.setNext(ComPagination.getXnext());

//        model.addAttribute("boardList",boardList);
        model.addAttribute("totComCnt",totComCnt);
        model.addAttribute("totalPageCnt",(int)Math.ceil(totComCnt / (double)postVO.getPageUnit()));
        model.addAttribute("comPagination",ComPagination);
        //댓글 페이징[e]


        //게시글 페이징[s]
        Pagination postPagination = new Pagination();
        postPagination.setCurrentPageNo(postVO.getPageIndex());
        postPagination.setRecordCountPerPage(postVO.getPageUnit());
        postPagination.setPageSize(postVO.getPageSize());

        postVO.setFirstIndex(postPagination.getFirstRecordIndex());
        postVO.setRecordCountPerPage(postPagination.getRecordCountPerPage());

        int totPostCnt = postService.getPostListCnt();

        postPagination.setTotalRecordCount(totPostCnt);

        postVO.setEndDate(postPagination.getLastPageNoOnPageList());
        postVO.setStartDate(postPagination.getFirstPageNoOnPageList());
        postVO.setPrev(postPagination.getXprev());
        postVO.setNext(postPagination.getXnext());

        model.addAttribute("totPostCnt",totPostCnt);
        model.addAttribute("totalPageCnt",(int)Math.ceil(totPostCnt / (double)postVO.getPageUnit()));
        model.addAttribute("postPagination",postPagination);
        //게시글 페이징[e]


        model.addAttribute("post", post);
        model.addAttribute("comments", commentList);
        model.addAttribute("postList", postList);
        model.addAttribute("commentVO", new CommentVO());

        ModelAndView detailView = new ModelAndView("postDetail");

        return detailView;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView gotoEdit(@PathVariable("id") Long id, Model model, HttpSession session) throws Exception {
        Long memberId = (Long) session.getAttribute("id");
        PostVO post = postService.getPostById(id);

        ModelAndView redirectDetailView = new ModelAndView("redirect:/post/detail?id=" + id);
        if (!post.getMemberId().equals(memberId)) {
            return redirectDetailView;
        }

        if (post == null) {
            throw new IllegalArgumentException("Invalid Post ID: " + id);
        }

        model.addAttribute("post", post);
        return new ModelAndView("edit");
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String editPost(@ModelAttribute("postVO") PostVO postVO, RedirectAttributes rttr) throws Exception {
        postService.editPost(postVO);
        rttr.addAttribute("id", postVO.getId());
        rttr.addFlashAttribute("msg", "MODIFIED");
        return "redirect:/post/detail";
    }


    // 게시글 삭제 기능 (본인만 삭제 가능)
    @RequestMapping(value = "/deletePost/{id}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Long memberId = (Long) session.getAttribute("id");

        ModelAndView redirectDetailView = new ModelAndView("redirect:/post/detail?id=" + id);
        // 게시글 작성자 확인
        PostVO post = postService.getPostById(id);
        if (!post.getMemberId().equals(memberId)) {
            redirectAttributes.addFlashAttribute("errorMessage", "본인만 삭제할 수 있습니다.");
            return redirectDetailView;
        }

        // 게시글 삭제
        postService.deletePost(id);
        redirectAttributes.addFlashAttribute("successMessage", "게시글이 삭제되었습니다.");
        ModelAndView redirectListView = new ModelAndView("redirect:/post/list");

        return redirectListView;
    }


}