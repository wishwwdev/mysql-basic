# 회원가입 (email, email2, email3가 가입함)
INSERT INTO user VALUES ('email@email.com', 'P!ssw0rd', 'nickname1', '010-1111-1111', '부산광역시 부산진구', '에이원프라자 4층', null);

INSERT INTO user VALUES ('email2@email.com', 'P!ssw0rd', 'nickname2', '010-1111-1112', '부산광역시 부산진구', '에이원프라자 4층', null);

INSERT INTO user VALUES ('email3@email.com', 'P!ssw0rd', 'nickname3', '010-1111-1113', '부산광역시 부산진구', '에이원프라자 4층', null);

SELECT * FROM user;

# 로그인 
SELECT * FROM user WHERE email = 'email@email.com' AND password = 'P!ssw0rd';

# 게시글 작성 (email이 게시글 3개 작성함, email2가 게시글 0개 작성함, email3가 게시글 1개 작성함) 
INSERT INTO board (writer_email, title, content, image) 
VALUES ('email@email.com', '게시글 제목', '게시글 내용', null);
INSERT INTO board (writer_email, title, content, image) 
VALUES ('email@email.com', '게시글 제목2', '게시글 내용2', null);
INSERT INTO board (writer_email, title, content, image) 
VALUES ('email@email.com', '게시글 제목3', '게시글 내용3', null);
INSERT INTO board (writer_email, title, content, image) 
VALUES ('email3@email.com', '게시글 제목3', '게시글 내용3', null);

SELECT * FROM board;

# Alias
# 컬럼이나 테이블에 별칭을 지정하고 할때 
# 컬럼이나 테이블 뒤에 'AS'를 붙여 별칭을 부여할 수 있음
SELECT board_number AS '게시물 번호', writer_email AS '작성자 이메일'
FROM board AS B;

# Inner Join
# 두 테이블에서 조건에 일치하는 레코드를 반환
# SELECT column1, ... FROM table1 
# INNER JOIN table2
# ON table1.column1 = table2.column1;

# 게시글을 쓴 사용자만 보여줘 (email이 3개, email2가 0개, email3가 1개 썼기 때문에 email과 email3만 나올거임)
SELECT * FROM user
INNER JOIN board
ON user.email = board.writer_email;

# LEFT OUTER JOIN
# from에 위치한 테이블의 모든 레코드와 join으로 붙은 테이블에서 조건에 일치하는 레코드를 반환 
# join으로 붙은 테이블에서 일치하는 레코드가 없다면 null을 반환

SELECT * FROM user
LEFT OUTER JOIN board
ON user.email = board.writer_email;

# RIGHT OUTER JOIN 
# join으로 붙은 테이블의 모든 레코드와 from에 위치한 테이블에서 조건에 일치하는 레코드를 반환
# from에 위치한 테이블에서 일치하는 레코드가 없다면 null을 반환

SELECT * FROM user
RIGHT OUTER JOIN board
ON user.email = board.writer_email;

# FULL OUTER JOIN
# 두 테이블의 모든 레코드를 반환하고 각각에 일치하는 레코드가 없으면 null을 반환 

-- SELECT * FROM user
-- FULL JOIN board
-- ON user.email = board.writer_email;

SELECT * FROM user LEFT OUTER JOIN board
ON user.email = board.writer_email
UNION
SELECT * FROM user RIGHT OUTER JOIN board
ON user.email = board.writer_email;

# 최신 게시물
# 게시물 번호 / 게시물 제목 / 게시물 내용 / 게시물 이미지 / 조회수 / 작성일 
# 작성자 프로필 사진 / 작성자 닉네임 [/ 댓글 수 / 좋아요 수] 

SELECT 
	b.board_number AS board_number,
    b.title, 
    b.content, 
    b.image, 
    b.view_count, 
    b.write_datetime,
    u.profile_image, 
    u.nickname
FROM board AS b
INNER JOIN user AS u
ON b.writer_email = u.email
ORDER BY write_datetime DESC;

