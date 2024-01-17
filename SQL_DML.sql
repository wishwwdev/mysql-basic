# DML (Data Manipulation Language - 데이터 조작어)
# 실제 데이터를 삽입, 수정, 삭제, 검색을 할 때 사용되는 명령어

# INSERT
# 테이블에 레크드(실제 데이터)를 삽입할 때 사용하는 명령어

# 1. INSERT INTO 테이블명 VALUES (value1, value2, ...);
# 2. INSERT INTO 테이블명 (column1, column2, ...) VALUES (value1, value2, ...);

# 1번 삽입 명령어: 해당 테이블의 모든 컬럼의 순서대로 데이터를 삽입하는 명령어
#				데이터를 데이블의 컬럼의 순서에 맞게 모두 입력을 해야함
# 2번 삽입 명령어: 해당 테이블의 지정한 컬럼에 대해서 데이터를 삽입하는 명령어
#				삽입하고자 하는 컬럼의 순서에 맞게 매핑하여 데이터를 입력 해야함
#				지정한 컬럼의 수와 데이터의 수가 같아야하고 데이터의 타입도 같아야함
#				필수 값으로 지정이 되어있다면 무조건 입력을 해야함
INSERT INTO sample_table VALUES (1, 1.0, false, '문자열', 'TEXT', '2023-06-26', '15:04:00','2023-06-26 15:04:00');
INSERT INTO sample_table (column1, column2) VALUES (1, 3.14);
INSERT INTO sample_table (column2) VALUES (2.5);

# SELECT
# 테이블에서 데이터를 검색할 때 사용하는 명령어

# 1. SELECT column1, column2, ... FROM 테이블명;
# 2. SELECT * FROM 테이블명;
# 3. SELECT column1, column2, ... FROM 테이블명 WHERE 조건;

# 1번 검색 명령어 : 해당 테이블에서 선택한 컬럼에 대히서만 데이터를 검색
# 2번 검생 명령어 : 해당 테이블에서 모든 데이터를 검색
# 3번 검색 명령어 : 해당 테이블에서 특정한 조건에 만족하는 데이터만 검색

SELECT column1, column2 FROM sample_table;
SELECT * FROM sample_table;
SELECT * FROM sample_table WHERE column2 > 1;

# UPDATE
# 데이블에서 레크드 혹은 필드(데이터)를 수정할 때 사용하는 명령어

# UPDATE 테이블명 SET column1 = value1, ... [WHERE 조건]

# 변경하고자 하는 컬럼에 대해서 값을 지정하는 것
# WHERE 문이 지정되지 않으면 모든 데이터에 대해서 수정 작업이 이루어짐

UPDATE sample_table SET column3 = true;
# 삽입 혹은 수정 작업을 할 때는 삽입하려는 컬럼의 데이터의 길이를 주의해야함
UPDATE sample_table SET column4 = '수정 문자열' WHERE column4 IS NULL;

# DELETE
# 테이블에서 특정 혹은 전체 레코드를 삭제할 때 사용하는 명령어

# DELETE FROM 테이블명 [WHERE 조건];

# 해당 테이블에서 데이터를 삭제함, 만약 WHERE 조건을 입력하지 않으면 해당 테이블의 모든 데이터가 삭제됨

DELETE FROM sample_table WHERE column2 = 3.14;
DELETE FROM sample_table;

# TRUNCATE TABLE 테이블명;
# 모든 데이터를 삭제하는 것 뿐만 아니라 해당 테이블을 초기 상태로 되돌려 놓음
TRUNCATE TABLE sample_table;

# WHERE
# DML 중 검색 수정, 삭제에 대해서 특정한 조건에 부합하는 레코드에 대해서만
# 작업이 이루어지도록 하는 연산자

# WHERE 조건을 잘 적는 것만으로도 대부분의 자겁을 수월하게 할 수 있음
# WHERE 조건에는 비교연산자 / 논리 연산자가 들어옴

# SQL의 연산자
# 비교연산자
# = : 좌항이 우항과 같은지를 비교 
# !=, <> : 좌항이 우항과 다른지를 비교
# <, <= : 좌항이 우항보다 작은지, 작거나 같은지를 비교
# >, >= : 좌항이 우항보다 큰지, 크거나 같은지를 비교
# <=> : 좌항과 우항이 모두 null이면 true, 하나라도 unll이 아니면 false
# IS : 좌항이 우항과 같은지를 비교 (true, false, unknown 일 때)
# IS NOT : 좌항이 우항과 다른지를 비교 (true, false, unknown 일 때)
# IS NULL : 좌항이 null이면 true, null이면 false
# BETWEEN min AND max : 좌항이 min보다 크거나 같으면서 max보다 작거나 같으면 true, 아니면 false
# NOT BETWEEN min AND max : 좌항이 min보다 작으면서 max보다 크면 true, 아니면 false
# IN() : 인자로 전달된 리스트가 값이 존재하면 true, 아니면 false
# NOT IN() : 인자로 전달된 리스트의 값이 존재하지 않으면 true, 존재하면 false

SELECT * FROM namgu;
UPDATE namgu SET 변경사유발생일자 = null WHERE 변경사유발생일자 = '';
# UPDATE namgu SET '면적_부피_길이(제곱미터)' = null WHERE '면적_부피_길이(제곱미터)' = '';
UPDATE namgu SET 위치_소재지 = '변경 소재지' WHERE 해체제거업자사업체명 = '우성건설' AND 순번 = 3;

