package com.icia.member_board.service;

import com.icia.member_board.dto.memberDTO;
import com.icia.member_board.dto.memberFileDTO;
import com.icia.member_board.dto.pageDTO;
import com.icia.member_board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public List<memberDTO> memberList(int page) {
        int pageLimit = 10;
        int pageStart = (page-1)*pageLimit;
        Map<String,Integer> listParams = new HashMap<>();
        listParams.put("start",pageStart);
        listParams.put("limit",pageLimit);
        List<memberDTO> memberDTOList = memberRepository.memberList(listParams);
        return memberDTOList;
    }

    public pageDTO pagingParam(int page) {
        int pageLimit = 10;
        int blockLimit = 3;
        int memberCount = memberRepository.memberCount();
        int maxPage = (int)(Math.ceil((double)memberCount/pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit -1 ;
        if(endPage > maxPage){
            endPage = maxPage;
        }
        pageDTO pageDTO = new pageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }

    public List<memberDTO> memberSearchList(int page, String type, String q) {
        int pageLimit = 10;
        int pageStart = (page-1)*pageLimit;
        Map<String , Object> searchPagingParams = new HashMap<>();
        searchPagingParams.put("start",pageStart);
        searchPagingParams.put("limit",pageLimit);
        searchPagingParams.put("q",q);
        searchPagingParams.put("type",type);
        List<memberDTO> memberDTOList = memberRepository.memberSearchList(searchPagingParams);
        return memberDTOList;
    }

    public pageDTO searchPagingParam(int page, String type, String q) {
        int pageLimit = 10;
        int blockLimit = 3;
        Map<String,Object> searchPagingParams = new HashMap<>();
        searchPagingParams.put("q",q);
        searchPagingParams.put("type",type);
        int memberSearchCount = memberRepository.memberSearchCount(searchPagingParams);
        int maxPage = (int)(Math.ceil((double)memberSearchCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit -1;
        if( endPage > maxPage){
            endPage = maxPage;
        }
        pageDTO pageDTO = new pageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }
}
