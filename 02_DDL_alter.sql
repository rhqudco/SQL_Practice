use sqldb1;

-- steTel 추가
ALTER TABLE student2 ADD steTel varchar(13);

describe student2;

-- 여러 개의 열(stdAge, stdAddress)추가 
alter table student2 add (stdAge varchar(2), stdAddress2 varchar(50));

-- 열의 데이터 형식 변경 : stdAge 열의 데이터 타입을 INT로 바꾼다.
alter table student2 modify stdAge int;

-- 열의 제약조건 변경 : stdName을 NULL 허용으로 설정
alter table student2 modify stdname varchar(2) null;

-- 열 이름 변경 : stdTel을 stdHP로 변경(데이터 타입 적으면 구문 오류)
alter table student2 rename column stdTel to stdHP;

-- 열 이름과 데이터 타입 변경
alter table student2 change stdAddress stdAddress1 varchar(30);

-- 열 삭제 : stdHP 삭제
alter table student2 drop column stdHP;

-- 여러 개의 열 삭제
alter table student2 drop stdAge,
					 drop stdAddress1,
					 drop stdAddress2;
                     
-- alter table 연습문제
/*
테이블 ALTER 연습문제
1. product 테이블에 숫자 값을 갖는 prdStock과 제조일을 나타내는 prdDate 열 추가
2. product 테이블의 prdCompany 열을 NOT NULL로 변경
3. publisher 테이블에 pubPhone, pubAddress 열 추가
4. publisher 테이블에서 pubPhone 열 삭제
*/
alter table product add (prdStock int, prdDate date);
alter table product modify prdCompany varchar(30) not null;
alter table publisher add (pubPhone varchar(13), pubAddress varchar(30));
alter table publisher drop column pubPhone;

-- 기본키 삭제
alter table department2 drop primary key; 
/*해당 sql구문은 오류 외래키 제약조건이 설정됐기 때문*/

-- 외래키 제약조건 삭제
alter table student2 drop constraint FK_student2_department2;
alter table professor drop constraint FK_professor_department2;

-- 외래키 제약조건 삭제 후 기본키 삭제
alter table department2 drop primary key;

-- 기본키 / 외래키 추가

-- 기본키 제약조건 추가 : department2 테이블
-- 둘 다 가능한 구문
alter table department2 add constraint PK_department2_dptNo primary key(dptNo);
alter table department2 add primary key(dptNo);

-- 외래키 제약조건 추가 : student2와 professor 테이블
alter table student2 
add constraint FK_student2_department2 
foreign key(dptNo) references department2(dptNo);

alter table professor 
add constraint FK_professor_department2 
foreign key(dptNo) references department2(dptNo);

-- ON DELETE CASCADE
-- student2 테이블의 기존 외래키 삭제하고 다시 설정
-- 기존 외래키 삭제
alter table student2 drop constraint FK_student2_department2;
-- ON DELETE CASCADE로 다시 외래키 설정
-- department2 table에서 값이 지워지면 자동으로 student2 table의 외래키가 지워진다.
alter table student2 add constraint FK_student2_department2
foreign key(dptNo) references department2(dptNo)
ON DELETE CASCADE;