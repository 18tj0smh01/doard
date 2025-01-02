package com.example.board.demo.controller;

import com.example.board.demo.domain.CommentVO;
import com.example.board.demo.domain.Pagination;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.mapper.PostMapper;
import com.example.board.demo.service.MemberService;
import com.example.board.demo.service.PostService;

import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/post")
public class PostController {
    private final HttpSession session;
    private final PostMapper postMapper;
    private final MemberService memberService;
    private final PostService postService;
    private final PostVO postVO;

    private static final Logger logger = LoggerFactory.getLogger(PostController.class);

    public PostController(HttpSession session, PostMapper postMapper, MemberService memberService, PostService postService, PostVO postVO) {
        this.session = session;
        this.postMapper = postMapper;
        this.memberService = memberService;
        this.postService = postService;
        this.postVO = postVO;
    }

//    게시글 리스트
//    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
//    public ModelAndView list(@ModelAttribute("postVO") PostVO postVO, Model model, Pagination pagination) {
//        Long memberId = (Long) session.getAttribute("id");
//        if (memberId == null) {
//            return new ModelAndView("redirect:/login");
//        }
//
//        int totPostCnt = postService.getPostListCnt();
//        Pagination postPagination = initializePagination(postVO.getPageIndex(), postVO.getPageUnit(), postVO.getPageSize(), totPostCnt);
//
//        List<PostVO> postList = postMapper.selectPostList(postPagination);
//
//        model.addAttribute("totPostCnt", totPostCnt);
//        model.addAttribute("totalPageCnt", (int) Math.ceil(totPostCnt / (double) postPagination.getRecordCountPerPage()));
//        model.addAttribute("pagination", postPagination);
//
//        logger.debug("Post list retrieved. Total posts: {}, Current page: {}", totPostCnt, postPagination.getCurrentPageNo());
//
//        return new ModelAndView("list", "postList", postList);
//    }

    @GetMapping("/list")
    public ResponseEntity<Map<String, Object>> getPostList(
            @RequestParam(defaultValue = "1") int pageIndex,
            @RequestParam(defaultValue = "10") int pageUnit) {

        int totalPostCount = postService.getPostListCnt();
        Pagination pagination = initializePagination(pageIndex, pageUnit, 10, totalPostCount);
        List<PostVO> postList = postMapper.selectPostList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("postList", postList);
        response.put("pagination", pagination);

        return ResponseEntity.ok(response);
    }

//    게시글 작성
    @GetMapping("/write")
    public ModelAndView gotoWrite(Model model) {
        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            return new ModelAndView("redirect:/login");
        }
        model.addAttribute("postVO", new PostVO());
        return new ModelAndView("write");
    }

    @PostMapping("/write")
    public ResponseEntity<String> write(@RequestBody PostVO postVO) {
        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        postVO.setMemberId(memberId);
        try {
            postService.createPost(postVO);
            return ResponseEntity.ok("게시글 작성이 완료되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 작성에 실패했습니다.");
        }
    }

//    @PostMapping("/write")
//    public ModelAndView write(@ModelAttribute PostVO postVO) {
//        Long memberId = (Long) session.getAttribute("id");
//        postVO.setMemberId(memberId);
//        postService.createPost(postVO);
//
//        return new ModelAndView("redirect:/post/detail?id=" + postVO.getId());
//    }

//  게시글 상세
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView gotoDetail(@RequestParam("id") Long id, Model model) {
        Long memberId = (Long) session.getAttribute("id");
        if (memberId == null) {
            return new ModelAndView("redirect:/login");
        }

        PostVO post = postService.getPostById(id);
        if (post == null) {
            model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
            return new ModelAndView("error");
        }

        model.addAttribute("post", post);
        return new ModelAndView("postDetail");
    }

