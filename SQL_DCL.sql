# DCL (Data Controll Language - 데이터 제어어)
# 데이터베이스에 보안과 관련된 설정을 관리하는 명령어

# 유저 생성 (DDL)
# 해당 데이터베이스에 대하여 사용자를 생성하는 명령어
# CREATE USER '유저명'@'호스트이름' IDENTIFIED BY '비밀번호';
CREATE USER 'developer1'@'localhost' IDENTIFIED BY 'p!ssw0rd';
CREATE USER 'developer2'@'%' IDENTIFIED BY 'p!ssw0rd';

# GRANT
# 사용자에게 특정 데이터베이스의 특정 테이블에 대하여 
# 특정 작업을 수행할 권한을 부여하는 명령어

# GRANT privilegel, ...
# ON 데이터베이스명.테이블명
# TO '유저이름'@'호스트명';

GRANT SELECT
ON sample_database.namgu 
TO 'developer1'@'localhost';


GRANT UPDATE, SELECT
ON *.*							# *.* : '모든 데이터베이스에 대해 모든 테이블'이라는 뜻
TO 'developer1'@'localhost';

REVOKE SELECT
ON *.*						
FROM 'developer1'@'localhost';

# REVOKE
# 사용자에게 특정 데이터베이스의 특정 테이블에 대하여
# 특정 작업을 수행할 권한을 취소하는 명령어

# REVOKE privilegel1, ...
# ON 데이터베이스명.테이블명
# FROM '유저이름'@'호스트명';








