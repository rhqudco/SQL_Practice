use sqldb3;

-- 서브쿼리

-- 단일 행 서브쿼리(=)
-- 고객 호날두의 주문수량 조회
-- 1. client 테이블에서 고객명 호날두의 clientNo를 찾아서 
-- 2. booksale에서 clientNo에 해당되는 주문에 대해 주문일, 주문수량 출력
select bsDate, bsQty
from booksale
where clientNo = (select clientNo
					from client
					where clientName = '호날두');

-- 호날두가 주문한 총 주문수량 출력
-- 1. client 테이블에서 고객명 호날두의 clientNo를 찾아서 
-- 2. booksale에서 clientNo에 해당되는 주문에 대해 총 주문수량 출력
select sum(bsQty) as '총 주문 수량'
from booksale
where clientNo = (select clientNo
					from client
					where clientName = '호날두');

-- 가장 비싼 도서의 도서명과 가격 출력
-- 1. 가장 비싼 도서를 찾아서 해당 도서의 도서명과 가격 출력
select bookName, bookPrice
from book
where bookPrice = (select max(bookPrice)
					from book);
                    
-- 단일 행 서브퀴리 비교 연산자 사용
-- 1. 도서의 평균 가격보다 비싼 도서에 대해 도서명, 가격 출력
-- 평균 도서 가격을 서브쿼리에서 반환하기 때문에 단일행 반환
select bookName, bookPrice
from book
where bookPrice >= (select avg(bookPrice)
					from book);
-- 책의 평균 가격
select round(avg(bookPrice))
from book;

-- 다중 행 서브쿼리(IN, NOT IN)
-- 도서를 구매한 적이 있는 고객의 고객명, 고객번호 출력
-- 1. booksale에 있는 clientNo는 모두 구매한 고객이다.
-- 2. clientNo에 해당되는 고객을 client테이블에서 clientName을 찾는다
select clientName, clientNo
from client
where clientNo in (select clientNo
					from bookSale);
-- 한 번도 주문한 적 없는 고객명, 고객번호 출
select clientName, clientNo
from client
where clientNo not in (select clientNo
					from bookSale);
-- 도서명이 '안드로이드 프로그래밍'인 도서를 구매한 고객의 고객명 출력
-- 1. book 테이블에서 원하는 도서명의 bookNo를 검색
-- 2. bookSale에서 bookNo에 해당되는 도서를 구매한 clientNo를 찾고
-- 3. client 테이블에서 이 clientNo에 해당되는 고객명을 출력
select clientName
from client
where clientNo in (select clientNo
					from bookSale
					where bookNo in (select bookNo
										from book
                                        where bookName = '안드로이드 프로그래밍'));
-- in : 다중 행 반환인 경우에 사용(단일 행 반환 시 사용해도 오류 없음)
-- = : 단일 행 반환인 경우에 사용(결과가 여러 행인 경우에 사용시 오류 해결)
-- 결과 행을 잘 모르겠으면 in 사용

-- 고객명 기준으로 정렬
select clientName
from client
where clientNo in (select clientNo
					from bookSale
					where bookNo in (select bookNo
										from book
                                        where bookName = '안드로이드 프로그래밍'))
order by clientName;



-- 다중 행 서브 쿼리(EXISTS, NOT EXISTS)
-- EXISTS : 서브 쿼리 결과가 행을 반환하면 참이 되는 연산자
-- 도서를 구매한 적이 있는 고객
-- 1. bookSale에 조건에 해당되는 행이 존재하면 참 반환
-- 2. client 테이블에서 이 clientNo에 해당되는 고객의 고객번호, 고객명 출력
select clientNo, clientName
from client
where exists (select clientNo
				from bookSale
				where client.clientNo = bookSale.clientNo);
-- 구매한 적 없는 고객번호, 고객명 출력
-- not exists
select clientNo, clientName
from client
where not exists (select clientNo
				from bookSale
				where client.clientNo = bookSale.clientNo);
