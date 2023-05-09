package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class memberBoardFileDTO {
    Long id;
    String originalFileName;
    String storedFileName;
    Long boardId;
}
