-- 스키마 생성
create schema sqldb1 default character set utf8;

-- 스키마 삭제
-- drop schema sqldb;

-- 테이블 생성
-- create table
-- 속성(열)과 속성에 관한 제약 정의
-- 기본키(PK), 외래키(FK) 정
use sqldb1;

-- 상품 테이블 생성
-- 제약 조건
	-- 기본키 : prdNo NOT NULL
	-- prdName NOT NULL
create table PRODUCT (
	prdNo varchar(10) NOT NULL PRIMARY KEY,
	prdName varchar(30) not null,
	prdPrice int,
	prdCompany varchar(30)
);

-- 상세 정보 출력
describe product3;

-- 기본키 제약 조건 설정 방법 2
create table PRODUCT2 (
	prdNo varchar(10) NOT NULL,
	prdName varchar(30) not null,
	prdPrice int,
	prdCompany varchar(30),
	primary key(prdNo)
);

-- 기본키 제약 조건 설정 방법 3
create table PRODUCT3 (
	prdNo varchar(10) NOT NULL,
	prdName varchar(30) not null,
	prdPrice int,
	prdCompany varchar(30),
	constraint PK_product_prdNo primary key(prdNo)
);

-- 출판사 테이블과 도서 테이블 생성
-- 기본키 / 외래키 제약 조건 설정

/*
출판사 테이블 생성 (출판사 번호, 출판사명)
제약조건 설정
- 기본키로 pubNo NOT NULL
- pubName NOT NULL
*/

-- publisher
-- pubNo 가변문자 10
-- pubName 가변문자 30 
-- 제약조건 설정하고
-- 테이블 생성

create table publisher(
	pubNo varchar(10) not null primary key,
	pubName varchar(30) not null
);

-- 도서 테이블 생성
-- 외래키(출판사 번호 pubNO) 제약조건 설정
-- 기타 제약조건 설정
	-- 기본키 : bookNo not null
    -- 외래키 : pubNo (참조 테이블의 기본키와 동일 -> varchar(10) not null)
    -- bookPirce : 기본값 10000, 1000보다 큰 값만 들어갈 수 있게 설정 
CREATE TABLE book (
    bookNo VARCHAR(10) NOT NULL PRIMARY KEY,
    bookName VARCHAR(30) NOT NULL,
    bookPrice INT DEFAULT 10000 CHECK (bookPrice > 1000),
    bookData DATE,
    pubNo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_book_publisher FOREIGN KEY (pubNo)
        REFERENCES publisher (pubNo)
);
-- constraint 제약조건 이름 foreign key(외래키로 사용하는 열이름) references 참조하는 테이블명(참조하는 테이블의 기본키)
describe book;
-- pri : 기본키
-- mul : 중복 가능한 키(외래키)
-- 외래키로 지정된 열에는 동일 값(중복 값) 저장 가능
-- @@ 출판사에서 출간한 도서가 여러 권 가능하기 때문
-- 테이블 생성 순서 주의
-- 외래키로 제약조건을 설정할 경우
-- 테이블 생성 순서
-- 1. publisher(book에서 사용할 외래키가 해당 테이블의 기본키이기 때문에)
-- 2. book(publisher의 기본키를 외래키로 사용하기 때문)

-- 테이블 생성 후 데이터 입력 시 주의
-- publisher의 기본키인 pubNo에 값을 먼저 입력해야 book의 pubNo를 입력할 때 오류가 없다.
-- 즉, 외래키 값을 입력할 때는 참조되는 테이블의 기본키로서의 값과 동일해야 한다(참조 무결성 제약조건)

-- 테이블 삭제 시 주의
-- publisher 먼저 삭제하면 외래키로 사용 중이라는 오류 발생(book에서 pubNo 사용 중 이기 때문)
-- book 테이블 먼저 삭제하고 publisher 삭제
-- 즉, 외래키로 사용 중인 경우 참조되는 테이블(부모 테이블)의 기본키를 삭제할 수 없다(참조 무결성 제약조건 때문)


-- 데이터 입력  publisher
-- 서울 출판사, 도서출판 강남, 정보 출판

