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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `prdNo` int DEFAULT NULL,
  `prdName` text,
  `prdPrice` int DEFAULT NULL,
  `prdMaker` text,
  `prdColor` text,
  `ctgNo` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1001,'삼성 냉장고 비스포크',1620000,'삼성전자','새틴 코럴',1),(1002,'LG 디오스 와인셀러',1367000,'LG전자','검정',1),(1003,'QLED 8K TV',2175000,'삼성전자','블랙',1),(1004,'올레드 TV 55',799000,'LG전자','검정',1),(1005,'UHD 커브드 65인치',2250000,'삼성전자','은색',1),(1006,'유아용 세발 자전거',76000,'삼천리 자전거','빨강',3),(1007,'로드 사이클 자전거',150000,'알톤','검정',3),(1008,'여성용 클래식 자전거',100000,'알톤','핑크',3),(1009,'갤럭시북',1390000,'도시바','은색',2),(1010,'HP 게이밍 노트북',1200000,'HP','흰색',2),(1011,'65인치 LED 모니터',299000,'LG전자','검정',2),(1012,'광시야각 LED 모니터',195000,'삼성전자','흰색',2),(1013,'등산배낭 옵티마',68000,'밀레','자주',4),(1014,'35L 등산배낭',49000,'(주)셀파','노랑',4),(1015,'원터치 자동 텐트',58000,'이지트래블러','그린',4),(1016,'그늘막 텐트',33000,'밀레','그린',4);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
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