# 해체제거업자사업체명이 '우성건설'인 데이터의 '건물명_설비명', '위치_소재지'을 검색
SELECT 건물명_설비명, 위치_소재지 FROM namgu WHERE 해체제거업자사업체명 = '우성건설';

# 해체제거업자사업체명이 '우성건설'이 아닌 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 해체제거업자사업체명 != '우성건설';
SELECT * FROM namgu WHERE 해체제거업자사업체명 <> '우성건설';

# 순번이 5보다 작은 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 순번 < 5;

# 변경사유발생일자와 면적_부피_길이(제곱미터)가 모두 null인 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE '변경사유발생일자' <=> '면적_부피_길이(제곱미터)';

# 변경사유발생일자의 데이터가 아직 지정되어있지 않은 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 변경사유발생일자 IS NULL;

# 변경사유발생일자의 데이터가 아직 지정되어있는 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 변경사유발생일자 IS NOT NULL;

# 순번이 2 ~ 5 사이인 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 순번 BETWEEN 2 AND 5;

# 해체시작년월일이 2022-05-01 ~ 2022-06-30 사이인 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 해체시작년월일 BETWEEN '2022-05-01' AND '2022-06-30';

# 해체시작년월일이 2022-05-01 ~ 2022-06-30 사이가 아닌 데이터의 모든 컬럼을 검색
SELECT * FROM namgu WHERE 해체시작년월일 NOT BETWEEN '2022-05-01' AND '2022-06-30';

# 논리연산자
# AND, && : 좌항과 우항이 모두 true일 때 true를 반환, 아니면 false를 반환
# OR, || : 좌항과 우항 중 하나라도 true일 때 true를 반환, 아니면 false를 반환
# XOR : 좌항과 우항이 서로 다르면 true를 반환, 같으면 false
# NOT, | : 우항이 true면 false를 반환, true면 false를 반환

# 해체제거업자사업체명이 '성수개발'이거나 '우성건설'이거나 '고은산업'인 데이터의 모든 컬럼을 검색
SELECT * 
FROM namgu 
WHERE 해체제거업자사업체명 = '성수개발' 
OR 해체제거업자사업체명 = '우성건설' 
OR 해체제거업자사업체명 = '고은산업';

SELECT * FROM namgu WHERE 해체제거업자사업체명 IN('성수개발', '우성건설', '고은산업');
SELECT * FROM namgu WHERE 해체제거업자사업체명 NOT IN('성수개발', '우성건설', '고은산업');

# DISTINCT : 컬럼 검색 결과의 조합의 중복을 제거
SELECT DISTINCT 해체제거업자사업체명 FROM namgu;
SELECT DISTINCT 건물명_설비명, 위치_소재지 FROM namgu WHERE 해체제거업자사업체명 = '우성건설';

# 패턴매칭 LIKE
# 특정 패턴을 포함하는 데이터만 검색하기 위해 사용하는 연산자

# 와일드카드
# % : 0개 이상의 문자
# _ : 1개의 문자

# '(%,_)특정패턴문자(%,_)'
# 1. '%용호%' : 앞뒤 어떠한 문자가 오든 '용호'라는 단어가 포함되어 있으면 true
# 2. '%용호' : 앞 어떠한 문자가 오든 '용호'라는 단어로 끝나면 true
# 3. '용호%' : 뒤 어떠한 문자가 오든 '용호'라는 단어로 시작하면 true
# 4. '_용호_' : 앞뒤에 한 문자가 오고 '용호'라는 단어를 포함하고 길이가 4면 true
# 5. '_용호' : 앞에 한 문자가 오고 '용호'라는 단어를 포함하고 길이가 3이면 true
# 6. '용호_' : 뒤에 한 문자가 오고 '용호'라는 단어를 포함하고 길이가 3이면 true

# 위치_소재지에 '용호로'가 포함되어 있는 데이터의 전체 컬럼을 검색
SELECT * FROM namgu WHERE 위치_소재지 LIKE '%용호로%';

# 해체제거업자사업체명이 '(주)'로 시작하는 데이터의 전체 컬럼을 검색
SELECT * FROM namgu WHERE 해체제거업자사업체명 LIKE '(주)%';

SELECT * FROM namgu WHERE 해체제거업자사업체명 LIKE '%주%';
SELECT * FROM namgu WHERE 해체제거업자사업체명 LIKE '_주%';

# 해체시작년월일 중 6월달인 데이터의 전체 컬럼울 검색
SELECT * FROM namgu WHERE 해체시작년월일 LIKE '_____06___';
SELECT * FROM namgu WHERE 해체시작년월일 LIKE '%-06-%';

# SORT 문 
# 특정 컬럼을 기준으로 정렬 된 결과를 보고자 할 때 사용
# ASC : 오름차순 정렬
# DESC : 내림차순 정렬

# SORT 컬럼 (ASC / DESC), ...
# ASC는 생략 가능하고 만약 여러 개의 컬럼을 SORT문에 지정했다면 먼저 작성한 컬럼 순으로 정렬
SELECT * FROM namgu ORDER BY 해체시작년월일;
SELECT * FROM namgu ORDER BY 해체시작년월일 DESC;

SELECT 건물명_설비명, 순번 FROM namgu ORDER BY 건물명_설비명, 순번 DESC;
SELECT 건물명_설비명, 순번 FROM namgu ORDER BY 순번 DESC, 건물명_설비명;


