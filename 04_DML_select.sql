use sqldb3;

-- publisher 테이블 변경
-- 기본키 제약 조건 추가하기 전에 text 타입을 VARCHAR(10)으로 변경
-- 변경하지 않으면 text 길이가 앖다는 오류 발생    
alter table publisher modify pubNo varchar(10) not null;
alter table publisher modify pubName varchar(20);
-- 기본키 제약 조건 추가 
alter table publisher add constraint PK_publisher_pubNo primary key (pubNo);
describe publisher;

-- book 테이블 변경
    -- 기본키 제약 조건 추가하기 전에 text 타입을 VARCHAR(10)으로 변경
    -- 변경하지 않으면 text 길이가 앖다는 오류 발생
    
ALTER TABLE book MODIFY  bookNo VARCHAR(10) NOT NULL, 
				MODIFY bookName VARCHAR(20),
				MODIFY bookAuthor VARCHAR(30),
				MODIFY bookDate DATE,
				MODIFY  pubNo VARCHAR(10) NOT NULL; -- 외래키 pubNo  


 -- 기본키 제약 조건 추가    
ALTER TABLE book 
		ADD CONSTRAINT PK_book_bookNo 
		PRIMARY KEY (bookNo);
    
-- 외래키 제약 조건 추가
ALTER TABLE book 
		ADD CONSTRAINT FK_book_publisher 
		FOREIGN KEY (pubNo) REFERENCES publisher (pubNo);
            
DESCRIBE book;
SELECT * FROM book;
           


-- client 테이블 변경
-- 기본키 제약 조건 추가하기 전에 text 타입을 VARCHAR(10)으로 변경
-- 변경하지 않으면 text 길이가 앖다는 오류 발생    
ALTER TABLE client MODIFY clientNo VARCHAR(10) NOT NULL, 
				   MODIFY clientName VARCHAR(30),
				   MODIFY clientPhone VARCHAR(13),
				   MODIFY clientAddress VARCHAR(50),
				   MODIFY clientBirth DATE,
				   MODIFY clientHobby VARCHAR(30),
				   MODIFY clientGender VARCHAR(1); 

-- 기본키 제약 조건 추가    
ALTER TABLE client 
		ADD CONSTRAINT PK_client_clientNo 
		PRIMARY KEY (clientNo);         

DESCRIBE client;
SELECT * FROM client;


-- bookSale 테이블 변경 
ALTER TABLE bookSale MODIFY bsNo VARCHAR(10) NOT NULL, 
					 MODIFY bsDate DATE,
					 MODIFY clientNo VARCHAR(10) NOT NULL, -- clientNo 외래키
					 MODIFY bookNo VARCHAR(10) NOT NULL;  -- bookNo 외래키

-- 기본키 제약 조건 추가    
ALTER TABLE bookSale 
		ADD CONSTRAINT PK_bookSale_bsNo 
		PRIMARY KEY (bsNo);  	

-- 외래키 제약 조건 추가
ALTER TABLE bookSale 
		ADD CONSTRAINT FK_bookSale_book 
		FOREIGN KEY (bookNo) REFERENCES book (bookNo);
		
ALTER TABLE bookSale 
		ADD CONSTRAINT FK_bookSale_client 
		FOREIGN KEY (clientNo) REFERENCES client (clientNo);

DESCRIBE bookSale;
SELECT * FROM bookSale;

-- book 테이블에서 모든 행 검색하여 출력
-- 모든 열(*) 선택
select *  from book;

-- 도서명과 가격만 검색하여 출력
SELECT bookName, bookPrice FROM book;

-- 저자만 검색하여 출력
SELECT bookAuthor FROM book;

-- 저자만 검색하여 출력 (중복되는 행은 한번만 출력)
-- DISTINCT
SELECT DISTINCT bookAuthor FROM book;

-- where 조건 연습
-- 비교
-- 저자가 홍길동인 도서의 도서명, 저자 출력
select bookName, bookAuthor
from book
where bookAuthor = '홍길동';

-- 가격이 30000원 이상인 도서의 도서명, 가격, 재고 출력
select bookName, bookPrice, bookStock
from book
where bookPrice >= 30000;

-- 재고가 3~5개 사이인 도서의 재고명, 재고 출력
select bookName, bookStock
from book
where bookStock >= 3 and bookStock <= 5;

-- 위랑 같은 문제를 between 사용해서 해결
select bookName, bookStock
from book
where bookStock between 3 and 5;