-- book 테이블에 데이터 입력
-- 설정된 제약조건
	-- bookName에 NULL 값을 삽입할 수 없음
    -- bookPrice에 1000 이하 값을 입력 시 CHECK 제약조건 충돌 오류 발생
	-- bookPrice에 값을 입력하지 않으면(NULL) 자동으로 기본값인 10000으로 입력됨
    -- 클릭 하지 않은 상태에서 null 글자가 있으면 Null상태
    -- book 테이블의 pubNo입력 시 1,2,3 이외의 값 입력 시 외래키 제약조건 충돌 오류 발생


create table department(
	departmentCode int not null primary key,
	departmentName varchar(30) not null
);

create table student (
	studentNumber varchar(20) not null primary key,
	studentName varchar(30) not null,
    studentGrade int not null default 4 check(studentGrade >= 1 and studentGrade <= 4),
    departmentCode int not null,
    constraint FK_student_department foreign key(departmentCode) references department(departmentCode)
);

/*
테이블 생성 순서
1. 학과 테이블
2. 학생 테이블 : 학과번호를 외래키로 설정
*/
/*연습문제
학생(student)과 학과(department) 테이블 생성하고 데이터 3개씩 입력
제약조건
기본키 설정
필요한 경우 외래키 설정
학생은 학과에 소속
학생 이름과 학과 이름은 NULL 값을 허용하지 않음
학년은 4를 기본값으로, 범위를 1~4로 설정 (AND 키워드 사용)
*/

CREATE TABLE department2(
	 dptNo VARCHAR(10) NOT NULL PRIMARY KEY,
     dptName VARCHAR(30) NOT NULL,
     dptTel VARCHAR(13)
);

CREATE TABLE student2(
	stdNo VARCHAR(10) NOT NULL PRIMARY KEY,
    stdName VARCHAR(30) NOT NULL,
    stdYear INT DEFAULT 4 CHECK(stdYear >=1 AND stdYear <= 4),
    stdAddress VARCHAR(50),
    stdBirthday DATE,
    dptNo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_student2_department2 FOREIGN KEY (dptNo) REFERENCES department2(dptNo)
);

/*
교수 테이블
교수번호 : 기본키, NOT NULL 
학과코드 : 외래키 설정
과목
과목코드 : 기본키, NOT NULL
교수번호 : 외래키 설정
성적
학번과 과목코드 2개로 기본키 설정
학번 : 외래키 설정
과목코드 : 외래키 설정

*/

create table professor(
	proId varchar(10) not null primary key,
	proName varchar(30) not null,
	proPosition varchar(20) not null,
	proTel varchar(13),
	dptNo varchar(10) not null,
	constraint FK_professor_department2 foreign key (dptNo) references department2(dptNo)
);
create table subjects(
	subId varchar(10) not null primary key,
    subName varchar(20) not null,
    subCredit int,
    proId varchar(10) not null,
    constraint FK_subjects_professor foreign key (proId) references professor(proId)
);
create table scores(
	stdNo varchar(10) not null,
    subId varchar(10) not null,
    scSc int,
    scGrade varchar(2), 
    constraint PK_scores_stdNo_subId primary key(stdNo, subId),
    constraint FK_scores_student2 foreign key (stdNo) references student2(stdNo),
    constraint FK_scores_subjects foreign key (subId) references subjects(subId)
);

/*
실습
1. 1부터 1씩 증가
2. 초기값 100으로 설정하고 3씩 증가
3. 다시 1부터 1씩 증가하도록 변경
4. 중간에 있는 값 삭제하고 전체를 다시 1부터 1씩 증가하도록 재정
*/
-- 1번
create table board(
	boardNo int auto_increment not null primary key,
    boardTitle varchar(30) not null,
    boardWriter varchar(20),
    boardContent varchar(100) not null
    );
-- 2번
create table board2(
	boardNo int auto_increment not null primary key,
    boardTitle varchar(30) not null,
    boardWriter varchar(20),
    boardContent varchar(100) not null
    );
    alter table board2
    auto_increment = 100;
    set @@auto_increment_increment = 3;
-- 3번
set @count = 0;
update board2 set boardNo = @count:=@count+1;
-- 자바에서 변수값 1 증가 : sum = sum + 1 과 동일한 의미
-- 4번
-- 다시 0으로 설정하고
set @count = 0;
update board2 set boardNo = @count:=@count+1;
-- 초기 값을 1로 다시 설정
alter table board2 auto_increment = 1;
