DROP DATABASE IF EXISTS metadatadatabaseempty;
CREATE DATABASE metadatadatabaseempty;
DROP DATABASE IF EXISTS metadatadatabase;
CREATE DATABASE metadatadatabase;

DROP SCHEMA IF EXISTS metadatadb;
CREATE SCHEMA metadatadb;
SET search_path TO metadatadb;

DROP TABLE IF EXISTS OFFICES;
CREATE TABLE OFFICES (
  OFFICECODE varchar(10) NOT NULL,
  PRIMARY KEY (OFFICECODE)
);

DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES (
  EMPLOYEENUMBER bigint PRIMARY KEY,
  LASTNAME varchar(50) NOT NULL,
  FIRSTNAME varchar(50) NOT NULL,
  EXTENSION varchar(10) NOT NULL,
  EMAIL varchar(100) NOT NULL,
  OFFICECODE varchar(10) NOT NULL,
  REPORTSTO bigint DEFAULT NULL,
  JOBTITLE varchar(50) NOT NULL,
  CONSTRAINT CHK_EmpNums CHECK (EMPLOYEENUMBER>0 AND REPORTSTO>0),
  CONSTRAINT FK_EmployeesManager FOREIGN KEY (REPORTSTO) REFERENCES EMPLOYEES(EMPLOYEENUMBER),
  CONSTRAINT FK_EmployeesOffice FOREIGN KEY (OFFICECODE) REFERENCES OFFICES(OFFICECODE)
);

DROP PROCEDURE IF EXISTS getEmpsName;
CREATE PROCEDURE getEmpsName(IN EMPNUMBER bigint, INOUT FNAME VARCHAR(20))
language plpgsql
as $$
BEGIN
   SELECT FIRSTNAME INTO FNAME
   FROM EMPLOYEES
   WHERE EMPLOYEENUMBER = EMPNUMBER;
END; $$

DROP PROCEDURE IF EXISTS getEmpsEmail;
CREATE PROCEDURE getEmpsEmail(IN EMPNUMBER bigint, INOUT EMPEMAIL VARCHAR(20))
language plpgsql
as $$
BEGIN
   SELECT EMAIL INTO EMPEMAIL
   FROM EMPLOYEES
   WHERE EMPLOYEENUMBER = EMPNUMBER;
END; $$
