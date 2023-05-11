<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>boardList</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>BoardList</h2>
        <table>
            <thead>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성시간</th>
            </tr>
            <c:forEach items="${boardList}" var="boardList">
                <tr>
                    <td style="text-align: center">
                        <a>${boardList.id}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${boardList.boardTitle}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${boardList.boardWriter}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${boardList.boardHits}</a>
                    </td>
                    <td style="text-align: center">
                        <a><fmt:formatDate value="${boardList.boardCreatedDate}"
                                           pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></a>
                    </td>
                </tr>
            </c:forEach>
            </thead>
            <tbody>
            <tr>
                <th colspan="5">
                    <form action="/board/list" method="get">
                        <select name="type">
                            <option value="boardTitle">제목</option>
                            <option value="boardWriter">작성자</option>
                            <option value="boardContents">내용</option>
                        </select>
                        <input type="text" name="q" placeholder="검색어를 입력하세요">
                        <input type="submit" value="검색">
                    </form>
                </th>
            </tr>
            <tr>
                <th colspan="5"><c:choose>
                    <c:when test="${paging.page<=1}">
                        <a style="color: grey">[이전]</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/member/list?page=${paging.page-1}&q=${q}&type=${type}"
                           style="text-decoration: none;color: black">[이전]</a>
                    </c:otherwise>
                </c:choose>
                    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                        <c:choose>
                            <c:when test="${i eq paging.page}">
                                <a style="text-decoration: none;color: violet">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/member/list?page=${i}&q=${q}&type=${type}"
                                   style="text-decoration: none;color: black">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${paging.page >= paging.maxPage}">
                            <a style="color: grey">[다음]</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/member/list?page=${paging.page+1}&q=${q}&type=${type}"
                               style="text-decoration: none;color: black">[다음]</a>
                        </c:otherwise>
                    </c:choose></th>
            </tr>
            </tbody>
        </table>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
</html>
