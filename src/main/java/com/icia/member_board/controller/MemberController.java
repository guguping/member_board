package com.icia.member_board.controller;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.context.annotation.RequestScope;

import java.io.IOException;

@Controller
public class MemberController {
    @Autowired
    private MemberService memberService;
    @GetMapping("/member/save")
    public String memberSave(){
        return "memberPages/memberSave";
    }
    @PostMapping("/member/save")
    public String saveMember(@ModelAttribute memberDTO memberDTO) throws IOException {
        System.out.println("memberDTO = " + memberDTO);
        memberService.saveMember(memberDTO);
        return "memberPages/memberList";
    }
    @GetMapping("/member/list")
    public String memberList(){

        return "memberPages/memberList";
    }
    @GetMapping("/member/login")
    public String memberLogin(){
        return "memberPages/memberLogin";
    }
    @PostMapping("/member/login")
    public String Loginmember(@ModelAttribute memberDTO memberDTO , Model model){
        memberDTO dto = memberService.loginMember(memberDTO);
        if(dto != null) {
            model.addAttribute("memberDTO", dto);
            return "boardPages/boardMain";
        } else {
            String loginFalse = "아이디 또는 비밀번호를 잘못 입력했습니다."+"<br>"+"입력하신 내용을 다시 확인해주세요.";
            model.addAttribute("loginFalse",loginFalse);
            return "memberPages/memberLogin";
        }

    }
}
