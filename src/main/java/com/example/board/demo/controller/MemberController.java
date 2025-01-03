package com.example.board.demo.controller;

import com.example.board.demo.domain.MemberVO;
import com.example.board.demo.domain.PostVO;
import com.example.board.demo.service.MemberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

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
    public RedirectView login(String memberId, String memberPassword, HttpSession session, RedirectAttributes redirectAttributes) {
        final Optional<Long> foundMember = memberService.login(memberId, memberPassword);

        if (foundMember.isPresent()) {
            // Cookie 생성
            Cookie cookie = new Cookie("id", String.valueOf(foundMember.get()));
            cookie.setPath("/");

            session.setAttribute("id", foundMember.get());

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
            return new RedirectView("/signUp"); // 회원가입 페이지
        }
    }


}
