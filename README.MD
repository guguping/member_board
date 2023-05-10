## ICIA DAY 54 - 회원제 게시판 만들어보기 시작

#### 회원관리 테이블
```sql
drop table if exists members_table;
create table members_table(
id bigint auto_increment primary key,
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