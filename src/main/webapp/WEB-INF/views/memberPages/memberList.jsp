<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>memberList</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>memberList</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <%--<th>회원프로필</th>--%>
                <th>회원이메일</th>
                <th>회원비밀번호</th>
                <th>회원전화번호</th>
            </tr>
            <c:forEach items="${memberList}" var="member">
                <tr>
                    <td style="text-align: center">
                        <a>${member.id}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${member.memberEmail}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${member.memberPassword}</a>
                    </td>
                    <td style="text-align: center">
                        <a>${member.memberMobile}</a>
                    </td>
                </tr>
            </c:forEach>
            </thead>
            <tbody>
            <tr>
                <th colspan="4">
                    <form action="/member/list" method="get">
                        <select name="type">
                            <option value="memberEmail">아이디</option>
                            <option value="memberMobile">전화번호</option>
                        </select>
                        <input type="text" name="q" placeholder="검색어를 입력하세요">
                        <input type="submit" value="검색">
                    </form>
                </th>
            </tr>
            <tr>
                <th colspan="4"><c:choose>
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
