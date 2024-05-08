-- Create a new database
CREATE DATABASE IF NOT EXISTS cocolang;

-- Use the created database
USE cocolang;

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

CREATE TABLE COMPANIES (
    COMPANY_ID INT PRIMARY KEY,
    COMPANY_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE CAR_INFORS (
    CAR_NAME VARCHAR(255) NOT NULL,
    YEAR INT NOT NULL,
    CAR_INFOR_ID INT PRIMARY KEY,
    COMPANY_ID INT,
    FOREIGN KEY (COMPANY_ID) REFERENCES COMPANIES(COMPANY_ID)
);

CREATE TABLE factorys (
    FACTORY_ID INT PRIMARY KEY,
    FACTORY_NAME VARCHAR(255) NOT NULL,
    LOCATION VARCHAR(255),
    COMPANY_ID INT,
    FOREIGN KEY (COMPANY_ID) REFERENCES COMPANIES(COMPANY_ID)
);

-- Insert values into the table
INSERT INTO AUTH_NAMES (AUTH_NAME, UNIQUE_ID)
VALUES
  ('ADMIN', 'ROLE_ADMIN'),
  ('MANAGER', 'ROLE_MANAGER'),
  ('MEMBER', 'ROLE_MEMBER');

INSERT INTO USERS (UNIQUE_ID, NAME, PASSWORD, EMAIL, JOB)
VALUES
  ('USER_ID_1', 'John Doe', '$2a$10$yTdTDAA/vogepOFCO3WDa.n41.ZoQQH0TlL8WV2J3b8qbF1uU.n5.', 'john.doe@example.com', 'Developer'),
  ('USER_ID_2', 'Jane Smith', '$2a$10$yTdTDAA/vogepOFCO3WDa.n41.ZoQQH0TlL8WV2J3b8qbF1uU.n5.', 'jane.smith@example.com', 'Manager'),
  ('USER_ID_3', 'Bob Johnson', '$2a$10$yTdTDAA/vogepOFCO3WDa.n41.ZoQQH0TlL8WV2J3b8qbF1uU.n5.', 'bob.johnson@example.com', 'Member'),
  ('USER_ID_4', 'Alice Williams', '$2a$10$yTdTDAA/vogepOFCO3WDa.n41.ZoQQH0TlL8WV2J3b8qbF1uU.n5.', 'alice.williams@example.com', 'Admin');

INSERT INTO AUTHS (UNIQUE_ID_USERS, UNIQUE_ID_AUTH_NAMES)
VALUES
  ('USER_ID_1', 'ROLE_ADMIN'),
  ('USER_ID_2', 'ROLE_MANAGER'),
  ('USER_ID_3', 'ROLE_MEMBER'),
  ('USER_ID_4', 'ROLE_ADMIN'),
  ('USER_ID_4', 'ROLE_MEMBER'),
  ('USER_ID_4', 'ROLE_MANAGER');


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

INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (1, 'Hyundai');
INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (2, 'Tesla');
INSERT INTO COMPANIES (COMPANY_ID, COMPANY_NAME) VALUES (3, 'Toyota');

INSERT INTO CAR_INFORS (CAR_NAME, YEAR, CAR_INFOR_ID, COMPANY_ID) VALUES 
('Hyundai Sonata', 2020, 1, 1),
('Tesla Model S', 2021, 2, 2),
('Toyota Camry', 2019, 3, 3),
('Kia Optima', 2018, 4, 1),
('Tesla Model X', 2021, 5, 2),
('Toyota Corolla', 2018, 6, 3),
('Hyundai Elantra', 2019, 7, 1),
('Kia Sorento', 2020, 8, 1),
('Tesla Model 3', 2021, 9, 2),
('Toyota Prius', 2017, 10, 3),
('Hyundai Tucson', 2021, 11, 1),
('Kia Sportage', 2019, 12, 1),
('Tesla Model Y', 2021, 13, 2),
('Toyota RAV4', 2020, 14, 3),
('Hyundai Santa Fe', 2018, 15, 1),
('Kia Telluride', 2021, 16, 1),
('Tesla Roadster', 2022, 17, 2),
('Toyota Highlander', 2019, 18, 3),
('Hyundai Kona', 2020, 19, 1),
('Kia Forte', 2018, 20, 1);

INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (1, 'Hyundai Ulsan Plant', 'Ulsan', 1);
INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (2, 'Tesla Fremont Factory', 'California', 2);
INSERT INTO factorys (FACTORY_ID, FACTORY_NAME, LOCATION, COMPANY_ID) VALUES (3, 'Toyota Kentucky Plant', 'Kentucky', 3);
