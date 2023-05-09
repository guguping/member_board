package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class memberBoardDTO {
    Long id;
    String boardTitle;
    String boardWriter;
    String boardContents;
    String boardHits;
    Timestamp boardCreatedDate;
    int fileAttached = 0;
    Long memberId;
}
