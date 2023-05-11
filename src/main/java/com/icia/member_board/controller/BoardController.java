package com.icia.member_board.controller;

import com.icia.member_board.dto.memberBoardDTO;
import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board/logout")
    public String boardLogout(HttpSession session){
        session.invalidate();
        return "index";
    }
    @GetMapping("/board/main")
    public String boardMain(){
        return "boardPages/boardMain";
    }
    @GetMapping("/board/save")
    public String boardSave(){
        return "boardPages/boardSave";
    }

    @PostMapping("/board/save")
    public String saveBoard(@ModelAttribute memberBoardDTO memberBoardDTO,
                            HttpSession session) throws IOException {
        memberDTO DTO = boardService.findById((Long)session.getAttribute("memberID"));
        memberBoardDTO.setMemberId(DTO.getId());
        memberBoardDTO.setBoardWriter(DTO.getMemberEmail());
        boardService.boardSave(memberBoardDTO);
        return "boardPages/boardMain";
    }

    @GetMapping("/board/list")
    public String boardList(HttpSession session){
        memberDTO DTO = boardService.findById((Long)session.getAttribute("memberID"));
        return "boardPages/boardList";
    }

}
