package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class memberBoardCommentDTO {
    Long id;
    Long boardId;
    Long memberId;
    String commentWriter;
    String commentContents;
    Timestamp commentCreatedDate;
}
