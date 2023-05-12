package com.icia.member_board.controller;

import com.icia.member_board.dto.*;
import com.icia.member_board.service.BoardService;
import com.icia.member_board.service.CommentService;
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
    @Autowired
    private CommentService commentService;

    @GetMapping("/board/logout")
    public String boardLogout(HttpSession session) {
        session.invalidate();
        return "index";
    }

    @GetMapping("/board/main")
    public String boardMain() {
        return "boardPages/boardMain";
    }

    @GetMapping("/board/save")
    public String boardSave() {
        return "boardPages/boardSave";
    }

    @PostMapping("/board/save")
    public String saveBoard(@ModelAttribute memberBoardDTO memberBoardDTO,
                            HttpSession session) throws IOException {
        memberDTO DTO = boardService.findById((Long) session.getAttribute("memberID"));
        memberBoardDTO.setMemberId(DTO.getId());
        memberBoardDTO.setBoardWriter(DTO.getMemberEmail());
        boardService.boardSave(memberBoardDTO);
        return "redirect:/board/list";
    }

    @GetMapping("/board/list")
    public String boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                            Model model) {
        List<memberBoardDTO> memberBoardDTOList = null;
        pageDTO pageDTO = null;
        if (q.equals("")) {
            memberBoardDTOList = boardService.boardList(page);
            pageDTO = boardService.pagingParam(page);
        } else {
            memberBoardDTOList = boardService.boardSearchList(page, type, q);
            pageDTO = boardService.pagingSearchParams(page, type, q);
        }
        model.addAttribute("boardList", memberBoardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "boardPages/boardList";
    }

    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam("id") Long id,
                              @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "q", required = false, defaultValue = "") String q,
                              @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                              Model model, HttpSession session) {
        memberDTO memberDTO = boardService.findById((Long) session.getAttribute("memberID"));
        boardService.updateHits(id);
        memberBoardDTO memberBoardDTO = boardService.boardDetail(id);
        if (memberBoardDTO.getFileAttached() == 1) {
            List<memberBoardFileDTO> memberBoardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", memberBoardFileDTOList);
        }
        List<memberBoardCommentDTO> cList = commentService.boardComment(id);
        if (cList.size() == 0) {
            model.addAttribute("cList", null);
        } else {
            model.addAttribute("cList", cList);
        }
        model.addAttribute("boardDTO", memberBoardDTO);
        model.addAttribute("memberDTO", memberDTO);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "boardPages/boardDetail";
    }

    @GetMapping("/board/delete")
    public String boardDelete(@RequestParam("boardId") Long boardId,
                              @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "q", required = false, defaultValue = "") String q,
                              @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type) {
        boardService.boardDelete(boardId);
        return "redirect:/board/list?page="+page+"&type"+type+"&q="+q;
    }

    @GetMapping("/board/update")
    public String boardUpdate(@RequestParam("boardId") Long boardId,
                              @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "q", required = false, defaultValue = "") String q,
                              @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                              Model model) {
        memberBoardDTO boardDTO = boardService.findByboard(boardId);
        System.out.println("boardDTO = " + boardDTO);
        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "boardPages/boardUpdate";
    }
    @PostMapping("/board/update")
    public String updateBoard(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "q", required = false, defaultValue = "") String q,
                              @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                              @ModelAttribute memberBoardDTO memberBoardDTO){
        System.out.println("memberBoardDTO = " + memberBoardDTO);
        boardService.updateBoard(memberBoardDTO);
        return "redirect:/board/detail?id="+memberBoardDTO.getId()+"&page="+page+"&type="+type+"&q="+q;
    }
    @GetMapping("/board/myPage")
    public String myPage(HttpSession session,Model model){
        memberFileDTO memberFileDTO =  boardService.memberFile((Long)session.getAttribute("memberID"));
        memberDTO memberDTO = boardService.findById((Long)session.getAttribute("memberID"));
        model.addAttribute("memberFile",memberFileDTO);
        model.addAttribute("memberDTO",memberDTO);
        return "boardPages/boardMyPage";
    }
}
