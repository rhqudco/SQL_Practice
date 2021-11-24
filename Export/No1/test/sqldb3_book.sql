-- MySQL dump 10.13  Distrib 8.0.11, for macos10.13 (x86_64)
--
-- Host: localhost    Database: sqldb3
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `book` (
  `bookNo` varchar(10) NOT NULL,
  `bookName` varchar(20) DEFAULT NULL,
  `bookAuthor` varchar(30) DEFAULT NULL,
  `bookPrice` int DEFAULT NULL,
  `bookDate` date DEFAULT NULL,
  `bookStock` int DEFAULT NULL,
  `pubNo` varchar(10) NOT NULL,
  PRIMARY KEY (`bookNo`),
  KEY `FK_book_publisher` (`pubNo`),
  CONSTRAINT `FK_book_publisher` FOREIGN KEY (`pubNo`) REFERENCES `publisher` (`pubNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('1001','데이터베이스 이론','홍길동',22000,'2018-11-11',5,'3'),('1002','자바 프로그래밍','이몽룡',25000,'2020-12-12',4,'1'),('1003','인터넷프로그래밍','성춘향',30000,'2019-02-10',10,'2'),('1004','안드로이드 프로그래밍','변학도',23000,'2017-10-10',2,'1'),('1005','안드로이드 앱','강길동',26000,'2019-01-11',5,'2'),('1006','MS SQL SERVER','박지성',35000,'2019-03-25',7,'3'),('1007','HTML & CSS','손홍민',18000,'2021-05-30',3,'1'),('1008','MFC 입문','류현진',20000,'2014-12-12',5,'1'),('1009','안드로이드 게임 제작','나길동',33000,'2017-10-31',5,'2'),('1010','C++객체지향 프로그래밍','김길동',24000,'2016-04-20',2,'3'),('1011','JSP 웹 프로그래밍','김연아',27000,'2021-10-23',8,'1'),('1012','해커들의 해킹 기법','손연재',32000,'2017-07-07',1,'2'),('1013','자료구조','홍길동',19000,'2019-01-20',4,'1'),('1014','웹 해킹과 침해사고 분석','성춘향',35000,'2017-11-25',5,'2'),('1015','자바스크립 & jQuery','홍길동',27000,'2018-10-22',2,'2');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-24 14:19:19
