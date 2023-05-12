<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-12
  Time: 오후 1:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>boardMyPage</title>
    <link rel="stylesheet" href="/resources/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<style>
    table {
        margin: auto;
        border: 1px solid black;
    }

    table tr th {
        border: 1px solid black;
    }
</style>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center">My Page</h2>
        <form action="memberUpdate" method="post" id="gosave">
            <input type="text" name="id" style="display: none" value="${memberDTO.id}">
            <table style="margin-top: 10px;">
                <tr>
                    <th style="padding: 5px;" colspan="3">회원 프로필</th>
                </tr>
                <tr>
                    <th rowspan="5"><img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}" alt=""
                             style="width: 100px;height: 100px"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">이름</th>
                    <th><input type="text" id="member-name" name="memberName" value="${memberDTO.memberName}" disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">아이디</th>
                    <th><input type="text" id="member-email" name="memberEmail" value="${memberDTO.memberEmail}" disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">비밀번호</th>
                    <th><input type="password" id="member-password" name="memberPassword" value="${memberDTO.memberPassword}" disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">전화번호</th>
                    <th><input type="text" id="member-mobile" name="memberMobile" value="${memberDTO.memberMobile}" disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th colspan="3" style="padding: 5px;">
                        <input type="button" value="정보 수정" id="openUpdata" onclick="openUpdate()">
                        <input type="button" value="회원 탈퇴">
                    </th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const email = document.getElementById('member-email');
    const name = document.getElementById("member-name");
    const password = document.getElementById("member-password");
    const mobile = document.getElementById("member-mobile");
    const submit = document.getElementById("submit");
    const openUpdate = () => {
        name.disabled = false;
        password.disabled = false;
        mobile.disabled = false;
        email.disabled = false;
    }
</script>
</html>
