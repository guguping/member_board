package com.icia.member_board.repository;

import com.icia.member_board.dto.memberBoardDTO;
import com.icia.member_board.dto.memberBoardFileDTO;
import com.icia.member_board.dto.memberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public memberDTO findById(Long memberID) {
        return sql.selectOne("memberboard.findById",memberID);
    }

    public memberBoardDTO boardSave(memberBoardDTO memberBoardDTO) {
        sql.insert("memberboard.boardsave", memberBoardDTO);
        return memberBoardDTO;
    }

    public void boardSaveFile(memberBoardFileDTO memberBoardFileDTO) {
        sql.insert("memberboard.boardSaveFile",memberBoardFileDTO);
    }
}
