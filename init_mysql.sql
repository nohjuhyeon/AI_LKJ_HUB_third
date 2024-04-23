-- Create a new database
CREATE DATABASE IF NOT EXISTS spring_mysql;

-- Use the created database
USE spring_mysql;

-- Create a new table

CREATE TABLE AUTH_NAMES
(
  AUTH_NAME VARCHAR(200) NOT NULL COMMENT '접근권한명',
  UNIQUE_ID VARCHAR(200) NOT NULL COMMENT '접근권한 대표값',
  PRIMARY KEY (UNIQUE_ID)
) COMMENT '접근권한명';

CREATE TABLE AUTHS
(
  UNIQUE_ID_USERS      VARCHAR(200) NOT NULL COMMENT '대표값',
  UNIQUE_ID_AUTH_NAMES VARCHAR(200) NOT NULL COMMENT '접근권한 대표값',
  PRIMARY KEY (UNIQUE_ID_USERS, UNIQUE_ID_AUTH_NAMES)
) COMMENT '권한들';

CREATE TABLE USERS
(
  UNIQUE_ID VARCHAR(200) NOT NULL COMMENT '대표값',
  NAME      VARCHAR(200) NOT NULL COMMENT '이름',
  PASSWORD  VARCHAR(200) NOT NULL COMMENT '암호화',
  EMAIL     VARCHAR(200) NOT NULL COMMENT '이메일',
  JOB       VARCHAR(200) NULL     COMMENT '직책',
  PRIMARY KEY (UNIQUE_ID)
) COMMENT '사용자들';

ALTER TABLE AUTHS
  ADD CONSTRAINT FK_USERS_TO_AUTHS
    FOREIGN KEY (UNIQUE_ID_USERS)
    REFERENCES USERS (UNIQUE_ID);

ALTER TABLE AUTHS
  ADD CONSTRAINT FK_AUTH_NAMES_TO_AUTHS
    FOREIGN KEY (UNIQUE_ID_AUTH_NAMES)
    REFERENCES AUTH_NAMES (UNIQUE_ID);

-- 공통코드
CREATE TABLE COMMONS_CODE
(
	-- 공통 코드_ID(사용자 입력 가능)
	COMMON_CODE_ID varchar(40) NOT NULL COMMENT '공통 코드_ID',
	-- 명칭
	NAME varchar(1000) NOT NULL COMMENT '명칭',
	-- 정렬순서
	ORDER_NUMBER decimal COMMENT '정렬순서',
	-- 속성_1 
	ATTRIBUTION_1 varchar(60) COMMENT '속성_1',
	-- 속성_2
	ATTRIBUTION_2 varchar(60) COMMENT '속성_2',
	DESCRIPTION varchar(1000) COMMENT '코드설명',
	-- 삭제불가(초기 시스템 코드 or 카테고리)
	SYSTEM_CODE_YN varchar(40) DEFAULT 'N' NOT NULL COMMENT '초기 시스템 코드 여부',
	-- 사용 여부
	USE_YN varchar(40) NOT NULL COMMENT '사용 여부',
	-- 공통 코드_ID(사용자 입력 가능)
	PARENT_COMMON_CODE_ID varchar(40) COMMENT '상위 공통 코드 ID',
	-- 등록자SEQ
	REGISTER_SEQ varchar(50) NOT NULL COMMENT '등록자SEQ',
	-- 등록일자
	REGISTRY_DATE varchar(20) NOT NULL COMMENT '등록일자',
	MODIFIER_SEQ varchar(40) NOT NULL COMMENT '수정자_SEQ',
	-- 수정일자
	MODIFY_DATE varchar(20) NOT NULL COMMENT '수정일자',
	PRIMARY KEY (COMMON_CODE_ID)
) COMMENT = '공통코드';

-- Insert values into the table
INSERT INTO AUTH_NAMES (AUTH_NAME, UNIQUE_ID)
VALUES
  ('ADMIN', 'ADMIN_ID'),
  ('MANAGER', 'MANAGER_ID'),
  ('CUSTOMER', 'CUSTOMER_ID');

INSERT INTO USERS (UNIQUE_ID, NAME, PASSWORD, EMAIL, JOB)
VALUES
  ('USER_ID_1', 'John Doe', 'password123', 'john.doe@example.com', 'Developer'),
  ('USER_ID_2', 'Jane Smith', 'password456', 'jane.smith@example.com', 'Manager'),
  ('USER_ID_3', 'Bob Johnson', 'password789', 'bob.johnson@example.com', 'Customer'),
  ('USER_ID_4', 'Alice Williams', 'passwordabc', 'alice.williams@example.com', 'Admin');

INSERT INTO AUTHS (UNIQUE_ID_USERS, UNIQUE_ID_AUTH_NAMES)
VALUES
  ('USER_ID_1', 'ADMIN_ID'),
  ('USER_ID_2', 'MANAGER_ID'),
  ('USER_ID_3', 'CUSTOMER_ID'),
  ('USER_ID_4', 'ADMIN_ID'),
  ('USER_ID_4', 'CUSTOMER_ID'),
  ('USER_ID_4', 'MANAGER_ID');

insert into COMMONS_CODE 
(COMMON_CODE_ID,NAME,ORDER_NUMBER,ATTRIBUTION_1,ATTRIBUTION_2,DESCRIPTION,SYSTEM_CODE_YN,USE_YN,PARENT_COMMON_CODE_ID,REGISTER_SEQ,REGISTRY_DATE,MODIFIER_SEQ,MODIFY_DATE) 
select 'CarInforSearch','CarInfor Search',1,NULL,NULL,'CarInfor Search','System_Code_Yes','Yes',NULL,'UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'YEAR','per YEAR',1,NULL,NULL,'Using Yes','System_Code_Yes','Yes','CarInforSearch','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'CAR_NAME','per CAR_NAME',2,NULL,NULL,'Using No','System_Code_Yes','Yes','CarInforSearch','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'Use_YN','Yes or No',1,NULL,NULL,'Using Yes or No','System_Code_Yes','Yes',NULL,'UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'Yes','Yes',1,NULL,NULL,'Using Yes','System_Code_Yes','Yes','Use_YN','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'No','No',2,NULL,NULL,'Using No','System_Code_Yes','Yes','Use_YN','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'System_Code_YN','Sytem Yes or No',1,NULL,NULL,'Sytem Using Yes or No','System_Code_Yes','Yes',NULL,'UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'System_Code_Yes','Yes',1,NULL,NULL,'Sytem Using Yes','System_Code_Yes','Yes','System_Code_YN','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual union all 
select 'System_Code_No','No',2,NULL,NULL,'Sytem Using No','System_Code_Yes','Yes','System_Code_YN','UUID-1111-1111111',now(),'UUID-1111-1111111',now() from dual 
; 