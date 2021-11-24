use sqldb3;
-- 내장 함수

-- 수학 함수
-- ROUND
-- 고객별 평균 주문액을 출력
select clientNo, round(avg(bookPrice * bsQty)) as '평균주문액',
				 round(avg(bookPrice * bsQty), 0) as '1의 자리까지 출력',
                 round(avg(bookPrice * bsQty), -1) as '10의 자리까지 출력',
                 round(avg(bookPrice * bsQty), -2) as '100의 자리까지 출력',
                 round(avg(bookPrice * bsQty), -3) as '1000의 자리까지 출력'
from book, booksale
where book.bookNo = booksale.bookno
group by clientNo;
-- 평균 주문액 : 88333
-- 1의 자리까지 : 88333
-- 10의 자리까지 : 88330
-- 100의 자리까지 : 88300
-- 1000의 자리까지 : 88000

-- 순위 출력 함수
-- RANK(), DENSE_RANK(), ROW_NUMBER()
select bookPrice, 
		rank() over(order by bookPrice desc) "rank",
        dense_rank() over(order by bookPrice desc) "dense_rank",
        row_number() over(order by bookPrice desc) "row_number"
from book;

-- 문자 함수
-- 도서명에 '안드로이드'가 포함된 도서에 대해
-- '안드로이드'를 'Android'로 변경해서 출력
-- 실제 데이터는 변경되지 않음(출력만 한다) 
-- replace
select bookNo, replace(bookName, '안드로이드', 'Android') bookName, bookAuthor, bookPrice
from book
where bookName like '안드로이드%';

--  char_length(), length()
-- '서울 출판사'에서 출간한 도서의 도서명과 바이트 수, 문자열 길이 출력, 출판사명 출력
select b.bookName as '도서명',
	   length(b.bookName) as '바이트 수',
       char_length(b.bookName) as '길이',
       p.pubName as '출판사'
from book b
inner join publisher p on p.pubNo = b.pubNo
where p.pubName = '서울 출판사';

-- substr(전체 문자열, 시작, 길이)
-- 도서 테이블의 '저자' 열에서 성만 출력
select substr(bookAuthor, 1, 1) as '성'
from book;
-- 도서 테이블의 '저자' 열에서 이름만 출력
select substr(bookAuthor, 2, 2) as '이름'
from book;

-- 날짜 함수
-- 현재 날짜와 시간 출력
select date(now()), time(now());
-- 현재 날짜에서 연, 월, 일 추출
select year(curdate()), month(curdate()), dayofmonth(curdate());
-- 시간에서 시, 분, 초, 마이크로초 출력
-- current_time(), curtime() 둘 다 사용해도 무방하다.
select hour(curtime()),
	   minute(current_time()),
       second(current_time()),
       microsecond(current_time());
       
select hour(curtime()),
	   minute(curtime()),
       second(curtime()),
       microsecond(curtime());


-- 파일 로드
-- movie 테이블 생성
create table movie(
movieId varchar(10) not null primary key,
movidTitle varchar(30),
movieDirector varchar(20),
movieStar varchar(20),
movieScript longtext,
movieFilm longblob
);
-- 데이터 입력
insert into movie 
values ('1', '쉰들러 리스트', '스필버그', '리암 니슨',
		load_file('/Users/gobyeongchae/Desktop/movies&csv/Schindler.txt'),
        load_file('/Users/gobyeongchae/Desktop/movies&csv/Schindler.mp4'));

-- 저장할 수 있는 파일의 최대 크기 변수 확인        
show variables like 'max_allowed_packet';
-- '67108864' -> 1GB로 변경

-- 파일 업로드/다운로드 경로 변수 확인
SHOW variables LIKE 'secure_file_priv';
        