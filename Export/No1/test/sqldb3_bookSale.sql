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
-- Table structure for table `bookSale`
--

DROP TABLE IF EXISTS `bookSale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bookSale` (
  `bsNo` varchar(10) NOT NULL,
  `bsDate` date DEFAULT NULL,
  `bsQty` int DEFAULT NULL,
  `clientNo` varchar(10) NOT NULL,
  `bookNo` varchar(10) NOT NULL,
  PRIMARY KEY (`bsNo`),
  KEY `FK_bookSale_book` (`bookNo`),
  KEY `FK_bookSale_client` (`clientNo`),
  CONSTRAINT `FK_bookSale_book` FOREIGN KEY (`bookNo`) REFERENCES `book` (`bookNo`),
  CONSTRAINT `FK_bookSale_client` FOREIGN KEY (`clientNo`) REFERENCES `client` (`clientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookSale`
--

LOCK TABLES `bookSale` WRITE;
/*!40000 ALTER TABLE `bookSale` DISABLE KEYS */;
INSERT INTO `bookSale` VALUES ('1','2020-04-05',2,'3','1006'),('2','2021-10-11',1,'7','1004'),('3','2018-02-20',5,'2','1009'),('4','2020-07-10',4,'1','1011'),('5','2018-09-09',2,'2','1002'),('6','2020-02-09',2,'4','1003'),('7','2019-04-16',2,'2','1002'),('8','2021-06-02',9,'7','1005'),('9','2019-07-25',1,'8','1004');
/*!40000 ALTER TABLE `bookSale` ENABLE KEYS */;
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
