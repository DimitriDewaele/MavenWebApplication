-- LOGIN as DataBase Administrator
-- Cleanup database before start
DROP USER feesboekDB CASCADE;
DROP TABLESPACE feesboekDB_perm INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE feesboekDB_temp INCLUDING CONTENTS AND DATAFILES;

-- Create Space on Disk for the database
CREATE TABLESPACE feesboekDB_perm
  DATAFILE 'feesboekDB_perm.dat' 
    SIZE 20M
  ONLINE;
  
CREATE TEMPORARY TABLESPACE feesboekDB_temp
  TEMPFILE 'feesboekDB_temp.dbf'
    SIZE 5M
    AUTOEXTEND ON;

-- Create Database Schema
-- (Creating a user creates the same database schema)
CREATE USER feesboekDB
  IDENTIFIED BY feesboekDB
  DEFAULT TABLESPACE feesboekDB_perm
  TEMPORARY TABLESPACE feesboekDB_temp
  QUOTA 20M on feesboekDB_perm;
  
-- Grant rights to the user
GRANT CREATE session TO feesboekDB;
GRANT CREATE table TO feesboekDB;
GRANT CREATE view TO feesboekDB;
GRANT CREATE any trigger TO feesboekDB;
GRANT CREATE any procedure TO feesboekDB;
GRANT CREATE sequence TO feesboekDB;
GRANT CREATE synonym TO feesboekDB;
GRANT CONNECT TO feesboekDB;

-- login with the new user and create databases.
-- !!!! REPEAT: Login with new user
CREATE TABLE COUNTRIES ( 
    COUNTRY_ID NUMBER(10) NOT NULL,
    COUNTRY_ISO_CODE CHAR(2 BYTE) NOT NULL,
    COUNTRY_NAME VARCHAR2(256) NOT NULL,
    CONSTRAINT PK_COUNTRY_ID PRIMARY KEY (COUNTRY_ID)
);
CREATE TABLE USERS (
    USER_ID NUMBER(10) NOT NULL,
    COUNTRY_ID NUMBER(10),
    USERNAME VARCHAR(256) NOT NULL,
    FIRSTNAME VARCHAR(256),
    LASTNAME VARCHAR(256),
    CONSTRAINT PK_USER_ID PRIMARY KEY (USER_ID),
    CONSTRAINT FK_COUNTRY_ID FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID),
    CONSTRAINT UNIQUE_USER_NAME UNIQUE (USERNAME)
);
CREATE TABLE MESSAGES (
    MESSAGE_ID NUMBER(10) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    TITLE VARCHAR(128),
    MESSAGE VARCHAR(1024),
    SUBMIT_TIME TIMESTAMP WITH TIME ZONE,
    CONSTRAINT PK_MESSAGE_ID PRIMARY KEY (MESSAGE_ID),
    CONSTRAINT FK_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID)
);

-- Create Database USer
GRANT SELECT, INSERT, UPDATE, DELETE ON USERS TO feesboekDB;
GRANT SELECT, INSERT, UPDATE, DELETE ON MESSAGES TO feesboekDB;

INSERT INTO COUNTRIES VALUES(1,'BE','Belgium');
INSERT INTO COUNTRIES VALUES(2,'NL','Netherlands');
INSERT INTO COUNTRIES VALUES(3,'FR','France');
INSERT INTO COUNTRIES VALUES(4,'US','United States');
INSERT INTO COUNTRIES VALUES(5,'GB','United Kingdom');
INSERT INTO COUNTRIES VALUES(6,'DE','Germany');
INSERT INTO COUNTRIES VALUES(7,'ES','Spain');
INSERT INTO COUNTRIES VALUES(8,'LU','Luxembourg');
INSERT INTO COUNTRIES VALUES(9,'IT','Italy');
INSERT INTO COUNTRIES VALUES(10,'CA','Canada');

INSERT INTO USERS VALUES(1,1,'polle','Pol','Vanden Walle');
INSERT INTO USERS VALUES(2,1,'pete','Peter','Zonnebloem');
INSERT INTO USERS VALUES(3,1,'mattn','Martin','De Wilde');
INSERT INTO USERS VALUES(4,2,'kees','Kees','Mees');
INSERT INTO USERS VALUES(5,4,'james','James','Johnson');
INSERT INTO USERS VALUES(6,4,'alice','Alice','Cooper');
INSERT INTO USERS VALUES(7,5,'jen','Jennifer','Althow');
INSERT INTO USERS VALUES(8,10,'ashley','Ashley','Flower');
INSERT INTO USERS VALUES(9,6,'stein','Stein','Berg');
INSERT INTO USERS (USER_ID, USERNAME, FIRSTNAME, LASTNAME) VALUES(10,'mario','Mario','Elder');

INSERT INTO MESSAGES VALUES(1,10,'Car for sale','I sell my car for a good price!',TO_TIMESTAMP_TZ ('21-FEB-2015 18:00:00 -5:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(2,8,'Dog','Anyone needs a dog?',TO_TIMESTAMP_TZ ('03-MAR-2015 19:15:00 -4:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(3,6,'Cycle','I search a cycle partner.',TO_TIMESTAMP_TZ ('04-MAR-2015 20:40:45 +5:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(4,5,'Money','Free money. Contact me soon.',TO_TIMESTAMP_TZ ('21-MAR-2015 18:00:00 -3:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(5,8,'Old socks','Can anybody find my old socks? Reds with blue stars.',TO_TIMESTAMP_TZ ('11-APR-2015 18:00:00 +3:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(6,5,'500 tennis balls','I have some balls for sale.',TO_TIMESTAMP_TZ ('15-MAY-2015 18:00:00 +1:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(7,1,'Dance contest','Next week dance contest: hip hop',TO_TIMESTAMP_TZ ('02-JUN-2015 18:00:00 +1:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(8,2,'Airplane ticket','One way plane ticket for alaska on sale',TO_TIMESTAMP_TZ ('28-JUL-2015 18:00:00 +1:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(9,1,'4 tires','4 truck tires - free!',TO_TIMESTAMP_TZ ('02-AUG-2015 18:00:00 -9:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));
INSERT INTO MESSAGES VALUES(10,3,'Cats and dogs','Cats and dogs for sale.',TO_TIMESTAMP_TZ ('15-DEC-2015 18:00:00 -8:00', 'DD-MON-YYYY HH24:MI:SS TZH:TZM'));

EXIT;
