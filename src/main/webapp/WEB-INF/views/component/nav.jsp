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
            <li>
                <c:choose>
                    <c:when test="${memberID != null}">
                        <a href="/board/logout">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/member/login">로그인</a>
                    </c:otherwise>
                </c:choose>
            </li>
            <c:choose>
                <c:when test="${memberID == 1}">
                    <li>
                        <a href="/member/list">멤버리스트</a>
                    </li>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${memberID != null}">
                    <li><a href="/board/list">글목록</a></li>
                    <li><a href="/board/save">글쓰기</a></li>
                </c:when>
            </c:choose>
        </ul>
    </div>
</nav>
