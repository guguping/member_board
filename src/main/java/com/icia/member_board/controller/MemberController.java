package com.icia.member_board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
    @GetMapping("/member/save")
    public String memberSave(){
        return "memberPages/memberSave";
    }
}
