package com.icia.member_board.controller;

import com.icia.member_board.dto.memberBoardDTO;
import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.dto.pageDTO;
import com.icia.member_board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

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
    public String boardList(@RequestParam(value = "page", required = false,defaultValue = "1") int page,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                            Model model) {
    List<memberBoardDTO> memberBoardDTOList = null;
        pageDTO pageDTO = null;
        if(q.equals("")) {
            memberBoardDTOList = boardService.boardList(page);
            pageDTO = boardService.pagingParam(page);
        } else {
            memberBoardDTOList = boardService.boardSearchList(page, type, q);
            pageDTO = boardService.pagingSearchParams(page, type, q);
        }
        model.addAttribute("boardList",memberBoardDTOList);
        model.addAttribute("paging",pageDTO);
        model.addAttribute("q",q);
        model.addAttribute("type",type);
        return "boardPages/boardList";
    }

}
