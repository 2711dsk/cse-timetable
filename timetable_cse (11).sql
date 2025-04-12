-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2025 at 10:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `timetable_cse`
--

-- --------------------------------------------------------

--
-- Table structure for table `delete_entries`
--

CREATE TABLE `delete_entries` (
  `day` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `section_id` varchar(255) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `faculty_name` varchar(255) NOT NULL,
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elective`
--

CREATE TABLE `elective` (
  `semester_id` int(11) NOT NULL,
  `elective_section` varchar(255) NOT NULL,
  `elective_id` varchar(255) NOT NULL,
  `elective_subject_id` varchar(255) DEFAULT NULL,
  `elective_name` varchar(255) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `hours_per_week` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elective`
--

INSERT INTO `elective` (`semester_id`, `elective_section`, `elective_id`, `elective_subject_id`, `elective_name`, `faculty_id`, `hours_per_week`) VALUES
(5, 'aiml', 'R23MSCSE001', 'R23MSCST019', 'Data Warehousing and Data Mining (DWDM)', 51, 3),
(5, 'bi', 'R23MSCSE001', 'R23MSCST019', 'Data Warehousing and Data Mining (DWDM)', 21, 3),
(5, 'ds', 'R23MSCSE001', 'R23MSCST031', 'Statistical and Mathematical Foundations of Data Analytics (SMFDA)', 101, 3),
(5, 'icb', 'R23MSCSE001', 'R23MSCST040', 'Cryptography and Information Security (CIS)', 102, 3),
(7, 'bi-1', 'A3CIE701', 'A3CIT414', 'Machine Learning (ML)', 13, 3),
(7, 'bi-1', 'A3CIE702', 'A3CIT421', 'Switching Routing Wireless Essentials (SRWE)', 8, 3),
(7, 'bi-1', 'A3CIE703', 'A3CIT495', 'Mean Stack for Web Development (MSWD)', 7, 3),
(7, 'bi-2', 'A3CIE701', 'A3CIT414', 'Machine Learning (ML)', 24, 3),
(7, 'bi-2', 'A3CIE702', 'A3CIT421', 'Switching Routing Wireless Essentials (SRWE)', 27, 3),
(7, 'bi-2', 'A3CIE703', 'A3CIT495', 'Mean Stack for Web Development (MSWD)', 26, 3);

-- --------------------------------------------------------

--
-- Table structure for table `elective_sections`
--

CREATE TABLE `elective_sections` (
  `id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elective_sections`
--

INSERT INTO `elective_sections` (`id`) VALUES
('aiml'),
('bi'),
('bi-1'),
('bi-2'),
('ds'),
('es'),
('icb'),
('nt');

-- --------------------------------------------------------

--
-- Table structure for table `elective_semester`
--

CREATE TABLE `elective_semester` (
  `semester_id` int(11) NOT NULL,
  `section` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elective_semester`
--

INSERT INTO `elective_semester` (`semester_id`, `section`) VALUES
(5, 'aiml'),
(5, 'bi'),
(5, 'ds'),
(5, 'es'),
(5, 'icb'),
(5, 'nt'),
(7, 'bi-1'),
(7, 'bi-2');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `name`, `department`) VALUES
(1, 'Prof. P.S. Sitharama Raju', 'CSE'),
(2, 'Dr. S. Sreenivasa Rao', 'CSE'),
(3, 'Dr. C. Kalyana Chakravarthy', 'CSE'),
(4, 'Dr. B. Aruna Kumari', 'CSE'),
(5, 'Dr. T. Pavan Kumar', 'CSE'),
(6, 'Mrs. K. Sobha Rani', 'CSE'),
(7, 'Mr. R. Ravi Kanth', 'CSE'),
(8, 'Mr. K. V. Subba Raju', 'CSE'),
(9, 'Mr. P. L. N. Raju', 'CSE'),
(10, 'Dr. K. Santosh Jhansi', 'CSE'),
(11, 'Mr. K. A. Prasada Raju', 'CSE'),
(12, 'Mrs. M. Priyanka', 'CSE'),
(13, 'Mrs. M. Beulah Rani', 'CSE'),
(14, 'Mr. T. Chaitanya Kumar', 'CSE'),
(15, 'Dr. P. Rama Santosh Naidu', 'CSE'),
(16, 'Mr. N. Narendra Kumar', 'CSE'),
(17, 'Mr. R. Ravi Kumar', 'CSE'),
(18, 'Mr. M. Vamsi Krishna', 'CSE'),
(19, 'Mrs. K. Vindhya Rani', 'CSE'),
(20, 'Mrs. V. Lavanya', 'CSE'),
(21, 'Mr. K. Leela Prasad', 'CSE'),
(22, 'Mr. K. Dileep Kumar', 'CSE'),
(23, 'Mr. G. Lakshmana Rao', 'CSE'),
(24, 'Mrs. N. Aswani', 'CSE'),
(25, 'Mrs. K. Hymavathi', 'CSE'),
(26, 'Mrs. K. Janaki', 'CSE'),
(27, 'Mr. Y. Surya Prakash', 'CSE'),
(28, 'Mrs. P. Jyothi', 'CSE'),
(29, 'Mr. Pankaj Sarma', 'CSE'),
(30, 'CSE-F1', 'CSE'),
(31, 'CSE-F2', 'CSE'),
(32, 'CSE-F3', 'CSE'),
(33, 'CSE-F4', 'CSE'),
(51, 'IECT-1', 'IE&CT'),
(101, 'DE-1', 'DE'),
(102, 'DE-2', 'DE'),
(151, 'C-1', 'CIVIL'),
(152, 'C-2', 'CIVIL'),
(251, 'ECE-1', 'ECE'),
(252, 'ECE-2', 'ECE'),
(253, 'ECE-3', 'ECE'),
(254, 'ECE-4', 'ECE'),
(255, 'ECE-5', 'ECE'),
(301, 'EE-1', 'EEE'),
(302, 'EE-2', 'EEE'),
(351, 'ME-1', 'MECH'),
(352, 'ME-2', 'MECH'),
(353, 'ME-3', 'MECH'),
(401, 'MBA-1', 'MBA'),
(402, 'MBA-2', 'MBA'),
(403, 'MBA-3', 'MBA'),
(404, 'MBA-4', 'MBA'),
(405, 'MBA-5', 'MBA'),
(406, 'MBA-6', 'MBA'),
(451, 'P-1', 'S&H'),
(452, 'P-2', 'S&H'),
(453, 'M-1', 'S&H'),
(454, 'M-2', 'S&H'),
(455, 'M-3', 'S&H'),
(461, 'M-4', 'S&H'),
(462, 'E-1', 'S&H'),
(463, 'E-2', 'S&H');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_lab_mapping`
--

CREATE TABLE `faculty_lab_mapping` (
  `id` int(11) NOT NULL,
  `faculty_id_A` int(11) NOT NULL,
  `faculty_id_B` int(11) DEFAULT NULL,
  `section_id` varchar(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `faculty_id_C` int(11) DEFAULT NULL,
  `lab_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty_lab_mapping`
--

INSERT INTO `faculty_lab_mapping` (`id`, `faculty_id_A`, `faculty_id_B`, `section_id`, `semester_id`, `subject_id`, `faculty_id_C`, `lab_name`) VALUES
(87, 13, 7, 'A', 5, 'R23MSCSL007', NULL, 'Turing Lab'),
(88, 7, 28, 'B', 5, 'R23MSCSL007', NULL, 'Turing Lab'),
(89, 28, 13, 'C', 5, 'R23MSCSL007', NULL, 'Turing Lab'),
(90, 401, 403, 'A', 5, 'R23MBMCL002', NULL, 'Turing Lab'),
(91, 402, 401, 'B', 5, 'R23MBMCL002', NULL, 'Turing Lab'),
(92, 403, 402, 'C', 5, 'R23MBMCL002', NULL, 'Turing Lab'),
(93, 353, NULL, 'A', 3, 'R24MMECL001', NULL, 'Codd Lab'),
(94, 353, NULL, 'B', 3, 'R24MMECL001', NULL, 'Codd Lab'),
(95, 351, NULL, 'C', 3, 'R24MMECL001', NULL, 'Codd Lab'),
(96, 353, NULL, 'D', 3, 'R24MMECL001', NULL, 'Codd Lab'),
(97, 353, NULL, 'E', 3, 'R24MMECL001', NULL, 'Codd Lab'),
(98, 16, 23, 'A', 3, 'R24MSCSL003', NULL, 'Panini Lab'),
(99, 17, NULL, 'B', 3, 'R24MSCSL003', NULL, 'Panini Lab'),
(100, 22, 24, 'C', 3, 'R24MSCSL003', NULL, 'Panini Lab'),
(101, 16, NULL, 'D', 3, 'R24MSCSL003', NULL, 'Panini Lab'),
(102, 24, NULL, 'E', 3, 'R24MSCSL003', NULL, 'Panini Lab'),
(103, 22, 18, 'A', 3, 'R24MSCSL004', NULL, 'Lee Lab'),
(104, 25, 14, 'B', 3, 'R24MSCSL004', NULL, 'Lee Lab'),
(105, 14, 18, 'C', 3, 'R24MSCSL004', NULL, 'Lee Lab'),
(106, 30, 6, 'D', 3, 'R24MSCSL004', NULL, 'Lee Lab'),
(107, 31, 6, 'E', 3, 'R24MSCSL004', NULL, 'Lee Lab'),
(108, 301, NULL, 'A', 1, 'R24MEEEW001', NULL, 'EEE Lab'),
(109, 301, NULL, 'B', 1, 'R24MEEEW001', NULL, 'EEE Lab'),
(110, 301, NULL, 'C', 1, 'R24MEEEW001', NULL, 'EEE Lab'),
(111, 302, NULL, 'D', 1, 'R24MEEEW001', NULL, 'EEE Lab'),
(112, 302, NULL, 'E', 1, 'R24MEEEW001', NULL, 'EEE Lab'),
(113, 451, NULL, 'A', 1, 'R24MPHYL001', NULL, 'Physics lab'),
(114, 451, NULL, 'B', 1, 'R24MPHYL001', NULL, 'Physics lab'),
(115, 452, NULL, 'C', 1, 'R24MPHYL001', NULL, 'Physics lab'),
(116, 452, NULL, 'D', 1, 'R24MPHYL001', NULL, 'Physics lab'),
(117, 452, NULL, 'E', 1, 'R24MPHYL001', NULL, 'Physics lab'),
(118, 8, 10, 'A', 1, 'R24MSCSL001', NULL, 'Babbage Lab'),
(119, 27, 28, 'B', 1, 'R24MSCSL001', NULL, 'Babbage Lab'),
(120, 8, 19, 'C', 1, 'R24MSCSL001', NULL, 'Babbage Lab'),
(121, 10, 28, 'D', 1, 'R24MSCSL001', NULL, 'Babbage Lab'),
(122, 27, 19, 'E', 1, 'R24MSCSL001', NULL, 'Babbage Lab');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_timetable`
--

CREATE TABLE `faculty_timetable` (
  `faculty_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `section_id` varchar(11) DEFAULT NULL,
  `elective_section_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fac_sec_map`
--

CREATE TABLE `fac_sec_map` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `section_id` varchar(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fac_sec_map`
--

INSERT INTO `fac_sec_map` (`id`, `faculty_id`, `section_id`, `subject_id`, `semester_id`) VALUES
(166, 3, 'A', 'A3CIT203', 7),
(167, 6, 'A', 'A3CIT314', 7),
(168, 4, 'A', 'A3EHT002', 7),
(169, 6, 'B', 'A3CIT203', 7),
(170, 15, 'B', 'A3CIT314', 7),
(171, 18, 'B', 'A3EHT002', 7),
(172, 3, 'C', 'A3CIT203', 7),
(173, 20, 'C', 'A3CIT314', 7),
(174, 4, 'C', 'A3EHT002', 7),
(175, 14, 'A', 'R23MSCST011', 5),
(176, 28, 'B', 'R23MSCST011', 5),
(177, 19, 'C', 'R23MSCST011', 5),
(178, 13, 'A', 'R23MSCST012', 5),
(179, 7, 'B', 'R23MSCST012', 5),
(180, 28, 'C', 'R23MSCST012', 5),
(181, 10, 'A', 'R23MSCST013', 5),
(182, 5, 'B', 'R23MSCST013', 5),
(183, 5, 'C', 'R23MSCST013', 5),
(184, 4, 'A', 'R23MSCST014', 5),
(185, 10, 'B', 'R23MSCST014', 5),
(186, 3, 'C', 'R23MSCST014', 5),
(187, 401, 'A', 'R23MBMCT005', 5),
(188, 402, 'B', 'R23MBMCT005', 5),
(189, 403, 'C', 'R23MBMCT005', 5),
(190, 16, 'A', 'R24MSCST003', 3),
(191, 17, 'B', 'R24MSCST003', 3),
(192, 22, 'C', 'R24MSCST003', 3),
(193, 16, 'D', 'R24MSCST003', 3),
(194, 24, 'E', 'R24MSCST003', 3),
(195, 22, 'A', 'R24MSCST004', 3),
(196, 25, 'B', 'R24MSCST004', 3),
(197, 14, 'C', 'R24MSCST004', 3),
(199, 30, 'D', 'R24MSCST004', 3),
(200, 31, 'E', 'R24MSCST004', 3),
(201, 251, 'A', 'R24MSCST005', 3),
(202, 252, 'B', 'R24MSCST005', 3),
(203, 253, 'C', 'R24MSCST005', 3),
(204, 254, 'D', 'R24MSCST005', 3),
(205, 255, 'E', 'R24MSCST005', 3),
(206, 9, 'A', 'R24MSCST006', 3),
(207, 18, 'B', 'R24MSCST006', 3),
(208, 21, 'C', 'R24MSCST006', 3),
(209, 32, 'D', 'R24MSCST006', 3),
(210, 21, 'E', 'R24MSCST006', 3),
(211, 404, 'A', 'R24MBMCT001', 3),
(212, 405, 'B', 'R24MBMCT001', 3),
(213, 406, 'C', 'R24MBMCT001', 3),
(214, 404, 'D', 'R24MBMCT001', 3),
(215, 405, 'E', 'R24MBMCT001', 3),
(216, 351, 'A', 'R24MMECT013', 3),
(217, 351, 'B', 'R24MMECT013', 3),
(218, 352, 'C', 'R24MMECT013', 3),
(219, 352, 'D', 'R24MMECT013', 3),
(220, 352, 'E', 'R24MMECT013', 3),
(221, 451, 'A', 'R24MPHYT001', 1),
(222, 451, 'B', 'R24MPHYT001', 1),
(224, 452, 'C', 'R24MPHYT001', 1),
(225, 452, 'D', 'R24MPHYT001', 1),
(226, 452, 'E', 'R24MPHYT001', 1),
(227, 453, 'A', 'R24MMATT001', 1),
(228, 453, 'B', 'R24MMATT001', 1),
(230, 453, 'C', 'R24MMATT001', 1),
(231, 454, 'D', 'R24MMATT001', 1),
(232, 454, 'E', 'R24MMATT001', 1),
(233, 455, 'A', 'R24MMATT002', 1),
(234, 455, 'B', 'R24MMATT002', 1),
(235, 455, 'C', 'R24MMATT002', 1),
(236, 461, 'D', 'R24MMATT002', 1),
(237, 461, 'E', 'R24MMATT002', 1),
(238, 151, 'A', 'R24MCIVT001', 1),
(239, 151, 'B', 'R24MCIVT001', 1),
(240, 151, 'C', 'R24MCIVT001', 1),
(241, 152, 'D', 'R24MCIVT001', 1),
(242, 152, 'E', 'R24MCIVT001', 1),
(243, 462, 'A', 'R24MENGT001', 1),
(244, 462, 'B', 'R24MENGT001', 1),
(245, 462, 'C', 'R24MENGT001', 1),
(246, 462, 'D', 'R24MENGT001', 1),
(247, 462, 'E', 'R24MENGT001', 1),
(248, 463, 'A', 'R24MENGT003', 1),
(249, 463, 'B', 'R24MENGT003', 1),
(250, 463, 'C', 'R24MENGT003', 1),
(251, 463, 'D', 'R24MENGT003', 1),
(252, 463, 'E', 'R24MENGT003', 1);

-- --------------------------------------------------------

--
-- Table structure for table `labs`
--

CREATE TABLE `labs` (
  `lab_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `labs`
--

INSERT INTO `labs` (`lab_name`) VALUES
('Babbage Lab'),
('Codd Lab'),
('EEE Lab'),
('Lee Lab'),
('Panini Lab'),
('Physics lab'),
('Turing Lab');

-- --------------------------------------------------------

--
-- Table structure for table `lab_deleted_entries`
--

CREATE TABLE `lab_deleted_entries` (
  `day` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `section_id` varchar(255) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `id` int(11) NOT NULL,
  `lab_name` varchar(255) NOT NULL,
  `faculty_id_A` int(11) DEFAULT NULL,
  `faculty_id_B` int(11) DEFAULT NULL,
  `faculty_id_C` int(11) DEFAULT NULL,
  `faculty_name_A` varchar(255) DEFAULT NULL,
  `faculty_name_B` varchar(255) DEFAULT NULL,
  `faculty_name_C` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lab_timetable`
--

CREATE TABLE `lab_timetable` (
  `day` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `lab_name` varchar(255) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `section_id` varchar(11) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `id` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`id`) VALUES
('A'),
('B'),
('C'),
('D'),
('E');

-- --------------------------------------------------------

--
-- Table structure for table `section_semester_map`
--

CREATE TABLE `section_semester_map` (
  `section_id` varchar(11) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_semester_map`
--

INSERT INTO `section_semester_map` (`section_id`, `semester_id`) VALUES
('A', 5),
('A', 6),
('A', 7),
('B', 5),
('B', 6),
('B', 7),
('C', 5),
('C', 6),
('C', 7);

-- --------------------------------------------------------

--
-- Table structure for table `semester`
--

CREATE TABLE `semester` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('Lecture','Lab','Elective') NOT NULL,
  `hours_per_week` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `name`, `type`, `hours_per_week`, `semester_id`) VALUES
('A3CIE701', 'Professional Core Elective-IV', 'Elective', 3, 7),
('A3CIE702', 'Professional Core Elective-V', 'Elective', 3, 7),
('A3CIE703', 'Professional Core Elective-VI', 'Elective', 3, 7),
('A3CIP603', 'Project (Phase-I)', 'Lab', 3, 7),
('A3CIT203', 'Internet of Things (IOT)', 'Lecture', 3, 7),
('A3CIT314', 'Object Oriented Design & Analysis and Design Patterns (OOAD&DP)', 'Lecture', 3, 7),
('A3EHT002', 'Professional Ethics and Human Values (PEHV)', 'Lecture', 3, 7),
('MVGRCOUN6', 'Counselling Hour', 'Elective', 1, 6),
('R23MBMCL002', 'Digital Engineering Lab (DE Lab)', 'Lab', 3, 5),
('R23MBMCT005', 'Entrepreneurship (EN)', 'Lecture', 3, 5),
('R23MSCSE001', 'DSC-E1', 'Elective', 3, 5),
('R23MSCSL007', 'Advance Java Programming Lab (AJP Lab)', 'Lab', 3, 5),
('R23MSCSP001', 'Community Project (CP)', 'Lab', 2, 5),
('R23MSCST011', 'Operating Systems (OS)', 'Lecture', 3, 5),
('R23MSCST012', 'Advance Java Programming (AJP)', 'Lecture', 3, 5),
('R23MSCST013', 'Automata & Compiler Design (ACD)', 'Lecture', 3, 5),
('R23MSCST014', 'Computer Networks (CN)', 'Lecture', 3, 5),
('R24MBMCT001', 'Financial Management (FM)', 'Lecture', 3, 3),
('R24MCIVT001', 'Environmental Studies (ES)', 'Lecture', 2, 1),
('R24MEEEW001', 'Electrical and Electronics Engineering Workshop (EEEW)', 'Lab', 3, 1),
('R24MENGT001', 'Language Proficiency (LP)', 'Lecture', 2, 1),
('R24MENGT003', 'Health and Wellness (HW)', 'Lecture', 2, 1),
('R24MMATT001', 'Linear Algebra and Differential Equations (LADE)', 'Lecture', 4, 1),
('R24MMATT002', 'Multi Variables and Vector Calculus (MVVC)', 'Lecture', 4, 1),
('R24MMECL001', 'Computer Aided Geometric Design and Assembly Lab (CAGDA)', 'Lab', 3, 3),
('R24MMECT013', 'Leadership and Team Management (LTM)', 'Lecture', 3, 3),
('R24MPHYL001', 'Physics Lab (PHY LAB)', 'Lab', 2, 1),
('R24MPHYT001', 'Physics (PHY)', 'Lecture', 3, 1),
('R24MSCSL001', 'Office Tools and Social Media Etiquette (OTSME)', 'Lab', 2, 1),
('R24MSCSL003', 'Data Structures Lab (DS Lab)', 'Lab', 3, 3),
('R24MSCSL004', 'OOP with C++ Lab (OOP Lab)', 'Lab', 3, 3),
('R24MSCST003', 'Data Structures (DS)', 'Lecture', 3, 3),
('R24MSCST004', 'OOP with C++ (OOP)', 'Lecture', 3, 3),
('R24MSCST005', 'Digital Logic Design (DLD)', 'Lecture', 3, 3),
('R24MSCST006', 'Principles of Programming Languages (PPL)', 'Lecture', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `day` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `section_id` varchar(11) NOT NULL,
  `subject_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','faculty','student') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', 'admin'),
(4, '21331A0543', '21331A0543', 'student'),
(5, '21331A0537', '21331A0537', 'student'),
(6, '21331A0532', '21331A0532', 'student'),
(7, '21331A0545', '21331A0545', 'student'),
(8, 'kvsubbaraju@mvgrce.edu.in', 'kvsubbaraju@mvgrce.edu.in', 'faculty'),
(9, 'prsnaidu@mvgrce.edu.in', 'prsnaidu@mvgrce.edu.in', 'faculty'),
(10, 'mbrani@mvgrce.edu.in', 'mbrani@mvgrce.edu.in', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `delete_entries`
--
ALTER TABLE `delete_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `elective`
--
ALTER TABLE `elective`
  ADD PRIMARY KEY (`semester_id`,`elective_section`,`elective_id`),
  ADD KEY `elective_id` (`elective_id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `elective_sections`
--
ALTER TABLE `elective_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elective_semester`
--
ALTER TABLE `elective_semester`
  ADD PRIMARY KEY (`semester_id`,`section`),
  ADD KEY `section` (`section`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty_lab_mapping`
--
ALTER TABLE `faculty_lab_mapping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `faculty_id_A` (`faculty_id_A`),
  ADD KEY `faculty_id_B` (`faculty_id_B`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `faculty_id_C` (`faculty_id_C`),
  ADD KEY `lab_name` (`lab_name`);

--
-- Indexes for table `faculty_timetable`
--
ALTER TABLE `faculty_timetable`
  ADD PRIMARY KEY (`faculty_id`,`day`,`time`),
  ADD KEY `faculty_timetable_ibfk_2` (`semester_id`),
  ADD KEY `faculty_timetable_ibfk_3` (`subject_id`),
  ADD KEY `faculty_timetable_ibfk_4` (`section_id`),
  ADD KEY `elective_section_id` (`elective_section_id`);

--
-- Indexes for table `fac_sec_map`
--
ALTER TABLE `fac_sec_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `labs`
--
ALTER TABLE `labs`
  ADD PRIMARY KEY (`lab_name`);

--
-- Indexes for table `lab_deleted_entries`
--
ALTER TABLE `lab_deleted_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `lab_name` (`lab_name`),
  ADD KEY `faculty_id_A` (`faculty_id_A`),
  ADD KEY `faculty_id_B` (`faculty_id_B`),
  ADD KEY `faculty_id_C` (`faculty_id_C`);

--
-- Indexes for table `lab_timetable`
--
ALTER TABLE `lab_timetable`
  ADD PRIMARY KEY (`day`,`time`,`lab_name`),
  ADD KEY `lab_name` (`lab_name`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `section_semester_map`
--
ALTER TABLE `section_semester_map`
  ADD PRIMARY KEY (`section_id`,`semester_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`day`,`time`,`semester_id`,`section_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `delete_entries`
--
ALTER TABLE `delete_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `faculty_lab_mapping`
--
ALTER TABLE `faculty_lab_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `fac_sec_map`
--
ALTER TABLE `fac_sec_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=253;

--
-- AUTO_INCREMENT for table `lab_deleted_entries`
--
ALTER TABLE `lab_deleted_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delete_entries`
--
ALTER TABLE `delete_entries`
  ADD CONSTRAINT `delete_entries_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delete_entries_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delete_entries_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delete_entries_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `elective`
--
ALTER TABLE `elective`
  ADD CONSTRAINT `elective_ibfk_1` FOREIGN KEY (`semester_id`,`elective_section`) REFERENCES `elective_semester` (`semester_id`, `section`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `elective_ibfk_3` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `elective_ibfk_4` FOREIGN KEY (`elective_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `elective_semester`
--
ALTER TABLE `elective_semester`
  ADD CONSTRAINT `elective_semester_ibfk_1` FOREIGN KEY (`section`) REFERENCES `elective_sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faculty_lab_mapping`
--
ALTER TABLE `faculty_lab_mapping`
  ADD CONSTRAINT `faculty_id_A` FOREIGN KEY (`faculty_id_A`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_id_B` FOREIGN KEY (`faculty_id_B`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_id_C` FOREIGN KEY (`faculty_id_C`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_lab_mapping_ibfk_1` FOREIGN KEY (`lab_name`) REFERENCES `labs` (`lab_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_lab_mapping_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `section_id` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `semester_id` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faculty_timetable`
--
ALTER TABLE `faculty_timetable`
  ADD CONSTRAINT `faculty_timetable_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_timetable_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_timetable_ibfk_4` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_timetable_ibfk_5` FOREIGN KEY (`elective_section_id`) REFERENCES `elective_sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `faculty_timetable_ibfk_6` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fac_sec_map`
--
ALTER TABLE `fac_sec_map`
  ADD CONSTRAINT `fac_sec_map_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fac_sec_map_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fac_sec_map_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fac_sec_map_ibfk_5` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lab_deleted_entries`
--
ALTER TABLE `lab_deleted_entries`
  ADD CONSTRAINT `lab_deleted_entries_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_4` FOREIGN KEY (`lab_name`) REFERENCES `labs` (`lab_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_5` FOREIGN KEY (`faculty_id_A`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_6` FOREIGN KEY (`faculty_id_B`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_deleted_entries_ibfk_7` FOREIGN KEY (`faculty_id_C`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lab_timetable`
--
ALTER TABLE `lab_timetable`
  ADD CONSTRAINT `lab_timetable_ibfk_1` FOREIGN KEY (`lab_name`) REFERENCES `labs` (`lab_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_timetable_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_timetable_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_timetable_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `section_semester_map`
--
ALTER TABLE `section_semester_map`
  ADD CONSTRAINT `section_semester_map_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`),
  ADD CONSTRAINT `section_semester_map_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`);

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
