package com.icia.member_board.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class memberDTO {
   Long id;
   String memberEmail;
   String memberPassword;
   String memberMobile;
   int memberProfile = 0;
}
