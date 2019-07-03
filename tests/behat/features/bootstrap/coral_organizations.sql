-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 03, 2019 at 08:51 PM
-- Server version: 5.6.40
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coral_organizations`
--

-- --------------------------------------------------------

--
-- Table structure for table `Alias`
--

CREATE TABLE `Alias` (
  `aliasID` int(11) NOT NULL,
  `organizationID` int(11) DEFAULT NULL,
  `aliasTypeID` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Alias`
--

INSERT INTO `Alias` (`aliasID`, `organizationID`, `aliasTypeID`, `name`) VALUES
(1, 2, 3, 'IOP'),
(2, 3, 3, 'AIAA'),
(3, 4, 3, 'APS'),
(4, 5, 3, 'ASCE'),
(5, 6, 3, 'AIP'),
(6, 7, 3, 'SIAM'),
(7, 9, 3, 'CAS'),
(8, 10, 3, 'RMA'),
(9, 11, 3, 'ACI'),
(10, 12, 3, 'AACR'),
(11, 13, 3, 'IET'),
(12, 14, 3, 'AEA'),
(13, 15, 3, 'AMS'),
(14, 16, 3, 'AMA'),
(15, 35, 2, 'Thomson Gale'),
(16, 18, 3, 'CSIC'),
(17, 19, 3, 'AMS'),
(18, 20, 3, 'ALA'),
(19, 21, 3, 'ASTM'),
(20, 22, 3, 'ARL'),
(21, 23, 3, 'ASLO'),
(22, 25, 3, 'APA'),
(23, 26, 3, 'ACLS'),
(24, 27, 3, 'AAAS'),
(25, 265, 3, 'CEA'),
(26, 141, 3, 'L/N'),
(27, 270, 3, 'CSA'),
(28, 305, 3, 'ACM'),
(29, 306, 3, 'ACS'),
(30, 8, 2, 'Competitive Media Reporting, LLC'),
(31, 28, 1, 'Thomson ISI'),
(32, 53, 3, 'AccuNet'),
(33, 271, 3, 'AICPA'),
(34, 311, 2, 'American Association on Mental Retardation'),
(35, 311, 3, 'AAMR'),
(36, 311, 3, 'AAIDD'),
(37, 46, 3, 'AFS'),
(38, 32, 3, 'AGU'),
(39, 245, 3, 'APPI'),
(40, 244, 3, 'ASCB'),
(41, 242, 3, 'ASHS'),
(42, 312, 3, 'ASM'),
(43, 314, 3, 'ASME'),
(44, 401, 3, 'WWP'),
(45, 236, 3, 'ASA'),
(46, 224, 3, 'BE Press'),
(47, 180, 3, 'FASEB'),
(48, 177, 3, 'GSA'),
(49, 163, 3, 'HCS'),
(50, 134, 3, 'MBL'),
(51, 104, 3, 'RSC'),
(52, 96, 3, 'SEBM'),
(53, 95, 3, 'SGM'),
(54, 94, 3, 'SLB'),
(55, 93, 3, 'SfN'),
(56, 82, 3, 'TTP'),
(57, 61, 1, 'Institute of Electrical and Electronics Engineers'),
(58, 171, 3, 'AIC'),
(59, 276, 3, 'AAR'),
(60, 273, 3, 'ACA'),
(61, 322, 3, 'AIMS'),
(62, 214, 3, 'CCDC'),
(63, 362, 3, 'CIAO'),
(64, 363, 3, 'CNRI'),
(65, 366, 3, 'GSA'),
(66, 368, 3, 'IPAP'),
(67, 371, 3, 'MLA'),
(68, 372, 3, 'OSA'),
(69, 380, 3, 'PS'),
(70, 257, 1, 'Atypon Link'),
(71, 383, 3, 'SAE'),
(72, 41, 1, 'Caliber'),
(73, 59, 3, 'CUP'),
(74, 193, 3, 'EUP'),
(75, 365, 1, 'Insight'),
(76, 386, 3, 'LEA'),
(77, 372, 1, 'OpticsInfoBase'),
(78, 116, 1, 'POJ'),
(79, 113, 1, 'Sirius'),
(80, 255, 3, 'MIT'),
(81, 206, 3, 'CDP'),
(82, 317, 3, 'CRL'),
(83, 88, 1, 'Society of Photo-optical Instrumentation Engineers'),
(84, 279, 1, 'Simmons Market Research Bureau'),
(85, 404, 1, 'Society of Environmental Toxicology and Chemistry '),
(86, 405, 1, 'oldenbourg-link'),
(87, 415, 1, 'Otto Harrassowitz'),
(88, 259, 2, 'Thomson RIA'),
(89, 28, 2, 'Thomson Scientific'),
(90, 418, 3, 'HRAF'),
(91, 399, 1, 'ReferenceUSA'),
(92, 254, 1, 'Audit Analytics'),
(93, 159, 2, 'Idea Group Inc'),
(94, 87, 3, 'S&P'),
(95, 422, 1, 'Morgan Stanley Capital International'),
(96, 420, 2, 'RiskMetrics Group'),
(97, 267, 3, 'ISS'),
(98, 120, 3, 'Readex'),
(99, 425, 1, 'Center for the Advancement of the Research Methods and Analysis'),
(100, 305, 1, 'ACM Digital Library'),
(101, 426, 3, 'MCLS'),
(102, 426, 2, 'MLC'),
(103, 426, 2, 'Michigan Library Consortia'),
(104, 426, 2, 'INCOLSA'),
(105, 427, 3, 'PLoS'),
(106, 400, 1, 'R.R. Bowker'),
(107, 429, 3, 'UNIDO'),
(108, 434, 3, 'BAS'),
(109, 35, 1, 'APG: Academic and Professional Group'),
(110, 44, 2, 'Silverplatter'),
(111, 44, 1, 'OvidSP'),
(112, 122, 1, 'Naxos Digital Services Ltd'),
(113, 37, 3, 'OUP'),
(114, 475, 3, 'OECD'),
(115, 194, 3, 'ESA'),
(116, 173, 1, 'H1Base'),
(117, 28, 1, 'ISI'),
(118, 484, 1, 'Austrian Academy of Sciences Press'),
(119, 485, 3, 'ARM'),
(120, 485, 1, 'New World Records'),
(121, 490, 1, 'CDI Systems Ltd.'),
(122, 399, 2, 'infogroup');

-- --------------------------------------------------------

--
-- Table structure for table `AliasType`
--

