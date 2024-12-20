package com.example.board.demo.controller;

import com.example.board.demo.service.MemberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Optional;

@Controller
public class MemberController {
    private final MemberService memberService;

    // 생성자
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/login")
    public String getLogin() {
        return "loginPage";
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

}
