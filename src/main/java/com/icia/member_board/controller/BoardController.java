package com.icia.member_board.controller;

import com.icia.member_board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board/logout")
    public String boardLogout(HttpSession session){
        session.invalidate();
        return "index";
    }
    @GetMapping("/board/save")
    public String boardSave(){
        return "boardPages/boardSave";
    }

    @GetMapping("/board/list")
    public String boardList(){
        return "boardPages/boardList";
    }

}
