package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

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
    List<MultipartFile> boardFile;
    Long memberId;
}
