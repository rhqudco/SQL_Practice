use sqldb3;

-- 	join 표기 형식

-- 1. where 조건 사용
select client.clientNo, clientName, bsQty
from client, bookSale
where client.clientNo = bookSale.clientNo;
-- 양쪽 테이블에 공통되는 열 이름 앞에 테이블 이름 표기(양쪽에 같은 정보가 있기 때문에 어떤 것을 표시할지 모름)
-- client.clientNo <- 모호성 해결

-- 2. 양쪽 테이블에 공통되지 않지만 모든 열 이름에 테이블명을 붙여 서버에서 찾고자 하는 열의 정확한 위치를 알려줘, 성능을 향상시킴.
select client.clientNo, client.clientName, bookSale.bsQty
from client, bookSale
where client.clientNo = bookSale.clientNo;

-- 3. 테이블명 대신 별칭 사용(alias)
select c.clientNo, c.clientName, bs.bsQty
from client c, bookSale bs
where c.clientNo = bs.clientNo;

-- 4. join on 명시하는 방법
select c.clientNo, c.clientName, bs.bsQty
from bookSale bs
join client c
on c.clientNo = bs.clientNo;

-- 5. inner join on (가장 많이 사용)
select c.clientNo, c.clientName, bs.bsQty
from bookSale bs
inner join client c
on c.clientNo = bs.clientNo;

-- client와 booksale 조인
-- clientNo 기준 :  client(모든 고객) > booksale(주문한 고객)
-- '한 번이라도 도서를 주문한 적 있는 고객'이  join을 통해 얻고자 하는 결과
--  출력 열 선택하지 않으면 2개 테이블의 모든 열이 표시된다.
-- 공통되는 clientNo 열이 중복되어 출력된다.
select *
from client
inner join booksale
on client.clientNo = booksale.clientNo;

-- 필요한 열만 추출한다.
-- 테이블명 대신 alias 사용
-- 한 번이라도 도서를 주문한 적 있는 고객의 고객번호, 고객명 출력
select c.clientno, c.clientname
from client c
inner join booksale bs
on c.clientno = bs.clientno;

-- 중복되는 행은 한 번만 출력하고 한 번이라도 도서를 주문한 적 있는 고객의 고객번호, 고객명 출력하는데 고객번호 기준 오름차순으로 정렬
select distinct c.clientno, c.clientname
from client c
inner join booksale bs
on c.clientno = bs.clientno
order by c.clientno desc;
-- client와 booksale 테이블 위치 상관없음
select distinct c.clientno, c.clientname
from booksale bs
inner join client c
on c.clientno = bs.clientno
order by c.clientno desc;

-- 세 개 테이블 결합
-- 테이블은 세 개 조인 조건은 두 개
-- 주문된 도서에 대하여 고객명과 도서명 출력
-- 주문된 도서 : booksale, 고객명 : client, 도서명 : book
--  booksale : 기본키, 외래키1(clientNo), 외래키2(bookNo) 외래키들이 각각 테이블에 조인
select c.clientName, b.bookName
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo;

-- 도서를 주문한 고객의 고객 정보, 주문 정보, 도서 정보 출력
-- 주문번호, 주문일, 고객번호, 고객명, 도서명, 주문수량
-- 날짜 기준 최근 주문이 먼저 출력되도록
select bs.bsNo, bs.bsDate, c.clientNo, c.clientName, b.bookName, bs.bsQty
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo
order by bs.bsDate desc;

-- 고객별로 총 주문 수량 계산하여 고객번호, 고객명, 총 주문수량 출력
-- 총 주문수량 기준 내림차순 정렬
-- 고객별 = group by, 고객번호 = client 테이블 필요, 총 주문수량 = booksale 필요, 2개 테이블 사용 = 조인(공통값 있으므로 inner join), 내림차순 = order by
select c.clientName, c.clientNo, sum(bsQty) as TotalQty
from booksale bs
inner join client c on c.clientNo = bs.clientNo
group by c.clientNo
order by TotalQty desc;

-- 주문일, 고객명, 도서명, 도서 가격, 주문수량, 주문액 계산하여 출력
-- 주문일 오름차순 정렬
select bs.bsDate, c.clientName, b.bookPrice, bs.bsQty, b.bookPrice * bs.bsQty as 주문액
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo
order by bs.bsDate;
-- 2019년 ~ 현재까지 판매된 내용만 출력
select bs.bsDate, c.clientName, b.bookPrice, bs.bsQty, b.bookPrice * bs.bsQty as 주문액
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo
where bs.bsDate >= '2019-01-01'
order by bs.bsDate;

