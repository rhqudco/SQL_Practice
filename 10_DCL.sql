-- DCL
use sqldb3;

-- 사용자 계정 조회하려면 해당 테이블 사용해야 함.
use mysql;

-- 사용자 계정 조회
select * from user;

-- 사용자 계정 생성
-- create user 계정@호스트 identified by 비밀번호
/*
호스트
- localhost : 로컬에서 접근 가능
- 192.168.@@@.@@@ : 특정 ip에서 접근 가능
- '%' : 어디에서나 접근 가능
비밀번호 변경
- SET PASSWORD for '계정명'@호스트 = '새 비밀번호';
계정 삭제
- DROP USER 계정@호스트;
*/

-- 계정생성
create user newuser1@'%' identified by '1111';
-- 스키마 접근 불가

-- 비밀번호 변경
set password for 'newuser1'@'%' = '1234';
-- 서버 연결 (newuser1)

-- 계정 삭제
drop user newuser1@'%';


-- 권한 조회 : SHOW GRANTS FOR 사용자계정;
show grants for root;

-- 권한 부여 : GRANT 권한 ON 데이터베이스.테이블 TO 계정@호스트;
-- 모든 권한 부여 : GRANT ALL PRIVILEGES ON *.* TO 계정@호스트; (*은 '모두'라는 뜻)
-- 특정 DB의 모든 테이블에 특정 권한 부여 : GRANT select, insert, update, delete ON DB명.* TO 계정@호스트;

-- 특정 DB의 모든 테이블에 대한 권한 삭제 : REVOKE ALL PRIVILEGES ON DB.* FROM TO 계정@호스트;

-- 특정 DB의 모든 테이블에 대해 특정 권한 삭제 : REVOKE select, insert, update, delete ON DB명.* FROM 계정@호스트;


-- 계정 생성
create user newuser1@'%' identified by '1111';
-- 권한 조회
show grants for newuser1;
-- 서버 접속은 가능하지만 아무런 스키마가 보이지 않는다(스키마 사용 권한 없음)

-- 모든 권한 부여
grant all privileges on *.* to newuser1@'%';
-- 모든 스키마 / 테이블 접근 가능

-- user1 select 권한 삭제
revoke select on *.* from newuser1@'%';
-- table could not fetched

-- sqldb3의 모든 테이블에 select권한 부여
grant select on sqldb3.* to newuser1@'%';
-- 다른 테이블은 could not fetched

-- Import한 데이터베이스 테이블에서 동영상 파일 내보내기 테스트
use sqldb6;

select movieFilm from movie where movieId='1'
into outfile '/Users/gobyeongchae/Desktop/SQL_script';