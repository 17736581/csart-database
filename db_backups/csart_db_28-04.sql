-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: csart_db
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `statement` text DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Ante Prodan','Ante','Prodan','A.Prodan@westernsydney.edu.au','http://www.csart-world.com/','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),(2,'Jo-An Occhipinti','Jo-An','Occhipinti',NULL,NULL,NULL),(3,'Nathaniel Osgood','Nathaniel','Osgood',NULL,NULL,NULL),(4,'Paulo Gonçalves','Paulo','Gonçalves',NULL,NULL,NULL),(5,'Patricia Mabry','Patricia','Mabry',NULL,NULL,NULL),(6,'Robin Purshouse','Robin','Purshouse',NULL,NULL,NULL),(15,'Frank Iorfino','Frank','Iorfino',NULL,NULL,NULL),(16,'Adam Skinner','Adam','Skinner',NULL,NULL,NULL),(17,'Tracey Davenport','Tracey','Davenport',NULL,NULL,NULL),(18,'Shelley Rowe','Shelley','Rowe',NULL,NULL,NULL),(19,'Julie Sturgess','Julie','Sturgess',NULL,NULL,NULL),(20,'Ian Hickie','Ian','Hickie',NULL,NULL,NULL),(47,'Danya Rose','','',NULL,NULL,NULL),(48,'Daniel Rock','','',NULL,NULL,NULL),(49,'Yun Ju Christine Song','','',NULL,NULL,NULL),(50,'Sebastian Rosenberg','','',NULL,NULL,NULL),(51,'Louise Freebairn','','',NULL,NULL,NULL),(52,'Catherine Vacher','','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keywords` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`keyword_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES (1,'agent based modelling'),(2,'agent based systems'),(3,'computer simulation'),(4,'complex systems'),(5,'public health'),(6,'suicide prevention'),(7,'strategic planning'),(8,'decision analysis'),(9,'systems modelling'),(10,'simulation'),(11,'mental health');
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other_names`
--

DROP TABLE IF EXISTS `other_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `other_names` (
  `other_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `other_name` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`other_name_id`),
  KEY `fk_author_id` (`author_id`),
  CONSTRAINT `fk_author_id` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_names`
--

LOCK TABLES `other_names` WRITE;
/*!40000 ALTER TABLE `other_names` DISABLE KEYS */;
INSERT INTO `other_names` VALUES (1,'Jo-An Atkinson',2),(2,'Ian B. Hickie',20),(3,'Ian B Hickie',20);
/*!40000 ALTER TABLE `other_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_authors`
--

DROP TABLE IF EXISTS `project_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_authors` (
  `project_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`author_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `project_authors_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  CONSTRAINT `project_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_authors`
--

LOCK TABLES `project_authors` WRITE;
/*!40000 ALTER TABLE `project_authors` DISABLE KEYS */;
INSERT INTO `project_authors` VALUES (1,1),(1,2),(2,1),(3,1),(41,1),(41,2),(41,15),(41,16),(41,17),(41,18),(41,19),(41,20),(43,4),(68,1),(68,2),(68,16),(68,20),(68,47),(68,48),(68,49),(68,50),(68,51),(68,52);
/*!40000 ALTER TABLE `project_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_keywords`
--

DROP TABLE IF EXISTS `project_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_keywords` (
  `project_id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`keyword_id`),
  KEY `keyword_id` (`keyword_id`),
  CONSTRAINT `project_keywords_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  CONSTRAINT `project_keywords_ibfk_2` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_keywords`
--

LOCK TABLES `project_keywords` WRITE;
/*!40000 ALTER TABLE `project_keywords` DISABLE KEYS */;
INSERT INTO `project_keywords` VALUES (68,6),(68,7),(68,8),(68,9),(68,10),(68,11);
/*!40000 ALTER TABLE `project_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) NOT NULL,
  `url` varchar(2048) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funding_org` varchar(255) DEFAULT NULL,
  `funding_amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Systems modelling tools to support policy and planning','https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(18)30302-7/fulltext',NULL,NULL,'2018-03-24',NULL,NULL,NULL),(2,'The impact of strengthening mental health services to prevent suicidal behaviour',NULL,NULL,NULL,'2018-12-12',NULL,NULL,NULL),(3,'Harnessing advances in computer simulation to inform policy and planning to reduce alcohol-related harms',NULL,NULL,NULL,'2017-10-19',NULL,NULL,NULL),(41,'The Impact of Technology-Enabled Care Coordination in a Complex Mental Health System: A Local System Dynamics Model','https://www.jmir.org/2021/6/e25331/',NULL,NULL,'2021-06-30',NULL,NULL,NULL),(43,'System Dynamics Modeling of Humanitarian Relief Operations','https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1139817#',NULL,NULL,'2008-06-02',NULL,NULL,NULL),(68,'Sound Decision Making in Uncertain Times: Can Systems Modelling Be Useful for Informing Policy and Planning for Suicide Prevention?','https://www.mdpi.com/1660-4601/19/3/1468',NULL,NULL,'2022-01-27',NULL,NULL,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(255) NOT NULL,
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-28  0:22:53
