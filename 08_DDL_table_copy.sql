use sqldb3;

-- 테이블 복사
-- 제약조건 복사 안됨
-- 복사 후 제약조건 설정 필요

-- 테이블 복사 : 새 테이블로 전체 복사
create table new_book1 as
select * 
from book;

select * from new_book1
desc new_book1;

-- 기본키 제약조건 추가
alter table new_book1
add constraint PK_new_book1_bookNo
primary key (bookNo);

-- 테이블 복사 : 새 테이블로 일부만 복사
create table new_book2 as
select * 
from book
where bookDate like '2020%';

select * from new_book2
desc new_book2;

-- 기본키 제약조건 추가
alter table new_book2
add constraint PK_new_book2_bookNo
primary key (bookNo);

-- 테이블 복사 : 기존 테이블로 데이터만 복사
-- 테이블 구조가 동일한 경우에만 가능

-- new_book2 테이블 데이터 전체 삭제 (구조, 제약조건은 남아 있음)
delete from new_book2;

-- new_book2 테이블에 데이터 복사
insert into new_book2
select *
from book;

select * from new_book2
desc new_book2;

-- 테이블 복사 : 다른 데이터베이스의 테이블에서 복사
-- 새 테이블로 일부 복사create table product2 as
select * 
from sqldb2.product
where prdPrice >= 1000000;

-- 기본키 제약조건 추가
alter table product2
add constraint PK_product2_prdNo
primary key (prdNo);