# 서브쿼리 
# SQL 문 내부에 작성되는 또 다른 쿼리를 지칭
# 서부쿼리를 이용하면 복잡한 검색 조건을 사용 할 수 있음 

# WHERE 절에서 서브쿼리

# 예시 : nickname이 nickname1인 유저가 작성한 게시물의 전체 컬럼을 검색
SELECT * FROM board
WHERE board.writer_email IN (
	SELECT email FROM user WHERE nickname = 'nickname1'
);

SELECT * FROM board
LEFT OUTER JOIN user
ON board.writer_email = user.email
WHERE nickname = 'nickname1';

# SELECT 절에서 서브쿼리 사용

SELECT board_number,
	(SELECT nickname FROM user WHERE email = 'email@email.com') AS nickname
FROM board
WHERE writer_email = 'email@email.com';

# FROM 절에서 서브쿼리 사용

SELECT * FROM (SELECT * FROM user WHERE address = '부산광역시 부산진구') AS T1;

SELECT * FROM board
INNER JOIN (SELECT * FROM user WHERE address = '부산광역시 부산진구') AS T1
ON board.writer_email = T1.email;

# VIEW 
# 복잡한 SELECT 문을 특정한 이름으로 지정해놓은 스키마 (READ-ONLY) 
# 읽기 전용의 '가상' 테이블 

# REEATE VIEW view_name AS (SELECT ~);
CREATE VIEW latest_board AS
(
	SELECT 
		b.board_number AS board_number, b.title, b.content, b.image, b.view_count, b.write_datetime,
		u.profile_image, u.nickname
	FROM board AS b
	INNER JOIN user AS u
	ON b.writer_email = u.email
	ORDER BY write_datetime DESC
);

SELECT * FROM latest_board;

# 집계 함수 
# 여러 행의 데이터를 그룹화하여 하나의 결과를 반환하는 함수 (일반적으로 수를 연산)

# count() 
# 행의 갯수 반환 
SELECT count(*) FROM user;
# 특정 조건으로 검색
SELECT count(*) FROM user WHERE email = 'email@email.com';
# 특정 컬럼으로 검색 
SELECT count(profile_image), count(email) FROM user;

# MAX, MIN
# 특정 컬럼의 최대, 최소 값을 구함 
SELECT MAX(view_count), MIN(view_conut) FROM board;

USE sample_database;

# GROUP BY
# SELECT 문에서 반환되는 행들을 하나 이상의 컬럼을 기준으로 그룹화 할때 사용
SELECT * FROM namgu;
SELECT 해체제거업자사업체명, count(해체제거업자사업체명) FROM namgu
GROUP BY 해체제거업자사업체명;

SELECT 해체제거업자사업체명, 공사현장명, count(해체제거업자사업체명) FROM namgu
GROUP BY 해체제거업자사업체명, 공사현장명;

# HAVING
# GROUP BY 결과에 조건을 걸어서 출력(필터링)을 하기위한 구문 
# WHERE 절과 비슷한 사용 방법을 가지고 있음 
# WHERE 절과의 차이는 WHERE 절은 실제 데이터(테이블 자체)에서 조건을 걸고 
# HAVING 절은 SELECT의 결과에서 조건에 해당하는 데이터를 출력 

SELECT 해체제거업자사업체명, count(해체제거업자사업체명) AS 업체수 FROM namgu
WHERE 해체시작년월일 <= '2022-06-30'
GROUP BY 해체제거업자사업체명
HAVING 업체수 <= 3;

# LIMIT
# SELECT 결과에 갯수 제한을 걸때 사용하는 키워드
SELECT 해체제거업자사업체명, count(해체제거업자사업체명) AS 업체수 FROM namgu
WHERE 해체시작년월일 <= '2022-06-30'
GROUP BY 해체제거업자사업체명
HAVING 업체수 <= 3
ORDER BY 업체수 DESC
LIMIT 5;





















