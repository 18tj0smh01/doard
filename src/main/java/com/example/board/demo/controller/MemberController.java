package com.example.board.demo.controller;

import com.example.board.demo.domain.MemberVO;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.service.MemberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class MemberController {
    private final MemberService memberService;
    private final MemberVO memberVO;

    public MemberController(MemberService memberService, MemberVO memberVO) {
        this.memberService = memberService;
        this.memberVO = memberVO;
    }

    @GetMapping("/login")
    public ModelAndView getLogin() {
        ModelAndView loginPage = new ModelAndView("loginPage");
        return loginPage;
    }

    @PostMapping("/login")
    public RedirectView login(String memberId, String memberPassword, HttpSession session, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        final Optional<Long> foundMember = memberService.login(memberId, memberPassword);

        if (foundMember.isPresent()) {
            // 쿠키 생성
            Cookie cookie = new Cookie("id", String.valueOf(foundMember.get()));
            cookie.setPath("/");
            session.setAttribute("id", foundMember.get());
            response.addCookie(cookie);
            System.out.println("id:"+foundMember.get());

            return new RedirectView("/post/list");
        }

        redirectAttributes.addFlashAttribute("login", "fail");
        return new RedirectView("/login");
    }

    @GetMapping("/signUp")
    public ModelAndView getSignUp() {
            ModelAndView signUp = new ModelAndView("signUp");
            return signUp;
    }

    @PostMapping("/signUp")
    public RedirectView signUp(@RequestBody MemberVO memberVO, RedirectAttributes redirectAttributes) {

        try {
            memberService.signUp(memberVO);
            redirectAttributes.addFlashAttribute("signUpSuccess", true);
            return new RedirectView("/login");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("signUpFail", true);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return new RedirectView("/signUp");
        }
    }

    @GetMapping("/logout")
    public ResponseEntity<String> logout(HttpSession session, HttpServletResponse response,  HttpServletRequest request) {
        // 세션 무효화
        if (session != null) {
            session.invalidate();
        }

        // 쿠키 제거
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setValue(null);
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }

        return ResponseEntity.ok("로그아웃");
    }

    @RequestMapping(value = "/checkId", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> checkId(@RequestParam("memberId") String memberId) {
        boolean exists = memberService.findByMemberId(memberId);

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("cnt", exists ? 1 : 0);

        return responseMap;
    }

    @RequestMapping(value = "/checkName", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> checkName(@RequestParam("memberName") String memberName) {
        boolean exists = memberService.findByMemberName(memberName);

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("cnt", exists ? 1 : 0);

        return responseMap;
    }

}
