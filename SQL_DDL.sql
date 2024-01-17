# DDL (Data Dfinition Language / 데이터 정의어)
# 데이터베이스, 테이블, 인덱스, 뷰 등의 스키마를 정의하는데 사용되는 명령어

# CREATE
# 데이터베이스, 테이블, 인덱스, 뷰 등을 생성할 때 사용하는 명령어

# 데이터베이스 생성 
CREATE DATABASE sample_database;

# 데이터베이스 선택
USE sample_database;

# 테이블 생성
CREATE TABLE sample_table (
	column1 INT AUTO_INCREMENT PRIMARY KEY,		# INT : 정수
    column2 DOUBLE,								# DOUBLE : 실수
    column3 BOOLEAN,							# BOOLEAN : 논리 (0: false, 1: true)
    column4 VARCHAR(10),						# VARCHAR(길이) : 길이를 제한한 문자열
    column5 TEXT,								# TEXT : 길이를 제한하지 않은 문자열
    column6 DATE,								# DATE : 날짜
    column7 TIME,								# TIME : 시간
    column8 DATETIME							# DATETIME : 날짜 및 시간
);

# ALTER
# 데이터베이스, 테이블, 인덱스, 뷰 등을 수정할 때 사용하는 명령어

# 테이블 수정 - 컬럼 추가
# ALTER TABLE 테이블명 ADD 컬럼명 데이터타입;
ALTER TABLE sample_table ADD column9 INT;

# 테이블 수정 - 컬럼 타입 수정
# ALTER TABLE 테이블명 MODIFY COLUMN 변경할컬럼명 변경될테이터타입
ALTER TABLE sample_table MODIFY COLUMN column9 DOUBLE;

# 테이블 수정 - 컬럼 삭제
# ALTER TABLE 테이블명 DROP COLUMN 삭제할컬럼명;
ALTER TABLE sample_table DROP COLUMN column9;

# DROP
# 데이터베이스, 테이블, 인덱스, 뷰 등을 삭제할 때 사용하는 명령어

# 테이블 삭제
# DROP TABLE 테이블명;
DROP TABLE sample_table;

# DROP TABLE, TRUNCATE TABLE, DELETE TABLE
# 테이블과 관련된 삭제 명령어
# DROP (DDL) : 정의와 관련된 작업 -> 테이블의 정의 자체 삭제
# TRUNCATE (DML) : 데이터와 관련된 작업 -> 모든 데이터 삭제 (테이블을 초기화 - 인덱스도 초기화)
# DELETE (DML) : 데이터와 관련된 작업 -> 모든 데이터 삭제 (데이터만 삭제 - 인덱스 등은 삭제 안함)

# 데이터베이스 삭제
# DROP DATABASE 데이터베이스명;
DROP DATABASE sample_database;








