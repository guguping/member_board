<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Save</title>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2>회원가입 페이지</h2>
        <form action="/member/save" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th><label for="memberEmail">이메일</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberEmail" id="memberEmail"></th>
                </tr>
                <tr>
                    <th><label for="memberPassword">비밀번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="password" name="memberPassword" id="memberPassword"></th>
                </tr>
                <tr>
                    <th><label for="memberMobile">전화번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberMobile" id="memberMobile"></th>
                </tr>
                <tr>
                    <th>
                        <label for="memberFile">증명사진</label>
                        <button style="display: inline-block" type="button">
                            <label for="memberFile">등록</label>
                        </button>
                    </th>
                </tr>
                <tr>
                    <th style="padding: 5px">
                        <input type="file" accept="image/*" name="memberFile" id="memberFile"
                               style="display: none"
                               onchange="javascript:document.getElementById('fileName').innerHTML =
                                (this.value.replace(/c:\\fakepath\\/i,''))">
                        <img style="width: 100px;height: 100px;border: 1px solid black" id="preview-image">
                    </th>
                </tr>
                <tr>
                    <th>
                        <p id="fileName"></p>
                    </th>
                </tr>
                <tr>
                    <th colspan="2" style="padding: 5px">
                        <input type="submit" style="display: inline-block" value="등록">
                        <input type="button" style="display: inline-block" value="취소" onclick="goindex()">
                    </th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const goindex = () => {
        location.href = "/";
    }

    function readImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = e => {
                const previewImage = document.getElementById("preview-image")
                previewImage.src = e.target.result
            }
            reader.readAsDataURL(input.files[0])
        }
    }

    const memberFile = document.getElementById("memberFile")
    memberFile.addEventListener("change", e => {
        readImage(e.target)
    })
</script>
</html>
