<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 2:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>memberLogin</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>memberLogin</h2>
        <form action="/member/login" method="post">
            <table>
                <tr>
                    <th style="padding: 5px"><label for="memberEmail">이메일</label></th>
                </tr>
                <tr>
                    <th><input type="text" name="memberEmail" id="memberEmail">
                        <p id="emailResult"></p></th>
                </tr>
                <tr>
                    <th><label for="memberPassword">비밀번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberPassword" id="memberPassword">
                        <p id="passwordResult"></p></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="button" value="로그인" style="display:inline-block;"></th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
</html>
