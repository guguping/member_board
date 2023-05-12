<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav>
    <div>
        <ul>
            <c:choose>
                <c:when test="${memberID == null}">
                    <li>
                        <a href="/member/save">회원가입</a>
                    </li>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${memberID != null}">
                    <li><a href="/board/main">Home</a></li>
                    <li><a href="/board/save">글쓰기</a></li>
                    <li><a href="/board/list">글목록</a></li>
                    <li style="float: right"><a href="/board/logout">로그아웃</a></li>
                    <li style="float: right"><a href="/board/myPage">${memberEmail}님 환영합니다</a></li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="/member/login">로그인</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${memberID == 1}">
                    <li>
                        <a href="/member/list">멤버리스트</a>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>
</nav>
