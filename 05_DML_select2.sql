use sqldb3;

-- 도서명 순으로 도서 검색 (기본 : 오름차순 (일반적으로 ASC 생략))
select *
from book
order by bookName asc;


-- 일반적으로 asc 생략
select *
from book
order by bookname;

-- 도서명 순으로 도서 검색 (내림차순 DESC)
select *
from book
order by bookname desc;

-- 한글 -> 영문 -> 숫자 순서로
select * 
from book
order by
(case when ascii(substring(bookName, 1)) between 48 and 57 then 3
	  when ascii(substring(bookName, 1)) < 122 then 2 else 1 end), bookName;
-- 영어 -> 한글 -> 숫자 순서로
select * 
from book
order by
(case when ascii(substring(bookName, 1)) between 48 and 57 then 3
	  when ascii(substring(bookName, 1)) < 122 then 1 else 2 end), bookName;
      
/*
LIMIT 활용 예제
*/

-- 상위 n개 출력
-- 첫번째부터 상위 5개
select *
from book
order by bookname
limit 5;
-- 위랑 같음.
select *
from book
order by bookname
limit 5 offset 5;
-- 위랑 같음.
select *
from book
order by bookname
limit 0, 5;

-- 11번째부터 상위 7개
select *
from book
order by bookname
limit 10, 7;
-- 11번째부터 상위 5개
select *
from book
limit 10, 5;

-- 정렬

-- SUM
-- 도서 테이블에서 재고 수량 기준 내림차순으로 도서명, 저자, 재고 출력
select bookName, bookAuthor, bookStock
from book
order by bookStock desc;

-- 2차 정렬 (2차 정렬시에도 생략가능)
-- 상위 문제에서 재고 수량이 동일할 때 저자명으로 오름차순 정렬
select bookName, bookAuthor, bookStock
from book
order by bookStock desc, bookAuthor asc;

-- 집계 함수
-- 도서 테이블에서 총 재고 수량 계산하여 출력
select sum(bookStock) -- <- 열 이름으로 함수 코드를 통한 출력.
from book;

-- 열 이름 sym of bookstock 총 재고수량 계산하여 출력
select sum(bookstock) as 'sum of bookStock'
from book;
-- 열 이름으로 한글도 가능, 큰 따옴표도 사용 가능.
select sum(bookstock) as "책 재고"
from book;
-- 열 이름에 공백 없으면 따옴표 필요 없음.
select sum(bookstock) as 책재고
from book;

-- 도서판매 테이블에서 고객번호 2가 주문한 도서의 총 주문 수량 계산하여 출력
select sum(bsQty) as '2번의 총 주문 수량'
from bookSale
where clientNo = '2';

-- MIN MAX
-- 도서 판매 테이블에서 최대/최소 주문수량
select max(bsQty) as 최대, min(bsQty) as 최소
from booksale

-- 도서 테이블에서 도서의 가격 총합, 평균가, 최고가, 최저가 출력
select sum(bookPrice) as 총합, 
	   avg(bookPrice) as 평균, 
	   max(bookPrice) as 최대, 
       min(bookPrice) as 최소
from book;
-- as 생략 가능
select sum(bookPrice) 총합, 
	   avg(bookPrice) 평균, 
	   max(bookPrice) 최대, 
       min(bookPrice) 최소
from book;
-- 형변환(평균가 정수로)
-- ROUND(숫자) : 반올림
-- ROUND(솟자, 소수이하 자리수) : 소수점 이하 자리수
select sum(bookPrice) as 총합, 
	   round(avg(bookPrice)) as 평균, 
	   max(bookPrice) as 최대, 
       min(bookPrice) as 최소
from book;

-- COUNT(*) 전체 행 출력
-- 도서 판매 테이블에서 도서 판매 건수 출력(모든 행의 수가 출력된다)
select count(*) as '총 판매 개수'
from bookSale;
-- COUNT(열이름)
-- 고객 테이블에서 전체 고객 수 (모든 행의 수 출력)
select count(*) as '총 고객 수'
from client;
-- null이 있는 행의 개수 출력
-- null은 함수에서 제외된다.
select count(clientHobby) as '총 취미 개수'
from client;
-- 안에 값이 공백인 경우 공백을 빼고 출력 (null과 공백 모두 제거)
select count(clientHobby) as '총 취미 개수'
from client
where clientHobby not in('');
-- 또는 결과가 동일한 다른 방법
select count(clientHobby) as '총 취미 개수'
from client
where clientHobby != '';

-- group by절 연습
-- 도서 판매 테이블에서 도서별 판매수량 합계 출력
select bookNo, sum(bsQty) as '판매량 합계'
from bookSale
group by bookNo;
-- group by절에서 정렬 - 열 이름으로 정렬
select bookNo, sum(bsQty) as '판매량 합계'
from bookSale
group by bookNo
order by bookNo;
-- 열 순서로 정렬 가능
select bookNo, sum(bsQty) as '판매량 합계'
from bookSale
group by bookNo
order by 1; -- 첫 번째 열(bookNo)로 정렬

select bookNo, sum(bsQty) as '판매량 합계'
from bookSale
group by bookNo
order by 2; -- 두 번째 열(판매량 합계)로 정렬

select bookNo, sum(bsQty) as '판매량 합계'
from bookSale
group by bookNo
order by '판매량 합계'; -- 두 번째 열(판매량 합계)로 정렬 <- 불가능 정렬이 되지 않는다
-- 해결방법
select bookNo, sum(bsQty) as 판매량합계
from bookSale
group by bookNo
order by 판매량합계; -- 열 이름에 따옴표, 공백을 쓰지 않으면 정렬할 수 있다.

-- having 연습-- 도서 테이블에서 가격이 25000원인 도서에 대하여 출판사별로 도서 수 합계(출판사별 = group by)
-- 단 도서 수 합계가 2인 이상만 출력
select pubNo, count(*) as '도서 수 합계'
from book
where bookPrice >= 25000
group by pubNo
having count(*) >= 2;
-- 1번 출판사는 2권 2번 출판사는 6권 나옴

/*
연습문제
1. 도서 테이블에서 가격 순으로 내림차순 정렬하여,  도서명, 저자, 가격 출력 (가격이 같으면 저자 순으로 오름차순 정렬)
2. 도서 테이블에서 저자에 '길동'이 들어가는 도서의 총 재고 수량 계산하여 출력
3. 도서 테이블에서 ‘서울 출판사' 도서 중 최고가와 최저가 출력 
4. 도서 테이블에서 출판사별로 총 재고수량과 평균 재고 수량 계산하여 출력 (‘총 재고 수량’으로 내림차순 정렬)
5. 도서판매 테이블에서 고객별로 ‘총 주문 수량’과 ‘총 주문 건수’ 출력. 단 주문 건수가 2이상인 고객만 해당  
*/
-- no.1
select bookName, bookAuthor, bookPrice
from book
order by bookPrice desc, bookAuthor asc;
-- no.2
select sum(bookStock) as '총 재고 수량'
from book
where bookAuthor like '%길동%';
-- no.3
select max(bookPrice) as 최고가, min(bookPrice) as 최저가
from book
where pubNo ='1';
-- no.4
-- round 대신 ceil 사용하면 올림, floor 사용하면 내림
select pubNo, sum(bookStock) as '총 재고수량', round(avg(bookStock)) as '평균 재고수량'
from book
group by pubNo
order by 2 desc; -- 따옴표 있으면 order by에 정렬 불가능.
-- no.5
select clientNo, sum(bsQty) as '총 주문 수량', count(clientNo) as '총 주문 건수'
from bookSale
group by clientNo
having count(*) >= 2;
