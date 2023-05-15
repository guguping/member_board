## ICIA DAY 54 - 회원제 게시판 만들어보기 시작

#### 회원관리 테이블
```sql
drop table if exists members_table;
create table members_table(
id bigint auto_increment primary key,
memberName varchar(10) not null,
memberEmail varchar(50) unique,
memberPassword varchar(20) not null,
memberMobile varchar(30) not null,
memberProfile int default 0
);
```
#### 회원사진 저장 테이블
```sql
drop table if exists member_file_table;
create table member_file_table(
id bigint auto_increment primary key,
originalFileName varchar(100),
storedFileName varchar(100),
memberId bigint,
constraint fk_member_file foreign key (memberId) references members_table(id) on delete cascade
);
```
#### 회원게시판 테이블
```sql
drop table if exists memberBoard_table;
create table memberBoard_table(
id bigint auto_increment primary key,
boardTitle varchar(50) not null,
boardWriter varchar(50) not null,
boardContents varchar(500) not null,
boardHits int default 0,
boardCreatedDate datetime default now(),
fileAttached int default 0,
memberId bigint,
constraint fk_member_board foreign key (memberId) references members_table(id) on delete cascade
);
```
#### 회원게시판 파일 저장 테이블
```sql
drop table if exists memberBoard_file_table;
create table memberBoard_file_table(
id bigint auto_increment primary key,
originalFileName varchar(100),
storedFileName varchar(100),
boardId bigint,
constraint fk_board_file foreign key (boardId) references memberBoard_table(id) on delete cascade
);
```
#### 회원게시판 코멘트 저장 테이블
```sql
drop table if exists member_board_comment_table;
create table member_board_comment_table(
id bigint auto_increment primary key,
boardId bigint,
memberId bigint,
commentWriter varchar(50),
commentContents varchar(100),
commentCreatedDate datetime default now(),
constraint fk_board_comment foreign key (boardId) references memberBoard_table(id) on delete cascade,
constraint fk_member_comment foreign key (memberId) references members_table(id) on delete cascade
);
```

#### DTO 5개 생성

## Save
```html
<input type="file" accept="image/*" name="memberProfile" id="memberProfile" multiple style="display: none">
```
#### input file에 accept = "image/*"를 붙여주면 이미지 파일만 선택이 가능하게 바뀐다

```javascript
<tr>
    <th>
        <label for="memberProfile">증명사진</label>
    </th>
</tr>
<tr>
    <th>
        <p id="fileName"></p>
    </th>
</tr>
<tr>
    <th>
        <input type="file" accept="image/*" name="memberProfile" id="memberProfile"
                multiple style="display: none"
                onchange="javascript:document.getElementById('fileName').innerHTML =
                (this.value.replace(/c:\\fakepath\\/i,''))">
    </th>
</tr>
```
#### 스크립트 형식으로 변환 & List에 담긴 파일이름 가져오기
```javascript
    const upFile = document.getElementById('boardFile');
    const fileName = document.getElementById('fileName');

    upFile.addEventListener('change',function (){
        for(let j = 0; j < this.files.length; j++)
        fileName.innerHTML += "["+this.files[j].name+"] ";
    })
```
#### input 태그의 file로 업로드하면 이쁘지 않기 때문에 label을 통해 덮어씌움 이후 파일의 이름을 화면에 출력해주기 위해
#### p태그의 innerHTML에 input의 value를 넣어줌 경로는 지우기 위해 replace를 사용하였다

## ICIA DAY 55 - SAVE 사진 프리뷰
```javascript
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
    const memberProfile = document.getElementById("memberProfile")
    memberProfile.addEventListener("change", e => {
        readImage(e.target)
    })
```
#### 공부 필요 memberSave.JSP에 추가함

## iCIA DAY 56 - BOARDSAVE 다중 프리뷰
```javascript
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
```

## 버튼 onclick - 스크립트 변경
```javascript
    <input type="button" value="정보 수정" id="openUpdata" onclick="openUpdate()">

    const openUpdate = () => {
        name.disabled = false;
        password.disabled = false;
        mobile.disabled = false;
        email.disabled = false;
        openUpdata.setAttribute("onclick", "changed()");
    }
    const changed = () => {
        const passwordResult = '${memberDTO.memberPassword}';
        const promptResult = prompt("기존 비밀번호 확인.", "입력해주세요.");
        if (passwordResult != promptResult) {
            alert("비밀번호 확인 필요.");
        } else if (email.value == "guping"||email.value == "GUPING") {
            alert("사용불가능한 email입니다.");
        } else {
            alert("수정 완료!\n로그아웃 됩니다");
            gosave.submit();
        }
    };
```
## DAY 57 추가
```javascript
<tr id="check-see" style="display: none;" >
    <th id="emailResult"></th>
</tr>

if (memberEmail.value.length == 0) {
    emailResult.colSpan = 3;
    emailResult.style.color = "red";
    emailResult.innerHTML = "필수 입력입니다";
    checkSee.style.display = "table-row";
    resResult = false;
} 
```
#### table의 display의 기본값은 table 이기 때문에 display none으로 css를 변경 후,
#### 다시 보여주기 위해서는 display table 속성으로 시작해야한다.