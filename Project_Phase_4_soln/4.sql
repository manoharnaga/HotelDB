-- Host: localhost    Database: Company
-- ------------------------------------------------------
-- Server version: 8.0.31-0ubuntu0.22.04.1 (Ubuntu)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Host: localhost    Database: hw3
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- Server version	8.0.31

DROP DATABASE IF EXISTS `p4_t`;
CREATE SCHEMA `p4_t`;
USE `p4_t`;

-- TOTAL NUMBER OF TABLES == 11 --------


DROP TABLE IF EXISTS `EMPLOYEE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE EMPLOYEE
(   F_name          VARCHAR(21)   NOT NULL,
    L_name          VARCHAR(21)   NOT NULL,
    Employee_ID     INT           NOT NULL,
    Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(31)   NOT NULL,
    Contact_number  BIGINT,
    -- Role_in_hotel   VARCHAR(31)   NOT NULL,
    M_Employee_ID   INT,
    Role            VARCHAR(31)   NOT NULL, 
CONSTRAINT phoneDigit1 CHECK (Contact_number>=6000000000 AND Contact_number<=9999999999),
PRIMARY KEY (Employee_ID, Hotel_name, Hotel_Location))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE CUSTOMER
(   City            VARCHAR(31),
    State           VARCHAR(31),
    Country         VARCHAR(31),
    Email_ID        VARCHAR(75)   NOT NULL,
    Gender          CHAR(1),
    Phone_number    BIGINT(10),
    DOB             DATE,
    F_name          VARCHAR(21)   NOT NULL,
    L_name          VARCHAR(21)   NOT NULL,
    AGE             INT,
CONSTRAINT phoneDigit2 CHECK (Phone_number>=6000000000 AND Phone_number<=9999999999),
CONSTRAINT AgeCheck CHECK (AGE>=18),
PRIMARY KEY (Email_ID))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `HOTEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE HOTEL
(   Max_No_of_rooms INT,
-- //changed
    Hotel_name      VARCHAR(31)   NOT NULL,        
    Hotel_Location  VARCHAR(31)   NOT NULL,
-- //changed

PRIMARY KEY (Hotel_name,Hotel_Location))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `ROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE ROOM
(   Room_number     INT           NOT NULL,
    Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Price_per_day   INT,
    Max_No_of_persons_per_room INT,

PRIMARY KEY (Room_number,Hotel_name,Hotel_Location),
FOREIGN KEY (Hotel_name) REFERENCES HOTEL(Hotel_name))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `BOOKING_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE BOOKING_STATUS
(   Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Room_number     INT           NOT NULL,
    IS_BOOKED       INT,

PRIMARY KEY (Hotel_name,Hotel_Location,Room_number),
FOREIGN KEY (Room_number) REFERENCES ROOM(Room_number))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `ROOM_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE ROOM_TYPE
(   Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Room_number     INT           NOT NULL,
    HAS_TV          INT,
    HAS_AC          INT,
    Max_No_of_persons_accomodated INT,
PRIMARY KEY (Hotel_name,Hotel_Location,Room_number))
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `REVIEWS_RATING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE REVIEWS_RATING
(   Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Room_Rating     FLOAT(1),
    Food_Rating     FLOAT(1),
    Service_Rating  FLOAT(1),
PRIMARY KEY (Hotel_name,Hotel_Location)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `GOES_TO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE GOES_TO
(   Email_ID        VARCHAR(75)   NOT NULL,
    Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    
PRIMARY KEY (Email_ID,Hotel_name,Hotel_Location),
FOREIGN KEY (Email_ID) REFERENCES CUSTOMER(Email_ID),
FOREIGN KEY (Hotel_name) REFERENCES HOTEL(Hotel_name)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `STAYS_IN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE STAYS_IN
(   Email_ID        VARCHAR(75)   NOT NULL,
    Room_number     INT           NOT NULL,
    Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    
PRIMARY KEY (Email_ID,Room_number,Hotel_name,Hotel_Location),
FOREIGN KEY (Email_ID) REFERENCES CUSTOMER(Email_ID),
FOREIGN KEY (Room_number) REFERENCES ROOM(Room_number),
FOREIGN KEY (Hotel_name) REFERENCES HOTEL(Hotel_name)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;





DROP TABLE IF EXISTS `MANAGES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE MANAGES
(   Email_ID        VARCHAR(75)   NOT NULL,
    Employee_ID     INT           NOT NULL,
    Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Room_number     INT           NOT NULL,
    
PRIMARY KEY (Email_ID,Employee_ID,Hotel_name,Hotel_Location,Room_number),
FOREIGN KEY (Email_ID) REFERENCES CUSTOMER(Email_ID),
-- FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID),
FOREIGN KEY (Hotel_name) REFERENCES HOTEL(Hotel_name),
FOREIGN KEY (Room_number) REFERENCES ROOM(Room_number)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `FACILITIES_PROVIDED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE FACILITIES_PROVIDED
(   Hotel_name      VARCHAR(31)   NOT NULL,
    Hotel_Location  VARCHAR(75)   NOT NULL,
    Facility        VARCHAR(100)  NOT NULL,
    
PRIMARY KEY (Hotel_name,Hotel_Location,Facility),
FOREIGN KEY (Hotel_name) REFERENCES HOTEL(Hotel_name)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;




-- INSERT DATA INTO TABLES
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

--
-- Dumping data for table `EMPLOYEE`
--

LOCK TABLES `EMPLOYEE` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE` DISABLE KEYS */;
INSERT INTO EMPLOYEE
VALUES    
('h1f1',    'h1l1', 1,'h1', 'h1loc',    7611976453,      1, 'MANAGER        '),
('h1f2',    'h1l2', 2,'h1', 'h1loc',    7612976453,      1, 'RECEPTIONIST   '),
('h1f3',    'h1l3', 3,'h1', 'h1loc',    7613976453,      1, 'ACCOUNTANT      '),
('h1f4',    'h1l4', 4,'h1', 'h1loc',    7614976453,      1, 'HOUSE_KEEPER    '),
('h1f5',    'h1l5', 5,'h1', 'h1loc',    7615976453,      1, 'HOUSE_KEEPER    '),


('h2f1',    'h2l1', 1,'h2', 'h2loc',    7621976454,      1, 'MANAGER        '),
('h2f2',    'h2l2', 2,'h2', 'h2loc',    7622976454,      1, 'ACCOUNTANT      '),
('h2f3',    'h2l3', 3,'h2', 'h2loc',    7623976454,      1, 'RECEPTIONIST   '),
('h2f4',    'h2l4', 4,'h2', 'h2loc',    7624976454,      1, 'HOUSE_KEEPER    '),
('h2f5',    'h2l5', 5,'h2', 'h2loc',    7625976454,      1, 'SECURITY_GAURD  '),



('h3f1',    'h3l1', 1,'h3', 'h3loc',    7631976455,      1, 'MANAGER        '),
('h3f2',    'h3l2', 2,'h3', 'h3loc',    7632976455,      1, 'ACCOUNTANT      '),
('h3f3',    'h3l3', 3,'h3', 'h3loc',    7633976455,      1, 'RECEPTIONIST   '),
('h3f4',    'h3l4', 4,'h3', 'h3loc',    7634976455,      1, 'SECURITY_GAURD  '),
('h3f5',    'h3l5', 5,'h3', 'h3loc',    7635976455,      1, 'HOUSE_KEEPER    '),



('h4f1',    'h4l1', 1,'h4', 'h4loc',    7641976456,      1, 'MANAGER        '),
('h4f2',    'h4l2', 2,'h4', 'h4loc',    7642976456,      1, 'ACCOUNTANT      '),
('h4f3',    'h4l3', 3,'h4', 'h4loc',    7643976456,      1, 'SECURITY_GAURD  '),
('h4f4',    'h4l4', 4,'h4', 'h4loc',    7644976456,      1, 'RECEPTIONIST   '),
('h4f5',    'h4l5', 5,'h4', 'h4loc',    7645976456,      1, 'SECURITY_GAURD  '),



('h5f1',    'h5l1', 1,'h5', 'h5loc',    7651976457,      1, 'MANAGER        '),
('h5f2',    'h5l2', 2,'h5', 'h5loc',    7652976457,      1, 'RECEPTIONIST   '),
('h5f3',    'h5l3', 3,'h5', 'h5loc',    7653976457,      1, 'ACCOUNTANT      '),
('h5f4',    'h5l4', 4,'h5', 'h5loc',    7654976457,      1, 'HOUSE_KEEPER    '),
('h5f5',    'h5l5', 5,'h5', 'h5loc',    7655976457,      1, 'SECURITY_GAURD  ');


/*!40000 ALTER TABLE `EMPLOYEE` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
INSERT INTO CUSTOMER
VALUES    
('c1cit',   'c1st', 'c1cou',    'c1emid',   'M',  9911234567, '1983-01-04',    'c1f',  'c1l',    34),
('c2cit',   'c2st', 'c2cou',    'c2emid',   'F',  9921234567, '1995-06-01',    'c2f',  'c2l',    37),
('c3cit',   'c3st', 'c3cou',    'c3emid',   'M',  9931234567, '1993-01-02',    'c3f',  'c3l',    43),
('c4cit',   'c4st', 'c4cou',    'c4emid',   'M',  9941234567, '1978-03-05',    'c4f',  'c4l',    27),
('c5cit',   'c5st', 'c5cou',    'c5emid',   'F',  9951234567, '1991-08-05',    'c5f',  'c5l',    47),
('c6cit',   'c6st', 'c6cou',    'c6emid',   'M',  9961234567, '1979-02-14',    'c6f',  'c6l',    51),
('c7cit',   'c7st', 'c7cou',    'c7emid',   'F',  9971234567, '1978-04-12',    'c7f',  'c7l',    53),  
('c8cit',   'c8st', 'c8cou',    'c8emid',   'F',  9981234567, '1987-09-11',    'c8f',  'c8l',    52),
('c9cit',   'c9st', 'c9cou',    'c9emid',   'M',  9991234567, '1991-05-19',    'c9f',  'c9l',    29),
('c10cit',   'c10st', 'c10cou',    'c10emid',   'M',  9101234567, '1991-05-19',    'c10f',  'c10l',    29),
('c11cit',   'c11st', 'c11cou',    'c11emid',   'M',  9111234567, '1945-07-19',    'c11f',  'c11l',    36),
('c12cit',   'c12st', 'c12cou',    'c12emid',   'M',  9121234567, '1981-09-19',    'c12f',  'c12l',    49),
('c13cit',   'c13st', 'c13cou',    'c13emid',   'M',  9131234567, '1997-11-19',    'c13f',  'c13l',    21);


/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `HOTEL` WRITE;
/*!40000 ALTER TABLE `HOTEL` DISABLE KEYS */;
INSERT INTO HOTEL
VALUES    
(10,   'h1', 'h1loc'),
(11,   'h2', 'h2loc'),
(13,   'h3', 'h3loc'),
(19,   'h4', 'h4loc'),
(21,   'h5', 'h5loc');

/*!40000 ALTER TABLE `HOTEL` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `ROOM` WRITE;
/*!40000 ALTER TABLE `ROOM` DISABLE KEYS */;
INSERT INTO ROOM
VALUES    
(1, 'h1', 'h1loc',  5999,   3),
(2, 'h1', 'h1loc',  4599,   4),
(3, 'h1', 'h1loc',  3999,   5),
(4, 'h1', 'h1loc',  1999,   2),

   
(1, 'h2', 'h2loc',  7999,   4),
(2, 'h2', 'h2loc',  3599,   3),
(3, 'h2', 'h2loc',  4999,   3),
(4, 'h2', 'h2loc',  2999,   2),

   
(1, 'h3', 'h3loc',  6599,   5),
(2, 'h3', 'h3loc',  4599,   2),
(3, 'h3', 'h3loc',  2999,   3),
(4, 'h3', 'h3loc',  1599,   1),

   
(1, 'h4', 'h4loc',  8599,   7),
(2, 'h4', 'h4loc',  7599,   4),
(3, 'h4', 'h4loc',  4999,   5),
(4, 'h4', 'h4loc',  1499,   1),

   
(1, 'h5', 'h5loc',  6599,   2),
(2, 'h5', 'h5loc',  4599,   3),
(3, 'h5', 'h5loc',  3999,   1),
(4, 'h5', 'h5loc',  1999,   1);


/*!40000 ALTER TABLE `ROOM` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `BOOKING_STATUS` WRITE;
/*!40000 ALTER TABLE `BOOKING_STATUS` DISABLE KEYS */;
INSERT INTO BOOKING_STATUS
VALUES    
('h1', 'h1loc',  1, 1),
('h1', 'h1loc',  2, 1),
('h1', 'h1loc',  3, 0),
('h1', 'h1loc',  4, 0),

   
('h2', 'h2loc',  1, 1),
('h2', 'h2loc',  2, 0),
('h2', 'h2loc',  3, 0),
('h2', 'h2loc',  4, 1),

   
('h3', 'h3loc',  1, 1),
('h3', 'h3loc',  2, 1),
('h3', 'h3loc',  3, 1),
('h3', 'h3loc',  4, 1),

   
('h4', 'h4loc',  1, 0),
('h4', 'h4loc',  2, 0),
('h4', 'h4loc',  3, 0),
('h4', 'h4loc',  4, 1),

   
('h5', 'h5loc',  1, 0),
('h5', 'h5loc',  2, 0),
('h5', 'h5loc',  3, 0),
('h5', 'h5loc',  4, 0);


/*!40000 ALTER TABLE `BOOKING_STATUS` ENABLE KEYS */;
UNLOCK TABLES;



LOCK TABLES `ROOM_TYPE` WRITE;
/*!40000 ALTER TABLE `ROOM_TYPE` DISABLE KEYS */;
INSERT INTO ROOM_TYPE
VALUES    
('h1', 'h1loc',  1,  1, 1,  3),
('h1', 'h1loc',  2,  0, 1,  4),
('h1', 'h1loc',  3,  1, 0,  5),
('h1', 'h1loc',  4,  0, 0,  2),

   
('h2', 'h2loc',  1,  1, 1,  4),
('h2', 'h2loc',  2,  0, 1,  3),
('h2', 'h2loc',  3,  1, 0,  3),
('h2', 'h2loc',  4,  0, 1,  2),

   
('h3', 'h3loc',  1,  1, 1,  5),
('h3', 'h3loc',  2,  0, 1,  2),
('h3', 'h3loc',  3,  0, 0,  3),
('h3', 'h3loc',  4,  0, 1,  1),

   
('h4', 'h4loc',  1,  1, 1,  7),
('h4', 'h4loc',  2,  0, 1,  4),
('h4', 'h4loc',  3,  0, 0,  5),
('h4', 'h4loc',  4,  0, 1,  1),

   
('h5', 'h5loc',  1,  1, 1,  2),
('h5', 'h5loc',  2,  1, 0,  3),
('h5', 'h5loc',  3,  0, 1,  1),
('h5', 'h5loc',  4,  0, 0,  1);


/*!40000 ALTER TABLE `ROOM_TYPE` ENABLE KEYS */;
UNLOCK TABLES;





LOCK TABLES `REVIEWS_RATING` WRITE;
/*!40000 ALTER TABLE `REVIEWS_RATING` DISABLE KEYS */;
INSERT INTO REVIEWS_RATING
VALUES    
('h1', 'h1loc',  3.5,  4.5, 4.1),
('h2', 'h2loc',  3.9,  4.9, 2.1),
('h3', 'h3loc',  4.1,  4.5, 4.7),
('h4', 'h4loc',  1.9,  3.7, 2.9),
('h5', 'h5loc',  3.1,  2.9, 3.1);


/*!40000 ALTER TABLE `REVIEWS_RATING` ENABLE KEYS */;
UNLOCK TABLES;




LOCK TABLES `GOES_TO` WRITE;
/*!40000 ALTER TABLE `GOES_TO` DISABLE KEYS */;
INSERT INTO GOES_TO
VALUES    
('c1',  'h1', 'h1loc'),
('c2',  'h3', 'h3loc'),
('c3',  'h1', 'h1loc'),
('c4',  'h4', 'h4loc'),
('c5',  'h2', 'h2loc'),
('c6',  'h3', 'h3loc'),
('c7',  'h2', 'h2loc'),
('c8',  'h3', 'h3loc'),
('c9',  'h3', 'h3loc');

/*!40000 ALTER TABLE `GOES_TO` ENABLE KEYS */;
UNLOCK TABLES;



LOCK TABLES `STAYS_IN` WRITE;
/*!40000 ALTER TABLE `STAYS_IN` DISABLE KEYS */;
INSERT INTO STAYS_IN
VALUES    
('c1emid',  2,   'h1', 'h1loc'),
('c2emid',  3,   'h3', 'h3loc'),
('c3emid',  1,   'h1', 'h1loc'),
('c4emid',  4,   'h4', 'h4loc'),
('c5emid',  4,   'h2', 'h2loc'),
('c6emid',  2,   'h3', 'h3loc'),
('c7emid',  1,   'h2', 'h2loc'),
('c8emid',  4,   'h3', 'h3loc'),
('c9emid',  1,   'h3', 'h3loc');

/*!40000 ALTER TABLE `STAYS_IN` ENABLE KEYS */;
UNLOCK TABLES;


-- ASST_MANAGER MANAGES ALL CUSTOMERS  --------

LOCK TABLES `MANAGES` WRITE;
/*!40000 ALTER TABLE `MANAGES` DISABLE KEYS */;
INSERT INTO MANAGES
VALUES    
('c1emid',  2,  'h1', 'h1loc', 2),
('c2emid',  2,  'h3', 'h3loc', 3),
('c3emid',  2,  'h1', 'h1loc', 1),
('c4emid',  2,  'h4', 'h4loc', 4),
('c5emid',  2,  'h2', 'h2loc', 4),
('c6emid',  2,  'h3', 'h3loc', 2),
('c7emid',  2,  'h2', 'h2loc', 1),
('c8emid',  2,  'h3', 'h3loc', 4),
('c9emid',  2,  'h3', 'h3loc', 1);

/*!40000 ALTER TABLE `MANAGES` ENABLE KEYS */;
UNLOCK TABLES;




LOCK TABLES `FACILITIES_PROVIDED` WRITE;
/*!40000 ALTER TABLE `FACILITIES_PROVIDED` DISABLE KEYS */;
INSERT INTO FACILITIES_PROVIDED
VALUES    

('h1', 'h1loc', 'Sofa-Set'),
('h1', 'h1loc', 'laundry rooms'),

('h2', 'h2loc', 'Sofa-Set'),

('h3', 'h3loc', 'Sofa-Set'),
('h3', 'h3loc', 'laundry rooms'),
('h3', 'h3loc', 'parking areas'),

('h4', 'h4loc', 'laundry rooms'),
('h4', 'h4loc', 'conference rooms'),
('h4', 'h4loc', 'parking areas'),

('h5', 'h5loc', 'laundry rooms');

/*!40000 ALTER TABLE `FACILITIES_PROVIDED` ENABLE KEYS */;
UNLOCK TABLES;



select * from   EMPLOYEE;
select * from   CUSTOMER;
select * from   HOTEL;
select * from   ROOM;
select * from   BOOKING_STATUS;
select * from   ROOM_TYPE;
select * from   REVIEWS_RATING;
select * from   GOES_TO;
select * from   STAYS_IN;
select * from   MANAGES;
select * from   FACILITIES_PROVIDED;
