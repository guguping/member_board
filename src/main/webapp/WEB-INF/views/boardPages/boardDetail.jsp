<%--
  Created by IntelliJ IDEA.
  User: 이호섭
  Date: 2023-05-12
  Time: 오전 5:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>boardDetail</title>
    <link rel="stylesheet" href="/resources/css/style.css">
    <script src="//cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <table>
        <thead>
        <tr>
            <th colspan="6">제목</th>
        </tr>
        <tr>
            <td colspan="6"><textarea cols="104" name="boardTitle" readonly>${boardDTO.boardTitle}</textarea></td>
        </tr>
        <tr>
            <th>글번호</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>조회수</th>
        </tr>
        <tr>
            <th>${boardDTO.id}</th>
            <th>${boardDTO.boardWriter}</th>
            <th>
                <fmt:formatDate value="${boardDTO.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
            </th>
            <%--            <th>${boardDTO.boardCreateDate}</th>--%>
            <th>${boardDTO.boardHits}</th>
        </tr>
        <c:if test="${boardDTO.fileAttached == 1}">
            <tr>
                <th colspan="6">image</th>
            </tr>
            <tr>
                <td colspan="6">
                    <c:forEach items="${boardFileList}" var="boardFile">
                        <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt=""
                             style="width: 100px" ; height="100px">
                    </c:forEach>
                </td>
            </tr>
        </c:if>
        <tr>
            <td colspan="6"><textarea id="editor1" name="boardContents"
                                      COLS="104" ROWS="38" readonly>${boardDTO.boardContents}</textarea></td>
        </tr>
        <tr>
            <th colspan="6">
                <input type="button" value="수정" onclick="goUpdate(${boardDTO.id})">
                <input type="button" value="삭제" onclick="goDelete(${boardDTO.id})">
                <input type="button" value="목록" onclick="goList()">
            </th>
        </tr>
        <tr>
            <th colspan="6">댓글</th>
        </tr>
        </thead>
        <tbody id="commentResult">
        <c:choose>
            <c:when test="${cList == null}">
                <tr>
                    <th colspan="6">
                        <h1>아직 작성된 댓글이 없습니다</h1>
                    </th>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <th>id</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>작성시간</th>
                </tr>
                <c:forEach items="${cList}" var="cList">
                    <tr>
                        <th>${cList.id}</th>
                        <th>${cList.commentWriter}</th>
                        <th>${cList.commentContents}</th>
                        <th>
                            <fmt:formatDate value="${cList.commentCreatedDate}"
                                            pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                        </th>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="6"><label for="commentWriter" style="float: left">작성자: </label>
                <input type="text" name="commentWriter" id="commentWriter" style="float: left">
                <label for="commentContents" style="margin-right: 187px">내용</label>
                <input type="button" value="등록" style="float: right" onclick="helloComment(${boardDTO.id})">
            </th>
        </tr>
        <tr>
            <td colspan="6"><textarea id="commentContents" COLS="104" ROWS="5"></textarea></td>
        </tr>
        </tfoot>
    </table>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>

    CKEDITOR.replace('editor1',{
        height : '450px'
    });
</script>
</html>
