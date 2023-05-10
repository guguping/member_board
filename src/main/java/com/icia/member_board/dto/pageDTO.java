package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class pageDTO {
    int page; // 현재 페이지
    int maxPage; // 전체페이지갯수
    int startPage; // 하단에 보여지는 시작 페이지 번호
    int endPage; // 하단에 보여지는 마지막 페이지 번호
}