-- 리스트에 포함(in, not in)
-- 출판사명이 '서울 출판사'와 '도서출판 강남'인 도서의 도서명, 출판사 번호 출력
-- publisher 테이블의 출판사 넘버에 따라 달라지기 때문에 publisher 테이블을 알아야 함.
select bookName,bookNo
from book
where pubNo in ('1', '2');

-- 출판사명이 '도서출판 강남'이 아닌 도서의 도서명, 출판사 번호 출력
select bookName, pubNo
from book
where pubNo not in ('2');

-- null(is null, is not null)
-- 고객 테이블에서 취미 열 확인
select * from client;

-- null 실습을 위해 일부러 null로 설정
update client set clientHobby=null where clientName='호날두';
update client set clientHobby=null where clientName='샤라포바';

-- 모든 고객명, 취미 출력
select clientName, clientHobby from client;

-- 취미에 null 값이 들어 있는 행만 출력
select clientName, clientHobby
from client
where clientHobby is null;

-- 취미가 null값이 아닌 행만 출력
select clientName, clientHobby
from client
where clientHobby is not null;

-- 취미에 공백이 들어있는 행만 출력
-- ''나 '     '나 상관없이 출력 가능.
select clientName, clientHobby
from client
where clientHobby ='  ';

-- 논리(and, or)
-- 저자가 '홍길동'이면서 재고가 3권 이상인 모든 도서 출력
select *
from book
where bookAuthor = '홍길동' and bookStock >= 3;

-- 저자가 '홍길동'이거나 '성춘향'인 모든 도서 출력
select *
from book
where bookAuthor = '홍길동' or bookAuthor = '성춘향';

-- like 연습 문제
-- 출판사 테이블에서 출판사명에 '출판사'가 포함된 모든 행 출력
select *
from publisher
where pubName like '%출판사%';

-- 고객 중 출생년도가 1990년대인 모든 고객 출력
select clientName, clientBirth
from client
where clientBirth like '199%';

-- 고객 테이블에서 고객명이 4글자인 모든 고객 정보
select *
from client
where clientName like '____';

-- 도서 테이블에서 도서명에 '안드로이드'가 들어 있지 않는 도서의 도서명 출력
select bookName
from book
where bookName not like '%안드로이드%';

/*
연습문제
1. 고객 테이블에서 고객명, 생년월일, 성별 출력
2. 고객 테이블에서 주소만 검색하여 출력 (중복되는 주소는 한번만 출력)
3. 고객 테이블에서 취미가 '축구'이거나 '등산'인 고객의 고객명, 취미 출력
4. 도서 테이블에서 저자의 두 번째 위치에 '길'이 들어 있는 저자명 출력 (중복되는 저자명은 한번만 출력)
5. 도서 테이블에서 발행일이 2019년인 도서의 도서명, 저자, 발행일 출력
6. 도서판매 테이블에서 고객번호1, 2를 제외한 모든 판매 데이터 출력
7. 고객 테이블에서 취미가 NULL이 아니면서 주소가 '서울'인 고객의 고객명, 주소, 취미 출력
8. 도서 테이블에서 가격이 25,000원 이상이면서 저자 이름에 '길동'이 들어가는 도서의 도서명, 저자, 가격, 재고 출력
9. 도서 테이블에서 가격이 20,000 ~ 25,000원인 모든 도서 출력 
10. 도서 테이블에서 저자명에 '길동'이 들어 있지 않는 도서의 도서명, 저자 출력
*/
-- no.1
select clientName, clientBirth, clientGender
from client
-- no.2
select distinct clientAddress
from client;
-- no.3
select clientName, clientHobby
from client
where clientHobby = '축구' or clientHobby = '등산';
-- no.4
select distinct bookAuthor
from book
where bookAuthor like '_길%';
-- no.5
select bookName, bookAuthor, bookDate
from book
where bookDate like '2019%';
-- no.6
select *
from booksale
where clientNo not in(1,2);
-- no.7
select clientName,clientAddress,clientHobby
from client
where clientHobby is not null and clientAddress like '%서울%';
-- no.8
select bookName,bookAuthor,bookPrice,bookStock
from book
where bookPrice >= 25000 and bookAuthor like '%길동%';
-- no.9
select *
from book
where bookPrice between 20000 and 25000;
-- no.10
select bookName,bookAuthor
from book
where bookAuthor not like '%길동%';