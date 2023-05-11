package com.icia.member_board.repository;

import com.icia.member_board.dto.memberBoardDTO;
import com.icia.member_board.dto.memberBoardFileDTO;
import com.icia.member_board.dto.memberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    public List<memberBoardDTO> boardList(Map<String, Integer> listParams) {
        return sql.selectList("memberboard.boardList",listParams);
    }

    public int boardCount() {
        return sql.selectOne("memberboard.boardCount");
    }

    public List<memberBoardDTO> boardSearchList(Map<String, Object> pagingParams) {
        return sql.selectList("memberboard.boardSearchList",pagingParams);
    }

    public int boardSearchCount(Map<String, Object> paginParams) {
        return sql.selectOne("memberboard.boardSearchCount",paginParams);
    }

    public void updateHits(Long id) {
        sql.update("memberboard.updateHits",id);
    }

    public memberBoardDTO boardDetail(Long id) {
        return sql.selectOne("memberboard.boardDetail",id);
    }

    public List<memberBoardFileDTO> findFile(Long boardid) {
        return sql.selectList("memberboard.findFile",boardid);
    }
}
