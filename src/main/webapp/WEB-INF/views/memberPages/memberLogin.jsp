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
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center">memberLogin</h2>
        <form action="/member/login" method="post">
            <table>
                <tr>
                    <th style="padding: 5px"><label for="memberEmail">이메일</label></th>
                </tr>
                <tr>
                    <th><input type="text" name="memberEmail" id="memberEmail"></th>
                </tr>
                <tr>
                    <th><label for="memberPassword">비밀번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="password" name="memberPassword" id="memberPassword"></th>
                </tr>
                <tr>
                    <th><p style="color: red">${loginFalse}</p></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="submit" value="로그인" style="display:inline-block;"></th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
</script>
</html>
