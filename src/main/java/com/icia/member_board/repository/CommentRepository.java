package com.icia.member_board.repository;

import com.icia.member_board.dto.memberBoardCommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public List<memberBoardCommentDTO> boardComment(Long id) {
        return sql.selectList("memberboard.boardComment",id);
    }

    public void save(memberBoardCommentDTO memberBoardCommentDTO) {
        sql.insert("memberboard.commentSave",memberBoardCommentDTO);
    }
}
