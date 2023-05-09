package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class memberFileDTO {
    Long id;
    String originalFileName;
    String storedFileName;
    Long memberId;
}
