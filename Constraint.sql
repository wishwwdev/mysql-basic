# Constraint (제약조건)
# 각 테이블의 각 컬럼에 적용이 되는 데이터 입력 및 수정에 대한 규칙을 정의
# 제약조건을 통해서 DBMS의 무결성을 보장해 줌

# NOT NULL
# NOT NULL 제약조건이 지정되어있는 컬럼에는 삽입 및 수정 작업에서 필수로
# 데이터를 입력해야 함
CREATE TABLE not_null_table (
	column1 INT,
    column2 INT,
    not_null_column INT NOT NULL
);

INSERT INTO not_null_table (column1, column2, not_null_column) 
VALUES (1, 2, 3);

UPDATE not_null_table SET not_null_column = null;

# UNIQUE
# UNIQUE 제약조건이 지정되어 있는 컬럼에는 각 레코드에서 해당하는 컬럼 값을 
# 중복하여 삽입 혹은 수정할 수 없음
CREATE TABLE unique_table (
	column1 INT,
    unique_column INT UNIQUE
);

INSERT INTO unique_table VALUES (1, 2);

UPDATE unique_table SET unique_column = 2;

# UNIQUE 제약조건을 적용하면 해당 컬럼에 INDEX가 자동으로 생성됨
SELECT * FROM unique_table WHERE column1 = 1;
SELECT * FROM unique_table WHERE unique_column = 1;

# Candidate key (후보키)
# 각 레코드를 구분할 수 있은 키로 중복을 허용하지 않고 필수로 값을 가지고 있어야 함
CREATE TABLE candidate_table (
	candidate_column1 INT NOT NULL UNIQUE,
    candidate_column2 INT NOT NULL UNIQUE,
    column1 INT
);

INSERT INTO candidate_table VALUES (1, 1, 1);
INSERT INTO candidate_table VALUES (2, 22, 1);

SELECT * FROM candidate_table;

# PRIMARY KEY (기본키)
# PRIMARY KEY 제약 조건이 지정되어 있는 컬럼은 해당 레코드를 유일하게 식별하는 컬럼이 됨
# PRIMARY KEY는 후보키 중 선택된 하나의 컬럼이 PRIMARY KEY가 됨
# PRIMARY KEY 제약 조건이 지정되어 있는 컬럼은 NOT NULL, UNIQUE 제약조건을 포함하고 있음 
CREATE TABLE primary_table_1 (
	primary_column INT PRIMARY KEY,
    column1 INT
);

INSERT INTO primary_table_1 (column1) VALUES (1);
INSERT INTO primary_table_1 VALUES (1, 1);
INSERT INTO primary_table_1 VALUES (2, 1);

UPDATE primary_table_1 SET primary_column = null;
UPDATE primary_table_1 SET primary_column = 1;

# CONSTRAINT 명령어를 이용한 제약조건 지정 
# [CONSTRAINT 제약조건명] 제약조건 (colmn1, ...)
CREATE TABLE primary_table_2 (
	primary_column INT,
    column1 INT,
    CONSTRAINT primary_table_2_pk
    PRIMARY KEY (primary_column)
);

# CHECK
# CHECK 제약조건이 지정되어 있는 컬럼에는 삽입 및 수정 작업시에 
# 데이터의 유효성을 검증함
CREATE TABLE check_table (
	check_column INT CHECK (check_column < 10),
    colum_1 INT
);

INSERT INTO check_table  VALUES (10, 10);
INSERT INTO check_table  VALUES (1, 10);

UPDATE check_table SET check_column = 10;

# DEFAULT
# DEFAULT 제약조건이 지정되어있는 컬럼에 삽입 작업시에 
# 값을 지정하지않으며 (null이 지정될때) 삽입될 기본값을 명시함
CREATE TABLE default_table (
	default_column INT DEFAULT 10,
    column_1 INT
);

SELECT * FROM default_table;

INSERT INTO default_table (column_1) VALUES (1);
INSERT INTO default_table VALUES (20, 1);

UPDATE default_table SET default_column = null;

# FOREIGN KEY
# FOREIGN KEY 제약조건이 지정되어있는 컬럼은 외부 테이블의 PRIMARY KEY와 연결되어 있음을 나타냄
# FOREIGN KEY 제약조건으로 테이블간의 관계를 지어줌

# 1. 만약 테이블을 삭제하려고 할때 만약 해당 테이블을 잠조하고 있는 테이블이 있다면
# 	 삭제할 수 없음 
# 2. 특정 컬럼에 참조제약조건을 지정하려한다면 참조하는 컬럼의 데이터타입과 일치해야함(당연한 말임)
# 3. 피참조 테이블의 수정 및 삭제 작업 시에 해당 컬럼의 값을 참조하고 있는 테이블이 있다면 
# 	 수정 및 삭제 작업이 실패

# CONSTRAINT 제약조건명 FOREIGN KEY (외래키로 지정할 컬럼)
# REFERENCES 참조할테이블명 (참조할컬럼명)
CREATE TABLE super_table (
	primary_column INT PRIMARY KEY,
    column_1 INT
);

CREATE TABLE sub_table (
	column_1 INT,
    column_2 INT,
    CONSTRAINT sub_table_fk
    FOREIGN KEY (column_2) 
    REFERENCES super_table (primary_column)
);

SELECT * FROM super_table;

# FOREIGN KEY 제약조건이 지정되어있는 컬럼의 값은
# 참조하고 있는 테이블의 컬럼에 있는 데이터만 지정할 수 있음
INSERT INTO super_table VALUES (1, 1);
INSERT INTO super_table VALUES (2, 2);
INSERT INTO super_table VALUES (3, 3);
INSERT INTO sub_table VALUES (1, 1);

DELETE FROM super_table WHERE primary_column = 2;
UPDATE super_table SET primary_column = 5 WHERE primary_column = 2;

UPDATE sub_table SET column_2 = 10;

DROP TABLE super_table;

# 3 제한에 대한 해결 방안 
# ON UPDATE, ON DELETE 
# ON UPDATE : 참조하고 있는 데이터가 수정이 됐을 때의 작업 
# ON DELETE : 참조하고 있는 데이터가 삭제가 됐을 때의 작업

# CASCADE : 참조하고 있는 데이터가 수정 또는 삭제가 됐을 때 
# 			참조하는 레코드에서도 삭제 및 수정이 이뤄짐 
# SET NULL : 참조하고 있는 데이터가 수정 또는 삭제가 됐을 때 
#			 참조하는 레코드의 해당 컬럼 값을 null로 지정 
# RESTRICT : 참조하고 있는 데이터에서 수정 또는 삭제가 불가능하게 지정

CREATE TABLE sub_table_2 (
	column_1 INT,
    column_2 INT,
    CONSTRAINT sub_table_2_fk
    FOREIGN KEY (column_2) 
    REFERENCES super_table (primary_column)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

SELECT * FROM sub_table_2;
SELECT * FROM super_table;

INSERT INTO sub_table_2 VALUES (3, 3);
UPDATE super_table 
SET primary_column = 10 
WHERE primary_column = 3;

DELETE FROM super_table WHERE primary_column = 10;














