package com.icia.member_board.service;

import com.icia.member_board.dto.*;
import com.icia.member_board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public memberDTO findById(Long memberID) {
        return boardRepository.findById(memberID);
    }

    public void boardSave(memberBoardDTO memberBoardDTO) throws IOException {
        if (memberBoardDTO.getBoardFile().get(0).isEmpty()){
            memberBoardDTO.setFileAttached(0);
            boardRepository.boardSave(memberBoardDTO);
        } else {
            memberBoardDTO.setFileAttached(1);
            memberBoardDTO dto = boardRepository.boardSave(memberBoardDTO);
            for (MultipartFile boardFile : memberBoardDTO.getBoardFile()){
                String originalFilename = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "-"+originalFilename;
                memberBoardFileDTO memberBoardFileDTO = new memberBoardFileDTO();
                memberBoardFileDTO.setBoardId(dto.getId());
                memberBoardFileDTO.setOriginalFileName(originalFilename);
                memberBoardFileDTO.setStoredFileName(storedFileName);
                String savePath = "D:\\springframework_img\\"+storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.boardSaveFile(memberBoardFileDTO);
            }
        }
    }

    public List<memberBoardDTO> boardList(int page) {
        int pageLimit = 10;
        int pageStart = (page-1) * pageLimit;
        Map<String , Integer> listParams = new HashMap<>();
        listParams.put("start",pageStart);
        listParams.put("limit",pageLimit);
        List<memberBoardDTO> memberBoardDTOList = boardRepository.boardList(listParams);
        return memberBoardDTOList;
    }

    public pageDTO pagingParam(int page) {
        int pageLimit = 10;
        int blockLimit = 3;
        int boardCount = boardRepository.boardCount();
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit -1 ;
        if(endPage>maxPage){
            endPage = maxPage;
        }
        pageDTO pageDTO = new pageDTO();
        pageDTO.setPage(page);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setMaxPage(maxPage);
        return pageDTO;
    }

    public List<memberBoardDTO> boardSearchList(int page, String type, String q) {
        int pageLimit = 10;
        int pagingStart = (page-1) * pageLimit;
        Map<String,Object> pagingParams = new HashMap<>();
        pagingParams.put("start",pagingStart);
        pagingParams.put("limit",pageLimit);
        pagingParams.put("q",q);
        pagingParams.put("type",type);
        List<memberBoardDTO> memberBoardDTOList = boardRepository.boardSearchList(pagingParams);
        return memberBoardDTOList;
    }

    public pageDTO pagingSearchParams(int page, String type, String q) {
        int pageLimit= 10;
        int blockLimit = 3;
        Map<String,Object> paginParams = new HashMap<>();
        paginParams.put("q",q);
        paginParams.put("type",type);
        int boardSearchCount = boardRepository.boardSearchCount(paginParams);
        int maxPage = (int)(Math.ceil((double)boardSearchCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit -1 ;
        if(endPage>maxPage){
            endPage = maxPage;
        }
        pageDTO pageDTO = new pageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }

    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public memberBoardDTO boardDetail(Long id) {
        return boardRepository.boardDetail(id);
    }

    public List<memberBoardFileDTO> findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public void boardDelete(Long boardId) {
        boardRepository.boardDelete(boardId);
    }

    public memberBoardDTO findByboard(Long boardId) {
        return boardRepository.findByBoard(boardId);
    }

    public void updateBoard(memberBoardDTO memberBoardDTO) {
        boardRepository.updateBoard(memberBoardDTO);
    }

    public memberFileDTO memberFile(Long memberID) {
        return boardRepository.memberFile(memberID);
    }
}
