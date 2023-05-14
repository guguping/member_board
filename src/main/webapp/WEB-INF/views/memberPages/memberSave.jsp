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
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center">회원가입 페이지</h2>
        <form action="/member/save" method="post" enctype="multipart/form-data" onsubmit="return save_check()">
            <table>
                <tr>
                    <th><label for="memberEmail">이메일</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberEmail" id="memberEmail"
                                                    onblur="email_check()"></th>
                </tr>
                <tr>
                    <th><p id="emailResult"></p></th>
                </tr>
                <tr>
                    <th><label for="memberPassword">비밀번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="password" name="memberPassword" id="memberPassword" onblur="pass_check()"></th>
                </tr>
                <tr>
                    <th><p id="passwordResult"></p></th>
                </tr>
                <tr>
                    <th><label for="memberName">이름</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberName" id="memberName"></th>
                </tr>
                <tr>
                    <th><label for="memberMobile">전화번호</label></th>
                </tr>
                <tr>
                    <th style="padding: 5px"><input type="text" name="memberMobile" id="memberMobile" onblur="mobile_check()"></th>
                </tr>
                <tr>
                    <th><p id="mobileResult"></p></th>
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

    const save_check = () => {
        const memberEmail = document.getElementById('memberEmail');
        const memberPassword = document.getElementById('memberPassword');
        const memberName = document.getElementById('memberName');
        const memberMobile = document.getElementById('memberMobile');
        const memberFile = document.getElementById('memberFile');
        if (memberEmail.value.length == 0) {
            alert("이메일을 입력해주세요");
            return false;
        } else if (memberPassword.value.length == 0) {
            alert("비밀번호를 입력해주세요");
            return false;
        } else if (memberName.value.length == 0) {
            alert("이름을 입력해주세요");
            return false;
        } else if (memberMobile.value.length == 0) {
            alert("전화번호를 입력해주세요");
            return false;
        } else if (memberFile.files.length == 0) {
            alert("프로필 사진은 필수입니다");
            return false;
        } else if (!(email_check())) {
            alert("이메일을 확인해주세요");
            return false;
        } else if (!(pass_check())) {
            alert("비밀번호를 확인해주세요");
            return false;
        } else if(!(mobile_check())){
            alert("전화번호를 확인해주세요");
            return false;
        }
    }

    const email_check = () => {
        let memberEmail = document.getElementById('memberEmail');
        let emailResult = document.getElementById('emailResult');
        $.ajax({
            type: "post",
            url: "/member/emailCheck",
            async: false,
            data: {
                "memberEmail": memberEmail.value
            },
            success: function (res) {
                if (memberEmail.value.length == 0) {
                    emailResult.style.color = "red";
                    emailResult.innerHTML = "필수 입력입니다";
                    resResult = false;
                } else {
                    emailResult.style.color = "green";
                    emailResult.innerHTML = "사용가능한 이메일";
                    resResult = true;
                }
            },
            error: function () {
                emailResult.style.color = "red";
                emailResult.innerHTML = "증복된 아이디입니다";
                resResult = false;
            }
        })
        return resResult;
    }

    const pass_check = () =>{
        let memberPassword = document.getElementById('memberPassword').value;
        let passwordResult = document.getElementById('passwordResult');
        const exp = /^(?=.*[A-z])(?=.*\d)(?=.*[!#$%])[A-z\d!#$%]{5,10}$/;

        if (memberPassword.length == 0){
            passwordResult.style.color = "red";
            passwordResult.innerHTML = "필수 입력입니다.";
            return false;
        } else if (!(memberPassword.match(exp))){
            passwordResult.style.color = "red";
            passwordResult.innerHTML = "5~10자 영문 대 소문자, 숫자, 특수문자(!#$%) 하나 이상을 사용하세요.";
            return false;
        } else {
            passwordResult.style.color = "green";
            passwordResult.innerHTML = "사용가능합니다";
            return true;
        }
    }
    const mobile_check = () => {
        let memberMobile = document.getElementById('memberMobile').value;
        let mobileResult = document.getElementById('mobileResult');
        const regex = /\d{3}-\d{4}-\d{4}/;

        if (!(memberMobile.match(regex))){
            mobileResult.style.color = "red";
            mobileResult.innerHTML = "전화번호를 입력해주세요<br>양식은 010-0000-0000 입니다";
            return false;
        } else {
            mobileResult.innerHTML = "";
            return true;
        }
    }


</script>
</html>
