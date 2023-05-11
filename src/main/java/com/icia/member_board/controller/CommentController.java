package com.icia.member_board.controller;

import com.icia.member_board.dto.memberBoardCommentDTO;
import com.icia.member_board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class CommentController {
    @Autowired
    private CommentService commentService;

    @PostMapping("/comment/save")
    public ResponseEntity commentSave(@ModelAttribute memberBoardCommentDTO memberBoardCommentDTO) {
        commentService.save(memberBoardCommentDTO);
        List<memberBoardCommentDTO> commentDTOList = commentService.boardComment(memberBoardCommentDTO.getBoardId());
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }
}
