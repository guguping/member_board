package com.icia.member_board.service;

import com.icia.member_board.dto.memberBoardCommentDTO;
import com.icia.member_board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public List<memberBoardCommentDTO> boardComment(Long id) {
        return commentRepository.boardComment(id);
    }
}
