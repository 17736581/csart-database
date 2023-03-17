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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Ante Prodan','A.Prodan@westernsydney.edu.au','http://www.csart-world.com/','Association for Computing Machinery, Monash University, Sax Institute, The University of Sydney Brain and Mind Centre, University of Technology Sydney, Western Sydney University',NULL),(2,'Jo-An Occhipinti',NULL,NULL,NULL,NULL),(3,'Nathaniel Osgood',NULL,NULL,NULL,NULL),(4,'Paulo Gonçalves',NULL,NULL,NULL,NULL),(5,'Patricia Mabry',NULL,NULL,NULL,NULL),(6,'Robin Purshouse',NULL,NULL,NULL,NULL),(15,'Frank Iorfino',NULL,NULL,NULL,NULL),(16,'Adam Skinner',NULL,NULL,NULL,NULL),(17,'Tracey Davenport',NULL,NULL,NULL,NULL),(18,'Shelley Rowe',NULL,NULL,NULL,NULL),(19,'Julie Sturgess',NULL,NULL,NULL,NULL),(20,'Ian Hickie','ian.hickie@sydney.edu.au',NULL,'RANZCP, University of New South Wales, University of Sydney','Prof Hickie has just been reappointed an NHMRC Senior Principal Research Fellow (2018-22, previously SPRF 2013-17) and was previously an NHMRC Australian Research Fellow (2007-12). He is a Fellow of the Academy of Social Sciences in Australia and Co-Director, Health and Policy, of the Brain & Mind Centre (BMC), University of Sydney. From 2012 to 2018, he was a Commissioner of the Australian National Mental Health Commission (NMHC), with a major focus on improving outcome measurement and improved accountability for Australia’s investments in mental health services. In partnership with the Mental Health Council of Australia, the Human Rights and Equal Opportunities Commission, Orygen Youth Health, the Young & Well CRC and the National Mental Health Commission, he has authored major national reports on community experiences of mental health services. Prof Hickie was a key participant in the most recent 2014 NMHC review of Mental Health Programmes and Services, which served as the template for the 2015 Turnbull Government initiatives in Mental Health Reform (total value $190M), including specifically the $30M Project Synergy investment in new technologies and the new $90M investment in 12 large regional trials of suicide prevention. His long-standing commitment to the impact of mental health research on mental health service improvement, through active engagement with those with lived experiences (patients, families and communities) in Australia is evident in his: i) capacity to facilitate public engagement with mental health issues, notably through his initial CEO role with beyondblue (2000-03); ii) engagement with major national mental health service reports over two decades (notably 2006, Not For Service Report with Human Rights and Equal Opportunities Commission); iii) continuous public commentary on contemporary mental health and suicide prevention issues; and iv) role in implementation of substantive health services reform in Australia (e.g. headspace and Young&Well CRC and now Project Synergy). He has been recognised nationally for his role over the last two decades in using clinical, health services and population health data to drive enhanced primary care services, increased access to psychological treatments and better interventions for those with severe mood disorders. In partnership with Prof Pat McGorry, he has been at the forefront of development and systematic evaluation of the new primary care based national youth mental health services (headspace). He has been a critical voice in the advocacy for enhanced social and health services for those with persistent mental illness and increased accountability for delivery of those services.'),(47,'Danya Rose',NULL,NULL,NULL,NULL),(48,'Daniel Rock',NULL,NULL,NULL,NULL),(49,'Yun Ju Christine Song',NULL,NULL,NULL,NULL),(50,'Sebastian Rosenberg',NULL,NULL,NULL,NULL),(51,'Louise Freebairn',NULL,NULL,NULL,NULL),(52,'Catherine Vacher',NULL,NULL,NULL,NULL),(58,'Andrew Page',NULL,NULL,NULL,NULL),(59,'Geoff McDonnell',NULL,NULL,NULL,NULL),(60,'Mark Heffernan',NULL,NULL,NULL,NULL),(61,'Bill Campos',NULL,NULL,NULL,NULL),(62,'Graham Meadows',NULL,NULL,NULL,NULL),(63,'Dylan Knowles',NULL,NULL,NULL,NULL),(64,'John Wiggers',NULL,NULL,NULL,NULL),(65,'Michael Livingston',NULL,NULL,NULL,NULL),(66,'Robin Room',NULL,NULL,NULL,NULL),(67,'Eloise O\'Donnell',NULL,NULL,NULL,NULL),(68,'Sandra Jones',NULL,NULL,NULL,NULL),(69,'Paul S Haber',NULL,NULL,NULL,NULL),(70,'David Muscatello',NULL,NULL,NULL,NULL),(71,'Nadine Ezard',NULL,NULL,NULL,NULL),(72,'Nghi Phung',NULL,NULL,NULL,NULL),(73,'Devon Indig',NULL,NULL,NULL,NULL),(74,'Lucie Rychetnik',NULL,NULL,NULL,NULL),(75,'Jaithri Ananthapavan',NULL,NULL,NULL,NULL),(76,'Sonia Wutzke',NULL,NULL,NULL,NULL),(77,'Jan Scott',NULL,NULL,NULL,NULL),(78,'Kirill Glavatsky',NULL,NULL,NULL,NULL),(108,'Nicholas Ho',NULL,NULL,NULL,NULL),(109,'Jo Robinson',NULL,NULL,NULL,NULL),(110,'Grace Yeeun Lee',NULL,NULL,NULL,NULL),(111,'Christopher J Nolan',NULL,NULL,NULL,NULL),(112,'Paul M Kelly',NULL,NULL,NULL,NULL),(113,'Yang Qin',NULL,NULL,NULL,NULL),(114,'Weicheng Qian',NULL,NULL,NULL,NULL),(115,'Anahita Safarishahrbijari',NULL,NULL,NULL,NULL),(116,'Luke Penza',NULL,NULL,NULL,NULL),(117,'Allen McLean',NULL,NULL,NULL,NULL),(118,'Alison L Kent',NULL,NULL,NULL,NULL),(119,'Roland Dyck',NULL,NULL,NULL,NULL),(120,'Louise Maple-Brown',NULL,NULL,NULL,NULL),(121,'Vincy Li',NULL,NULL,NULL,NULL),(122,'Nick Roberts',NULL,NULL,NULL,NULL),(123,'Thomas Lung',NULL,NULL,NULL,NULL),(124,'Suzanne Nieuwenhuizen',NULL,NULL,NULL,NULL),(125,'Bev Lloyd',NULL,NULL,NULL,NULL),(126,'Jo Mitchell',NULL,NULL,NULL,NULL),(127,'Lennert Veerman',NULL,NULL,NULL,NULL),(128,'Margaret Bright',NULL,NULL,NULL,NULL),(129,'Pippy Walker',NULL,NULL,NULL,NULL),(130,'Rebecca Whitehead',NULL,NULL,NULL,NULL),(131,'Suzan Burton',NULL,NULL,NULL,NULL),(132,'Tim Roselli',NULL,NULL,NULL,NULL),(133,'David P Thomas',NULL,NULL,NULL,NULL),(134,'Mark West',NULL,NULL,NULL,NULL),(135,'Elizabeth M Scott',NULL,NULL,NULL,NULL),(136,'Haley M LaMonica',NULL,NULL,NULL,NULL),(137,'Anna E Roberts',NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES (66,'Adolescent psychiatry'),(1,'agent based modelling'),(2,'agent based systems'),(73,'aging'),(51,'alcohol-related harm'),(35,'care coordination'),(40,'casual loop diagrams'),(58,'causal modeling'),(62,'cessation'),(59,'childhood obesity'),(72,'community-based participatory research'),(4,'complex systems'),(3,'computer simulation'),(8,'decision analysis'),(39,'dynamics complexity'),(64,'end game'),(44,'epidemiology'),(52,'evidence synthesis'),(55,'gestational diabetes mellitus'),(68,'health care reform'),(36,'health systems'),(38,'humanitarian relief operations'),(34,'internet'),(33,'medical informatics'),(11,'mental health'),(67,'Mental health policy'),(43,'mental health services'),(69,'mobile phone'),(57,'modeling'),(65,'Mood disorders'),(37,'policy'),(56,'population health'),(50,'prevention policy'),(5,'public health'),(60,'public health policy'),(63,'public policy'),(10,'simulation'),(42,'simulation modeling'),(70,'stakeholder participation'),(7,'strategic planning'),(45,'suicide'),(6,'suicide prevention'),(41,'system dynamics'),(61,'system dynamics modelling'),(9,'systems modelling'),(71,'technology');
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
  `author_order` int(11) DEFAULT NULL,
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
INSERT INTO `project_authors` VALUES (41,1,5),(41,2,1),(41,15,0),(41,16,2),(41,17,3),(41,18,4),(41,19,6),(41,20,7),(43,4,NULL),(68,1,5),(68,2,0),(68,16,2),(68,20,9),(68,47,1),(68,48,3),(68,49,4),(68,50,6),(68,51,7),(68,52,8),(71,1,NULL),(71,2,NULL),(71,3,NULL),(71,58,NULL),(71,59,NULL),(72,1,NULL),(72,2,NULL),(72,20,NULL),(72,58,NULL),(72,59,NULL),(72,60,NULL),(72,61,NULL),(72,62,NULL),(73,1,NULL),(73,2,NULL),(73,51,NULL),(73,59,NULL),(73,63,NULL),(73,64,NULL),(73,65,NULL),(73,66,NULL),(73,67,NULL),(73,68,NULL),(73,69,NULL),(73,70,NULL),(73,71,NULL),(73,72,NULL),(73,73,NULL),(73,74,NULL),(73,75,NULL),(73,76,NULL),(74,15,NULL),(74,20,NULL),(74,77,NULL),(74,78,NULL),(107,1,7),(107,2,9),(107,15,6),(107,16,2),(107,20,10),(107,49,8),(107,51,4),(107,52,0),(107,108,1),(107,109,3),(107,110,5),(108,1,7),(108,2,1),(108,3,14),(108,51,0),(108,59,13),(108,111,3),(108,112,5),(108,113,2),(108,114,9),(108,115,8),(108,116,6),(108,117,12),(108,118,4),(108,119,11),(108,120,10),(109,1,NULL),(109,2,NULL),(109,51,NULL),(109,59,NULL),(109,60,NULL),(109,64,NULL),(109,121,NULL),(109,122,NULL),(109,123,NULL),(109,124,NULL),(109,125,NULL),(109,126,NULL),(110,1,NULL),(110,2,NULL),(110,16,NULL),(110,59,NULL),(110,60,NULL),(110,127,NULL),(110,128,NULL),(110,129,NULL),(110,130,NULL),(110,131,NULL),(110,132,NULL),(110,133,NULL),(110,134,NULL),(111,1,NULL),(111,4,NULL),(116,15,0),(116,20,2),(116,135,1),(118,17,1),(118,20,3),(118,136,0),(118,137,2);
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
INSERT INTO `project_keywords` VALUES (41,4),(41,10),(41,11),(41,33),(41,34),(41,35),(41,36),(41,37),(41,44),(43,4),(43,38),(43,39),(43,40),(43,41),(43,42),(68,6),(68,7),(68,8),(68,9),(68,10),(68,11),(72,41),(72,43),(72,44),(72,45),(73,1),(73,50),(73,51),(73,52),(107,8),(107,9),(107,11),(108,55),(108,56),(108,57),(108,58),(109,50),(109,52),(109,59),(109,60),(109,61),(110,62),(110,63),(110,64),(111,51),(111,62),(116,65),(116,66),(116,67),(118,11),(118,68),(118,69),(118,70),(118,71),(118,72),(118,73);
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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (41,'The Impact of Technology-Enabled Care Coordination in a Complex Mental Health System: A Local System Dynamics Model','https://www.jmir.org/2021/6/e25331/',NULL,NULL,NULL,'2021-06-30',NULL,NULL,NULL,NULL),(43,'System Dynamics Modeling of Humanitarian Relief Operations','https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1139817#',NULL,NULL,NULL,'2008-06-02',NULL,NULL,NULL,NULL),(68,'Sound Decision Making in Uncertain Times: Can Systems Modelling Be Useful for Informing Policy and Planning for Suicide Prevention?','https://www.mdpi.com/1660-4601/19/3/1468',NULL,NULL,NULL,'2022-01-27',NULL,NULL,NULL,NULL),(71,'Systems modelling tools to support policy and planning','https://doi.org/10.1016/S0140-6736(18)30302-7',NULL,NULL,NULL,'2018-03-24',NULL,NULL,NULL,NULL),(72,'The impact of strengthening mental health services to prevent suicidal behaviour','https://doi.org/10.1177%2F0004867418817381',NULL,NULL,NULL,'2018-12-12',NULL,NULL,NULL,NULL),(73,'Harnessing advances in computer simulation to inform policy and planning to reduce alcohol-related harms','https://doi.org/10.1007/s00038-017-1041-y',NULL,NULL,NULL,'2017-10-19',NULL,NULL,NULL,NULL),(74,'Youth Mania Model',NULL,NULL,'2021-03-01',NULL,NULL,'Australia','MRFF',3100000,NULL),(107,'Optimizing Strategies for Improving Mental Health in Victoria, Australia during the COVID-19 Era: A System Dynamics Modelling Study','https://doi.org/10.3390/ijerph19116470','The ongoing COVID-19 pandemic has impacted the mental health of populations and highlighted the limitations of mental health care systems. As the trajectory of the pandemic and the economic recovery are still uncertain, decision tools are needed to help evaluate the best interventions to improve mental health outcomes. We developed a system dynamics model that captures causal relationships among population, demographics, post-secondary education, health services, COVID-19 impact, and mental health outcomes. The study was conducted in the Australian state of Victoria. The model was calibrated using historical data and was stratified by age group and by geographic remoteness. Findings demonstrate that the most effective intervention combination includes economic, social, and health sector initiatives. Assertive post-suicide attempt care is the most impactful health sector intervention, but delaying implementation reduces the potency of its impact. Some evidence-based interventions, such as population-wide community awareness campaigns, are projected to worsen mental health outcomes when implemented on their own. Systems modelling offers a powerful decision-support tool to test alternative strategies for improving mental health outcomes in the Victorian context.',NULL,NULL,'2022-05-26',NULL,NULL,NULL,1),(108,'\'Turning the tide\' on hyperglycemia in pregnancy: insights from multiscale dynamic simulation modeling','https://doi.org/10.1136/bmjdrc-2019-000975','Introduction Hyperglycemia in pregnancy (HIP, including gestational diabetes and pre-existing type 1 and type 2 diabetes) is increasing, with associated risks to the health of women and their babies. Strategies to manage and prevent this condition are contested. Dynamic simulation models (DSM) can test policy and program scenarios before implementation in the real world. This paper reports the development and use of an advanced DSM exploring the impact of maternal weight status interventions on incidence of HIP.\r\n\r\nMethods A consortium of experts collaboratively developed a hybrid DSM of HIP, comprising system dynamics, agent-based and discrete event model components. The structure and parameterization drew on a range of evidence and data sources. Scenarios comparing population-level and targeted prevention interventions were simulated from 2018 to identify the intervention combination that would deliver the greatest impact.\r\n\r\nResults Population interventions promoting weight loss in early adulthood were found to be effective, reducing the population incidence of HIP by 17.3% by 2030 (baseline (‘business as usual’ scenario)=16.1%, 95% CI 15.8 to 16.4; population intervention=13.3%, 95% CI 13.0 to 13.6), more than targeted prepregnancy (5.2% reduction; incidence=15.3%, 95% CI 15.0 to 15.6) and interpregnancy (4.2% reduction; incidence=15.5%, 95% CI 15.2 to 15.8) interventions. Combining targeted interventions for high-risk groups with population interventions promoting healthy weight was most effective in reducing HIP incidence (28.8% reduction by 2030; incidence=11.5, 95% CI 11.2 to 11.8). Scenarios exploring the effect of childhood weight status on entry to adulthood demonstrated significant impact in the selected outcome measure for glycemic regulation, insulin sensitivity in the short term and HIP in the long term.\r\n\r\nDiscussion Population-level weight reduction interventions will be necessary to ‘turn the tide’ on HIP. Weight reduction interventions targeting high-risk individuals, while beneficial for those individuals, did not significantly impact forecasted HIP incidence rates. The importance of maintaining interventions promoting healthy weight in childhood was demonstrated.',NULL,NULL,'2020-05-31',NULL,NULL,NULL,NULL),(109,'Can the Target Set for Reducing Childhood Overweight and Obesity Be Met? A System Dynamics Modelling Study in New South Wales, Australia','https://doi.org/10.1002/sres.2555',NULL,NULL,NULL,'2018-09-21',NULL,NULL,NULL,NULL),(110,'Policy options for endgame planning in tobacco control: A simulation modelling study','http://dx.doi.org/10.1136/tobaccocontrol-2019-055126',NULL,NULL,NULL,'2019-12-19',NULL,NULL,NULL,NULL),(111,'Test Project','qweqwe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(116,'Social and occupational outcomes for young people who attend early intervention mental health services: a longitudinal study','https://doi.org/10.5694/mja2.51653','Objective: To identify trajectories of social and occupational functioning in young people during the two years after presenting for early intervention mental health care; to identify demographic and clinical factors that influence these trajectories.\r\n\r\nDesign: Longitudinal, observational study of young people presenting for mental health care.\r\n\r\nSetting: Two primary care‐based early intervention mental health services at the Brain and Mind Centre (University of Sydney), 1 June 2008 – 31 July 2018.\r\n\r\nParticipants: 1510 people aged 12‒25 years who had presented with anxiety, mood, or psychotic disorders, for whom two years’ follow‐up data were available for analysis.\r\n\r\nMain outcome measures: Latent class trajectories of social and occupational functioning based on growth mixture modelling of Social and Occupational Assessment Scale (SOFAS) scores.\r\n\r\nResults: We identified four trajectories of functioning during the first two years of care: deteriorating and volatile (733 participants, 49%); persistent impairment (237, 16%); stable good functioning (291, 19%); and improving, but late recurrence (249, 16%). The less favourable trajectories (deteriorating and volatile; persistent impairment) were associated with physical comorbidity, not being in education, employment, or training, having substance‐related disorders, having been hospitalised, and having a childhood onset mental disorder, psychosis‐like experiences, or a history of self‐harm or suicidality.\r\n\r\nConclusions: Two in three young people with emerging mental disorders did not experience meaningful improvement in social and occupational functioning during two years of early intervention care. Most functional trajectories were also quite volatile, indicating the need for dynamic service models that emphasise multidisciplinary interventions and measurement‐based care.',NULL,NULL,'2022-08-15',NULL,NULL,NULL,1),(118,'Understanding Technology Preferences and Requirements for Health Information Technologies Designed to Improve and Maintain the Mental Health and Well-Being of Older Adults: Participatory Design Study','https://doi.org/10.2196/21461','Background:\r\nWorldwide, the population is aging rapidly; therefore, there is a growing interest in strategies to support and maintain health and well-being in later life. Although familiarity with technology and digital literacy are increasing among this group, some older adults still lack confidence in their ability to use web-based technologies. In addition, age-related changes in cognition, vision, hearing, and perception may be barriers to adoption and highlight the need for digital tools developed specifically to meet the unique needs of older adults.\r\n\r\nObjective:\r\nThe aim of this study is to understand the use of technology by older adults in general and identify the potential barriers to and facilitators of the adoption of health information technologies (HITs) to support the health and well-being of older adults to facilitate implementation and promote user uptake. In addition, this study aims to co-design and configure the InnoWell Platform, a digital tool designed to facilitate better outcomes for people seeking mental health services, to meet the needs of adults 50 years and older and their supportive others (eg, family members, caregivers) to ensure the accessibility, engagement, and appropriateness of the technology.\r\n\r\nMethods:\r\nParticipants were adults 50 years and older and those who self-identified as a supportive other (eg, family member, caregiver). Participants were invited to participate in a 3-hour participatory design workshop using a variety of methods, including prompted discussion, creation of descriptive artifacts, and group-based development of user journeys.\r\n\r\nResults:\r\nFour participatory design workshops were conducted, including a total of 21 participants, each attending a single workshop. Technology use was prevalent, with a preference indicated for smartphones and computers. Factors facilitating the adoption of HITs included personalization of content and functionality to meet and be responsive to a consumer’s needs, access to up-to-date information from reputable sources, and integration with standard care practices to support the relationship with health professionals. Concerns regarding data privacy and security were the primary barriers to the use of technology to support mental health and well-being.\r\n\r\nConclusions:\r\nAlthough HITs have the potential to improve access to cost-effective and low-intensity interventions at scale for improving and maintaining mental health and well-being, several strategies may improve the uptake and efficacy of technologies by the older adult community, including the use of co-design methodologies to ensure usability, acceptability, and appropriateness of the technology; support in using and understanding the clinical applications of the technology by a digital navigator; and ready availability of education and training materials.',NULL,NULL,'2021-06-01',NULL,NULL,NULL,1);
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

-- Dump completed on 2023-02-20 15:19:39