CREATE TABLE `AliasType` (
  `aliasTypeID` int(11) NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AliasType`
--

INSERT INTO `AliasType` (`aliasTypeID`, `shortName`) VALUES
(1, 'Alternate Name'),
(2, 'Name Change'),
(3, 'Acronym');

-- --------------------------------------------------------

--
-- Table structure for table `Contact`
--

CREATE TABLE `Contact` (
  `contactID` int(11) NOT NULL,
  `organizationID` int(11) NOT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `addressText` varchar(300) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `altPhoneNumber` varchar(50) DEFAULT NULL,
  `faxNumber` varchar(50) DEFAULT NULL,
  `emailAddress` varchar(100) DEFAULT NULL,
  `archiveDate` date DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ContactRole`
--

CREATE TABLE `ContactRole` (
  `contactRoleID` int(11) NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ContactRole`
--

INSERT INTO `ContactRole` (`contactRoleID`, `shortName`) VALUES
(1, 'Accounting'),
(2, 'Licensing'),
(3, 'Sales'),
(4, 'Support'),
(5, 'Training');

-- --------------------------------------------------------

--
-- Table structure for table `ContactRoleProfile`
--

CREATE TABLE `ContactRoleProfile` (
  `contactID` int(10) UNSIGNED NOT NULL,
  `contactRoleID` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExternalLogin`
--

CREATE TABLE `ExternalLogin` (
  `externalLoginID` int(11) NOT NULL,
  `organizationID` int(11) DEFAULT NULL,
  `externalLoginTypeID` int(11) DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `loginURL` varchar(150) DEFAULT NULL,
  `emailAddress` varchar(150) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExternalLoginType`
--

CREATE TABLE `ExternalLoginType` (
  `externalLoginTypeID` int(11) NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ExternalLoginType`
--

INSERT INTO `ExternalLoginType` (`externalLoginTypeID`, `shortName`) VALUES
(1, 'Admin'),
(2, 'FTP'),
(3, 'Other'),
(4, 'Statistics'),
(5, 'Support');

-- --------------------------------------------------------

--
-- Table structure for table `IssueLog`
--

CREATE TABLE `IssueLog` (
  `issueLogID` int(11) NOT NULL,
  `organizationID` int(11) DEFAULT NULL,
  `issueLogTypeID` int(11) DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `updateLoginID` varchar(50) DEFAULT NULL,
  `issueStartDate` date DEFAULT NULL,
  `issueEndDate` date DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IssueLogType`
--

CREATE TABLE `IssueLogType` (
  `issueLogTypeID` int(11) NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE `Organization` (
  `organizationID` int(11) NOT NULL,
  `ilsID` int(11) DEFAULT NULL,
  `createDate` date DEFAULT NULL,
  `createLoginID` varchar(50) DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `updateLoginID` varchar(50) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `companyURL` varchar(150) DEFAULT NULL,
  `noteText` text,
  `accountDetailText` text,
  `ebscoKbID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Organization`
--

INSERT INTO `Organization` (`organizationID`, `ilsID`, `createDate`, `createLoginID`, `updateDate`, `updateLoginID`, `name`, `companyURL`, `noteText`, `accountDetailText`, `ebscoKbID`) VALUES
(2, NULL, '2019-07-03', 'system', NULL, NULL, 'Institute of Physics', NULL, NULL, NULL, NULL),
(3, NULL, '2019-07-03', 'system', NULL, NULL, 'American Institute of Aeronautics and Astronautics', NULL, NULL, NULL, NULL),
(4, NULL, '2019-07-03', 'system', NULL, NULL, 'American Physical Society', NULL, NULL, NULL, NULL),
(5, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Civil Engineers', NULL, NULL, NULL, NULL),
(6, NULL, '2019-07-03', 'system', NULL, NULL, 'American Insitute of Physics', NULL, NULL, NULL, NULL),
(7, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Industrial and Applied Mathematics', NULL, NULL, NULL, NULL),
(8, NULL, '2019-07-03', 'system', NULL, NULL, 'TNS Media Intelligence', NULL, NULL, NULL, NULL),
(9, NULL, '2019-07-03', 'system', NULL, NULL, 'Chemical Abstracts Service', NULL, NULL, NULL, NULL),
(10, NULL, '2019-07-03', 'system', NULL, NULL, 'Risk Management Association', NULL, NULL, NULL, NULL),
(11, NULL, '2019-07-03', 'system', NULL, NULL, 'American Concrete Institute', NULL, NULL, NULL, NULL),
(12, NULL, '2019-07-03', 'system', NULL, NULL, 'American Association for Cancer Research', NULL, NULL, NULL, NULL),
(13, NULL, '2019-07-03', 'system', NULL, NULL, 'Institution of Engineering and Technology', NULL, NULL, NULL, NULL),
(14, NULL, '2019-07-03', 'system', NULL, NULL, 'American Economic Association', NULL, NULL, NULL, NULL),
(15, NULL, '2019-07-03', 'system', NULL, NULL, 'American Mathematical Society', NULL, NULL, NULL, NULL),
(16, NULL, '2019-07-03', 'system', NULL, NULL, 'American Medical Association', NULL, NULL, NULL, NULL),
(18, NULL, '2019-07-03', 'system', NULL, NULL, 'Consejo Superior de Investigaciones Cientificas', NULL, NULL, NULL, NULL),
(19, NULL, '2019-07-03', 'system', NULL, NULL, 'American Meteorological Society', NULL, NULL, NULL, NULL),
(20, NULL, '2019-07-03', 'system', NULL, NULL, 'American Library Association', NULL, NULL, NULL, NULL),
(21, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Testing and Materials', NULL, NULL, NULL, NULL),
(22, NULL, '2019-07-03', 'system', NULL, NULL, 'Association of Research Libraries', NULL, NULL, NULL, NULL),
(23, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Limnology and Oceanography', NULL, NULL, NULL, NULL),
(24, NULL, '2019-07-03', 'system', NULL, NULL, 'Tablet Publishing', NULL, NULL, NULL, NULL),
(25, NULL, '2019-07-03', 'system', NULL, NULL, 'American Psychological Association', NULL, NULL, NULL, NULL),
(26, NULL, '2019-07-03', 'system', NULL, NULL, 'American Council of Learned Societies', NULL, NULL, NULL, NULL),
(27, NULL, '2019-07-03', 'system', NULL, NULL, 'American Association for the Advancement of Science', NULL, NULL, NULL, NULL),
(28, NULL, '2019-07-03', 'system', NULL, NULL, 'Thomson Healthcare and Science', NULL, NULL, NULL, NULL),
(29, NULL, '2019-07-03', 'system', NULL, NULL, 'Elsevier', NULL, NULL, NULL, NULL),
(30, NULL, '2019-07-03', 'system', NULL, NULL, 'JSTOR', NULL, NULL, NULL, NULL),
(31, NULL, '2019-07-03', 'system', NULL, NULL, 'SAGE Publications', NULL, NULL, NULL, NULL),
(32, NULL, '2019-07-03', 'system', NULL, NULL, 'American Geophysical Union', NULL, NULL, NULL, NULL),
(33, NULL, '2019-07-03', 'system', NULL, NULL, 'Annual Reviews', NULL, NULL, NULL, NULL),
(34, NULL, '2019-07-03', 'system', NULL, NULL, 'BioOne', NULL, NULL, NULL, NULL),
(35, NULL, '2019-07-03', 'system', NULL, NULL, 'Gale', NULL, NULL, NULL, NULL),
(36, NULL, '2019-07-03', 'system', NULL, NULL, 'Wiley', NULL, NULL, NULL, NULL),
(37, NULL, '2019-07-03', 'system', NULL, NULL, 'Oxford University Press', NULL, NULL, NULL, NULL),
(38, NULL, '2019-07-03', 'system', NULL, NULL, 'Springer', NULL, NULL, NULL, NULL),
(39, NULL, '2019-07-03', 'system', NULL, NULL, 'Taylor and Francis', NULL, NULL, NULL, NULL),
(40, NULL, '2019-07-03', 'system', NULL, NULL, 'Stanford University', NULL, NULL, NULL, NULL),
(41, NULL, '2019-07-03', 'system', NULL, NULL, 'University of California Press', NULL, NULL, NULL, NULL),
(42, NULL, '2019-07-03', 'system', NULL, NULL, 'EBSCO Publishing', NULL, NULL, NULL, NULL),
(43, NULL, '2019-07-03', 'system', NULL, NULL, 'Blackwell Publishing', NULL, NULL, NULL, NULL),
(44, NULL, '2019-07-03', 'system', NULL, NULL, 'Ovid', NULL, NULL, NULL, NULL),
(45, NULL, '2019-07-03', 'system', NULL, NULL, 'Project Muse', NULL, NULL, NULL, NULL),
(46, NULL, '2019-07-03', 'system', NULL, NULL, 'American Fisheries Society', NULL, NULL, NULL, NULL),
(47, NULL, '2019-07-03', 'system', NULL, NULL, 'Neilson Journals Publishing', NULL, NULL, NULL, NULL),
(48, NULL, '2019-07-03', 'system', NULL, NULL, 'GuideStar USA, Inc', NULL, NULL, NULL, NULL),
(49, NULL, '2019-07-03', 'system', NULL, NULL, 'Alexander Street Press, LLC', NULL, NULL, NULL, NULL),
(50, NULL, '2019-07-03', 'system', NULL, NULL, 'Informa Healthcare USA, Inc', NULL, NULL, NULL, NULL),
(51, NULL, '2019-07-03', 'system', NULL, NULL, 'ProQuest LLC', NULL, NULL, NULL, NULL),
(52, NULL, '2019-07-03', 'system', NULL, NULL, 'Accessible Archives Inc', NULL, NULL, NULL, NULL),
(53, NULL, '2019-07-03', 'system', NULL, NULL, 'ACCU Weather Sales and Services, Inc', NULL, NULL, NULL, NULL),
(54, NULL, '2019-07-03', 'system', NULL, NULL, 'Adam Matthew Digital Ltd', NULL, NULL, NULL, NULL),
(55, NULL, '2019-07-03', 'system', NULL, NULL, 'Akademiai Kiado', NULL, NULL, NULL, NULL),
(56, NULL, '2019-07-03', 'system', NULL, NULL, 'World Trade Press', NULL, NULL, NULL, NULL),
(57, NULL, '2019-07-03', 'system', NULL, NULL, 'World Scientific', NULL, NULL, NULL, NULL),
(58, NULL, '2019-07-03', 'system', NULL, NULL, 'Walter de Gruyter', NULL, NULL, NULL, NULL),
(59, NULL, '2019-07-03', 'system', NULL, NULL, 'Cambridge University Press', NULL, NULL, NULL, NULL),
(60, NULL, '2019-07-03', 'system', NULL, NULL, 'GeoScienceWorld', NULL, NULL, NULL, NULL),
(61, NULL, '2019-07-03', 'system', NULL, NULL, 'IEEE', NULL, NULL, NULL, NULL),
(62, NULL, '2019-07-03', 'system', NULL, NULL, 'Yankelovich Inc', NULL, NULL, NULL, NULL),
(63, NULL, '2019-07-03', 'system', NULL, NULL, 'Nature Publishing Group', NULL, NULL, NULL, NULL),
(64, NULL, '2019-07-03', 'system', NULL, NULL, 'Verlag der Zeitschrift fur Naturforschung ', NULL, NULL, NULL, NULL),
(65, NULL, '2019-07-03', 'system', NULL, NULL, 'White Horse Press', NULL, NULL, NULL, NULL),
(66, NULL, '2019-07-03', 'system', NULL, NULL, 'Verlag C.H. Beck', NULL, NULL, NULL, NULL),
(67, NULL, '2019-07-03', 'system', NULL, NULL, 'Vault, Inc', NULL, NULL, NULL, NULL),
(68, NULL, '2019-07-03', 'system', NULL, NULL, 'Value Line, Inc', NULL, NULL, NULL, NULL),
(69, NULL, '2019-07-03', 'system', NULL, NULL, 'Vanderbilt University', NULL, NULL, NULL, NULL),
(70, NULL, '2019-07-03', 'system', NULL, NULL, 'Uniworld Business Publications, Inc', NULL, NULL, NULL, NULL),
(71, NULL, '2019-07-03', 'system', NULL, NULL, 'Universum USA', NULL, NULL, NULL, NULL),
(72, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Wisconsin Press', NULL, NULL, NULL, NULL),
(73, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Virginia Press', NULL, NULL, NULL, NULL),
(74, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Toronto Press Inc', NULL, NULL, NULL, NULL),
(75, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Toronto', NULL, NULL, NULL, NULL),
(76, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Pittsburgh', NULL, NULL, NULL, NULL),
(77, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Illinois Press', NULL, NULL, NULL, NULL),
(78, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Chicago Press', NULL, NULL, NULL, NULL),
(79, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Barcelona', NULL, NULL, NULL, NULL),
(80, NULL, '2019-07-03', 'system', NULL, NULL, 'UCLA Chicano Studies Research Center Press', NULL, NULL, NULL, NULL),
(81, NULL, '2019-07-03', 'system', NULL, NULL, 'Transportation Research Board', NULL, NULL, NULL, NULL),
(82, NULL, '2019-07-03', 'system', NULL, NULL, 'Trans Tech Publications', NULL, NULL, NULL, NULL),
(83, NULL, '2019-07-03', 'system', NULL, NULL, 'Thomas Telford Ltd', NULL, NULL, NULL, NULL),
(84, NULL, '2019-07-03', 'system', NULL, NULL, 'Thesaurus Linguae Graecae', NULL, NULL, NULL, NULL),
(85, NULL, '2019-07-03', 'system', NULL, NULL, 'Tetrad Computer Applications Inc', NULL, NULL, NULL, NULL),
(86, NULL, '2019-07-03', 'system', NULL, NULL, 'Swank Motion Pictures, Inc', NULL, NULL, NULL, NULL),
(87, NULL, '2019-07-03', 'system', NULL, NULL, 'Standard and Poors', NULL, NULL, NULL, NULL),
(88, NULL, '2019-07-03', 'system', NULL, NULL, 'SPIE', NULL, NULL, NULL, NULL),
(89, NULL, '2019-07-03', 'system', NULL, NULL, 'European Society of Endocrinology', NULL, NULL, NULL, NULL),
(90, NULL, '2019-07-03', 'system', NULL, NULL, 'Society of Environmental Toxicology and Chemistry', NULL, NULL, NULL, NULL),
(91, NULL, '2019-07-03', 'system', NULL, NULL, 'Society of Antiquaries of Scotland', NULL, NULL, NULL, NULL),
(92, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Reproduction and Fertility', NULL, NULL, NULL, NULL),
(93, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Neuroscience', NULL, NULL, NULL, NULL),
(94, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Leukocyte Biology', NULL, NULL, NULL, NULL),
(95, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for General Microbiology', NULL, NULL, NULL, NULL),
(96, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Experimental Biology and Medicine', NULL, NULL, NULL, NULL),
(97, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Endocrinology', NULL, NULL, NULL, NULL),
(98, NULL, '2019-07-03', 'system', NULL, NULL, 'Societe Mathematique de France', NULL, NULL, NULL, NULL),
(99, NULL, '2019-07-03', 'system', NULL, NULL, 'Social Explorer', NULL, NULL, NULL, NULL),
(404, NULL, '2019-07-03', 'system', NULL, NULL, 'SETAC', NULL, NULL, NULL, NULL),
(101, NULL, '2019-07-03', 'system', NULL, NULL, 'Swiss Chemical Society', NULL, NULL, NULL, NULL),
(102, NULL, '2019-07-03', 'system', NULL, NULL, 'Scholarly Digital Editions', NULL, NULL, NULL, NULL),
(103, NULL, '2019-07-03', 'system', NULL, NULL, 'Royal Society of London', NULL, NULL, NULL, NULL),
(104, NULL, '2019-07-03', 'system', NULL, NULL, 'Royal Society of Chemistry', NULL, NULL, NULL, NULL),
(105, NULL, '2019-07-03', 'system', NULL, NULL, 'Roper Center for Public Opinion Research', NULL, NULL, NULL, NULL),
(106, NULL, '2019-07-03', 'system', NULL, NULL, 'Rockefeller University Press', NULL, NULL, NULL, NULL),
(107, NULL, '2019-07-03', 'system', NULL, NULL, 'Rivista di Studi italiani', NULL, NULL, NULL, NULL),
(108, NULL, '2019-07-03', 'system', NULL, NULL, 'Reuters Loan Pricing Corporation', NULL, NULL, NULL, NULL),
(109, NULL, '2019-07-03', 'system', NULL, NULL, 'Religious and Theological Abstracts, Inc', NULL, NULL, NULL, NULL),
(110, NULL, '2019-07-03', 'system', NULL, NULL, 'Psychoanalytic Electronic Publishing Inc', NULL, NULL, NULL, NULL),
(111, NULL, '2019-07-03', 'system', NULL, NULL, 'Cornell University Library', NULL, NULL, NULL, NULL),
(112, NULL, '2019-07-03', 'system', NULL, NULL, 'Preservation Technologies LP', NULL, NULL, NULL, NULL),
(113, NULL, '2019-07-03', 'system', NULL, NULL, 'Portland Press Limited', NULL, NULL, NULL, NULL),
(114, NULL, '2019-07-03', 'system', NULL, NULL, 'ITHAKA', NULL, NULL, NULL, NULL),
(115, NULL, '2019-07-03', 'system', NULL, NULL, 'Philosophy Documentation Center', NULL, NULL, NULL, NULL),
(116, NULL, '2019-07-03', 'system', NULL, NULL, 'Peeters Publishers', NULL, NULL, NULL, NULL),
(117, NULL, '2019-07-03', 'system', NULL, NULL, 'Paratext', NULL, NULL, NULL, NULL),
(118, NULL, '2019-07-03', 'system', NULL, NULL, 'Mathematical Sciences Publishers', NULL, NULL, NULL, NULL),
(119, NULL, '2019-07-03', 'system', NULL, NULL, 'Oxford Centre of Hebrew and Jewish Studies', NULL, NULL, NULL, NULL),
(120, NULL, '2019-07-03', 'system', NULL, NULL, 'NewsBank, Inc', NULL, NULL, NULL, NULL),
(121, NULL, '2019-07-03', 'system', NULL, NULL, 'Massachusetts Medical Society', NULL, NULL, NULL, NULL),
(122, NULL, '2019-07-03', 'system', NULL, NULL, 'Naxos of America, Inc.', NULL, NULL, NULL, NULL),
(123, NULL, '2019-07-03', 'system', NULL, NULL, 'National Research Council of Canada', NULL, NULL, NULL, NULL),
(124, NULL, '2019-07-03', 'system', NULL, NULL, 'National Gallery Company Ltd', NULL, NULL, NULL, NULL),
(125, NULL, '2019-07-03', 'system', NULL, NULL, 'National Academy of Sciences', NULL, NULL, NULL, NULL),
(126, NULL, '2019-07-03', 'system', NULL, NULL, 'Mintel International Group Limited', NULL, NULL, NULL, NULL),
(127, NULL, '2019-07-03', 'system', NULL, NULL, 'Metropolitan Opera', NULL, NULL, NULL, NULL),
(128, NULL, '2019-07-03', 'system', NULL, NULL, 'M.E. Sharpe, Inc', NULL, NULL, NULL, NULL),
(129, NULL, '2019-07-03', 'system', NULL, NULL, 'Mergent, Inc', NULL, NULL, NULL, NULL),
(130, NULL, '2019-07-03', 'system', NULL, NULL, 'Mediamark Research and Intelligence, LLC', NULL, NULL, NULL, NULL),
(131, NULL, '2019-07-03', 'system', NULL, NULL, 'Mary Ann Liebert, Inc', NULL, NULL, NULL, NULL),
(132, NULL, '2019-07-03', 'system', NULL, NULL, 'MIT Press', NULL, NULL, NULL, NULL),
(133, NULL, '2019-07-03', 'system', NULL, NULL, 'MarketResearch.com, Inc', NULL, NULL, NULL, NULL),
(134, NULL, '2019-07-03', 'system', NULL, NULL, 'Marine Biological Laboratory', NULL, NULL, NULL, NULL),
(135, NULL, '2019-07-03', 'system', NULL, NULL, 'W.S. Maney and Son Ltd', NULL, NULL, NULL, NULL),
(136, NULL, '2019-07-03', 'system', NULL, NULL, 'Manchester University Press', NULL, NULL, NULL, NULL),
(137, NULL, '2019-07-03', 'system', NULL, NULL, 'Lord Music Reference Inc', NULL, NULL, NULL, NULL),
(138, NULL, '2019-07-03', 'system', NULL, NULL, 'Liverpool University Press', NULL, NULL, NULL, NULL),
(139, NULL, '2019-07-03', 'system', NULL, NULL, 'Seminario Matematico of the University of Padua', NULL, NULL, NULL, NULL),
(140, NULL, '2019-07-03', 'system', NULL, NULL, 'Library of Congress, Cataloging Distribution Service', NULL, NULL, NULL, NULL),
(141, NULL, '2019-07-03', 'system', NULL, NULL, 'LexisNexis', NULL, NULL, NULL, NULL),
(142, NULL, '2019-07-03', 'system', NULL, NULL, 'Corporacion Latinobarometro', NULL, NULL, NULL, NULL),
(143, NULL, '2019-07-03', 'system', NULL, NULL, 'Landes Bioscience', NULL, NULL, NULL, NULL),
(144, NULL, '2019-07-03', 'system', NULL, NULL, 'Keesings Worldwide, LLC', NULL, NULL, NULL, NULL),
(145, NULL, '2019-07-03', 'system', NULL, NULL, 'Karger', NULL, NULL, NULL, NULL),
(146, NULL, '2019-07-03', 'system', NULL, NULL, 'John Benjamins Publishing Company', NULL, NULL, NULL, NULL),
(147, NULL, '2019-07-03', 'system', NULL, NULL, 'Irish Newspaper Archives Ltd', NULL, NULL, NULL, NULL),
(148, NULL, '2019-07-03', 'system', NULL, NULL, 'IPA Source, LLC', NULL, NULL, NULL, NULL),
(149, NULL, '2019-07-03', 'system', NULL, NULL, 'International Press', NULL, NULL, NULL, NULL),
(150, NULL, '2019-07-03', 'system', NULL, NULL, 'Intelligence Research Limited', NULL, NULL, NULL, NULL),
(151, NULL, '2019-07-03', 'system', NULL, NULL, 'Intellect', NULL, NULL, NULL, NULL),
(152, NULL, '2019-07-03', 'system', NULL, NULL, 'InteLex', NULL, NULL, NULL, NULL),
(153, NULL, '2019-07-03', 'system', NULL, NULL, 'Institute of Mathematics of the Polish Academy of Sciences', NULL, NULL, NULL, NULL),
(154, NULL, '2019-07-03', 'system', NULL, NULL, 'Ingentaconnect', NULL, NULL, NULL, NULL),
(155, NULL, '2019-07-03', 'system', NULL, NULL, 'INFORMS', NULL, NULL, NULL, NULL),
(156, NULL, '2019-07-03', 'system', NULL, NULL, 'Information Resources, Inc', NULL, NULL, NULL, NULL),
(157, NULL, '2019-07-03', 'system', NULL, NULL, 'Indiana University Mathematics Journal', NULL, NULL, NULL, NULL),
(158, NULL, '2019-07-03', 'system', NULL, NULL, 'Incisive Media Ltd', NULL, NULL, NULL, NULL),
(159, NULL, '2019-07-03', 'system', NULL, NULL, 'IGI Global ', NULL, NULL, NULL, NULL),
(160, NULL, '2019-07-03', 'system', NULL, NULL, 'IBISWorld USA', NULL, NULL, NULL, NULL),
(161, NULL, '2019-07-03', 'system', NULL, NULL, 'H.W. Wilson Company', NULL, NULL, NULL, NULL),
(162, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Houston Department of Mathematics', NULL, NULL, NULL, NULL),
(163, NULL, '2019-07-03', 'system', NULL, NULL, 'Histochemical Society', NULL, NULL, NULL, NULL),
(164, NULL, '2019-07-03', 'system', NULL, NULL, 'Morningstar Inc.', NULL, NULL, NULL, NULL),
(165, NULL, '2019-07-03', 'system', NULL, NULL, 'Paradigm Publishers', NULL, NULL, NULL, NULL),
(166, NULL, '2019-07-03', 'system', NULL, NULL, 'HighWire Press', NULL, NULL, NULL, NULL),
(167, NULL, '2019-07-03', 'system', NULL, NULL, 'Heldref Publications', NULL, NULL, NULL, NULL),
(168, NULL, '2019-07-03', 'system', NULL, NULL, 'Haworth Press', NULL, NULL, NULL, NULL),
(417, NULL, '2019-07-03', 'system', NULL, NULL, 'Thomson Legal', NULL, NULL, NULL, NULL),
(170, NULL, '2019-07-03', 'system', NULL, NULL, 'IOS Press', NULL, NULL, NULL, NULL),
(171, NULL, '2019-07-03', 'system', NULL, NULL, 'Agricultural Institute of Canada', NULL, NULL, NULL, NULL),
(172, NULL, '2019-07-03', 'system', NULL, NULL, 'Allen Press', NULL, NULL, NULL, NULL),
(173, NULL, '2019-07-03', 'system', NULL, NULL, 'H1 Base, Inc', NULL, NULL, NULL, NULL),
(175, NULL, '2019-07-03', 'system', NULL, NULL, 'Global Science Press', NULL, NULL, NULL, NULL),
(176, NULL, '2019-07-03', 'system', NULL, NULL, 'Geographic Research, Inc', NULL, NULL, NULL, NULL),
(177, NULL, '2019-07-03', 'system', NULL, NULL, 'Genetics Society of America', NULL, NULL, NULL, NULL),
(178, NULL, '2019-07-03', 'system', NULL, NULL, 'Franz Steiner Verlag', NULL, NULL, NULL, NULL),
(179, NULL, '2019-07-03', 'system', NULL, NULL, 'Forrester Research, Inc', NULL, NULL, NULL, NULL),
(180, NULL, '2019-07-03', 'system', NULL, NULL, 'Federation of American Societies for Experimental Biology', NULL, NULL, NULL, NULL),
(181, NULL, '2019-07-03', 'system', NULL, NULL, 'Faulkner Information Services', NULL, NULL, NULL, NULL),
(182, NULL, '2019-07-03', 'system', NULL, NULL, 'ExLibris', NULL, NULL, NULL, NULL),
(183, NULL, '2019-07-03', 'system', NULL, NULL, 'Brill', NULL, NULL, NULL, NULL),
(184, NULL, '2019-07-03', 'system', NULL, NULL, 'Evolutionary Ecology Ltd', NULL, NULL, NULL, NULL),
(185, NULL, '2019-07-03', 'system', NULL, NULL, 'European Mathematical Society Publishing House', NULL, NULL, NULL, NULL),
(186, NULL, '2019-07-03', 'system', NULL, NULL, 'New York Review of Books', NULL, NULL, NULL, NULL),
(187, NULL, '2019-07-03', 'system', NULL, NULL, 'Dunstans Publishing Ltd', NULL, NULL, NULL, NULL),
(188, NULL, '2019-07-03', 'system', NULL, NULL, 'Equinox Publishing Ltd', NULL, NULL, NULL, NULL),
(189, NULL, '2019-07-03', 'system', NULL, NULL, 'Entomological Society of Canada', NULL, NULL, NULL, NULL),
(190, NULL, '2019-07-03', 'system', NULL, NULL, 'American Association of Immunologists, Inc.', NULL, NULL, NULL, NULL),
(191, NULL, '2019-07-03', 'system', NULL, NULL, 'Endocrine Society', NULL, NULL, NULL, NULL),
(192, NULL, '2019-07-03', 'system', NULL, NULL, 'EDP Sciences', NULL, NULL, NULL, NULL),
(193, NULL, '2019-07-03', 'system', NULL, NULL, 'Edinburgh University Press', NULL, NULL, NULL, NULL),
(194, NULL, '2019-07-03', 'system', NULL, NULL, 'Ecological Society of America', NULL, NULL, NULL, NULL),
(195, NULL, '2019-07-03', 'system', NULL, NULL, 'East View Information Services', NULL, NULL, NULL, NULL),
(196, NULL, '2019-07-03', 'system', NULL, NULL, 'Dun and Bradstreet Inc', NULL, NULL, NULL, NULL),
(197, NULL, '2019-07-03', 'system', NULL, NULL, 'Duke University Press', NULL, NULL, NULL, NULL),
(198, NULL, '2019-07-03', 'system', NULL, NULL, 'Digital Distributed Community Archive', NULL, NULL, NULL, NULL),
(199, NULL, '2019-07-03', 'system', NULL, NULL, 'Albert C. Muller', NULL, NULL, NULL, NULL),
(200, NULL, '2019-07-03', 'system', NULL, NULL, 'Dialogue Foundation', NULL, NULL, NULL, NULL),
(201, NULL, '2019-07-03', 'system', NULL, NULL, 'Dialog', NULL, NULL, NULL, NULL),
(202, NULL, '2019-07-03', 'system', NULL, NULL, 'Current History, Inc', NULL, NULL, NULL, NULL),
(203, NULL, '2019-07-03', 'system', NULL, NULL, 'CSIRO Publishing', NULL, NULL, NULL, NULL),
(204, NULL, '2019-07-03', 'system', NULL, NULL, 'CQ Press', NULL, NULL, NULL, NULL),
(205, NULL, '2019-07-03', 'system', NULL, NULL, 'Japan Focus', NULL, NULL, NULL, NULL),
(206, NULL, '2019-07-03', 'system', NULL, NULL, 'Carbon Disclosure Project', NULL, NULL, NULL, NULL),
(207, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Buckingham Press', NULL, NULL, NULL, NULL),
(208, NULL, '2019-07-03', 'system', NULL, NULL, 'Boopsie, INC.', NULL, NULL, NULL, NULL),
(209, NULL, '2019-07-03', 'system', NULL, NULL, 'Company of Biologists Ltd', NULL, NULL, NULL, NULL),
(210, NULL, '2019-07-03', 'system', NULL, NULL, 'Chronicle of Higher Education', NULL, NULL, NULL, NULL),
(211, NULL, '2019-07-03', 'system', NULL, NULL, 'CCH Incorporated', NULL, NULL, NULL, NULL),
(212, NULL, '2019-07-03', 'system', NULL, NULL, 'CareerShift LLC', NULL, NULL, NULL, NULL),
(213, NULL, '2019-07-03', 'system', NULL, NULL, 'Canadian Mathematical Society', NULL, NULL, NULL, NULL),
(214, NULL, '2019-07-03', 'system', NULL, NULL, 'Cambridge Crystallographic Data Centre', NULL, NULL, NULL, NULL),
(215, NULL, '2019-07-03', 'system', NULL, NULL, 'CABI Publishing', NULL, NULL, NULL, NULL),
(216, NULL, '2019-07-03', 'system', NULL, NULL, 'Business Monitor International', NULL, NULL, NULL, NULL),
(217, NULL, '2019-07-03', 'system', NULL, NULL, 'Bureau of National Affairs, Inc', NULL, NULL, NULL, NULL),
(218, NULL, '2019-07-03', 'system', NULL, NULL, 'Bulletin of the Atomic Scientists', NULL, NULL, NULL, NULL),
(219, NULL, '2019-07-03', 'system', NULL, NULL, 'Brepols Publishers', NULL, NULL, NULL, NULL),
(221, NULL, '2019-07-03', 'system', NULL, NULL, 'Botanical Society of America', NULL, NULL, NULL, NULL),
(222, NULL, '2019-07-03', 'system', NULL, NULL, 'BMJ Publishing Group Limited', NULL, NULL, NULL, NULL),
(223, NULL, '2019-07-03', 'system', NULL, NULL, 'BioMed Central', NULL, NULL, NULL, NULL),
(224, NULL, '2019-07-03', 'system', NULL, NULL, 'Berkeley Electronic Press', NULL, NULL, NULL, NULL),
(225, NULL, '2019-07-03', 'system', NULL, NULL, 'Berghahn Books', NULL, NULL, NULL, NULL),
(226, NULL, '2019-07-03', 'system', NULL, NULL, 'Berg Publishers', NULL, NULL, NULL, NULL),
(227, NULL, '2019-07-03', 'system', NULL, NULL, 'Belser Wissenschaftlicher Dienst Ltd', NULL, NULL, NULL, NULL),
(228, NULL, '2019-07-03', 'system', NULL, NULL, 'Beilstein Information Systems, Inc', NULL, NULL, NULL, NULL),
(229, NULL, '2019-07-03', 'system', NULL, NULL, 'Barkhuis Publishing', NULL, NULL, NULL, NULL),
(230, NULL, '2019-07-03', 'system', NULL, NULL, 'Augustine Institute', NULL, NULL, NULL, NULL),
(231, NULL, '2019-07-03', 'system', NULL, NULL, 'Asempa Limited', NULL, NULL, NULL, NULL),
(232, NULL, '2019-07-03', 'system', NULL, NULL, 'ARTstor Inc', NULL, NULL, NULL, NULL),
(233, NULL, '2019-07-03', 'system', NULL, NULL, 'Applied Probability Trust', NULL, NULL, NULL, NULL),
(234, NULL, '2019-07-03', 'system', NULL, NULL, 'Antiquity Publications Limited', NULL, NULL, NULL, NULL),
(235, NULL, '2019-07-03', 'system', NULL, NULL, 'Ammons Scientific Limited', NULL, NULL, NULL, NULL),
(236, NULL, '2019-07-03', 'system', NULL, NULL, 'American Statistical Association', NULL, NULL, NULL, NULL),
(237, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Tropical Medicine and Hygiene', NULL, NULL, NULL, NULL),
(238, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Plant Biologists', NULL, NULL, NULL, NULL),
(239, NULL, '2019-07-03', 'system', NULL, NULL, 'Teachers College Record', NULL, NULL, NULL, NULL),
(240, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Agronomy', NULL, NULL, NULL, NULL),
(241, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Nutrition', NULL, NULL, NULL, NULL),
(242, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Horticultural Science', NULL, NULL, NULL, NULL),
(243, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Clinical Investigation', NULL, NULL, NULL, NULL),
(244, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Cell Biology', NULL, NULL, NULL, NULL),
(245, NULL, '2019-07-03', 'system', NULL, NULL, 'American Psychiatric Publishing', NULL, NULL, NULL, NULL),
(246, NULL, '2019-07-03', 'system', NULL, NULL, 'American Phytopathological Society', NULL, NULL, NULL, NULL),
(247, NULL, '2019-07-03', 'system', NULL, NULL, 'American Physiological Society', NULL, NULL, NULL, NULL),
(248, NULL, '2019-07-03', 'system', NULL, NULL, 'Encyclopaedia Britannica Online', NULL, NULL, NULL, NULL),
(249, NULL, '2019-07-03', 'system', NULL, NULL, 'Agricultural History Society', NULL, NULL, NULL, NULL),
(250, NULL, '2019-07-03', 'system', NULL, NULL, 'Begell House, Inc', NULL, NULL, NULL, NULL),
(251, NULL, '2019-07-03', 'system', NULL, NULL, 'Hans Zell Publishing', NULL, NULL, NULL, NULL),
(252, NULL, '2019-07-03', 'system', NULL, NULL, 'Alliance for Children and Families', NULL, NULL, NULL, NULL),
(253, NULL, '2019-07-03', 'system', NULL, NULL, 'Robert Blakemore', NULL, NULL, NULL, NULL),
(254, NULL, '2019-07-03', 'system', NULL, NULL, 'IVES Group, Inc', NULL, NULL, NULL, NULL),
(255, NULL, '2019-07-03', 'system', NULL, NULL, 'Massachusetts Institute of Technology', NULL, NULL, NULL, NULL),
(256, NULL, '2019-07-03', 'system', NULL, NULL, 'Marquis Who\'s Who LLC', NULL, NULL, NULL, NULL),
(257, NULL, '2019-07-03', 'system', NULL, NULL, 'Atypon Systems Inc', NULL, NULL, NULL, NULL),
(258, NULL, '2019-07-03', 'system', NULL, NULL, 'Worldwatch Institute', NULL, NULL, NULL, NULL),
(259, NULL, '2019-07-03', 'system', NULL, NULL, 'Thomson Financial', NULL, NULL, NULL, NULL),
(260, NULL, '2019-07-03', 'system', NULL, NULL, 'Digital Heritage Publishing Limited', NULL, NULL, NULL, NULL),
(261, NULL, '2019-07-03', 'system', NULL, NULL, 'U.S. Department of Commerce', NULL, NULL, NULL, NULL),
(262, NULL, '2019-07-03', 'system', NULL, NULL, 'Lipper Inc', NULL, NULL, NULL, NULL),
(263, NULL, '2019-07-03', 'system', NULL, NULL, 'Chiniquy Collection', NULL, NULL, NULL, NULL),
(264, NULL, '2019-07-03', 'system', NULL, NULL, 'OCLC', NULL, NULL, NULL, NULL),
(265, NULL, '2019-07-03', 'system', NULL, NULL, 'Consumer Electronics Association', NULL, NULL, NULL, NULL),
(267, NULL, '2019-07-03', 'system', NULL, NULL, 'Institutional Shareholder Services Inc', NULL, NULL, NULL, NULL),
(268, NULL, '2019-07-03', 'system', NULL, NULL, 'KLD Research and Analytics Inc', NULL, NULL, NULL, NULL),
(269, NULL, '2019-07-03', 'system', NULL, NULL, 'BIGresearch LLC', NULL, NULL, NULL, NULL),
(270, NULL, '2019-07-03', 'system', NULL, NULL, 'Cambridge Scientific Abstracts', NULL, NULL, NULL, NULL),
(271, NULL, '2019-07-03', 'system', NULL, NULL, 'American Institute of Certified Public Accountants', NULL, NULL, NULL, NULL),
(272, NULL, '2019-07-03', 'system', NULL, NULL, 'Terra Scientific Publishing Company', NULL, NULL, NULL, NULL),
(273, NULL, '2019-07-03', 'system', NULL, NULL, 'American Counseling Association', NULL, NULL, NULL, NULL),
(274, NULL, '2019-07-03', 'system', NULL, NULL, 'Army Times Publishing Company', NULL, NULL, NULL, NULL),
(275, NULL, '2019-07-03', 'system', NULL, NULL, 'Librairie Droz', NULL, NULL, NULL, NULL),
(276, NULL, '2019-07-03', 'system', NULL, NULL, 'American Academy of Religion', NULL, NULL, NULL, NULL),
(277, NULL, '2019-07-03', 'system', NULL, NULL, 'Boyd Printing', NULL, NULL, NULL, NULL),
(278, NULL, '2019-07-03', 'system', NULL, NULL, 'Canadian Association of African Studies', NULL, NULL, NULL, NULL),
(279, NULL, '2019-07-03', 'system', NULL, NULL, 'Experian Marketing Solutions, Inc.', NULL, NULL, NULL, NULL),
(280, NULL, '2019-07-03', 'system', NULL, NULL, 'Centro de Investigaciones Sociologicas', NULL, NULL, NULL, NULL),
(281, NULL, '2019-07-03', 'system', NULL, NULL, 'Chorus America', NULL, NULL, NULL, NULL),
(282, NULL, '2019-07-03', 'system', NULL, NULL, 'College Art Association', NULL, NULL, NULL, NULL),
(283, NULL, '2019-07-03', 'system', NULL, NULL, 'Human Kinetics Inc.', NULL, NULL, NULL, NULL),
(288, NULL, '2019-07-03', 'system', NULL, NULL, 'NERL', NULL, NULL, NULL, NULL),
(293, NULL, '2019-07-03', 'system', NULL, NULL, 'Colegio de Mexico', NULL, NULL, NULL, NULL),
(294, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Iowa', NULL, NULL, NULL, NULL),
(295, NULL, '2019-07-03', 'system', NULL, NULL, 'Academy of the Hebrew Language', NULL, NULL, NULL, NULL),
(296, NULL, '2019-07-03', 'system', NULL, NULL, 'FamilyLink.com, Inc.', NULL, NULL, NULL, NULL),
(297, NULL, '2019-07-03', 'system', NULL, NULL, 'SISMEL - Edizioni del Galluzzo', NULL, NULL, NULL, NULL),
(301, NULL, '2019-07-03', 'system', NULL, NULL, 'Informaworld', NULL, NULL, NULL, NULL),
(302, NULL, '2019-07-03', 'system', NULL, NULL, 'ScienceDirect', NULL, NULL, NULL, NULL),
(304, NULL, '2019-07-03', 'system', NULL, NULL, 'China Data Center', NULL, NULL, NULL, NULL),
(305, NULL, '2019-07-03', 'system', NULL, NULL, 'Association for Computing Machinery', NULL, NULL, NULL, NULL),
(306, NULL, '2019-07-03', 'system', NULL, NULL, 'American Chemical Society', NULL, NULL, NULL, NULL),
(307, NULL, '2019-07-03', 'system', NULL, NULL, 'Design Research Publications', NULL, NULL, NULL, NULL),
(308, NULL, '2019-07-03', 'system', NULL, NULL, 'ABC-CLIO', NULL, NULL, NULL, NULL),
(311, NULL, '2019-07-03', 'system', NULL, NULL, 'American Association on Intellectual and Developmental Disabilities ', NULL, NULL, NULL, NULL),
(310, NULL, '2019-07-03', 'system', NULL, NULL, 'American Antiquarian Society', NULL, NULL, NULL, NULL),
(312, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society for Microbiology', NULL, NULL, NULL, NULL),
(314, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Mechanical Engineers', NULL, NULL, NULL, NULL),
(315, NULL, '2019-07-03', 'system', NULL, NULL, 'Now Publishers, Inc.', NULL, NULL, NULL, NULL),
(316, NULL, '2019-07-03', 'system', NULL, NULL, 'Cabell Publishing Company, Inc.', NULL, NULL, NULL, NULL),
(317, NULL, '2019-07-03', 'system', NULL, NULL, 'Center for Research Libraries', NULL, NULL, NULL, NULL),
(444, NULL, '2019-07-03', 'system', NULL, NULL, 'Cold North Wind Inc', NULL, NULL, NULL, NULL),
(321, NULL, '2019-07-03', 'system', NULL, NULL, 'Erudit ', NULL, NULL, NULL, NULL),
(322, NULL, '2019-07-03', 'system', NULL, NULL, 'American Institute of Mathematical Sciences', NULL, NULL, NULL, NULL),
(324, NULL, '2019-07-03', 'system', NULL, NULL, 'American Sociological Association', NULL, NULL, NULL, NULL),
(325, NULL, '2019-07-03', 'system', NULL, NULL, 'Archaeological Institute of America', NULL, NULL, NULL, NULL),
(326, NULL, '2019-07-03', 'system', NULL, NULL, 'Bertrand Russell Research Centre', NULL, NULL, NULL, NULL),
(328, NULL, '2019-07-03', 'system', NULL, NULL, 'Cork University Press', NULL, NULL, NULL, NULL),
(329, NULL, '2019-07-03', 'system', NULL, NULL, 'College Publishing', NULL, NULL, NULL, NULL),
(330, NULL, '2019-07-03', 'system', NULL, NULL, 'Council for Learning Disabilities', NULL, NULL, NULL, NULL),
(331, NULL, '2019-07-03', 'system', NULL, NULL, 'International Society on Hypertension in Blacks (ISHIB)', NULL, NULL, NULL, NULL),
(332, NULL, '2019-07-03', 'system', NULL, NULL, 'Firenze University Press', NULL, NULL, NULL, NULL),
(333, NULL, '2019-07-03', 'system', NULL, NULL, 'History of Earth Sciences Society', NULL, NULL, NULL, NULL),
(334, NULL, '2019-07-03', 'system', NULL, NULL, 'History Today Ltd.', NULL, NULL, NULL, NULL),
(335, NULL, '2019-07-03', 'system', NULL, NULL, 'Journal of Music', NULL, NULL, NULL, NULL),
(336, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Nebraska at Omaha', NULL, NULL, NULL, NULL),
(337, NULL, '2019-07-03', 'system', NULL, NULL, 'Journal of Indo-European Studies', NULL, NULL, NULL, NULL),
(338, NULL, '2019-07-03', 'system', NULL, NULL, 'Library Binding Institute', NULL, NULL, NULL, NULL),
(339, NULL, '2019-07-03', 'system', NULL, NULL, 'McFarland & Co. Inc.', NULL, NULL, NULL, NULL),
(340, NULL, '2019-07-03', 'system', NULL, NULL, 'Lyrasis', NULL, NULL, NULL, NULL),
(341, NULL, '2019-07-03', 'system', NULL, NULL, 'Amigos Library Services', NULL, NULL, NULL, NULL),
(343, NULL, '2019-07-03', 'system', NULL, NULL, 'Fabrizio Serra Editore', NULL, NULL, NULL, NULL),
(344, NULL, '2019-07-03', 'system', NULL, NULL, 'Aux Amateurs', NULL, NULL, NULL, NULL),
(346, NULL, '2019-07-03', 'system', NULL, NULL, 'National Affairs, Inc', NULL, NULL, NULL, NULL),
(357, NULL, '2019-07-03', 'system', NULL, NULL, 'Society of Chemical Industry', NULL, NULL, NULL, NULL),
(347, NULL, '2019-07-03', 'system', NULL, NULL, 'New Criterion', NULL, NULL, NULL, NULL),
(348, NULL, '2019-07-03', 'system', NULL, NULL, 'Casa Editrice Leo S. Olschki s.r.l.', NULL, NULL, NULL, NULL),
(349, NULL, '2019-07-03', 'system', NULL, NULL, 'Rhodes University, Department of Philosophy', NULL, NULL, NULL, NULL),
(350, NULL, '2019-07-03', 'system', NULL, NULL, 'Rocky Mountain Mathematics Consortium', NULL, NULL, NULL, NULL),
(352, NULL, '2019-07-03', 'system', NULL, NULL, 'Royal Irish Academy', NULL, NULL, NULL, NULL),
(353, NULL, '2019-07-03', 'system', NULL, NULL, 'Chadwyck-Healey', NULL, NULL, NULL, NULL),
(354, NULL, '2019-07-03', 'system', NULL, NULL, 'CSA illumina', NULL, NULL, NULL, NULL),
(355, NULL, '2019-07-03', 'system', NULL, NULL, 'New School for Social Research', NULL, NULL, NULL, NULL),
(356, NULL, '2019-07-03', 'system', NULL, NULL, 'Society of Biblical Literature', NULL, NULL, NULL, NULL),
(358, NULL, '2019-07-03', 'system', NULL, NULL, 'Stazione Zoologica Anton Dohrn', NULL, NULL, NULL, NULL),
(359, NULL, '2019-07-03', 'system', NULL, NULL, 'BioScientifica Ltd.', NULL, NULL, NULL, NULL),
(360, NULL, '2019-07-03', 'system', NULL, NULL, 'CASALINI LIBRI', NULL, NULL, NULL, NULL),
(361, NULL, '2019-07-03', 'system', NULL, NULL, 'Institute of Organic Chemistry', NULL, NULL, NULL, NULL),
(362, NULL, '2019-07-03', 'system', NULL, NULL, 'Columbia International Affairs Online ', NULL, NULL, NULL, NULL),
(363, NULL, '2019-07-03', 'system', NULL, NULL, 'Corporation for National Research Initiatives ', NULL, NULL, NULL, NULL),
(364, NULL, '2019-07-03', 'system', NULL, NULL, 'Tilgher-Genova', NULL, NULL, NULL, NULL),
(365, NULL, '2019-07-03', 'system', NULL, NULL, 'Emerald Group Publishing Limited', NULL, NULL, NULL, NULL),
(366, NULL, '2019-07-03', 'system', NULL, NULL, 'Geological Society of America', NULL, NULL, NULL, NULL),
(367, NULL, '2019-07-03', 'system', NULL, NULL, 'Institute of Mathematical Statistics', NULL, NULL, NULL, NULL),
(368, NULL, '2019-07-03', 'system', NULL, NULL, 'Institute of Pure and Applied Physics', NULL, NULL, NULL, NULL),
(369, NULL, '2019-07-03', 'system', NULL, NULL, 'JSTAGE', NULL, NULL, NULL, NULL),
(370, NULL, '2019-07-03', 'system', NULL, NULL, 'Metapress', NULL, NULL, NULL, NULL),
(371, NULL, '2019-07-03', 'system', NULL, NULL, 'Modern Language Association', NULL, NULL, NULL, NULL),
(372, NULL, '2019-07-03', 'system', NULL, NULL, 'Optical Society of America', NULL, NULL, NULL, NULL),
(373, NULL, '2019-07-03', 'system', NULL, NULL, 'University of British Columbia', NULL, NULL, NULL, NULL),
(374, NULL, '2019-07-03', 'system', NULL, NULL, 'University of New Mexico', NULL, NULL, NULL, NULL),
(375, NULL, '2019-07-03', 'system', NULL, NULL, 'Vandenhoeck & Ruprecht', NULL, NULL, NULL, NULL),
(376, NULL, '2019-07-03', 'system', NULL, NULL, 'Verlag Mohr Siebeck GmbH & Co. KG', NULL, NULL, NULL, NULL),
(377, NULL, '2019-07-03', 'system', NULL, NULL, 'Palgrave Macmillan', NULL, NULL, NULL, NULL),
(378, NULL, '2019-07-03', 'system', NULL, NULL, 'Vittorio Klostermann', NULL, NULL, NULL, NULL),
(379, NULL, '2019-07-03', 'system', NULL, NULL, 'Project Euclid', NULL, NULL, NULL, NULL),
(380, NULL, '2019-07-03', 'system', NULL, NULL, 'Psychonomic Society ', NULL, NULL, NULL, NULL),
(411, NULL, '2019-07-03', 'system', NULL, NULL, 'Cengage Learning', NULL, NULL, NULL, NULL),
(382, NULL, '2019-07-03', 'system', NULL, NULL, 'Infotrieve', NULL, NULL, NULL, NULL),
(383, NULL, '2019-07-03', 'system', NULL, NULL, 'Society of Automotive Engineers', NULL, NULL, NULL, NULL),
(384, NULL, '2019-07-03', 'system', NULL, NULL, 'Turpion Publications', NULL, NULL, NULL, NULL),
(426, NULL, '2019-07-03', 'system', NULL, NULL, 'Midwest Collaborative for Library Services', NULL, NULL, NULL, NULL),
(386, NULL, '2019-07-03', 'system', NULL, NULL, 'Lawrence Erlbaum Associates', NULL, NULL, NULL, NULL),
(387, NULL, '2019-07-03', 'system', NULL, NULL, 'Alphagraphics', NULL, NULL, NULL, NULL),
(388, NULL, '2019-07-03', 'system', NULL, NULL, 'Bellerophon Publications, Inc.', NULL, NULL, NULL, NULL),
(389, NULL, '2019-07-03', 'system', NULL, NULL, 'Boydell & Brewer Inc.', NULL, NULL, NULL, NULL),
(390, NULL, '2019-07-03', 'system', NULL, NULL, 'Carcanet Press', NULL, NULL, NULL, NULL),
(391, NULL, '2019-07-03', 'system', NULL, NULL, 'Feminist Studies', NULL, NULL, NULL, NULL),
(393, NULL, '2019-07-03', 'system', NULL, NULL, 'Dustbooks', NULL, NULL, NULL, NULL),
(394, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Applied Anthropology ', NULL, NULL, NULL, NULL),
(395, NULL, '2019-07-03', 'system', NULL, NULL, 'United Nations Publications', NULL, NULL, NULL, NULL),
(396, NULL, '2019-07-03', 'system', NULL, NULL, 'Wharton Research Data Services', NULL, NULL, NULL, NULL),
(398, NULL, '2019-07-03', 'system', NULL, NULL, 'Human Development', NULL, NULL, NULL, NULL),
(399, NULL, '2019-07-03', 'system', NULL, NULL, 'infoUSA Marketing, Inc.', NULL, NULL, NULL, NULL),
(400, NULL, '2019-07-03', 'system', NULL, NULL, 'Bowker', NULL, NULL, NULL, NULL),
(402, NULL, '2019-07-03', 'system', NULL, NULL, 'Brown University', NULL, NULL, NULL, NULL),
(401, NULL, '2019-07-03', 'system', NULL, NULL, 'Women Writers Project', NULL, NULL, NULL, NULL),
(445, NULL, '2019-07-03', 'system', NULL, NULL, 'Coutts', NULL, NULL, NULL, NULL),
(446, NULL, '2019-07-03', 'system', NULL, NULL, 'Numara Software, Inc.', NULL, NULL, NULL, NULL),
(447, NULL, '2019-07-03', 'system', NULL, NULL, 'Trinity College Library Dublin', NULL, NULL, NULL, NULL),
(405, NULL, '2019-07-03', 'system', NULL, NULL, 'Oldenbourg Wissenschaftsverlag ', NULL, NULL, NULL, NULL),
(406, NULL, '2019-07-03', 'system', NULL, NULL, 'Dow Jones', NULL, NULL, NULL, NULL),
(412, NULL, '2019-07-03', 'system', NULL, NULL, 'Financial Information Inc. (FII)', NULL, NULL, NULL, NULL),
(408, NULL, '2019-07-03', 'system', NULL, NULL, 'Jackson Publishing and Distribution', NULL, NULL, NULL, NULL),
(409, NULL, '2019-07-03', 'system', NULL, NULL, 'Elsevier Engineering Information, Inc. ', NULL, NULL, NULL, NULL),
(410, NULL, '2019-07-03', 'system', NULL, NULL, 'Eneclann Ltd.', NULL, NULL, NULL, NULL),
(413, NULL, '2019-07-03', 'system', NULL, NULL, 'UCLA Latin American Institute', NULL, NULL, NULL, NULL),
(414, NULL, '2019-07-03', 'system', NULL, NULL, 'Harmonie Park Press ', NULL, NULL, NULL, NULL),
(415, NULL, '2019-07-03', 'system', NULL, NULL, 'Harrassowitz', NULL, NULL, NULL, NULL),
(416, NULL, '2019-07-03', 'system', NULL, NULL, 'Thomson Reuters', NULL, NULL, NULL, NULL),
(418, NULL, '2019-07-03', 'system', NULL, NULL, 'Human Relations Area Files, Inc. ', NULL, NULL, NULL, NULL),
(432, NULL, '2019-07-03', 'system', NULL, NULL, 'Capital IQ', NULL, NULL, NULL, NULL),
(419, NULL, '2019-07-03', 'system', NULL, NULL, 'Society for Ethnomusicology', NULL, NULL, NULL, NULL),
(420, NULL, '2019-07-03', 'system', NULL, NULL, 'MSCI RiskMetrics', NULL, NULL, NULL, NULL),
(421, NULL, '2019-07-03', 'system', NULL, NULL, 'Rapid Multimedia', NULL, NULL, NULL, NULL),
(422, NULL, '2019-07-03', 'system', NULL, NULL, 'MSCI Inc', NULL, NULL, NULL, NULL),
(423, NULL, '2019-07-03', 'system', NULL, NULL, 'New England Journal of Medicine', NULL, NULL, NULL, NULL),
(424, NULL, '2019-07-03', 'system', NULL, NULL, 'NetLibrary', NULL, NULL, NULL, NULL),
(425, NULL, '2019-07-03', 'system', NULL, NULL, 'CARMA', NULL, NULL, NULL, NULL),
(427, NULL, '2019-07-03', 'system', NULL, NULL, 'Public Library of Science', NULL, NULL, NULL, NULL),
(428, NULL, '2019-07-03', 'system', NULL, NULL, 'Social Science Electronic Publishing', NULL, NULL, NULL, NULL),
(429, NULL, '2019-07-03', 'system', NULL, NULL, 'United Nations Industrial Develoipment Organization', NULL, NULL, NULL, NULL),
(430, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Michigan Press', NULL, NULL, NULL, NULL),
(431, NULL, '2019-07-03', 'system', NULL, NULL, 'ORS Publishing, Inc.', NULL, NULL, NULL, NULL),
(433, NULL, '2019-07-03', 'system', NULL, NULL, 'McGraw-Hill', NULL, NULL, NULL, NULL),
(434, NULL, '2019-07-03', 'system', NULL, NULL, 'Biblical Archaeology Society', NULL, NULL, NULL, NULL),
(435, NULL, '2019-07-03', 'system', NULL, NULL, 'GeoLytics, Inc.', NULL, NULL, NULL, NULL),
(436, NULL, '2019-07-03', 'system', NULL, NULL, 'JoVE ', NULL, NULL, NULL, NULL),
(437, NULL, '2019-07-03', 'system', NULL, NULL, 'ICEsoft Technologies, Inc.', NULL, NULL, NULL, NULL),
(438, NULL, '2019-07-03', 'system', NULL, NULL, 'Films Media Group', NULL, NULL, NULL, NULL),
(439, NULL, '2019-07-03', 'system', NULL, NULL, 'Films on Demand', NULL, NULL, NULL, NULL),
(440, NULL, '2019-07-03', 'system', NULL, NULL, 'Connect Journals', NULL, NULL, NULL, NULL),
(441, NULL, '2019-07-03', 'system', NULL, NULL, 'Scuola Normale Superiore', NULL, NULL, NULL, NULL),
(442, NULL, '2019-07-03', 'system', NULL, NULL, 'Wolters Kluwer', NULL, NULL, NULL, NULL),
(448, NULL, '2019-07-03', 'system', NULL, NULL, 'Pier Professional', NULL, NULL, NULL, NULL),
(449, NULL, '2019-07-03', 'system', NULL, NULL, 'ABC News', NULL, NULL, NULL, NULL),
(450, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Aberdeen ', NULL, NULL, NULL, NULL),
(451, NULL, '2019-07-03', 'system', NULL, NULL, 'BullFrog Films, Inc.', NULL, NULL, NULL, NULL),
(453, NULL, '2019-07-03', 'system', NULL, NULL, 'FirstSearch', NULL, NULL, NULL, NULL),
(455, NULL, '2019-07-03', 'system', NULL, NULL, 'History Cooperative ', NULL, NULL, NULL, NULL),
(456, NULL, '2019-07-03', 'system', NULL, NULL, 'Omohundro Institute of Early American History and Culture', NULL, NULL, NULL, NULL),
(457, NULL, '2019-07-03', 'system', NULL, NULL, 'Arms Control Association', NULL, NULL, NULL, NULL),
(458, NULL, '2019-07-03', 'system', NULL, NULL, 'Heritage Archives', NULL, NULL, NULL, NULL),
(459, NULL, '2019-07-03', 'system', NULL, NULL, 'International Historic Films, Inc.', NULL, NULL, NULL, NULL),
(460, NULL, '2019-07-03', 'system', NULL, NULL, 'Euromonitor International ', NULL, NULL, NULL, NULL),
(461, NULL, '2019-07-03', 'system', NULL, NULL, 'Safari Books Online', NULL, NULL, NULL, NULL),
(462, NULL, '2019-07-03', 'system', NULL, NULL, 'Mirabile', NULL, NULL, NULL, NULL),
(466, NULL, '2019-07-03', 'system', NULL, NULL, 'Publishing Technology', NULL, NULL, NULL, NULL),
(463, NULL, '2019-07-03', 'system', NULL, NULL, 'SageWorks, Inc', NULL, NULL, NULL, NULL),
(464, NULL, '2019-07-03', 'system', NULL, NULL, 'Johns Hopkins Universtiy Press', NULL, NULL, NULL, NULL),
(465, NULL, '2019-07-03', 'system', NULL, NULL, 'Knovel ', NULL, NULL, NULL, NULL),
(467, NULL, '2019-07-03', 'system', NULL, NULL, 'American Society of Nephrology', NULL, NULL, NULL, NULL),
(468, NULL, '2019-07-03', 'system', NULL, NULL, 'Water Envrionment Federation ', NULL, NULL, NULL, NULL),
(469, NULL, '2019-07-03', 'system', NULL, NULL, 'Refworks', NULL, NULL, NULL, NULL),
(470, NULL, '2019-07-03', 'system', NULL, NULL, 'Cinemagician Productions', NULL, NULL, NULL, NULL),
(471, NULL, '2019-07-03', 'system', NULL, NULL, 'Algorithmics', NULL, NULL, NULL, NULL),
(472, NULL, '2019-07-03', 'system', NULL, NULL, 'YBP Library Services ', NULL, NULL, NULL, NULL),
(474, NULL, '2019-07-03', 'system', NULL, NULL, 'Maydream Inc.', NULL, NULL, NULL, NULL),
(475, NULL, '2019-07-03', 'system', NULL, NULL, 'Organization for Economic Cooperation and Development', NULL, NULL, NULL, NULL),
(476, NULL, '2019-07-03', 'system', NULL, NULL, 'The Chronicle for Higher Education', NULL, NULL, NULL, NULL),
(477, NULL, '2019-07-03', 'system', NULL, NULL, 'Association for Research in Vision and Ophthalmologie (ARVO)', NULL, NULL, NULL, NULL),
(478, NULL, '2019-07-03', 'system', NULL, NULL, 'SRDS Media Solutions', NULL, NULL, NULL, NULL),
(479, NULL, '2019-07-03', 'system', NULL, NULL, 'Kantar Media', NULL, NULL, NULL, NULL),
(480, NULL, '2019-07-03', 'system', NULL, NULL, 'Peace & Justice Studies Association', NULL, NULL, NULL, NULL),
(481, NULL, '2019-07-03', 'system', NULL, NULL, 'Addison Publications Ltd.', NULL, NULL, NULL, NULL),
(482, NULL, '2019-07-03', 'system', NULL, NULL, 'Mutii-Science Publishing', NULL, NULL, NULL, NULL),
(483, NULL, '2019-07-03', 'system', NULL, NULL, 'ASM International', NULL, NULL, NULL, NULL),
(484, NULL, '2019-07-03', 'system', NULL, NULL, 'Verlag der Osterreichischen Akademie der Wissenschaften', NULL, NULL, NULL, NULL),
(485, NULL, '2019-07-03', 'system', NULL, NULL, 'Anthology of Recorded Music', NULL, NULL, NULL, NULL),
(486, NULL, '2019-07-03', 'system', NULL, NULL, 'Left Coast Press, Inc', NULL, NULL, NULL, NULL),
(487, NULL, '2019-07-03', 'system', NULL, NULL, 'Video Data Bank', NULL, NULL, NULL, NULL),
(488, NULL, '2019-07-03', 'system', NULL, NULL, 'Atlassian', NULL, NULL, NULL, NULL),
(489, NULL, '2019-07-03', 'system', NULL, NULL, 'medici.tv', NULL, NULL, NULL, NULL),
(490, NULL, '2019-07-03', 'system', NULL, NULL, 'Bar Ilan Research & Development Company Ltd', NULL, NULL, NULL, NULL),
(491, NULL, '2019-07-03', 'system', NULL, NULL, 'Primary Source Media', NULL, NULL, NULL, NULL),
(492, NULL, '2019-07-03', 'system', NULL, NULL, 'Ebrary', NULL, NULL, NULL, NULL),
(493, NULL, '2019-07-03', 'system', NULL, NULL, 'University of Michigan, Department of Mathematics', NULL, NULL, NULL, NULL),
(494, NULL, '2019-07-03', 'system', NULL, NULL, 'StataCorp LP ', NULL, NULL, NULL, NULL),
(495, NULL, '2019-07-03', 'system', NULL, NULL, 'L\' Enseignement Mathematique  ', NULL, NULL, NULL, NULL),
(496, NULL, '2019-07-03', 'system', NULL, NULL, 'Audio Engineering Society, Inc', NULL, NULL, NULL, NULL),
(497, NULL, '2019-07-03', 'system', NULL, NULL, 'LOCKSS', NULL, NULL, NULL, NULL),
(498, NULL, '2019-07-03', 'system', NULL, NULL, 'MUSEEC ', NULL, NULL, NULL, NULL),
(499, NULL, '2019-07-03', 'system', NULL, NULL, 'Mortgage Bankers Association', NULL, NULL, NULL, NULL),
(500, NULL, '2019-07-03', 'system', NULL, NULL, 'BibleWorks', NULL, NULL, NULL, NULL),
(501, NULL, '2019-07-03', 'system', NULL, NULL, 'National Library of Ireland', NULL, NULL, NULL, NULL),
(502, NULL, '2019-07-03', 'system', NULL, NULL, 'Scholars Press', NULL, NULL, NULL, NULL),
(503, NULL, '2019-07-03', 'system', NULL, NULL, 'Index to Jewish periodicals', NULL, NULL, NULL, NULL),
(504, NULL, '2019-07-03', 'system', NULL, NULL, 'Cold Spring Harbor Laboratory Press', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `OrganizationHierarchy`
--

CREATE TABLE `OrganizationHierarchy` (
  `organizationID` int(11) NOT NULL,
  `parentOrganizationID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OrganizationHierarchy`
--

INSERT INTO `OrganizationHierarchy` (`organizationID`, `parentOrganizationID`) VALUES
(28, 416),
(35, 411),
(43, 36),
(44, 442),
(87, 433),
(154, 466),
(168, 39),
(228, 29),
(259, 416),
(267, 422),
(270, 51),
(301, 39),
(302, 29),
(353, 51),
(354, 270),
(370, 42),
(401, 402),
(406, 51),
(409, 29),
(417, 416),
(420, 422),
(424, 42),
(432, 87),
(439, 438),
(453, 264),
(462, 297),
(469, 270),
(478, 479);

-- --------------------------------------------------------

--
-- Table structure for table `OrganizationRole`
--

CREATE TABLE `OrganizationRole` (
  `organizationRoleID` int(11) NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OrganizationRole`
--

INSERT INTO `OrganizationRole` (`organizationRoleID`, `shortName`) VALUES
(1, 'Consortium'),
(2, 'Library'),
(3, 'Platform'),
(4, 'Provider'),
(5, 'Publisher'),
(6, 'Vendor');

-- --------------------------------------------------------

--
-- Table structure for table `OrganizationRoleProfile`
--

CREATE TABLE `OrganizationRoleProfile` (
  `organizationID` int(11) NOT NULL,
  `organizationRoleID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Privilege`
--

CREATE TABLE `Privilege` (
  `privilegeID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Privilege`
--

INSERT INTO `Privilege` (`privilegeID`, `shortName`) VALUES
(1, 'admin'),
(2, 'add/edit'),
(3, 'view only');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `loginID` varchar(50) NOT NULL,
  `privilegeID` int(11) DEFAULT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `accountTabIndicator` int(1) UNSIGNED DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`loginID`, `privilegeID`, `firstName`, `lastName`, `accountTabIndicator`) VALUES
('coral_admin', 1, NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Alias`
--
ALTER TABLE `Alias`
  ADD PRIMARY KEY (`aliasID`),
  ADD UNIQUE KEY `aliasID` (`aliasID`),
  ADD KEY `organizationID` (`organizationID`),
  ADD KEY `aliasTypeID` (`aliasTypeID`);

--
-- Indexes for table `AliasType`
--
ALTER TABLE `AliasType`
  ADD PRIMARY KEY (`aliasTypeID`),
  ADD UNIQUE KEY `aliasTypeID` (`aliasTypeID`);

--
-- Indexes for table `Contact`
--
ALTER TABLE `Contact`
  ADD PRIMARY KEY (`contactID`),
  ADD UNIQUE KEY `contactID` (`contactID`),
  ADD KEY `organizationID` (`organizationID`);

--
-- Indexes for table `ContactRole`
--
ALTER TABLE `ContactRole`
  ADD PRIMARY KEY (`contactRoleID`),
  ADD UNIQUE KEY `contactRoleID` (`contactRoleID`);

--
-- Indexes for table `ContactRoleProfile`
--
ALTER TABLE `ContactRoleProfile`
  ADD PRIMARY KEY (`contactID`,`contactRoleID`);

--
-- Indexes for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  ADD PRIMARY KEY (`externalLoginID`),
  ADD UNIQUE KEY `externalLoginID` (`externalLoginID`),
  ADD KEY `organizationID` (`organizationID`),
  ADD KEY `externalLoginTypeID` (`externalLoginTypeID`);

--
-- Indexes for table `ExternalLoginType`
--
ALTER TABLE `ExternalLoginType`
  ADD PRIMARY KEY (`externalLoginTypeID`),
  ADD UNIQUE KEY `externalLoginTypeID` (`externalLoginTypeID`);

--
-- Indexes for table `IssueLog`
--
ALTER TABLE `IssueLog`
  ADD PRIMARY KEY (`issueLogID`),
  ADD UNIQUE KEY `issueLogID` (`issueLogID`),
  ADD KEY `organizationID` (`organizationID`),
  ADD KEY `issueLogTypeID` (`issueLogTypeID`);

--
-- Indexes for table `IssueLogType`
--
ALTER TABLE `IssueLogType`
  ADD PRIMARY KEY (`issueLogTypeID`),
  ADD UNIQUE KEY `issueLogTypeID` (`issueLogTypeID`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`organizationID`),
  ADD UNIQUE KEY `organizationID` (`organizationID`);

--
-- Indexes for table `OrganizationHierarchy`
--
ALTER TABLE `OrganizationHierarchy`
  ADD PRIMARY KEY (`organizationID`,`parentOrganizationID`);

--
-- Indexes for table `OrganizationRole`
--
ALTER TABLE `OrganizationRole`
  ADD PRIMARY KEY (`organizationRoleID`),
  ADD UNIQUE KEY `organizationRoleID` (`organizationRoleID`);

--
-- Indexes for table `OrganizationRoleProfile`
--
ALTER TABLE `OrganizationRoleProfile`
  ADD PRIMARY KEY (`organizationID`,`organizationRoleID`),
  ADD KEY `organizationRoleID` (`organizationRoleID`);

--
-- Indexes for table `Privilege`
--
ALTER TABLE `Privilege`
  ADD PRIMARY KEY (`privilegeID`) USING BTREE;

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`loginID`) USING BTREE,
  ADD KEY `roleID` (`privilegeID`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Alias`
--
ALTER TABLE `Alias`
  MODIFY `aliasID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `AliasType`
--
ALTER TABLE `AliasType`
  MODIFY `aliasTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Contact`
--
ALTER TABLE `Contact`
  MODIFY `contactID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ContactRole`
--
ALTER TABLE `ContactRole`
  MODIFY `contactRoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  MODIFY `externalLoginID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ExternalLoginType`
--
ALTER TABLE `ExternalLoginType`
  MODIFY `externalLoginTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `IssueLog`
--
ALTER TABLE `IssueLog`
  MODIFY `issueLogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IssueLogType`
--
ALTER TABLE `IssueLogType`
  MODIFY `issueLogTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `organizationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=505;

--
-- AUTO_INCREMENT for table `OrganizationRole`
--
ALTER TABLE `OrganizationRole`
  MODIFY `organizationRoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Privilege`
--
ALTER TABLE `Privilege`
  MODIFY `privilegeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
