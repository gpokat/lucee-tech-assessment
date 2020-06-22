CREATE DATABASE  IF NOT EXISTS `testing_center_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `testing_center_db`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: testing_center_db
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidates` (
  `cid` int NOT NULL,
  `uniqID` int NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `uniqID_UNIQUE` (`uniqID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,999,'Jon','Doe1'),(2,998,'Jon','Doe2'),(3,997,'Jon','Doe3'),(4,996,'Jon','Doe4'),(5,995,'Jon','Doe5'),(6,994,'Jon','Doe6'),(7,993,'Jon','Doe7'),(8,992,'Jon','Doe8');
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `eid` int NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `notice` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (1,'exam1','description1'),(2,'exam2','description2'),(3,'exam3','description3'),(4,'exam4','description4'),(5,'exam5','description5'),(6,'exam6','description6'),(7,'exam7','description7'),(8,'exam8','description8'),(9,'exam9','description9'),(10,'exam10','description10'),(11,'exam11','description11'),(12,'exam12','description12'),(13,'exam13','description13'),(14,'exam14','description14'),(15,'exam15','description15'),(16,'exam16','description16'),(17,'exam17','description17');
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams_associated`
--

DROP TABLE IF EXISTS `exams_associated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams_associated` (
  `eaid` int NOT NULL AUTO_INCREMENT,
  `exid` int NOT NULL,
  `cid` int NOT NULL,
  `taid` int DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`eaid`),
  KEY `cid_idx` (`cid`),
  KEY `exid_idx` (`exid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `candidates` (`cid`),
  CONSTRAINT `exid` FOREIGN KEY (`exid`) REFERENCES `exams` (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams_associated`
--

LOCK TABLES `exams_associated` WRITE;
/*!40000 ALTER TABLE `exams_associated` DISABLE KEYS */;
INSERT INTO `exams_associated` VALUES (1,1,1,2,0),(2,2,2,3,1),(3,1,3,5,1),(4,14,4,3,0),(5,3,4,2,0),(6,2,4,8,1),(7,4,5,6,0),(8,12,5,1,1),(9,10,6,2,0),(10,14,4,2,0);
/*!40000 ALTER TABLE `exams_associated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testing_centers`
--

DROP TABLE IF EXISTS `testing_centers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testing_centers` (
  `tid` int NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `notice` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testing_centers`
--

LOCK TABLES `testing_centers` WRITE;
/*!40000 ALTER TABLE `testing_centers` DISABLE KEYS */;
INSERT INTO `testing_centers` VALUES (1,'test1','everett1','notice1'),(2,'test2','everett2','notice2'),(3,'test3','everett3','notice3'),(4,'test4','everett4',NULL),(5,'test5','everett5','notice4'),(6,'test6','everett6',NULL),(7,'test7','everett7','notice7'),(8,'test8','everett8','notice8'),(9,'test9','everett9',NULL),(10,'test10','snohomish1','notice10');
/*!40000 ALTER TABLE `testing_centers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testing_centers_associated`
--

DROP TABLE IF EXISTS `testing_centers_associated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testing_centers_associated` (
  `tcaid` int NOT NULL,
  `tid1` int DEFAULT NULL,
  `tid2` int DEFAULT NULL,
  `tid3` int DEFAULT NULL,
  `tid4` int DEFAULT NULL,
  `tid5` int DEFAULT NULL,
  `tid6` int DEFAULT NULL,
  `tid7` int DEFAULT NULL,
  PRIMARY KEY (`tcaid`),
  CONSTRAINT `tca` FOREIGN KEY (`tcaid`) REFERENCES `exams` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testing_centers_associated`
--

LOCK TABLES `testing_centers_associated` WRITE;
/*!40000 ALTER TABLE `testing_centers_associated` DISABLE KEYS */;
INSERT INTO `testing_centers_associated` VALUES (1,1,2,5,NULL,NULL,NULL,NULL),(2,3,7,8,NULL,NULL,NULL,NULL),(3,2,NULL,NULL,NULL,NULL,NULL,NULL),(4,6,NULL,NULL,NULL,NULL,NULL,NULL),(5,7,NULL,NULL,NULL,NULL,NULL,NULL),(6,8,9,10,NULL,NULL,NULL,NULL),(7,8,NULL,NULL,NULL,NULL,NULL,NULL),(8,6,NULL,NULL,NULL,NULL,NULL,NULL),(9,1,2,NULL,NULL,NULL,NULL,NULL),(10,2,NULL,NULL,NULL,NULL,NULL,NULL),(11,4,5,NULL,NULL,NULL,NULL,NULL),(12,1,NULL,NULL,NULL,NULL,NULL,NULL),(13,5,9,7,NULL,NULL,NULL,NULL),(14,3,NULL,NULL,NULL,NULL,NULL,NULL),(15,2,3,NULL,NULL,NULL,NULL,NULL),(16,3,4,NULL,NULL,NULL,NULL,NULL),(17,5,6,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `testing_centers_associated` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-22 15:23:02
