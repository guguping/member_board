package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@NoArgsConstructor
public class memberDTO {
   Long id;
   String memberName;
   String memberEmail;
   String memberPassword;
   String memberMobile;
   int memberProfile = 0;
   List<MultipartFile> memberFile;
}
