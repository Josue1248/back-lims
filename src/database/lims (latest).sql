-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 19, 2019 at 05:50 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `lims`
--

-- --------------------------------------------------------

--
-- Table structure for table `attribute`
--

CREATE TABLE IF NOT EXISTS `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(99) NOT NULL,
  `unit` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `attribute`
--

INSERT INTO `attribute` (`id`, `name`, `unit`) VALUES
(1, 'Chemistry', 'Q'),
(2, 'Temperature', 'C'),
(3, 'Time Elapse', 'Sec'),
(4, 'Velocity', 'RPM');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator_Id` int(11) NOT NULL,
  `sample_Id` int(11) NOT NULL,
  `test_Id` int(11) NOT NULL,
  `status_Id` int(11) NOT NULL,
  `onCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Log_test_id` (`test_Id`),
  KEY `fk_Log_operator_id` (`operator_Id`),
  KEY `fk_Log_sample_id` (`sample_Id`),
  KEY `fk_Log_status_id` (`status_Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `operator_Id`, `sample_Id`, `test_Id`, `status_Id`, `onCreated`) VALUES
(1, 12345, 1, 1, 5, '2019-02-15 08:40:46'),
(2, 12345, 1, 1, 2, '2019-02-15 08:40:46'),
(3, 12345, 2, 1, 5, '2019-02-15 08:55:10'),
(4, 12345, 2, 1, 2, '2019-02-15 08:55:10'),
(5, 12345, 3, 1, 5, '2019-02-15 08:55:10'),
(6, 12345, 3, 1, 2, '2019-02-15 08:55:10'),
(7, 12345, 4, 1, 5, '2019-02-15 08:55:10'),
(8, 12345, 4, 1, 2, '2019-02-15 08:55:11'),
(9, 12345, 5, 1, 5, '2019-02-15 08:55:11'),
(10, 12345, 5, 1, 2, '2019-02-15 08:55:11'),
(11, 12345, 6, 1, 5, '2019-02-15 08:55:11'),
(12, 12345, 6, 1, 2, '2019-02-15 08:55:11'),
(13, 12345, 7, 1, 5, '2019-02-15 08:55:11'),
(14, 12345, 7, 1, 2, '2019-02-15 08:55:11'),
(15, 12345, 8, 1, 5, '2019-02-15 08:55:11'),
(16, 12345, 8, 1, 2, '2019-02-15 08:55:11'),
(17, 12345, 9, 1, 5, '2019-02-15 08:55:11'),
(18, 12345, 9, 1, 2, '2019-02-15 08:55:11'),
(19, 12345, 10, 1, 5, '2019-02-15 08:55:11'),
(20, 12345, 10, 1, 2, '2019-02-15 08:55:11'),
(21, 12345, 11, 1, 5, '2019-02-15 09:41:36'),
(22, 12345, 11, 1, 2, '2019-02-15 09:41:36'),
(23, 619, 12, 1, 5, '2019-02-15 10:38:56'),
(24, 619, 12, 1, 2, '2019-02-15 10:38:56'),
(25, 619, 12, 8, 8, '2019-02-15 10:44:31'),
(26, 619, 12, 8, 1, '2019-02-15 10:44:31'),
(27, 619, 12, 9, 9, '2019-02-15 10:59:37'),
(28, 619, 12, 9, 3, '2019-02-15 10:59:37'),
(29, 619, 13, 1, 5, '2019-02-15 15:16:22'),
(30, 619, 13, 1, 2, '2019-02-15 15:16:22'),
(31, 619, 13, 8, 8, '2019-02-15 15:20:24'),
(32, 619, 13, 8, 1, '2019-02-15 15:20:24'),
(33, 619, 14, 1, 5, '2019-02-15 15:30:23'),
(34, 619, 14, 1, 2, '2019-02-15 15:30:23'),
(35, 619, 15, 1, 5, '2019-02-15 15:45:07'),
(36, 619, 15, 1, 2, '2019-02-15 15:45:08'),
(37, 619, 15, 8, 8, '2019-02-15 15:45:15'),
(38, 619, 15, 8, 1, '2019-02-15 15:45:15'),
(39, 619, 15, 9, 9, '2019-02-15 15:45:20'),
(40, 619, 15, 9, 3, '2019-02-15 15:45:20'),
(41, 619, 15, 10, 10, '2019-02-15 15:45:46'),
(42, 619, 15, 10, 11, '2019-02-15 15:45:46'),
(43, 12345, 16, 1, 5, '2019-02-18 09:58:39'),
(44, 12345, 16, 1, 2, '2019-02-18 09:58:39'),
(45, 12345, 16, 8, 8, '2019-02-18 10:01:34'),
(46, 12345, 16, 8, 1, '2019-02-18 10:01:34'),
(47, 12345, 16, 9, 9, '2019-02-18 10:01:41'),
(48, 12345, 16, 9, 3, '2019-02-18 10:01:41'),
(49, 1, 17, 1, 5, '2019-02-18 10:24:28'),
(50, 1, 17, 1, 2, '2019-02-18 10:24:28');

-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE IF NOT EXISTS `operator` (
  `id` int(11) NOT NULL,
  `name` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operator`
--

INSERT INTO `operator` (`id`, `name`) VALUES
(0, '12345'),
(1, 'Josue '),
(619, 'Testing'),
(12345, 'Luis Villalobos');

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE IF NOT EXISTS `sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`id`, `name`) VALUES
(1, 'SA-00-00010'),
(2, 'SA-00-00011'),
(3, 'SA-00-00012'),
(4, 'SA-00-00013'),
(5, 'SA-00-00014'),
(6, 'SA-00-00015'),
(7, 'SA-00-00016'),
(8, 'SA-00-00017'),
(9, 'SA-00-00018'),
(10, 'SA-00-00019'),
(11, 'SA-00-00020'),
(12, 'SA-12-12345'),
(13, 'SA-12-99997'),
(14, 'SA-12-12387'),
(15, 'SA-12-12398'),
(16, 'SA-00-00030'),
(17, 'SA-64-64565');

-- --------------------------------------------------------

--
-- Table structure for table `samplevalue`
--

CREATE TABLE IF NOT EXISTS `samplevalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_Id` int(11) NOT NULL,
  `test_Id` int(11) NOT NULL,
  `attribute_Id` int(11) NOT NULL,
  `value` varchar(99) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SampleValue_sample_id` (`sample_Id`),
  KEY `fk_SampleValue_test_id` (`test_Id`),
  KEY `fk_SampleValue_attribute_id` (`attribute_Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `samplevalue`
--

INSERT INTO `samplevalue` (`id`, `sample_Id`, `test_Id`, `attribute_Id`, `value`) VALUES
(1, 12, 8, 2, '100'),
(2, 12, 8, 3, '120'),
(3, 12, 9, 1, 'CH-12345'),
(4, 13, 8, 2, '100'),
(5, 13, 8, 3, '120'),
(6, 15, 8, 2, '100'),
(7, 15, 8, 3, '120'),
(8, 15, 9, 1, 'CH-12345'),
(9, 16, 8, 2, '100'),
(10, 16, 8, 3, '120'),
(11, 16, 9, 1, 'CH-00000');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'Sample Ready for Chemistry'),
(2, 'Sample Ready for Heat'),
(3, 'Sample Ready for Sppiner'),
(4, 'Sample Ready for Electricity'),
(5, 'Sample Passed Electricty'),
(6, 'Sample Ready for Electricity'),
(7, 'Sample Passed Electricty'),
(8, 'Sample Passed Heat'),
(9, 'Sample Passed Chemestry'),
(10, 'Sample Passed Spinner'),
(11, 'Sample Used');

-- --------------------------------------------------------

--
-- Table structure for table `statussequence`
--

CREATE TABLE IF NOT EXISTS `statussequence` (
  `status_Id` int(11) NOT NULL,
  `status_Required` int(11) DEFAULT NULL,
  KEY `fk_StatusSequence_status_id` (`status_Id`),
  KEY `fk_StatusSequence_status_required` (`status_Required`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `statussequence`
--

INSERT INTO `statussequence` (`status_Id`, `status_Required`) VALUES
(5, NULL),
(8, 2),
(9, 1),
(10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(199) NOT NULL,
  `samplesLength` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `name`, `samplesLength`, `status`) VALUES
(1, 'ELECTRICITY TEST', 0, 1),
(8, 'HEAT TEST', 2, 1),
(9, 'CHEMISTRY TEST', 1, 1),
(10, 'SPINNER TEST', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `testattributes`
--

CREATE TABLE IF NOT EXISTS `testattributes` (
  `test_Id` int(11) NOT NULL,
  `attribute_Id` int(11) NOT NULL,
  KEY `fk_TestAttributes_test_id` (`test_Id`),
  KEY `fk_TestAttributes_attribute_id` (`attribute_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testattributes`
--

INSERT INTO `testattributes` (`test_Id`, `attribute_Id`) VALUES
(9, 1),
(8, 2),
(8, 3),
(10, 4);

-- --------------------------------------------------------

--
-- Table structure for table `teststatus`
--

CREATE TABLE IF NOT EXISTS `teststatus` (
  `test_Id` int(11) NOT NULL,
  `prev_State` int(11) DEFAULT NULL,
  `post_State` int(11) NOT NULL,
  KEY `fk_TestStatus_test_id` (`test_Id`),
  KEY `fk_TestStatus_prev_state` (`prev_State`),
  KEY `fk_TestStatus_post_state` (`post_State`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teststatus`
--

INSERT INTO `teststatus` (`test_Id`, `prev_State`, `post_State`) VALUES
(1, 5, 2),
(8, 8, 1),
(9, 9, 3),
(10, 10, 11);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `fk_Log_operator_id` FOREIGN KEY (`operator_Id`) REFERENCES `operator` (`id`),
  ADD CONSTRAINT `fk_Log_sample_id` FOREIGN KEY (`sample_Id`) REFERENCES `sample` (`id`),
  ADD CONSTRAINT `fk_Log_status_id` FOREIGN KEY (`status_Id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `fk_Log_test_id` FOREIGN KEY (`test_Id`) REFERENCES `test` (`id`);

--
-- Constraints for table `samplevalue`
--
ALTER TABLE `samplevalue`
  ADD CONSTRAINT `fk_SampleValue_attribute_id` FOREIGN KEY (`attribute_Id`) REFERENCES `attribute` (`id`),
  ADD CONSTRAINT `fk_SampleValue_sample_id` FOREIGN KEY (`sample_Id`) REFERENCES `sample` (`id`),
  ADD CONSTRAINT `fk_SampleValue_test_id` FOREIGN KEY (`test_Id`) REFERENCES `test` (`id`);

--
-- Constraints for table `statussequence`
--
ALTER TABLE `statussequence`
  ADD CONSTRAINT `fk_StatusSequence_status_id` FOREIGN KEY (`status_Id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `fk_StatusSequence_status_required` FOREIGN KEY (`status_Required`) REFERENCES `status` (`id`);

--
-- Constraints for table `testattributes`
--
ALTER TABLE `testattributes`
  ADD CONSTRAINT `fk_TestAttributes_attribute_id` FOREIGN KEY (`attribute_Id`) REFERENCES `attribute` (`id`),
  ADD CONSTRAINT `fk_TestAttributes_test_id` FOREIGN KEY (`test_Id`) REFERENCES `test` (`id`);

--
-- Constraints for table `teststatus`
--
ALTER TABLE `teststatus`
  ADD CONSTRAINT `fk_TestStatus_post_state` FOREIGN KEY (`post_State`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `fk_TestStatus_prev_state` FOREIGN KEY (`prev_State`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `fk_TestStatus_test_id` FOREIGN KEY (`test_Id`) REFERENCES `test` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
