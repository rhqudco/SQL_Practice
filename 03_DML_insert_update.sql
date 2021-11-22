use sqldb2;

create table publisher(
	pubNo varchar(10) not null primary key,
	pubName varchar(30) not null
);

create table book(
bookNo varchar(10) not null primary key,
bookName varchar(30) not null,
bookPrice int default 10000 check(bookPrice>1000),
bookDate date,
pubNo varchar(10) not null,
constraint FK_book_publisher foreign key(pubNo) references publisher(pubNo)
);

-- publisher 테이블에 데이터 입력
-- INSERT INTO 테이블명(열이름 리스트) VALUES(값리스트);
insert into publisher (pubNo, pubName) values('1', '서울 출판사');
insert into publisher (pubNo, pubName) values('2', '강남 출판사');
insert into publisher (pubNo, pubName) values('3', '종로 출판사');

-- publisher 테이블 내용 조회
select * from publisher;

-- book 테이블에 데이터 입력
insert into book(bookNo, bookName, bookPrice, bookDate, pubNo)
values('1','자바',20000,'2021-05-17','1');
-- 모든 열에 데이터를 입력할 경우 열이름 생략 가능
insert into book values('2','자바스크립트',23000,'2019-05-17','3');

select * from book;

-- 여러 개의 데이터 한 번에 insert

insert into book(bookNo, bookName, bookPrice, bookDate, pubNo)
values	('3','데이터베이스',35000,'2021-05-18','2'),
		('4','알고리즘',18000,'2021-05-19','3'),
		('5','웹프로그래밍',22000,'2021-05-20','2');
        
-- 여러 개의 데이터 한 번에 insert

insert into book
values	('6','데이터베이스',35000,'2021-05-18','2'),
		('7','알고리즘',18000,'2021-05-19','3'),
		('8','웹프로그래밍',22000,'2021-05-20','2');
	
/*
연습문제
INSERT 문을 사용하여
학과 / 학생 테이블에 다음과 같이 데이터 입력
SELECT 문으로 조회
*/

 -- 학과 테이블 생성
    CREATE TABLE department(
        dptNo VARCHAR(10) NOT NULL PRIMARY KEY,
        dptName VARCHAR(30) NOT NULL,
        dptTel VARCHAR(13)
    );

  -- 학생 테이블 생성 
	CREATE TABLE student (
		stdNo VARCHAR(10) NOT NULL PRIMARY KEY,
		stdName VARCHAR(30) NOT NULL,
		stdYear INT DEFAULT 4 CHECK(stdYear >= 1 AND stdYear <= 4),
        stdAddress VARCHAR(50), 
		stdBirthDay DATE,
		dptNo VARCHAR(10) NOT NULL,
        CONSTRAINT FK_student_department FOREIGN KEY (dptNo) REFERENCES department (dptNo)
	);

insert into department 
values('1', '컴퓨터학과', '02-1111-1111'),
('2','경영학과','02-2222-2222'),
('3','수학과','02-7777-7777');

insert into student
values	('2018002','이몽룡',4,'서울시 강남구','1998-05-07','1'),
		('2019003','홍길동',3,'경기도 안양시','1999-11-11','2'),
        ('2021003','성춘향',1,'전라북도 남원시','2002-01-02','3'),
        ('2021004','변학도',1,'서울시 종로구','2000-11-11','2');
        
select * from department;
select * from student;

ALTER TABLE product MODIFY prdNo VARCHAR(10) NOT NULL;
    
-- 기본키 제약조건 추가
ALTER TABLE product
	ADD CONSTRAINT PK_product_prdNo
	PRIMARY KEY (prdNo);
    
-- 모든 text 타입을 VARCHAR 타입으로 변경
ALTER TABLE product MODIFY prdName VARCHAR(20),
					MODIFY prdMaker VARCHAR(30),
					MODIFY prdColor VARCHAR(10),
					MODIFY ctgNo VARCHAR(10);
                    
/*
    UPDATE 문 (데이터 수정)
	특정 열의 값을 수정하는 명령어 
	조건에 맞는 행을 찾아서 열의 값을 수정
	기본 형식 : UPDATE 테이블명 SET 열이름=새값 WHERE 조건;
	예: 상품번호가 5인 행의 상품명을 ‘UHD TV’로 수정
	UPDATE product SET prdName = ‘UHT TV’ WHERE prdNo=’5’;
*/

--  상품 테이블 내용 조회
SELECT * FROM product;


-- 상품번호가 1005인 상품의 상품명을 ‘UHD TV’로 변경
UPDATE product SET prdName = 'UHD TV' WHERE prdNo='1005';

/*
    DELETE 문 (데이터 삭제)
	테이블에 있는 기존 행을 삭제하는 명령어
	기본 형식 : DELETE FROM 테이블명 WHERE 조건;
	예: DELETE FROM product WHERE prdName = ‘그늘막 텐트’;
	테이블의 모든 행 삭제
	DELETE FROM product;
*/

-- 상품명이 '그늘막 텐트'인 상품 삭제alter  
DELETE FROM product WHERE prdName = '그늘막 텐트';    
    
--  상품 테이블 내용 조회
SELECT * FROM product;

/*
연습문제
1. book 테이블에 다음과 같이 행 삽입 
 (출판사 데이터는 테이블 구조에 맞게 입력) - 9번 10번으로 입력
		강남 출판사
2. book 테이블에서 도서명이 '자바'인 행의 가격을 22000으로 변경
3. book 테이블에서 발행일이 2018년도인 행 삭제  
*/
select * from book;
insert into book 
values	('9','JAVA 프로그래밍',30000,'2021-03-10','1'),
		('10','알고리즘',18000,'2021-05-19','2');
        
update book set bookPrice=22000 where bookName = '자바';
DELETE FROM book 
	WHERE bookDate >= '2018-01-01' AND bookDate <= '2018-12-31';
    

/*
	다음과 같이 SQL 문 작성
	1. 고객 테이블 (customer) 생성 
	2. 고객 테이블의 전화번호 열을 NOT NULL로 변경
	3. 고객 테이블에 ‘성별’, ‘나이’ 열 추가
	4. 고객 테이블에 데이터 삽입 (3개)
	5. 고객명이 홍길동인 고객의 전화번호 값 수정 (값은 임의로)
	6. 나이가 20살 미만인 고객 삭제
*/
	-- 1. 고객 테이블 (customer) 생성  
	CREATE TABLE customer(
		custNo VARCHAR(10) NOT NULL PRIMARY KEY,
		custName VARCHAR(30),
		custPhone VARCHAR(13),
		custAddress VARCHAR(50)
	);
-- 2번
alter table customer modify custPhone varchar(13) not null;
DESCRIBE customer;
-- 3번
alter table customer add (custGendet varchar(10), custAge int);
DESCRIBE customer;
-- 4번
insert into customer
			values('1001', '홍길동', '02-1111-1111', '서울특별시 강남구', '남성', 21),
				('1002', '김병지', '02-2222-2222', '서울특별시 마포구', '남성', 22),
				('1003', '강호동', '02-3333-3333', '서울특별시 은평구', '남성', 23);
SELECT * FROM customer;
-- 5번
update customer set custPhone='010-1231-1233' where custName='홍길동';
SELECT * FROM customer;
-- 6번
delete from customer where custAge < 22;
SELECT * FROM customer;