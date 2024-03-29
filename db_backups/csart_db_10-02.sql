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
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `affiliations` text DEFAULT NULL,
  `statement` text DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Ante Prodan','A.Prodan@westernsydney.edu.au','http://www.csart-world.com/','Association for Computing Machinery, Monash University, Sax Institute, The University of Sydney Brain and Mind Centre, University of Technology Sydney, Western Sydney University',NULL),(2,'Jo-An Occhipinti',NULL,NULL,NULL,NULL),(3,'Nathaniel Osgood',NULL,NULL,NULL,NULL),(4,'Paulo Gon├ºalves',NULL,NULL,NULL,NULL),(5,'Patricia Mabry',NULL,NULL,NULL,NULL),(6,'Robin Purshouse',NULL,NULL,NULL,NULL),(15,'Frank Iorfino',NULL,NULL,NULL,NULL),(16,'Adam Skinner',NULL,NULL,NULL,NULL),(17,'Tracey Davenport',NULL,NULL,NULL,NULL),(18,'Shelley Rowe',NULL,NULL,NULL,NULL),(19,'Julie Sturgess',NULL,NULL,NULL,NULL),(20,'Ian Hickie','ian.hickie@sydney.edu.au',NULL,'RANZCP, University of New South Wales, University of Sydney','Prof Hickie has just been reappointed an NHMRC Senior Principal Research Fellow (2018-22, previously SPRF 2013-17) and was previously an NHMRC Australian Research Fellow (2007-12). He is a Fellow of the Academy of Social Sciences in Australia and Co-Director, Health and Policy, of the Brain & Mind Centre (BMC), University of Sydney. From 2012 to 2018, he was a Commissioner of the Australian National Mental Health Commission (NMHC), with a major focus on improving outcome measurement and improved accountability for AustraliaΓÇÖs investments in mental health services. In partnership with the Mental Health Council of Australia, the Human Rights and Equal Opportunities Commission, Orygen Youth Health, the Young & Well CRC and the National Mental Health Commission, he has authored major national reports on community experiences of mental health services. Prof Hickie was a key participant in the most recent 2014 NMHC review of Mental Health Programmes and Services, which served as the template for the 2015 Turnbull Government initiatives in Mental Health Reform (total value $190M), including specifically the $30M Project Synergy investment in new technologies and the new $90M investment in 12 large regional trials of suicide prevention. His long-standing commitment to the impact of mental health research on mental health service improvement, through active engagement with those with lived experiences (patients, families and communities) in Australia is evident in his: i) capacity to facilitate public engagement with mental health issues, notably through his initial CEO role with beyondblue (2000-03); ii) engagement with major national mental health service reports over two decades (notably 2006, Not For Service Report with Human Rights and Equal Opportunities Commission); iii) continuous public commentary on contemporary mental health and suicide prevention issues; and iv) role in implementation of substantive health services reform in Australia (e.g. headspace and Young&Well CRC and now Project Synergy). He has been recognised nationally for his role over the last two decades in using clinical, health services and population health data to drive enhanced primary care services, increased access to psychological treatments and better interventions for those with severe mood disorders. In partnership with Prof Pat McGorry, he has been at the forefront of development and systematic evaluation of the new primary care based national youth mental health services (headspace). He has been a critical voice in the advocacy for enhanced social and health services for those with persistent mental illness and increased accountability for delivery of those services.'),(47,'Danya Rose',NULL,NULL,NULL,NULL),(48,'Daniel Rock',NULL,NULL,NULL,NULL),(49,'Yun Ju Christine Song',NULL,NULL,NULL,NULL),(50,'Sebastian Rosenberg',NULL,NULL,NULL,NULL),(51,'Louise Freebairn',NULL,NULL,NULL,NULL),(52,'Catherine Vacher',NULL,NULL,NULL,NULL),(58,'Andrew Page',NULL,NULL,NULL,NULL),(59,'Geoff McDonnell',NULL,NULL,NULL,NULL),(60,'Mark Heffernan',NULL,NULL,NULL,NULL),(61,'Bill Campos',NULL,NULL,NULL,NULL),(62,'Graham Meadows',NULL,NULL,NULL,NULL),(63,'Dylan Knowles',NULL,NULL,NULL,NULL),(64,'John Wiggers',NULL,NULL,NULL,NULL),(65,'Michael Livingston',NULL,NULL,NULL,NULL),(66,'Robin Room',NULL,NULL,NULL,NULL),(67,'Eloise O\'Donnell',NULL,NULL,NULL,NULL),(68,'Sandra Jones',NULL,NULL,NULL,NULL),(69,'Paul S Haber',NULL,NULL,NULL,NULL),(70,'David Muscatello',NULL,NULL,NULL,NULL),(71,'Nadine Ezard',NULL,NULL,NULL,NULL),(72,'Nghi Phung',NULL,NULL,NULL,NULL),(73,'Devon Indig',NULL,NULL,NULL,NULL),(74,'Lucie Rychetnik',NULL,NULL,NULL,NULL),(75,'Jaithri Ananthapavan',NULL,NULL,NULL,NULL),(76,'Sonia Wutzke',NULL,NULL,NULL,NULL),(77,'Jan Scott',NULL,NULL,NULL,NULL),(78,'Kirill Glavatsky',NULL,NULL,NULL,NULL),(108,'Nicholas Ho',NULL,NULL,NULL,NULL),(109,'Jo Robinson',NULL,NULL,NULL,NULL),(110,'Grace Yeeun Lee',NULL,NULL,NULL,NULL),(111,'Christopher J Nolan',NULL,NULL,NULL,NULL),(112,'Paul M Kelly',NULL,NULL,NULL,NULL),(113,'Yang Qin',NULL,NULL,NULL,NULL),(114,'Weicheng Qian',NULL,NULL,NULL,NULL),(115,'Anahita Safarishahrbijari',NULL,NULL,NULL,NULL),(116,'Luke Penza',NULL,NULL,NULL,NULL),(117,'Allen McLean',NULL,NULL,NULL,NULL),(118,'Alison L Kent',NULL,NULL,NULL,NULL),(119,'Roland Dyck',NULL,NULL,NULL,NULL),(120,'Louise Maple-Brown',NULL,NULL,NULL,NULL),(121,'Vincy Li',NULL,NULL,NULL,NULL),(122,'Nick Roberts',NULL,NULL,NULL,NULL),(123,'Thomas Lung',NULL,NULL,NULL,NULL),(124,'Suzanne Nieuwenhuizen',NULL,NULL,NULL,NULL),(125,'Bev Lloyd',NULL,NULL,NULL,NULL),(126,'Jo Mitchell',NULL,NULL,NULL,NULL),(127,'Lennert Veerman',NULL,NULL,NULL,NULL),(128,'Margaret Bright',NULL,NULL,NULL,NULL),(129,'Pippy Walker',NULL,NULL,NULL,NULL),(130,'Rebecca Whitehead',NULL,NULL,NULL,NULL),(131,'Suzan Burton',NULL,NULL,NULL,NULL),(132,'Tim Roselli',NULL,NULL,NULL,NULL),(133,'David P Thomas',NULL,NULL,NULL,NULL),(134,'Mark West',NULL,NULL,NULL,NULL);
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
  PRIMARY KEY (`keyword_id`),
  UNIQUE KEY `keyword_name` (`keyword_name`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES (1,'agent based modelling'),(2,'agent based systems'),(51,'alcohol-related harm'),(35,'care coordination'),(40,'casual loop diagrams'),(58,'causal modeling'),(62,'cessation'),(59,'childhood obesity'),(4,'complex systems'),(3,'computer simulation'),(8,'decision analysis'),(39,'dynamics complexity'),(64,'end game'),(44,'epidemiology'),(52,'evidence synthesis'),(55,'gestational diabetes mellitus'),(36,'health systems'),(38,'humanitarian relief operations'),(34,'internet'),(33,'medical informatics'),(11,'mental health'),(43,'mental health services'),(57,'modeling'),(37,'policy'),(56,'population health'),(50,'prevention policy'),(5,'public health'),(60,'public health policy'),(63,'public policy'),(10,'simulation'),(42,'simulation modeling'),(7,'strategic planning'),(45,'suicide'),(6,'suicide prevention'),(41,'system dynamics'),(61,'system dynamics modelling'),(9,'systems modelling');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_names`
--

LOCK TABLES `other_names` WRITE;
/*!40000 ALTER TABLE `other_names` DISABLE KEYS */;
INSERT INTO `other_names` VALUES (1,'Jo-An Atkinson',2),(2,'Ian B. Hickie',20),(3,'Ian B Hickie',20),(6,NULL,69),(7,'Paul Steven Haber',69);
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
INSERT INTO `project_authors` VALUES (41,1),(41,2),(41,15),(41,16),(41,17),(41,18),(41,19),(41,20),(43,4),(68,1),(68,2),(68,16),(68,20),(68,47),(68,48),(68,49),(68,50),(68,51),(68,52),(71,1),(71,2),(71,3),(71,58),(71,59),(72,1),(72,2),(72,20),(72,58),(72,59),(72,60),(72,61),(72,62),(73,1),(73,2),(73,51),(73,59),(73,63),(73,64),(73,65),(73,66),(73,67),(73,68),(73,69),(73,70),(73,71),(73,72),(73,73),(73,74),(73,75),(73,76),(74,15),(74,20),(74,77),(74,78),(107,1),(107,2),(107,15),(107,16),(107,20),(107,49),(107,51),(107,52),(107,108),(107,109),(107,110),(108,1),(108,2),(108,3),(108,51),(108,59),(108,111),(108,112),(108,113),(108,114),(108,115),(108,116),(108,117),(108,118),(108,119),(108,120),(109,1),(109,2),(109,51),(109,59),(109,60),(109,64),(109,121),(109,122),(109,123),(109,124),(109,125),(109,126),(110,1),(110,2),(110,16),(110,59),(110,60),(110,127),(110,128),(110,129),(110,130),(110,131),(110,132),(110,133),(110,134),(111,1),(111,4);
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
INSERT INTO `project_keywords` VALUES (41,4),(41,10),(41,11),(41,33),(41,34),(41,35),(41,36),(41,37),(41,44),(43,4),(43,38),(43,39),(43,40),(43,41),(43,42),(68,6),(68,7),(68,8),(68,9),(68,10),(68,11),(72,41),(72,43),(72,44),(72,45),(73,1),(73,50),(73,51),(73,52),(107,8),(107,9),(107,11),(108,55),(108,56),(108,57),(108,58),(109,50),(109,52),(109,59),(109,60),(109,61),(110,62),(110,63),(110,64),(111,51),(111,62);
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
  `statement` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funding_org` varchar(255) DEFAULT NULL,
  `funding_amount` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `project_name` (`project_name`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (41,'The Impact of Technology-Enabled Care Coordination in a Complex Mental Health System: A Local System Dynamics Model','https://www.jmir.org/2021/6/e25331/',NULL,NULL,NULL,'2021-06-30',NULL,NULL,NULL,NULL),(43,'System Dynamics Modeling of Humanitarian Relief Operations','https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1139817#',NULL,NULL,NULL,'2008-06-02',NULL,NULL,NULL,NULL),(68,'Sound Decision Making in Uncertain Times: Can Systems Modelling Be Useful for Informing Policy and Planning for Suicide Prevention?','https://www.mdpi.com/1660-4601/19/3/1468',NULL,NULL,NULL,'2022-01-27',NULL,NULL,NULL,NULL),(71,'Systems modelling tools to support policy and planning','https://doi.org/10.1016/S0140-6736(18)30302-7',NULL,NULL,NULL,'2018-03-24',NULL,NULL,NULL,NULL),(72,'The impact of strengthening mental health services to prevent suicidal behaviour','https://doi.org/10.1177%2F0004867418817381',NULL,NULL,NULL,'2018-12-12',NULL,NULL,NULL,NULL),(73,'Harnessing advances in computer simulation to inform policy and planning to reduce alcohol-related harms','https://doi.org/10.1007/s00038-017-1041-y',NULL,NULL,NULL,'2017-10-19',NULL,NULL,NULL,NULL),(74,'Youth Mania Model',NULL,NULL,'2021-03-01',NULL,NULL,'Australia','MRFF',3100000,NULL),(107,'Optimizing Strategies for Improving Mental Health in Victoria, Australia during the COVID-19 Era: A System Dynamics Modelling Study','https://doi.org/10.3390/ijerph19116470','The ongoing COVID-19 pandemic has impacted the mental health of populations and highlighted the limitations of mental health care systems. As the trajectory of the pandemic and the economic recovery are still uncertain, decision tools are needed to help evaluate the best interventions to improve mental health outcomes. We developed a system dynamics model that captures causal relationships among population, demographics, post-secondary education, health services, COVID-19 impact, and mental health outcomes. The study was conducted in the Australian state of Victoria. The model was calibrated using historical data and was stratified by age group and by geographic remoteness. Findings demonstrate that the most effective intervention combination includes economic, social, and health sector initiatives. Assertive post-suicide attempt care is the most impactful health sector intervention, but delaying implementation reduces the potency of its impact. Some evidence-based interventions, such as population-wide community awareness campaigns, are projected to worsen mental health outcomes when implemented on their own. Systems modelling offers a powerful decision-support tool to test alternative strategies for improving mental health outcomes in the Victorian context.',NULL,NULL,'2022-05-26',NULL,NULL,NULL,1),(108,'\'Turning the tide\' on hyperglycemia in pregnancy: insights from multiscale dynamic simulation modeling','https://doi.org/10.1136/bmjdrc-2019-000975',NULL,NULL,NULL,'2020-05-31',NULL,NULL,NULL,NULL),(109,'Can the Target Set for Reducing Childhood Overweight and Obesity Be Met? A System Dynamics Modelling Study in New South Wales, Australia','https://doi.org/10.1002/sres.2555',NULL,NULL,NULL,'2018-09-21',NULL,NULL,NULL,NULL),(110,'Policy options for endgame planning in tobacco control: A simulation modelling study','http://dx.doi.org/10.1136/tobaccocontrol-2019-055126',NULL,NULL,NULL,'2019-12-19',NULL,NULL,NULL,NULL),(111,'Test Project','qweqwe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'article'),(2,'other');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','password'),(2,'user1','pbkdf2:sha256:260000$OgCcPou8cL4a6sgX$612c9f408aa22c37bc642442fc9fd55584721d0ebdb56305aa60cef30a8c40b0'),(3,'user2','pbkdf2:sha256:260000$ljwy6IqBm2Ox24FL$df682a6df84251bbc614dd4c86565ee2443cbca4ca6c82849c38743ac5d83f97');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 11:59:23
