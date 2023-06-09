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
        <form action="/board/myPageUpdate" method="post" id="gosave">
            <input type="text" name="id" style="display: none" value="${memberDTO.id}">
            <table style="margin-top: 10px;">
                <tr>
                    <th style="padding: 5px;" colspan="3">회원 프로필</th>
                </tr>
                <tr>
                    <th rowspan="5"><img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}"
                                         alt=""
                                         style="width: 100px;height: 100px"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">이름</th>
                    <th><input type="text" id="member-name" name="memberName" value="${memberDTO.memberName}"
                               disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">이메일</th>
                    <th><input type="text" id="member-email" name="memberEmail" value="${memberDTO.memberEmail}"
                               disabled="disabled" style="padding: 5px;" onblur="email_check()"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">비밀번호</th>
                    <th><input type="password" id="member-password" name="memberPassword"
                               value="${memberDTO.memberPassword}" disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr>
                    <th style="padding: 5px;">전화번호</th>
                    <th><input type="text" id="member-mobile" name="memberMobile" value="${memberDTO.memberMobile}"
                               disabled="disabled" style="padding: 5px;"></th>
                </tr>
                <tr id="check-see" style="display: none;" >
                    <th id="emailResult"></th>
                </tr>
                <tr>
                    <th colspan="3" style="padding: 5px;">
                        <input type="button" value="정보 수정" id="openUpdata" onclick="openUpdate()">
                        <input type="button" value="회원 탈퇴" id="deleteUser" onclick="outUser()">
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
    const openUpdata = document.getElementById('openUpdata');
    const gosave = document.getElementById('gosave');


    const openUpdate = () => {
        name.disabled = false;
        password.disabled = false;
        mobile.disabled = false;
        email.disabled = false;
        openUpdata.setAttribute("onclick", "changed()");
    }
    const changed = () => {
        const passwordResult = '${memberDTO.memberPassword}';
        const memberidResult = '${memberDTO.id}';
        const promptResult = prompt("기존 비밀번호 확인.", "입력해주세요.");
        if (passwordResult != promptResult) {
            alert("비밀번호 확인 필요.");
        } else if (memberidResult != 1) {
            if (email.value == "guping" || email.value == "GUPING") {
                alert("사용불가능한 email입니다.");
            } else if (!(email_check())) {
                alert("중복된 이메일입니다");
            } else {
                alert("수정 완료!\n로그아웃 됩니다");
                gosave.submit();
            }
        }
    };
    const email_check = () => {
        let memberEmail = document.getElementById('member-email');
        let emailResult = document.getElementById('emailResult');
        let checkSee = document.getElementById('check-see');
        $.ajax({
            type: "post",
            url: "/member/emailCheck",
            async: false,
            data: {
                "memberEmail": memberEmail.value
            },
            success: function (res) {
                if (memberEmail.value.length == 0) {
                    emailResult.colSpan = 3;
                    emailResult.style.color = "red";
                    emailResult.innerHTML = "필수 입력입니다";
                    checkSee.style.display = "table-row";
                    resResult = false;
                }  else {
                    emailResult.colSpan = 3;
                    emailResult.style.color = "green";
                    emailResult.innerHTML = "사용가능한 이메일";
                    checkSee.style.display = "table-row";
                    resResult = true;
                }
            },
            error: function () {
                emailResult.colSpan = 3;
                emailResult.style.color = "red";
                emailResult.innerHTML = "중복된 아이디입니다";
                checkSee.style.display = "table-row";
                resResult = false;
            }
        })
        return resResult;
    }

    const outUser = () => {
        const passwordResult = '${memberDTO.memberPassword}';
        const promptResult = prompt("기존 비밀번호 확인.", "입력해주세요.");
        if (passwordResult != promptResult) {
            alert("비밀번호 확인 필요.");
        } else {
            alert("탈퇴 완료!");
            location.href = "/board/deleteUser?id=" + '${memberDTO.id}';
        }
    }

</script>
</html>
