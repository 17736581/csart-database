-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2022 at 06:53 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `csart_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL,
  `author_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `affiliations` text DEFAULT NULL,
  `statement` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `author_name`, `email`, `website`, `affiliations`, `statement`) VALUES
(1, 'Ante Prodan', 'A.Prodan@westernsydney.edu.au', 'http://www.csart-world.com/', 'Association for Computing Machinery, Monash University, Sax Institute, The University of Sydney Brain and Mind Centre, University of Technology Sydney, Western Sydney University', NULL),
(2, 'Jo-An Occhipinti', NULL, NULL, '', NULL),
(3, 'Nathaniel Osgood', NULL, NULL, NULL, NULL),
(4, 'Paulo Gonçalves', NULL, NULL, NULL, NULL),
(5, 'Patricia Mabry', NULL, NULL, NULL, NULL),
(6, 'Robin Purshouse', NULL, NULL, NULL, NULL),
(15, 'Frank Iorfino', NULL, NULL, NULL, NULL),
(16, 'Adam Skinner', NULL, NULL, NULL, NULL),
(17, 'Tracey Davenport', NULL, NULL, NULL, NULL),
(18, 'Shelley Rowe', NULL, NULL, NULL, NULL),
(19, 'Julie Sturgess', NULL, NULL, NULL, NULL),
(20, 'Ian Hickie', 'ian.hickie@sydney.edu.au', NULL, 'RANZCP, University of New South Wales, University of Sydney', 'Prof Hickie has just been reappointed an NHMRC Senior Principal Research Fellow (2018-22, previously SPRF 2013-17) and was previously an NHMRC Australian Research Fellow (2007-12). He is a Fellow of the Academy of Social Sciences in Australia and Co-Director, Health and Policy, of the Brain & Mind Centre (BMC), University of Sydney. From 2012 to 2018, he was a Commissioner of the Australian National Mental Health Commission (NMHC), with a major focus on improving outcome measurement and improved accountability for Australia’s investments in mental health services. In partnership with the Mental Health Council of Australia, the Human Rights and Equal Opportunities Commission, Orygen Youth Health, the Young & Well CRC and the National Mental Health Commission, he has authored major national reports on community experiences of mental health services. Prof Hickie was a key participant in the most recent 2014 NMHC review of Mental Health Programmes and Services, which served as the template for the 2015 Turnbull Government initiatives in Mental Health Reform (total value $190M), including specifically the $30M Project Synergy investment in new technologies and the new $90M investment in 12 large regional trials of suicide prevention. His long-standing commitment to the impact of mental health research on mental health service improvement, through active engagement with those with lived experiences (patients, families and communities) in Australia is evident in his: i) capacity to facilitate public engagement with mental health issues, notably through his initial CEO role with beyondblue (2000-03); ii) engagement with major national mental health service reports over two decades (notably 2006, Not For Service Report with Human Rights and Equal Opportunities Commission); iii) continuous public commentary on contemporary mental health and suicide prevention issues; and iv) role in implementation of substantive health services reform in Australia (e.g. headspace and Young&Well CRC and now Project Synergy). He has been recognised nationally for his role over the last two decades in using clinical, health services and population health data to drive enhanced primary care services, increased access to psychological treatments and better interventions for those with severe mood disorders. In partnership with Prof Pat McGorry, he has been at the forefront of development and systematic evaluation of the new primary care based national youth mental health services (headspace). He has been a critical voice in the advocacy for enhanced social and health services for those with persistent mental illness and increased accountability for delivery of those services.'),
(47, 'Danya Rose', NULL, NULL, NULL, NULL),
(48, 'Daniel Rock', NULL, NULL, NULL, NULL),
(49, 'Yun Ju Christine Song', NULL, NULL, NULL, NULL),
(50, 'Sebastian Rosenberg', NULL, NULL, NULL, NULL),
(51, 'Louise Freebairn', NULL, NULL, NULL, NULL),
(52, 'Catherine Vacher', NULL, NULL, NULL, NULL),
(58, 'Andrew Page', NULL, NULL, NULL, NULL),
(59, 'Geoff McDonnell', NULL, NULL, NULL, NULL),
(60, 'Mark Heffernan', NULL, NULL, NULL, NULL),
(61, 'Bill Campos', NULL, NULL, NULL, NULL),
(62, 'Graham Meadows', NULL, NULL, NULL, NULL),
(63, 'Dylan Knowles', NULL, NULL, NULL, NULL),
(64, 'John Wiggers', NULL, NULL, NULL, NULL),
(65, 'Michael Livingston', NULL, NULL, NULL, NULL),
(66, 'Robin Room', NULL, NULL, NULL, NULL),
(67, 'Eloise O\'Donnell', NULL, NULL, NULL, NULL),
(68, 'Sandra Jones', NULL, NULL, NULL, NULL),
(69, 'Paul S Haber', NULL, NULL, NULL, NULL),
(70, 'David Muscatello', NULL, NULL, NULL, NULL),
(71, 'Nadine Ezard', NULL, NULL, NULL, NULL),
(72, 'Nghi Phung', NULL, NULL, NULL, NULL),
(73, 'Devon Indig', NULL, NULL, NULL, NULL),
(74, 'Lucie Rychetnik', NULL, NULL, NULL, NULL),
(75, 'Jaithri Ananthapavan', NULL, NULL, NULL, NULL),
(76, 'Sonia Wutzke', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `keyword_id` int(11) NOT NULL,
  `keyword_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keywords`
--

INSERT INTO `keywords` (`keyword_id`, `keyword_name`) VALUES
(1, 'agent based modelling'),
(2, 'agent based systems'),
(3, 'computer simulation'),
(4, 'complex systems'),
(5, 'public health'),
(6, 'suicide prevention'),
(7, 'strategic planning'),
(8, 'decision analysis'),
(9, 'systems modelling'),
(10, 'simulation'),
(11, 'mental health');

-- --------------------------------------------------------

--
-- Table structure for table `other_names`
--

CREATE TABLE `other_names` (
  `other_name_id` int(11) NOT NULL,
  `other_name` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `other_names`
--

INSERT INTO `other_names` (`other_name_id`, `other_name`, `author_id`) VALUES
(1, 'Jo-An Atkinson', 2),
(2, 'Ian B. Hickie', 20),
(3, 'Ian B Hickie', 20);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `url` varchar(2048) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funding_org` varchar(255) DEFAULT NULL,
  `funding_amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_name`, `url`, `start_date`, `end_date`, `release_date`, `country`, `funding_org`, `funding_amount`) VALUES
(41, 'The Impact of Technology-Enabled Care Coordination in a Complex Mental Health System: A Local System Dynamics Model', 'https://www.jmir.org/2021/6/e25331/', NULL, NULL, '2021-06-30', NULL, NULL, NULL),
(43, 'System Dynamics Modeling of Humanitarian Relief Operations', 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1139817#', NULL, NULL, '2008-06-02', NULL, NULL, NULL),
(68, 'Sound Decision Making in Uncertain Times: Can Systems Modelling Be Useful for Informing Policy and Planning for Suicide Prevention?', 'https://www.mdpi.com/1660-4601/19/3/1468', NULL, NULL, '2022-01-27', NULL, NULL, NULL),
(71, 'Systems modelling tools to support policy and planning', 'https://doi.org/10.1016/S0140-6736(18)30302-7', NULL, NULL, '2018-03-24', NULL, NULL, NULL),
(72, 'The impact of strengthening mental health services to prevent suicidal behaviour', 'https://doi.org/10.1177%2F0004867418817381', NULL, NULL, '2018-12-12', NULL, NULL, NULL),
(73, 'Harnessing advances in computer simulation to inform policy and planning to reduce alcohol-related harms', 'https://doi.org/10.1007/s00038-017-1041-y', NULL, NULL, '2017-10-19', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `project_authors`
--

CREATE TABLE `project_authors` (
  `project_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_authors`
--

INSERT INTO `project_authors` (`project_id`, `author_id`) VALUES
(41, 1),
(41, 2),
(41, 15),
(41, 16),
(41, 17),
(41, 18),
(41, 19),
(41, 20),
(43, 4),
(68, 1),
(68, 2),
(68, 16),
(68, 20),
(68, 47),
(68, 48),
(68, 49),
(68, 50),
(68, 51),
(68, 52),
(71, 1),
(71, 2),
(71, 3),
(71, 58),
(71, 59),
(72, 1),
(72, 2),
(72, 20),
(72, 58),
(72, 59),
(72, 60),
(72, 61),
(72, 62),
(73, 1),
(73, 2),
(73, 51),
(73, 59),
(73, 63),
(73, 64),
(73, 65),
(73, 66),
(73, 67),
(73, 68),
(73, 69),
(73, 70),
(73, 71),
(73, 72),
(73, 73),
(73, 74),
(73, 75),
(73, 76);

-- --------------------------------------------------------

--
-- Table structure for table `project_keywords`
--

CREATE TABLE `project_keywords` (
  `project_id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_keywords`
--

INSERT INTO `project_keywords` (`project_id`, `keyword_id`) VALUES
(68, 6),
(68, 7),
(68, 8),
(68, 9),
(68, 10),
(68, 11);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `hash`) VALUES
(1, 'user', 'password'),
(2, 'user1', 'pbkdf2:sha256:260000$OgCcPou8cL4a6sgX$612c9f408aa22c37bc642442fc9fd55584721d0ebdb56305aa60cef30a8c40b0'),
(3, 'user2', 'pbkdf2:sha256:260000$ljwy6IqBm2Ox24FL$df682a6df84251bbc614dd4c86565ee2443cbca4ca6c82849c38743ac5d83f97');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`keyword_id`);

--
-- Indexes for table `other_names`
--
ALTER TABLE `other_names`
  ADD PRIMARY KEY (`other_name_id`),
  ADD KEY `fk_author_id` (`author_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `project_authors`
--
ALTER TABLE `project_authors`
  ADD PRIMARY KEY (`project_id`,`author_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `project_keywords`
--
ALTER TABLE `project_keywords`
  ADD PRIMARY KEY (`project_id`,`keyword_id`),
  ADD KEY `keyword_id` (`keyword_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `keywords`
--
ALTER TABLE `keywords`
  MODIFY `keyword_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `other_names`
--
ALTER TABLE `other_names`
  MODIFY `other_name_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `other_names`
--
ALTER TABLE `other_names`
  ADD CONSTRAINT `fk_author_id` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`);

--
-- Constraints for table `project_authors`
--
ALTER TABLE `project_authors`
  ADD CONSTRAINT `project_authors_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  ADD CONSTRAINT `project_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`);

--
-- Constraints for table `project_keywords`
--
ALTER TABLE `project_keywords`
  ADD CONSTRAINT `project_keywords_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  ADD CONSTRAINT `project_keywords_ibfk_2` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`keyword_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
