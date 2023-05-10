package com.icia.member_board.controller;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

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
    @GetMapping("member/login")
    public String memeberLogin(){
        return "memberPages/memberLogin";
    }
    @PostMapping("member/login")
    public String Loginmember(){
        return "boardPages/main";
    }
}
