package com.icia.member_board.repository;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.dto.memberFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public memberDTO saveMember(memberDTO memberDTO) {
        sql.insert("memberboard.save",memberDTO);
        return memberDTO;
    }

    public void saveFile(memberFileDTO memberFileDTO) {
        sql.insert("memberboard.saveFile",memberFileDTO);
    }

    public memberDTO loginMember(memberDTO memberDTO) {
        return sql.selectOne("memberboard.loginMember",memberDTO);
    }
}