/*
연습문제
1. 모든 도서에 대하여 도서의 도서번호, 도서명, 출판사명 출력
2. ‘서울 출판사'에서 출간한 도서의 도서명, 저자명, 출판사명 출력 (조건에 출판사명 사용)
3. ＇종로출판사'에서 출간한 도서 중 판매된 도서의 도서명 출력 (중복된 경우 한 번만 출력) (조건에 출판사명 사용)
4. 도서가격이 30,000원 이상인 도서를 주문한 고객의 고객명, 도서명, 도서가격, 주문수량 출력
5. '안드로이드 프로그래밍' 도서를 구매한 고객에 대하여 도서명, 고객명, 성별, 주소 출력 (고객명으로 오름차순 정렬)
6. ‘도서출판 강남'에서 출간된 도서 중 판매된 도서에 대하여 ‘총 매출액’ 출력
7. ‘서울 출판사'에서 출간된 도서에 대하여 판매일, 출판사명, 도서명, 도서가격, 주문수량, 주문액 출력
8. 판매된 도서에 대하여 도서별로 도서번호, 도서명, 총 주문 수량 출력
9. 판매된 도서에 대하여 고객별로 고객명, 총구매액 출력 ( 총구매액이 100,000원 이상인 경우만 해당)
10. 판매된 도서 중 ＇도서출판 강남'에서 출간한 도서에 대하여 고객명, 주문일, 도서명, 주문수량, 출판사명 출력 (고객명으로 오름차순 정렬)
*/
-- no.1
select b.bookNo, b.bookName, p.pubName
from book b
inner join publisher p on p.pubNo = b.pubNo;

-- no.2
select b.bookName, b.bookAuthor, p.pubName
from book b
inner join publisher p on p.pubNo = b.pubNo
where p.pubName = '서울 출판사';

-- no.3
select distinct bs.bookName, p.pubName
from book b
inner join publisher P on  B.pubNo = P.pubNo
inner join bookSale BS on  B.bookNo = BS.bookNo
where pubName = '종로출판사';

-- no.4
select c.clientName, b.bookName, b.bookPrice, bsQty
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo
where b.bookPrice >= 30000;

-- no.5
select b.bookName, c.clientName, c.clientGender, c.clientAddress
from bookSale bs
inner join book b on b.bookNo = bs.bookNo
inner join client c on c.clientNo = bs.clientNo
where bookName = '안드로이드 프로그래밍'
order by c.clientName;

-- no.6
select p.pubName, sum(bs.bsQty * b.bookPrice) as '총 매출액'
from book b
inner join publisher p on p.pubNo = b.pubNo
inner join bookSale bs on bs.bookNo = b.bookNo
where p.pubName = '도서출판 강남';

-- no.7
select bs.bsDate, p.pubName, b.bookName, b.bookPrice, bs.bsQty, bs.bsQty * b.bookPrice as 주문액
from booksale bs
inner join book b on b.bookNo = bs.bookNo
inner join publisher p on p.pubNo = b.pubNo
where p.pubName = '서울 출판사';

-- no.8
select b.bookNo, b.bookName, sum(bs.bsQty) as '총 주문 수량'
from book B
inner join bookSale BS on B.bookNo = BS.bookNo       		
group by B.bookNo;


-- no.9
select c.clientName, sum(b.bookPrice * bs.bsQty) as '총주문액'
from booksale bs
inner join client c on c.clientNo = bs.clientNo
inner join book b on b.bookNo = bs.bookNo
group by c.clientNo
having sum(b.bookPrice * bs.bsQty) >= 100000;

-- no.10
select c.clientName, bs.bsDate, b.bookName, bs.bsQty, p.pubName    
from bookSale BS 
inner join client c on c.clientNo = bs.clientNo
inner join book b  on b.bookNo = bs.bookNo       
inner join publisher p on b.pubNo = p.pubNo
where p.pubName = '도서출판 강남'
order by c.clientName;


-- 외부조인
-- 1. 왼쪽 테이블 기준(left outer join)
-- client, booksale
-- 왼쪽 테이블(client) 데이터 모두 출력
-- 오른쪽 테이블 해당 값 없으면 null 출-- 의미 : 고객 중 한 번도 구매한 적이 없는 고객은 null로 출력
select *
from client c
left outer join booksale bs
on c.clientNo = bs.clientNo
order by c.clientNo;

-- 고객 중에서 한 번도 구매한 적이 없는 고객의 고객 번호, 고객명 출력
select c.clientNo, c.clientName
from client c
left outer join booksale bs
on c.clientNo = bs.clientNo
where bs.clientNo is null
order by c.clientNo;

-- 도서 중에서 힌 반도 판매된 적이 없는 도서의
-- 도서번호, 도서명 출력 
select b.bookNo, b.bookName
from book b
left outer join booksale bs
on b.bookNo = bs.bookNo
where bs.bookNo is null
order by b.bookNo;

-- 오른쪽 테이블 기준
-- 오른쪽 booksale 데이터 모두 출력
-- 왼쪽 테이블 client에는 주문한 적 있는 고객 정보만 출력
select *
from client c
right outer join booksale bs
on c.clientNo = bs.clientNo
order by c.clientNo;

-- 한 번이라도 주문한 적 있는 고객의 고객번호, 고객명 출력(중복된 경우 한 번만 출력)
select distinct c.cleintNo, c.clientName
from client c
right outer join booksale bs
on c.clientNo = bs.clientNo
order by c.clientNo;

-- 완전 외부 조인(full outer join)
-- MySQL에서는 full 키워드를 지원하지 않는다.
-- left join과 right join을 union해서 사용할 수 있다.
select *
from client c
left join booksale bs
on c.clientNo = bs.clientNo
union
select *
from client c
right join booksale bs
on c.clientNo = bs.clientNo;