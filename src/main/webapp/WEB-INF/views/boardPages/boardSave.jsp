<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>boardSave</title>
    <link rel="stylesheet" href="/resources/css/style.css">
    <script src="//cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<section>
    <div>
        <h2 style="text-align: center">Board Save</h2>
        <form action="/board/save" method="post" enctype="multipart/form-data">
            <table style="border: 1px solid black">
                <tr>
                    <th colspan="6" style="border: 1px solid black"><label for="boardTitle">제목</label></th>
                </tr>
                <tr>
                    <td colspan="6" style="border: 1px solid black"><textarea cols="104" name="boardTitle" id="boardTitle"></textarea></td>
                </tr>
                <tr>
                    <th colspan="6" style="border: 1px solid black">
                        <label for="boardFile" style="margin-left: 49px;">이미지</label>
                        <button type="button" style="float: right"><label for="boardFile">등록</label></button>
                    </th>
                </tr>
                <tr>
                    <th>
                        <input type="file" accept="image/*" name="boardFile" multiple style="display: none;"
                               id="boardFile">
                        <div id="preview-image-container"></div>
                        <p id="fileName"></p>
                    </th>
                </tr>
                <tr>
                    <th colspan="6" style="border: 1px solid black"><label for="editor1">내용</label></th>
                </tr>
                <tr>
                    <td colspan="6" style="border: 1px solid black"><textarea id="editor1" name="boardContents" cols="104" rows="40"></textarea></td>
                </tr>
                <tr>
                    <th colspan="6" style="border: 1px solid black">
                        <input type="submit" style="display: inline" value="등록">
                        <input type="button" style="display: inline" onclick="back()" value="취소">
                    </th>
                </tr>
            </table>
        </form>
    </div>
</section>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const upFile = document.getElementById('boardFile');
    const fileName = document.getElementById('fileName');

    upFile.addEventListener('change',function (){
        for(let j = 0; j < this.files.length; j++)
        fileName.innerHTML += "["+this.files[j].name+"] ";
    })

    const back = () => {
        location.href = "/board/main";
    }

    function readImages(input) {
        if (input.files && input.files.length > 0) {
            const previewImageContainer = document.getElementById("preview-image-container");

            for (let i = 0; i < input.files.length; i++) {
                const reader = new FileReader();
                reader.onload = e => {
                    const previewImage = document.createElement("img");
                    previewImage.style.width = "100px";
                    previewImage.style.height = "100px";
                    previewImage.style.border = "1px solid black";
                    previewImage.src = e.target.result;
                    previewImageContainer.appendChild(previewImage);
                }
                reader.readAsDataURL(input.files[i]);
            }
        }
    }

    const memberFile = document.getElementById("boardFile");
    memberFile.addEventListener("change", e => {
        readImages(e.target);
    });

    CKEDITOR.replace('editor1',{
        height : '450px'
    });
</script>
</html>