//  게시글 수정
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView gotoEdit(@PathVariable("id") Long id, Model model) {
        Long memberId = (Long) session.getAttribute("id");
        PostVO post = postService.getPostById(id);

        if (post == null || !post.getMemberId().equals(memberId)) {
            return new ModelAndView("redirect:/post/detail?id=" + id);
        }

        model.addAttribute("post", post);
        return new ModelAndView("edit");
    }

    @PutMapping("/edit/{id}")
    public ResponseEntity<String> editPost(@PathVariable("id") Long id, @RequestBody PostVO postVO) {
        Long loggedInMemberId = (Long) session.getAttribute("id");

        PostVO post = postService.getPostById(id);
        if (post == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("게시물을 찾을 수 없습니다.");
        }

        if (!post.getMemberId().equals(loggedInMemberId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("본인의 글만 삭제할 수 있습니다.");
        }
        postVO.setId(id);
        postService.editPost(postVO);

        return ResponseEntity.ok("게시글이 수정되었습니다.");
    }


//    @RequestMapping(value = "/edit", method = RequestMethod.POST)
//    public ModelAndView editPost(@ModelAttribute("postVO") PostVO postVO, RedirectAttributes rttr) {
//        postService.editPost(postVO);
//        rttr.addAttribute("id", postVO.getId());
//        rttr.addFlashAttribute("msg", "MODIFIED");
//
//        return new ModelAndView("redirect:/post/detail");
//    }

//    게시글 삭제
//    @RequestMapping(value = "/deletePost/{id}", method = RequestMethod.GET)
//    public ModelAndView delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
//        Long memberId = (Long) session.getAttribute("id");
//        PostVO post = postService.getPostById(id);
//
//        if (post == null || !post.getMemberId().equals(memberId)) {
//            redirectAttributes.addFlashAttribute("errorMessage", "본인만 삭제할 수 있습니다.");
//            return new ModelAndView("redirect:/post/detail?id=" + id);
//        }
//
//        postService.deletePost(id);
//        redirectAttributes.addFlashAttribute("successMessage", "게시글이 삭제되었습니다.");
//        return new ModelAndView("redirect:/post/list");
//    }

//    @DeleteMapping("/deletePost")
//    public ResponseEntity<String> deletePost(@RequestBody Map<String, Long> payload) {
//        if (payload == null || !payload.containsKey("id")) {
//            return new ResponseEntity<>("삭제불가", HttpStatus.BAD_REQUEST);
//        }
//        Long postId = payload.get("id");
//
//        Long loggedInUserId = (Long) session.getAttribute("id");
//        if (loggedInUserId == null) {
//            return new ResponseEntity<>("로그인 필요", HttpStatus.UNAUTHORIZED);
//        }
//
//        PostVO post = postService.getPostById(postId);
//        if (post == null) {
//            return new ResponseEntity<>("게시물을 찾을 수 없습니다.", HttpStatus.NOT_FOUND);
//        }
//
//        if (!post.getMemberId().equals(loggedInUserId)) {
//            return new ResponseEntity<>("본인 글만 삭제 가능", HttpStatus.FORBIDDEN);
//        }
//
//        postService.deletePost(postId);
//        return new ResponseEntity<>("게시글이 삭제되었습니다.", HttpStatus.OK);
//    }

    @DeleteMapping("/deletePost/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id) {
        Long loggedInMemberId = (Long) session.getAttribute("id");
//        if (loggedInUserId == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                    .body("로그인이 필요합니다.");
//        }

        PostVO post = postService.getPostById(id);
        if (post == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("게시물을 찾을 수 없습니다.");
        }

        if (!post.getMemberId().equals(loggedInMemberId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("본인의 글만 삭제할 수 있습니다.");
        }

        postService.deletePost(id);
        return ResponseEntity.ok("게시글이 삭제되었습니다.");
    }


    @GetMapping
    public ResponseEntity<Map<String, Object>> getPosts(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Map<String, Object> response = postService.getPagedPosts(page, size);
        return ResponseEntity.ok(response);
    }


    private Pagination initializePagination(int pageIndex, int pageUnit, int pageSize, int totalRecordCount) {
        Pagination pagination = new Pagination();
        pagination.setCurrentPageNo(pageIndex > 0 ? pageIndex : 1);
        pagination.setRecordCountPerPage(pageUnit > 0 ? pageUnit : 10);
        pagination.setPageSize(pageSize > 0 ? pageSize : 10);
        pagination.setFirstRecordIndex((pagination.getCurrentPageNo() - 1) * pagination.getRecordCountPerPage());
        pagination.setTotalRecordCount(totalRecordCount);

        int realEnd = (int) Math.ceil((double) totalRecordCount / pagination.getRecordCountPerPage());
        pagination.setRealEnd(realEnd);

        pagination.setXprev(pagination.getCurrentPageNo() > 1);
        pagination.setXnext(pagination.getCurrentPageNo() < realEnd);

        return pagination;
    }

}
