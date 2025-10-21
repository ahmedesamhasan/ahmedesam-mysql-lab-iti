-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: iti_grades
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Enrollment`
--

DROP TABLE IF EXISTS `Enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Enrollment` (
  `StudentID` int NOT NULL,
  `SubjectID` int NOT NULL,
  `EnrollDate` date NOT NULL,
  PRIMARY KEY (`StudentID`,`SubjectID`),
  KEY `fk_enr_subject` (`SubjectID`),
  CONSTRAINT `Enrollment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Enrollment_ibfk_2` FOREIGN KEY (`SubjectID`) REFERENCES `Subject` (`SubjectID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enr_student` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enr_subject` FOREIGN KEY (`SubjectID`) REFERENCES `Subject` (`SubjectID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enrollment`
--

LOCK TABLES `Enrollment` WRITE;
/*!40000 ALTER TABLE `Enrollment` DISABLE KEYS */;
INSERT INTO `Enrollment` VALUES (1,1,'2025-10-01'),(1,2,'2025-10-01'),(2,3,'2025-10-01'),(2,5,'2025-10-01'),(3,1,'2025-10-02');
/*!40000 ALTER TABLE `Enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Exam`
--

DROP TABLE IF EXISTS `Exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exam` (
  `ExamID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int NOT NULL,
  `SubjectID` int NOT NULL,
  `ExamDate` date NOT NULL,
  `Score` decimal(5,2) NOT NULL,
  PRIMARY KEY (`ExamID`),
  KEY `fk_exam_student` (`StudentID`),
  KEY `fk_exam_subject` (`SubjectID`),
  CONSTRAINT `Exam_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Exam_ibfk_2` FOREIGN KEY (`SubjectID`) REFERENCES `Subject` (`SubjectID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_student` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_subject` FOREIGN KEY (`SubjectID`) REFERENCES `Subject` (`SubjectID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Exam_chk_1` CHECK ((`Score` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exam`
--

LOCK TABLES `Exam` WRITE;
/*!40000 ALTER TABLE `Exam` DISABLE KEYS */;
INSERT INTO `Exam` VALUES (1,1,1,'2025-10-10',88.00),(2,1,2,'2025-10-12',75.50),(3,2,3,'2025-10-11',92.00),(4,2,5,'2025-10-13',81.00),(5,3,1,'2025-10-14',69.00);
/*!40000 ALTER TABLE `Exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Phone`
--

DROP TABLE IF EXISTS `Phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Phone` (
  `PhoneID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`PhoneID`),
  KEY `fk_phone_student` (`StudentID`),
  CONSTRAINT `fk_phone_student` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Phone_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Phone`
--

LOCK TABLES `Phone` WRITE;
/*!40000 ALTER TABLE `Phone` DISABLE KEYS */;
INSERT INTO `Phone` VALUES (1,1,'01000000001'),(2,1,'01000000002'),(3,2,'01000000010'),(4,3,'01000000020'),(5,4,'01000000030');
/*!40000 ALTER TABLE `Phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `StudentID` int NOT NULL AUTO_INCREMENT,
  `Gender` enum('male','female') DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `FirstName` varchar(60) DEFAULT NULL,
  `LastName` varchar(60) DEFAULT NULL,
  `ContactInfo` json DEFAULT NULL,
  PRIMARY KEY (`StudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (1,'male','2000-03-15','Omar','Ali','{\"email\": \"omar@example.com\", \"address\": \"Cairo, EG\"}'),(2,'female','1999-07-21','Sara','Hassan','{\"email\": \"sara@example.com\", \"address\": \"الجيزة\"}'),(3,'male','1998-01-10','Ahmed','Nabil','{\"email\": \"ahmed@example.com\", \"address\": \"الإسكندرية\"}'),(4,'female','2001-05-02','Mona','Ibrahim','{\"email\": \"mona@example.com\", \"address\": \"القاهرة\"}'),(5,'male','1997-11-30','Youssef','Salem','{\"email\": \"youssef@example.com\", \"address\": \"المنصورة\"}');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subject`
--

DROP TABLE IF EXISTS `Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subject` (
  `SubjectID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(80) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `MaxScore` int NOT NULL,
  PRIMARY KEY (`SubjectID`),
  UNIQUE KEY `Name` (`Name`),
  CONSTRAINT `Subject_chk_1` CHECK ((`MaxScore` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subject`
--

LOCK TABLES `Subject` WRITE;
/*!40000 ALTER TABLE `Subject` DISABLE KEYS */;
INSERT INTO `Subject` VALUES (1,'C','مدخل إلى لغة C',100),(2,'CPP','البرمجة بلغة C++',100),(3,'HTML','أساسيات HTML',100),(4,'CSS','تصميم صفحات الويب',100),(5,'JS','أساسيات JavaScript',100);
/*!40000 ALTER TABLE `Subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21 20:43:08
