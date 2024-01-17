# 인사관리 시스템을 위한 데이터베이스 설계
# 사원 [사번, 이름, 전화번호, 생일, 이메일, 주소]
# 부서 [부서코드, 부서명, 부서전화번호, 부서주소]
# 직급 [직급아이디, 직급명, 기본연봉]

# 인사관리 데이터베이스 생성
CREATE DATABASE human_resource;

# 인사관리 데이터베이스 사용
USE human_resource;

# 사원 테이블 생성
CREATE TABLE employee (
	employee_number INT,
    employee_name VARCHAR(10),
    employee_tel_number VARCHAR(13),
    employee_birth DATE,
    employee_email VARCHAR(100),
    employee_address TEXT
);

# 부서 테이블 생성 
CREATE TABLE department (
	department_code VARCHAR(3),
    department_name VARCHAR(20),
    department_tel_name VARCHAR(13),
    department_address TEXT
);

# 직급 테이블 생성
CREATE TABLE position (
	position_code VARCHAR(5),
    position_name VARCHAR(20),
    position_annual_income INT
);