-- null인 경우 in과 exists의 차이
-- clientHobby에 null값이 포함됐다
-- exists : 서브 쿼리에 null값 포함
-- null과 공백 다 출력됨.
select clientHobby
from client
where exists (select clientHobby
					from client);
-- in : 서브 쿼리 결과에 null 값 포함되지 않음
-- null 값을 갖지 않는 행만 출력
-- null 제외 공백, 유효값 출력됨.
select clientHobby
from client
where clientHobby in (select clientHobby
					from client); 
                    
-- 다중 행 서브 쿼리(ALL, ANY)
-- ALL : 검색 조건이 서브 쿼리 결과의 모든 값에 만족하면 참이 되는 연산자
-- 2번 고객이 주문한 도서의 최고 주문수량보다 더 많은 도서를 구매한 고객의 고객번호, 주문번호, 주문수량 출력
-- 2번 고객이 주문한 모든 주문에서 발생한 주문수량보다 더 크면 된다.
select clientNo, bsNo, bsQty
from bookSale
where bsQty > all (select bsQty
					from bookSale
					where clientNo = '2');
                    
-- ANY : 검색 조건이 서브 쿼리 결과 중 하나 이상에 만족하면 참
-- 2번 고객보다 '한 번이라도' 더 많은 주문을 한 적이 있는 고객의 고객번호, 주문번호, 주문수량 출력
select clientNo, bsNo, bsQty
from bookSale
where bsQty > any (select bsQty
					from bookSale
					where clientNo = '2');
-- 2번 고객 자신도 포함됐기 때문에 빼고 출력select clientNo, bsNo, bsQty
from bookSale
where bsQty > any (select bsQty
					from bookSale
					where clientNo = '2')
				and clientNo != '2';
                
/*
연습문제 (서브 쿼리 사용)
1. 호날두(고객명)가 주문한 도서의 총 구매량 출력
2. ‘종로출판사’에서 출간한 도서를 구매한 적이 있는 고객명 출력
3. 베컴이 주문한 도서의 최고 주문수량보다 더 많은 도서를 구매한 고객명 출력
4. 서울에 거주하는 고객에게 판매한 도서의 총 판매량 출력
*/
-- no.1
select sum(bsQty)
from bookSale
where clientNo = (select clientNo
					from client
					where clientName = '호날두');

-- no.2
select clientName
from client
where clientNo in (select clientNo
					from bookSale
					where bookNo in (select bookNo
									from book
									where pubNo in (select pubNo
													from publisher
													where pubName = '종로출판사'))); 

-- no.3
select clientName
from client
where clientNo in (select clientNo
					from bookSale
					where bsQty > all (select bsQty
										from bookSale
										where bsQty > all (select bsQty
														from bookSale
														where clientNo in (select clientNo
																			from client
																			where clientName = '베컴')));	


                    
-- no.4
select sum(bsQty)
from bookSale
where clientNo in (select clientNo
					from client
					where clientAddress like '서울%');
                    
-- 스칼라 서브쿼리
-- 고객별로 고객변호, 고객명, 총 주문수량 출력
select clientNo, sum(bsQty), (select clientName
								from client
                                where client.clientNo = bookSale.clientNo)
from bookSale
group by clientNo;
-- 스칼라 서브쿼리
-- 고객별로 고객변호, 고객명, 총 주문수량 출력할 때 결과에 이름 지정
select clientNo, sum(bsQty) as '총 주문 수량', (select clientName
								from client
                                where client.clientNo = bookSale.clientNo) as '고객명'
from bookSale
group by clientNo;

-- 인라인 뷰 서브 쿼리
-- 도서 가격이 25,000 이상인 도서에 대하여 도서별로 도서명, 도서가격, 총 판매수량, 총 판매액 출력
-- 총 판매액 기준으로 내림차순 정렬
select bookName, bookPrice, sum(bsQty) as 총판매량, sum(bookPrice * bsQty) as '총 판매액'
from (select bookNo, bookName, bookPrice
		from book
		where bookPrice >= 25000) book, bookSale
where book.bookNo = bookSale.bookNo
group by book.bookNo
order by 총판매량 desc;