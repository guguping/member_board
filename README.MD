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