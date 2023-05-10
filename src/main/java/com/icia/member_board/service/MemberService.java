package com.icia.member_board.service;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.dto.memberFileDTO;
import com.icia.member_board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public void saveMember(memberDTO memberDTO) throws IOException {
        if(memberDTO.getMemberFile().get(0).isEmpty()){
            System.out.println("파일 없음!");
            memberDTO.setMemberProfile(0);
            memberRepository.saveMember(memberDTO);
        } else {
            memberDTO.setMemberProfile(1);
            memberDTO dto = memberRepository.saveMember(memberDTO);
            String originalFilename = memberDTO.getMemberFile().get(0).getOriginalFilename();
            String storedFileName = System.currentTimeMillis() + "-" + originalFilename;

            memberFileDTO memberFileDTO = new memberFileDTO();
            memberFileDTO.setOriginalFileName(originalFilename);
            memberFileDTO.setStoredFileName(storedFileName);
            memberFileDTO.setMemberId(dto.getId());
            String savePath = "D:\\springframework_img\\" + storedFileName;
            memberDTO.getMemberFile().get(0).transferTo(new File(savePath));
            memberRepository.saveFile(memberFileDTO);
        }
    }

    public memberDTO loginMember(memberDTO memberDTO) {
        return memberRepository.loginMember(memberDTO);
    }
}
