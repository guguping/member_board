package com.icia.member_board.controller;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.dto.pageDTO;
import com.icia.member_board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.annotation.RequestScope;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

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
        memberService.saveMember(memberDTO);
        return "memberPages/memberLogin";
    }
    @GetMapping("/member/login")
    public String memberLogin(){
        return "memberPages/memberLogin";
    }
    @PostMapping("/member/login")
    public String Loginmember(@ModelAttribute memberDTO memberDTO , Model model , HttpSession session){
        memberDTO dto = memberService.loginMember(memberDTO);
        if(dto != null) {
            session.setAttribute("memberID",dto.getId());
            session.setAttribute("memberEmail",dto.getMemberEmail());
            return "boardPages/boardMain";
        } else {
            String loginFalse = "아이디 또는 비밀번호를 잘못 입력했습니다."+"<br>"+"입력하신 내용을 다시 확인해주세요.";
            model.addAttribute("loginFalse",loginFalse);
            return "memberPages/memberLogin";
        }
    }
    @GetMapping("/member/list")
    public String memberList(@RequestParam(value = "page", required = false,defaultValue = "1")int page,
                             @RequestParam(value = "q",required = false,defaultValue = "") String q,
                             @RequestParam(value = "type",required = false,defaultValue = "memberEmail") String type,
                             Model model){
        List<memberDTO> memberDTOList = null;
        pageDTO pageDTO = null;
        if(q.equals("")) {
            memberDTOList = memberService.memberList(page);
            pageDTO = memberService.pagingParam(page);

        } else {
            memberDTOList = memberService.memberSearchList(page,type,q);
            pageDTO = memberService.searchPagingParam(page,type,q);
        }
        model.addAttribute("memberList",memberDTOList);
        model.addAttribute("paging",pageDTO);
        model.addAttribute("q",q);
        model.addAttribute("type",type);
        return "memberPages/memberList";
    }
    @PostMapping("/member/emailCheck")
    public ResponseEntity emailCheck(@RequestParam("memberEmail") String memberEmail,
                                     HttpSession session){
        String dbEmail = memberService.emailCheck(memberEmail);
        if (dbEmail != null && !(session.getAttribute("memberEmail").equals(memberEmail))){
            return new ResponseEntity(HttpStatus.CONFLICT);
        } else {
            return new ResponseEntity(HttpStatus.OK);
        }
    }
}
