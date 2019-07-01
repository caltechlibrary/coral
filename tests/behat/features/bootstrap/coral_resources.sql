-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jun 05, 2019 at 06:52 PM
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
-- Database: `coral_resources`
--

-- --------------------------------------------------------

--
-- Table structure for table `AccessMethod`
--

CREATE TABLE `AccessMethod` (
  `accessMethodID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AccessMethod`
--

INSERT INTO `AccessMethod` (`accessMethodID`, `shortName`) VALUES
(1, 'Standalone CD'),
(2, 'External Host'),
(3, 'Local Host');

-- --------------------------------------------------------

--
-- Table structure for table `AcquisitionType`
--

CREATE TABLE `AcquisitionType` (
  `acquisitionTypeID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AcquisitionType`
--

INSERT INTO `AcquisitionType` (`acquisitionTypeID`, `shortName`) VALUES
(1, 'Paid'),
(2, 'Free'),
(3, 'Trial'),
(4, 'Any');

-- --------------------------------------------------------

--
-- Table structure for table `AdministeringSite`
--

CREATE TABLE `AdministeringSite` (
  `administeringSiteID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AdministeringSite`
--

INSERT INTO `AdministeringSite` (`administeringSiteID`, `shortName`) VALUES
(1, 'Main Library');

-- --------------------------------------------------------

--
-- Table structure for table `AlertDaysInAdvance`
--

CREATE TABLE `AlertDaysInAdvance` (
  `alertDaysInAdvanceID` int(11) NOT NULL,
  `daysInAdvanceNumber` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AlertDaysInAdvance`
--

INSERT INTO `AlertDaysInAdvance` (`alertDaysInAdvanceID`, `daysInAdvanceNumber`) VALUES
(1, 30),
(2, 60),
(3, 90);

-- --------------------------------------------------------

--
-- Table structure for table `AlertEmailAddress`
--

CREATE TABLE `AlertEmailAddress` (
  `alertEmailAddressID` int(11) NOT NULL,
  `emailAddress` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Alias`
--

CREATE TABLE `Alias` (
  `aliasID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `aliasTypeID` int(11) DEFAULT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AliasType`
--

CREATE TABLE `AliasType` (
  `aliasTypeID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AliasType`
--

INSERT INTO `AliasType` (`aliasTypeID`, `shortName`) VALUES
(1, 'Abbreviation'),
(2, 'Alternate Name'),
(3, 'Name Change');

-- --------------------------------------------------------

--
-- Table structure for table `Attachment`
--

CREATE TABLE `Attachment` (
  `attachmentID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `attachmentTypeID` int(11) DEFAULT NULL,
  `shortName` varchar(200) DEFAULT NULL,
  `descriptionText` text,
  `attachmentURL` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AttachmentType`
--

CREATE TABLE `AttachmentType` (
  `attachmentTypeID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AttachmentType`
--

INSERT INTO `AttachmentType` (`attachmentTypeID`, `shortName`) VALUES
(1, 'Email'),
(2, 'User Guide'),
(3, 'Title List'),
(4, 'General');

-- --------------------------------------------------------

--
-- Table structure for table `AuthenticationType`
--

CREATE TABLE `AuthenticationType` (
  `authenticationTypeID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AuthenticationType`
--

INSERT INTO `AuthenticationType` (`authenticationTypeID`, `shortName`) VALUES
(1, 'IP Address'),
(2, 'Username'),
(3, 'Referring URL');

-- --------------------------------------------------------

--
-- Table structure for table `AuthorizedSite`
--

CREATE TABLE `AuthorizedSite` (
  `authorizedSiteID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AuthorizedSite`
--

INSERT INTO `AuthorizedSite` (`authorizedSiteID`, `shortName`) VALUES
(1, 'Main Campus');

-- --------------------------------------------------------

--
-- Table structure for table `CatalogingStatus`
--

CREATE TABLE `CatalogingStatus` (
  `catalogingStatusID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CatalogingStatus`
--

INSERT INTO `CatalogingStatus` (`catalogingStatusID`, `shortName`) VALUES
(1, 'Completed'),
(2, 'Ongoing'),
(3, 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `CatalogingType`
--

CREATE TABLE `CatalogingType` (
  `catalogingTypeID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CatalogingType`
--

INSERT INTO `CatalogingType` (`catalogingTypeID`, `shortName`) VALUES
(1, 'Batch'),
(2, 'Manual'),
(3, 'MARCit');

-- --------------------------------------------------------

--
-- Table structure for table `Contact`
--

CREATE TABLE `Contact` (
  `contactID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) NOT NULL,
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
(1, 'Support'),
(2, 'Accounting'),
(3, 'General'),
(4, 'Licensing'),
(5, 'Sales'),
(6, 'Training');

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
-- Table structure for table `CostDetails`
--

CREATE TABLE `CostDetails` (
  `costDetailsID` int(11) NOT NULL,
  `shortName` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Currency`
--

CREATE TABLE `Currency` (
  `currencyCode` varchar(3) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Currency`
--

INSERT INTO `Currency` (`currencyCode`, `shortName`) VALUES
('USD', 'United States Dollar'),
('EUR', 'Euro'),
('GBP', 'Great Britain (UK) Pound'),
('CAD', 'Canadian Dollar'),
('ARS', 'Argentine Peso'),
('AUD', 'Australian Dollar'),
('SEK', 'Swedish Krona');

-- --------------------------------------------------------

--
-- Table structure for table `DetailedSubject`
--

CREATE TABLE `DetailedSubject` (
  `detailedSubjectID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Downtime`
--

CREATE TABLE `Downtime` (
  `downtimeID` int(11) NOT NULL,
  `issueID` int(11) DEFAULT NULL,
  `entityID` int(11) NOT NULL,
  `entityTypeID` int(11) NOT NULL DEFAULT '2',
  `creatorID` varchar(80) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `downtimeTypeID` int(11) NOT NULL,
  `note` text,
  `resourceAcquisitionID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DowntimeType`
--

CREATE TABLE `DowntimeType` (
  `downtimeTypeID` int(11) NOT NULL,
  `shortName` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExternalLogin`
--

CREATE TABLE `ExternalLogin` (
  `externalLoginID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
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
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ExternalLoginType`
--

INSERT INTO `ExternalLoginType` (`externalLoginTypeID`, `shortName`) VALUES
(1, 'Admin'),
(2, 'FTP'),
(3, 'Statistics'),
(4, 'Support');

-- --------------------------------------------------------

--
-- Table structure for table `Fund`
--

CREATE TABLE `Fund` (
  `fundID` int(11) NOT NULL,
  `fundCode` varchar(20) DEFAULT NULL,
  `shortName` varchar(200) DEFAULT NULL,
  `archived` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `GeneralDetailSubjectLink`
--

CREATE TABLE `GeneralDetailSubjectLink` (
  `generalDetailSubjectLinkID` int(11) NOT NULL,
  `generalSubjectID` int(11) DEFAULT NULL,
  `detailedSubjectID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `GeneralSubject`
--

CREATE TABLE `GeneralSubject` (
  `generalSubjectID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ImportConfig`
--

CREATE TABLE `ImportConfig` (
  `importConfigID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL,
  `configuration` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ImportHistory`
--

CREATE TABLE `ImportHistory` (
  `importHistoryID` int(11) NOT NULL,
  `importDate` datetime NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `resourcesCount` int(11) NOT NULL,
  `importedResources` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `IsbnOrIssn`
--

CREATE TABLE `IsbnOrIssn` (
  `isbnOrIssnID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `isbnOrIssn` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Issue`
--

CREATE TABLE `Issue` (
  `issueID` int(11) NOT NULL,
  `creatorID` varchar(20) NOT NULL,
  `subjectText` varchar(80) NOT NULL,
  `bodyText` text NOT NULL,
  `reminderInterval` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `resolutionText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IssueContact`
--

CREATE TABLE `IssueContact` (
  `issueContactID` int(11) NOT NULL,
  `issueID` int(11) NOT NULL,
  `contactID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IssueEmail`
--

CREATE TABLE `IssueEmail` (
  `issueEmailID` int(11) NOT NULL,
  `issueID` int(11) NOT NULL,
  `email` varchar(120) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IssueEntityType`
--

CREATE TABLE `IssueEntityType` (
  `entityTypeID` int(11) NOT NULL,
  `entityName` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IssueRelationship`
--

CREATE TABLE `IssueRelationship` (
  `issueRelationshipID` int(11) NOT NULL,
  `issueID` int(11) NOT NULL,
  `entityID` int(11) NOT NULL,
  `entityTypeID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `LicenseStatus`
--

CREATE TABLE `LicenseStatus` (
  `licenseStatusID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `LicenseStatus`
--

INSERT INTO `LicenseStatus` (`licenseStatusID`, `shortName`) VALUES
(1, 'Pending'),
(2, 'Completed'),
(3, 'No License Required');

-- --------------------------------------------------------

--
-- Table structure for table `NoteType`
--

CREATE TABLE `NoteType` (
  `noteTypeID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `NoteType`
--

INSERT INTO `NoteType` (`noteTypeID`, `shortName`) VALUES
(1, 'Product Details'),
(2, 'Acquisition Details'),
(3, 'Access Details'),
(4, 'General'),
(5, 'Licensing Details'),
(6, 'Initial Note');

-- --------------------------------------------------------

--
-- Table structure for table `OrderType`
--

CREATE TABLE `OrderType` (
  `orderTypeID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OrderType`
--

INSERT INTO `OrderType` (`orderTypeID`, `shortName`) VALUES
(1, 'Ongoing'),
(2, 'One Time');

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE `Organization` (
  `organizationID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL,
  `ebscoKbID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Organization`
--

INSERT INTO `Organization` (`organizationID`, `shortName`, `ebscoKbID`) VALUES
(2, 'Institute of Physics', NULL),
(3, 'American Institute of Aeronautics and Astronautics', NULL),
(4, 'American Physical Society', NULL),
(5, 'American Society of Civil Engineers', NULL),
(6, 'American Insitute of Physics', NULL),
(7, 'Society for Industrial and Applied Mathematics', NULL),
(8, 'TNS Media Intelligence', NULL),
(9, 'Chemical Abstracts Service', NULL),
(10, 'Risk Management Association', NULL),
(11, 'American Concrete Institute', NULL),
(12, 'American Association for Cancer Research', NULL),
(13, 'Institution of Engineering and Technology', NULL),
(14, 'American Economic Association', NULL),
(15, 'American Mathematical Society', NULL),
(16, 'American Medical Association', NULL),
(18, 'Consejo Superior de Investigaciones Cientificas', NULL),
(19, 'American Meteorological Society', NULL),
(20, 'American Library Association', NULL),
(21, 'American Society for Testing and Materials', NULL),
(22, 'Association of Research Libraries', NULL),
(23, 'American Society of Limnology and Oceanography', NULL),
(24, 'Tablet Publishing', NULL),
(25, 'American Psychological Association', NULL),
(26, 'American Council of Learned Societies', NULL),
(27, 'American Association for the Advancement of Science', NULL),
(28, 'Thomson Healthcare and Science', NULL),
(29, 'Elsevier', NULL),
(30, 'JSTOR', NULL),
(31, 'SAGE Publications', NULL),
(32, 'American Geophysical Union', NULL),
(33, 'Annual Reviews', NULL),
(34, 'BioOne', NULL),
(35, 'Gale', NULL),
(36, 'Wiley', NULL),
(37, 'Oxford University Press', NULL),
(38, 'Springer', NULL),
(39, 'Taylor and Francis', NULL),
(40, 'Stanford University', NULL),
(41, 'University of California Press', NULL),
(42, 'EBSCO Publishing', NULL),
(43, 'Blackwell Publishing', NULL),
(44, 'Ovid', NULL),
(45, 'Project Muse', NULL),
(46, 'American Fisheries Society', NULL),
(47, 'Neilson Journals Publishing', NULL),
(48, 'GuideStar USA, Inc', NULL),
(49, 'Alexander Street Press, LLC', NULL),
(50, 'Informa Healthcare USA, Inc', NULL),
(51, 'ProQuest LLC', NULL),
(52, 'Accessible Archives Inc', NULL),
(53, 'ACCU Weather Sales and Services, Inc', NULL),
(54, 'Adam Matthew Digital Ltd', NULL),
(55, 'Akademiai Kiado', NULL),
(56, 'World Trade Press', NULL),
(57, 'World Scientific', NULL),
(58, 'Walter de Gruyter', NULL),
(59, 'Cambridge University Press', NULL),
(60, 'GeoScienceWorld', NULL),
(61, 'IEEE', NULL),
(62, 'Yankelovich Inc', NULL),
(63, 'Nature Publishing Group', NULL),
(64, 'Verlag der Zeitschrift fur Naturforschung ', NULL),
(65, 'White Horse Press', NULL),
(66, 'Verlag C.H. Beck', NULL),
(67, 'Vault, Inc', NULL),
(68, 'Value Line, Inc', NULL),
(69, 'Vanderbilt University', NULL),
(70, 'Uniworld Business Publications, Inc', NULL),
(71, 'Universum USA', NULL),
(72, 'University of Wisconsin Press', NULL),
(73, 'University of Virginia Press', NULL),
(74, 'University of Toronto Press Inc', NULL),
(75, 'University of Toronto', NULL),
(76, 'University of Pittsburgh', NULL),
(77, 'University of Illinois Press', NULL),
(78, 'University of Chicago Press', NULL),
(79, 'University of Barcelona', NULL),
(80, 'UCLA Chicano Studies Research Center Press', NULL),
(81, 'Transportation Research Board', NULL),
(82, 'Trans Tech Publications', NULL),
(83, 'Thomas Telford Ltd', NULL),
(84, 'Thesaurus Linguae Graecae', NULL),
(85, 'Tetrad Computer Applications Inc', NULL),
(86, 'Swank Motion Pictures, Inc', NULL),
(87, 'Standard and Poors', NULL),
(88, 'SPIE', NULL),
(89, 'European Society of Endocrinology', NULL),
(90, 'Society of Environmental Toxicology and Chemistry', NULL),
(91, 'Society of Antiquaries of Scotland', NULL),
(92, 'Society for Reproduction and Fertility', NULL),
(93, 'Society for Neuroscience', NULL),
(94, 'Society for Leukocyte Biology', NULL),
(95, 'Society for General Microbiology', NULL),
(96, 'Society for Experimental Biology and Medicine', NULL),
(97, 'Society for Endocrinology', NULL),
(98, 'Societe Mathematique de France', NULL),
(99, 'Social Explorer', NULL),
(404, 'SETAC', NULL),
(101, 'Swiss Chemical Society', NULL),
(102, 'Scholarly Digital Editions', NULL),
(103, 'Royal Society of London', NULL),
(104, 'Royal Society of Chemistry', NULL),
(105, 'Roper Center for Public Opinion Research', NULL),
(106, 'Rockefeller University Press', NULL),
(107, 'Rivista di Studi italiani', NULL),
(108, 'Reuters Loan Pricing Corporation', NULL),
(109, 'Religious and Theological Abstracts, Inc', NULL),
(110, 'Psychoanalytic Electronic Publishing Inc', NULL),
(111, 'Cornell University Library', NULL),
(112, 'Preservation Technologies LP', NULL),
(113, 'Portland Press Limited', NULL),
(114, 'ITHAKA', NULL),
(115, 'Philosophy Documentation Center', NULL),
(116, 'Peeters Publishers', NULL),
(117, 'Paratext', NULL),
(118, 'Mathematical Sciences Publishers', NULL),
(119, 'Oxford Centre of Hebrew and Jewish Studies', NULL),
(120, 'NewsBank, Inc', NULL),
(121, 'Massachusetts Medical Society', NULL),
(122, 'Naxos of America, Inc.', NULL),
(123, 'National Research Council of Canada', NULL),
(124, 'National Gallery Company Ltd', NULL),
(125, 'National Academy of Sciences', NULL),
(126, 'Mintel International Group Limited', NULL),
(127, 'Metropolitan Opera', NULL),
(128, 'M.E. Sharpe, Inc', NULL),
(129, 'Mergent, Inc', NULL),
(130, 'Mediamark Research and Intelligence, LLC', NULL),
(131, 'Mary Ann Liebert, Inc', NULL),
(132, 'MIT Press', NULL),
(133, 'MarketResearch.com, Inc', NULL),
(134, 'Marine Biological Laboratory', NULL),
(135, 'W.S. Maney and Son Ltd', NULL),
(136, 'Manchester University Press', NULL),
(137, 'Lord Music Reference Inc', NULL),
(138, 'Liverpool University Press', NULL),
(139, 'Seminario Matematico of the University of Padua', NULL),
(140, 'Library of Congress, Cataloging Distribution Service', NULL),
(141, 'LexisNexis', NULL),
(142, 'Corporacion Latinobarometro', NULL),
(143, 'Landes Bioscience', NULL),
(144, 'Keesings Worldwide, LLC', NULL),
(145, 'Karger', NULL),
(146, 'John Benjamins Publishing Company', NULL),
(147, 'Irish Newspaper Archives Ltd', NULL),
(148, 'IPA Source, LLC', NULL),
(149, 'International Press', NULL),
(150, 'Intelligence Research Limited', NULL),
(151, 'Intellect', NULL),
(152, 'InteLex', NULL),
(153, 'Institute of Mathematics of the Polish Academy of Sciences', NULL),
(154, 'Ingentaconnect', NULL),
(155, 'INFORMS', NULL),
(156, 'Information Resources, Inc', NULL),
(157, 'Indiana University Mathematics Journal', NULL),
(158, 'Incisive Media Ltd', NULL),
(159, 'IGI Global ', NULL),
(160, 'IBISWorld USA', NULL),
(161, 'H.W. Wilson Company', NULL),
(162, 'University of Houston Department of Mathematics', NULL),
(163, 'Histochemical Society', NULL),
(164, 'Morningstar Inc.', NULL),
(165, 'Paradigm Publishers', NULL),
(166, 'HighWire Press', NULL),
(167, 'Heldref Publications', NULL),
(168, 'Haworth Press', NULL),
(417, 'Thomson Legal', NULL),
(170, 'IOS Press', NULL),
(171, 'Agricultural Institute of Canada', NULL),
(172, 'Allen Press', NULL),
(173, 'H1 Base, Inc', NULL),
(175, 'Global Science Press', NULL),
(176, 'Geographic Research, Inc', NULL),
(177, 'Genetics Society of America', NULL),
(178, 'Franz Steiner Verlag', NULL),
(179, 'Forrester Research, Inc', NULL),
(180, 'Federation of American Societies for Experimental Biology', NULL),
(181, 'Faulkner Information Services', NULL),
(182, 'ExLibris', NULL),
(183, 'Brill', NULL),
(184, 'Evolutionary Ecology Ltd', NULL),
(185, 'European Mathematical Society Publishing House', NULL),
(186, 'New York Review of Books', NULL),
(187, 'Dunstans Publishing Ltd', NULL),
(188, 'Equinox Publishing Ltd', NULL),
(189, 'Entomological Society of Canada', NULL),
(190, 'American Association of Immunologists, Inc.', NULL),
(191, 'Endocrine Society', NULL),
(192, 'EDP Sciences', NULL),
(193, 'Edinburgh University Press', NULL),
(194, 'Ecological Society of America', NULL),
(195, 'East View Information Services', NULL),
(196, 'Dun and Bradstreet Inc', NULL),
(197, 'Duke University Press', NULL),
(198, 'Digital Distributed Community Archive', NULL),
(199, 'Albert C. Muller', NULL),
(200, 'Dialogue Foundation', NULL),
(201, 'Dialog', NULL),
(202, 'Current History, Inc', NULL),
(203, 'CSIRO Publishing', NULL),
(204, 'CQ Press', NULL),
(205, 'Japan Focus', NULL),
(206, 'Carbon Disclosure Project', NULL),
(207, 'University of Buckingham Press', NULL),
(208, 'Boopsie, INC.', NULL),
(209, 'Company of Biologists Ltd', NULL),
(210, 'Chronicle of Higher Education', NULL),
(211, 'CCH Incorporated', NULL),
(212, 'CareerShift LLC', NULL),
(213, 'Canadian Mathematical Society', NULL),
(214, 'Cambridge Crystallographic Data Centre', NULL),
(215, 'CABI Publishing', NULL),
(216, 'Business Monitor International', NULL),
(217, 'Bureau of National Affairs, Inc', NULL),
(218, 'Bulletin of the Atomic Scientists', NULL),
(219, 'Brepols Publishers', NULL),
(221, 'Botanical Society of America', NULL),
(222, 'BMJ Publishing Group Limited', NULL),
(223, 'BioMed Central', NULL),
(224, 'Berkeley Electronic Press', NULL),
(225, 'Berghahn Books', NULL),
(226, 'Berg Publishers', NULL),
(227, 'Belser Wissenschaftlicher Dienst Ltd', NULL),
(228, 'Beilstein Information Systems, Inc', NULL),
(229, 'Barkhuis Publishing', NULL),
(230, 'Augustine Institute', NULL),
(231, 'Asempa Limited', NULL),
(232, 'ARTstor Inc', NULL),
(233, 'Applied Probability Trust', NULL),
(234, 'Antiquity Publications Limited', NULL),
(235, 'Ammons Scientific Limited', NULL),
(236, 'American Statistical Association', NULL),
(237, 'American Society of Tropical Medicine and Hygiene', NULL),
(238, 'American Society of Plant Biologists', NULL),
(239, 'Teachers College Record', NULL),
(240, 'American Society of Agronomy', NULL),
(241, 'American Society for Nutrition', NULL),
(242, 'American Society for Horticultural Science', NULL),
(243, 'American Society for Clinical Investigation', NULL),
(244, 'American Society for Cell Biology', NULL),
(245, 'American Psychiatric Publishing', NULL),
(246, 'American Phytopathological Society', NULL),
(247, 'American Physiological Society', NULL),
(248, 'Encyclopaedia Britannica Online', NULL),
(249, 'Agricultural History Society', NULL),
(250, 'Begell House, Inc', NULL),
(251, 'Hans Zell Publishing', NULL),
(252, 'Alliance for Children and Families', NULL),
(253, 'Robert Blakemore', NULL),
(254, 'IVES Group, Inc', NULL),
(255, 'Massachusetts Institute of Technology', NULL),
(256, 'Marquis Who\'s Who LLC', NULL),
(257, 'Atypon Systems Inc', NULL),
(258, 'Worldwatch Institute', NULL),
(259, 'Thomson Financial', NULL),
(260, 'Digital Heritage Publishing Limited', NULL),
(261, 'U.S. Department of Commerce', NULL),
(262, 'Lipper Inc', NULL),
(263, 'Chiniquy Collection', NULL),
(264, 'OCLC', NULL),
(265, 'Consumer Electronics Association', NULL),
(267, 'Institutional Shareholder Services Inc', NULL),
(268, 'KLD Research and Analytics Inc', NULL),
(269, 'BIGresearch LLC', NULL),
(270, 'Cambridge Scientific Abstracts', NULL),
(271, 'American Institute of Certified Public Accountants', NULL),
(272, 'Terra Scientific Publishing Company', NULL),
(273, 'American Counseling Association', NULL),
(274, 'Army Times Publishing Company', NULL),
(275, 'Librairie Droz', NULL),
(276, 'American Academy of Religion', NULL),
(277, 'Boyd Printing', NULL),
(278, 'Canadian Association of African Studies', NULL),
(279, 'Experian Marketing Solutions, Inc.', NULL),
(280, 'Centro de Investigaciones Sociologicas', NULL),
(281, 'Chorus America', NULL),
(282, 'College Art Association', NULL),
(283, 'Human Kinetics Inc.', NULL),
(288, 'NERL', NULL),
(293, 'Colegio de Mexico', NULL),
(294, 'University of Iowa', NULL),
(295, 'Academy of the Hebrew Language', NULL),
(296, 'FamilyLink.com, Inc.', NULL),
(297, 'SISMEL - Edizioni del Galluzzo', NULL),
(301, 'Informaworld', NULL),
(302, 'ScienceDirect', NULL),
(304, 'China Data Center', NULL),
(305, 'Association for Computing Machinery', NULL),
(306, 'American Chemical Society', NULL),
(307, 'Design Research Publications', NULL),
(308, 'ABC-CLIO', NULL),
(311, 'American Association on Intellectual and Developmental Disabilities ', NULL),
(310, 'American Antiquarian Society', NULL),
(312, 'American Society for Microbiology', NULL),
(314, 'American Society of Mechanical Engineers', NULL),
(315, 'Now Publishers, Inc.', NULL),
(316, 'Cabell Publishing Company, Inc.', NULL),
(317, 'Center for Research Libraries', NULL),
(444, 'Cold North Wind Inc', NULL),
(321, 'Erudit ', NULL),
(322, 'American Institute of Mathematical Sciences', NULL),
(324, 'American Sociological Association', NULL),
(325, 'Archaeological Institute of America', NULL),
(326, 'Bertrand Russell Research Centre', NULL),
(328, 'Cork University Press', NULL),
(329, 'College Publishing', NULL),
(330, 'Council for Learning Disabilities', NULL),
(331, 'International Society on Hypertension in Blacks (ISHIB)', NULL),
(332, 'Firenze University Press', NULL),
(333, 'History of Earth Sciences Society', NULL),
(334, 'History Today Ltd.', NULL),
(335, 'Journal of Music', NULL),
(336, 'University of Nebraska at Omaha', NULL),
(337, 'Journal of Indo-European Studies', NULL),
(338, 'Library Binding Institute', NULL),
(339, 'McFarland & Co. Inc.', NULL),
(340, 'Lyrasis', NULL),
(341, 'Amigos Library Services', NULL),
(343, 'Fabrizio Serra Editore', NULL),
(344, 'Aux Amateurs', NULL),
(346, 'National Affairs, Inc', NULL),
(357, 'Society of Chemical Industry', NULL),
(347, 'New Criterion', NULL),
(348, 'Casa Editrice Leo S. Olschki s.r.l.', NULL),
(349, 'Rhodes University, Department of Philosophy', NULL),
(350, 'Rocky Mountain Mathematics Consortium', NULL),
(352, 'Royal Irish Academy', NULL),
(353, 'Chadwyck-Healey', NULL),
(354, 'CSA illumina', NULL),
(355, 'New School for Social Research', NULL),
(356, 'Society of Biblical Literature', NULL),
(358, 'Stazione Zoologica Anton Dohrn', NULL),
(359, 'BioScientifica Ltd.', NULL),
(360, 'CASALINI LIBRI', NULL),
(361, 'Institute of Organic Chemistry', NULL),
(362, 'Columbia International Affairs Online ', NULL),
(363, 'Corporation for National Research Initiatives ', NULL),
(364, 'Tilgher-Genova', NULL),
(365, 'Emerald Group Publishing Limited', NULL),
(366, 'Geological Society of America', NULL),
(367, 'Institute of Mathematical Statistics', NULL),
(368, 'Institute of Pure and Applied Physics', NULL),
(369, 'JSTAGE', NULL),
(370, 'Metapress', NULL),
(371, 'Modern Language Association', NULL),
(372, 'Optical Society of America', NULL),
(373, 'University of British Columbia', NULL),
(374, 'University of New Mexico', NULL),
(375, 'Vandenhoeck & Ruprecht', NULL),
(376, 'Verlag Mohr Siebeck GmbH & Co. KG', NULL),
(377, 'Palgrave Macmillan', NULL),
(378, 'Vittorio Klostermann', NULL),
(379, 'Project Euclid', NULL),
(380, 'Psychonomic Society ', NULL),
(411, 'Cengage Learning', NULL),
(382, 'Infotrieve', NULL),
(383, 'Society of Automotive Engineers', NULL),
(384, 'Turpion Publications', NULL),
(426, 'Midwest Collaborative for Library Services', NULL),
(386, 'Lawrence Erlbaum Associates', NULL),
(387, 'Alphagraphics', NULL),
(388, 'Bellerophon Publications, Inc.', NULL),
(389, 'Boydell & Brewer Inc.', NULL),
(390, 'Carcanet Press', NULL),
(391, 'Feminist Studies', NULL),
(393, 'Dustbooks', NULL),
(394, 'Society for Applied Anthropology ', NULL),
(395, 'United Nations Publications', NULL),
(396, 'Wharton Research Data Services', NULL),
(398, 'Human Development', NULL),
(399, 'infoUSA Marketing, Inc.', NULL),
(400, 'Bowker', NULL),
(402, 'Brown University', NULL),
(401, 'Women Writers Project', NULL),
(445, 'Coutts', NULL),
(446, 'Numara Software, Inc.', NULL),
(447, 'Trinity College Library Dublin', NULL),
(405, 'Oldenbourg Wissenschaftsverlag ', NULL),
(406, 'Dow Jones', NULL),
(412, 'Financial Information Inc. (FII)', NULL),
(408, 'Jackson Publishing and Distribution', NULL),
(409, 'Elsevier Engineering Information, Inc. ', NULL),
(410, 'Eneclann Ltd.', NULL),
(413, 'UCLA Latin American Institute', NULL),
(414, 'Harmonie Park Press ', NULL),
(415, 'Harrassowitz', NULL),
(416, 'Thomson Reuters', NULL),
(418, 'Human Relations Area Files, Inc. ', NULL),
(432, 'Capital IQ', NULL),
(419, 'Society for Ethnomusicology', NULL),
(420, 'MSCI RiskMetrics', NULL),
(421, 'Rapid Multimedia', NULL),
(422, 'MSCI Inc', NULL),
(423, 'New England Journal of Medicine', NULL),
(424, 'NetLibrary', NULL),
(425, 'CARMA', NULL),
(427, 'Public Library of Science', NULL),
(428, 'Social Science Electronic Publishing', NULL),
(429, 'United Nations Industrial Develoipment Organization', NULL),
(430, 'University of Michigan Press', NULL),
(431, 'ORS Publishing, Inc.', NULL),
(433, 'McGraw-Hill', NULL),
(434, 'Biblical Archaeology Society', NULL),
(435, 'GeoLytics, Inc.', NULL),
(436, 'JoVE ', NULL),
(437, 'ICEsoft Technologies, Inc.', NULL),
(438, 'Films Media Group', NULL),
(439, 'Films on Demand', NULL),
(440, 'Connect Journals', NULL),
(441, 'Scuola Normale Superiore', NULL),
(442, 'Wolters Kluwer', NULL),
(448, 'Pier Professional', NULL),
(449, 'ABC News', NULL),
(450, 'University of Aberdeen ', NULL),
(451, 'BullFrog Films, Inc.', NULL),
(453, 'FirstSearch', NULL),
(455, 'History Cooperative ', NULL),
(456, 'Omohundro Institute of Early American History and Culture', NULL),
(457, 'Arms Control Association', NULL),
(458, 'Heritage Archives', NULL),
(459, 'International Historic Films, Inc.', NULL),
(460, 'Euromonitor International ', NULL),
(461, 'Safari Books Online', NULL),
(462, 'Mirabile', NULL),
(466, 'Publishing Technology', NULL),
(463, 'SageWorks, Inc', NULL),
(464, 'Johns Hopkins Universtiy Press', NULL),
(465, 'Knovel ', NULL),
(467, 'American Society of Nephrology', NULL),
(468, 'Water Envrionment Federation ', NULL),
(469, 'Refworks', NULL),
(470, 'Cinemagician Productions', NULL),
(471, 'Algorithmics', NULL),
(472, 'YBP Library Services ', NULL),
(474, 'Maydream Inc.', NULL),
(475, 'Organization for Economic Cooperation and Development', NULL),
(476, 'The Chronicle for Higher Education', NULL),
(477, 'Association for Research in Vision and Ophthalmologie (ARVO)', NULL),
(478, 'SRDS Media Solutions', NULL),
(479, 'Kantar Media', NULL),
(480, 'Peace & Justice Studies Association', NULL),
(481, 'Addison Publications Ltd.', NULL),
(482, 'Mutii-Science Publishing', NULL),
(483, 'ASM International', NULL),
(484, 'Verlag der Osterreichischen Akademie der Wissenschaften', NULL),
(485, 'Anthology of Recorded Music', NULL),
(486, 'Left Coast Press, Inc', NULL),
(487, 'Video Data Bank', NULL),
(488, 'Atlassian', NULL),
(489, 'medici.tv', NULL),
(490, 'Bar Ilan Research & Development Company Ltd', NULL),
(491, 'Primary Source Media', NULL),
(492, 'Ebrary', NULL),
(493, 'University of Michigan, Department of Mathematics', NULL),
(494, 'StataCorp LP ', NULL),
(495, 'L\' Enseignement Mathematique  ', NULL),
(496, 'Audio Engineering Society, Inc', NULL),
(497, 'LOCKSS', NULL),
(498, 'MUSEEC ', NULL),
(499, 'Mortgage Bankers Association', NULL),
(500, 'BibleWorks', NULL),
(501, 'National Library of Ireland', NULL),
(502, 'Scholars Press', NULL),
(503, 'Index to Jewish periodicals', NULL),
(504, 'Cold Spring Harbor Laboratory Press', NULL);

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
-- Table structure for table `OrgNameMapping`
--

CREATE TABLE `OrgNameMapping` (
  `orgNameMappingID` int(11) NOT NULL,
  `importConfigID` int(11) NOT NULL,
  `orgNameImported` varchar(200) DEFAULT NULL,
  `orgNameMapped` varchar(200) DEFAULT NULL
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
-- Table structure for table `PurchaseSite`
--

CREATE TABLE `PurchaseSite` (
  `purchaseSiteID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PurchaseSite`
--

INSERT INTO `PurchaseSite` (`purchaseSiteID`, `shortName`) VALUES
(1, 'Main Library');

-- --------------------------------------------------------

--
-- Table structure for table `RelationshipType`
--

CREATE TABLE `RelationshipType` (
  `relationshipTypeID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `RelationshipType`
--

INSERT INTO `RelationshipType` (`relationshipTypeID`, `shortName`) VALUES
(1, 'Parent'),
(2, 'General');

-- --------------------------------------------------------

--
-- Table structure for table `Resource`
--

CREATE TABLE `Resource` (
  `resourceID` int(11) NOT NULL,
  `createDate` date DEFAULT NULL,
  `createLoginID` varchar(45) DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `updateLoginID` varchar(45) DEFAULT NULL,
  `archiveDate` date DEFAULT NULL,
  `archiveLoginID` varchar(45) DEFAULT NULL,
  `titleText` varchar(200) DEFAULT NULL,
  `descriptionText` text,
  `statusID` int(11) DEFAULT NULL,
  `resourceTypeID` int(11) DEFAULT NULL,
  `resourceFormatID` int(11) DEFAULT NULL,
  `currentStartDate` date DEFAULT NULL,
  `currentEndDate` date DEFAULT NULL,
  `resourceURL` varchar(2000) DEFAULT NULL,
  `registeredIPAddresses` varchar(200) DEFAULT NULL,
  `providerText` varchar(200) DEFAULT NULL,
  `resourceAltURL` varchar(2000) DEFAULT NULL,
  `ebscoKbID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceAcquisition`
--

CREATE TABLE `ResourceAcquisition` (
  `resourceAcquisitionID` int(11) NOT NULL,
  `resourceID` int(11) NOT NULL,
  `parentResourceID` int(11) DEFAULT NULL,
  `orderNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `systemNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acquisitionTypeID` int(11) DEFAULT NULL,
  `subscriptionStartDate` date DEFAULT NULL,
  `subscriptionEndDate` date DEFAULT NULL,
  `subscriptionAlertEnabledInd` int(11) DEFAULT NULL,
  `organizationID` int(11) DEFAULT NULL,
  `licenseID` int(11) DEFAULT NULL,
  `authenticationTypeID` int(10) DEFAULT NULL,
  `authenticationUserName` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `authenticationPassword` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accessMethodID` int(10) DEFAULT NULL,
  `storageLocationID` int(11) DEFAULT NULL,
  `userLimitID` int(11) DEFAULT NULL,
  `coverageText` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bibSourceURL` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `catalogingTypeID` int(11) DEFAULT NULL,
  `catalogingStatusID` int(11) DEFAULT NULL,
  `numberRecordsAvailable` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numberRecordsLoaded` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recordSetIdentifier` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hasOclcHoldings` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `workflowRestartDate` date DEFAULT NULL,
  `workflowRestartLoginID` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `libraryNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceAdministeringSiteLink`
--

CREATE TABLE `ResourceAdministeringSiteLink` (
  `resourceAdministeringSiteLinkID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `administeringSiteID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceAlert`
--

CREATE TABLE `ResourceAlert` (
  `resourceAlertID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `loginID` varchar(45) DEFAULT NULL,
  `sendDate` date DEFAULT NULL,
  `alertText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceAuthorizedSiteLink`
--

CREATE TABLE `ResourceAuthorizedSiteLink` (
  `resourceAuthorizedSiteLinkID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `authorizedSiteID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceFormat`
--

CREATE TABLE `ResourceFormat` (
  `resourceFormatID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ResourceFormat`
--

INSERT INTO `ResourceFormat` (`resourceFormatID`, `shortName`) VALUES
(1, 'Print + Electronic'),
(2, 'Electronic'),
(3, 'Any');

-- --------------------------------------------------------

--
-- Table structure for table `ResourceLicenseLink`
--

CREATE TABLE `ResourceLicenseLink` (
  `resourceLicenseLinkID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `licenseID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceLicenseStatus`
--

CREATE TABLE `ResourceLicenseStatus` (
  `resourceLicenseStatusID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `licenseStatusID` int(11) DEFAULT NULL,
  `licenseStatusChangeDate` datetime DEFAULT NULL,
  `licenseStatusChangeLoginID` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceNote`
--

CREATE TABLE `ResourceNote` (
  `resourceNoteID` int(11) NOT NULL,
  `entityID` int(11) DEFAULT NULL,
  `noteTypeID` int(11) DEFAULT NULL,
  `tabName` varchar(45) DEFAULT NULL,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateLoginID` varchar(45) DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceOrganizationLink`
--

CREATE TABLE `ResourceOrganizationLink` (
  `resourceOrganizationLinkID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `organizationID` int(11) DEFAULT NULL,
  `organizationRoleID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourcePayment`
--

CREATE TABLE `ResourcePayment` (
  `resourcePaymentID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) UNSIGNED NOT NULL,
  `fundID` int(10) DEFAULT NULL,
  `selectorLoginID` varchar(45) DEFAULT NULL,
  `priceTaxExcluded` int(10) UNSIGNED DEFAULT NULL,
  `taxRate` int(10) UNSIGNED DEFAULT NULL,
  `priceTaxIncluded` int(10) UNSIGNED DEFAULT NULL,
  `paymentAmount` int(10) UNSIGNED DEFAULT NULL,
  `orderTypeID` int(10) UNSIGNED DEFAULT NULL,
  `currencyCode` varchar(3) NOT NULL,
  `year` varchar(20) DEFAULT NULL,
  `subscriptionStartDate` date DEFAULT NULL,
  `subscriptionEndDate` date DEFAULT NULL,
  `costDetailsID` int(11) DEFAULT NULL,
  `costNote` text,
  `invoiceNum` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourcePurchaseSiteLink`
--

CREATE TABLE `ResourcePurchaseSiteLink` (
  `resourcePurchaseSiteLinkID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `purchaseSiteID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceRelationship`
--

CREATE TABLE `ResourceRelationship` (
  `resourceRelationshipID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `relatedResourceID` int(11) DEFAULT NULL,
  `relationshipTypeID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceStep`
--

CREATE TABLE `ResourceStep` (
  `resourceStepID` int(11) NOT NULL,
  `resourceAcquisitionID` int(11) DEFAULT NULL,
  `stepID` int(11) DEFAULT NULL,
  `stepStartDate` date DEFAULT NULL,
  `stepEndDate` date DEFAULT NULL,
  `archivingDate` datetime DEFAULT NULL,
  `endLoginID` varchar(200) DEFAULT NULL,
  `priorStepID` int(11) DEFAULT NULL,
  `stepName` varchar(200) DEFAULT NULL,
  `userGroupID` int(11) DEFAULT NULL,
  `displayOrderSequence` int(10) UNSIGNED DEFAULT NULL,
  `mailReminderDelay` int(10) UNSIGNED DEFAULT NULL,
  `note` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceSubject`
--

CREATE TABLE `ResourceSubject` (
  `resourceSubjectID` int(11) NOT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `generalDetailSubjectLinkID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ResourceType`
--

CREATE TABLE `ResourceType` (
  `resourceTypeID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL,
  `includeStats` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ResourceType`
--

INSERT INTO `ResourceType` (`resourceTypeID`, `shortName`, `includeStats`) VALUES
(1, 'Any', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Status`
--

CREATE TABLE `Status` (
  `statusID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Status`
--

INSERT INTO `Status` (`statusID`, `shortName`) VALUES
(1, 'In Progress'),
(2, 'Completed'),
(3, 'Saved'),
(4, 'Archived');

-- --------------------------------------------------------

--
-- Table structure for table `Step`
--

CREATE TABLE `Step` (
  `stepID` int(11) NOT NULL,
  `priorStepID` int(11) DEFAULT NULL,
  `stepName` varchar(200) DEFAULT NULL,
  `userGroupID` int(11) DEFAULT NULL,
  `workflowID` int(11) DEFAULT NULL,
  `displayOrderSequence` int(10) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Step`
--

INSERT INTO `Step` (`stepID`, `priorStepID`, `stepName`, `userGroupID`, `workflowID`, `displayOrderSequence`) VALUES
(1, NULL, 'Funding Approval', 3, 1, 1),
(2, NULL, 'Licensing', 2, 1, 2),
(3, 2, 'Order Processing', 4, 1, 3),
(4, 3, 'Activation', 1, 1, 4),
(5, NULL, 'Licensing', 2, 2, 1),
(6, NULL, 'Activation', 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `StorageLocation`
--

CREATE TABLE `StorageLocation` (
  `storageLocationID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `StorageLocation`
--

INSERT INTO `StorageLocation` (`storageLocationID`, `shortName`) VALUES
(1, 'Reserve Book Room');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `loginID` varchar(50) NOT NULL DEFAULT '',
  `lastName` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `privilegeID` int(10) UNSIGNED DEFAULT NULL,
  `accountTabIndicator` int(1) UNSIGNED DEFAULT '0',
  `emailAddress` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`loginID`, `lastName`, `firstName`, `privilegeID`, `accountTabIndicator`, `emailAddress`) VALUES
('coral_admin', NULL, NULL, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `UserGroup`
--

CREATE TABLE `UserGroup` (
  `userGroupID` int(11) NOT NULL,
  `groupName` varchar(200) DEFAULT NULL,
  `emailAddress` varchar(200) DEFAULT NULL,
  `emailText` varchar(2000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UserGroup`
--

INSERT INTO `UserGroup` (`userGroupID`, `groupName`, `emailAddress`, `emailText`) VALUES
(1, 'Access', NULL, NULL),
(2, 'Licensing', NULL, NULL),
(3, 'Funding Approval', NULL, NULL),
(4, 'Acquisitions', NULL, NULL),
(5, 'Receipt', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `UserGroupLink`
--

CREATE TABLE `UserGroupLink` (
  `userGroupLinkID` int(11) NOT NULL,
  `loginID` varchar(200) DEFAULT NULL,
  `userGroupID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `UserLimit`
--

CREATE TABLE `UserLimit` (
  `userLimitID` int(11) NOT NULL,
  `shortName` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `UserLimit`
--

INSERT INTO `UserLimit` (`userLimitID`, `shortName`) VALUES
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4'),
(5, '5'),
(6, '6'),
(7, '7'),
(8, '8'),
(9, '9'),
(10, '10+');

-- --------------------------------------------------------

--
-- Table structure for table `Workflow`
--

CREATE TABLE `Workflow` (
  `workflowID` int(11) NOT NULL,
  `workflowName` varchar(200) DEFAULT NULL,
  `resourceFormatIDValue` varchar(45) DEFAULT NULL,
  `resourceTypeIDValue` varchar(45) DEFAULT NULL,
  `acquisitionTypeIDValue` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Workflow`
--

INSERT INTO `Workflow` (`workflowID`, `workflowName`, `resourceFormatIDValue`, `resourceTypeIDValue`, `acquisitionTypeIDValue`) VALUES
(1, NULL, '2', '', '1'),
(2, NULL, '2', '', '2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AccessMethod`
--
ALTER TABLE `AccessMethod`
  ADD PRIMARY KEY (`accessMethodID`);

--
-- Indexes for table `AcquisitionType`
--
ALTER TABLE `AcquisitionType`
  ADD PRIMARY KEY (`acquisitionTypeID`),
  ADD UNIQUE KEY `acquisitionTypeID` (`acquisitionTypeID`);

--
-- Indexes for table `AdministeringSite`
--
ALTER TABLE `AdministeringSite`
  ADD PRIMARY KEY (`administeringSiteID`);

--
-- Indexes for table `AlertDaysInAdvance`
--
ALTER TABLE `AlertDaysInAdvance`
  ADD PRIMARY KEY (`alertDaysInAdvanceID`);

--
-- Indexes for table `AlertEmailAddress`
--
ALTER TABLE `AlertEmailAddress`
  ADD PRIMARY KEY (`alertEmailAddressID`);

--
-- Indexes for table `Alias`
--
ALTER TABLE `Alias`
  ADD PRIMARY KEY (`aliasID`),
  ADD KEY `Index_resourceID` (`resourceID`),
  ADD KEY `Index_aliasTypeID` (`aliasTypeID`),
  ADD KEY `shortName` (`shortName`),
  ADD KEY `Index_All` (`resourceID`,`aliasTypeID`);

--
-- Indexes for table `AliasType`
--
ALTER TABLE `AliasType`
  ADD PRIMARY KEY (`aliasTypeID`),
  ADD UNIQUE KEY `aliasTypeID` (`aliasTypeID`);

--
-- Indexes for table `Attachment`
--
ALTER TABLE `Attachment`
  ADD PRIMARY KEY (`attachmentID`);

--
-- Indexes for table `AttachmentType`
--
ALTER TABLE `AttachmentType`
  ADD PRIMARY KEY (`attachmentTypeID`);

--
-- Indexes for table `AuthenticationType`
--
ALTER TABLE `AuthenticationType`
  ADD PRIMARY KEY (`authenticationTypeID`) USING BTREE;

--
-- Indexes for table `AuthorizedSite`
--
ALTER TABLE `AuthorizedSite`
  ADD PRIMARY KEY (`authorizedSiteID`);

--
-- Indexes for table `CatalogingStatus`
--
ALTER TABLE `CatalogingStatus`
  ADD PRIMARY KEY (`catalogingStatusID`);

--
-- Indexes for table `CatalogingType`
--
ALTER TABLE `CatalogingType`
  ADD PRIMARY KEY (`catalogingTypeID`);

--
-- Indexes for table `Contact`
--
ALTER TABLE `Contact`
  ADD PRIMARY KEY (`contactID`),
  ADD UNIQUE KEY `contactID` (`contactID`);

--
-- Indexes for table `ContactRole`
--
ALTER TABLE `ContactRole`
  ADD PRIMARY KEY (`contactRoleID`);

--
-- Indexes for table `ContactRoleProfile`
--
ALTER TABLE `ContactRoleProfile`
  ADD PRIMARY KEY (`contactID`,`contactRoleID`);

--
-- Indexes for table `CostDetails`
--
ALTER TABLE `CostDetails`
  ADD PRIMARY KEY (`costDetailsID`),
  ADD KEY `costDetailsID` (`costDetailsID`),
  ADD KEY `Index_shortName` (`shortName`),
  ADD KEY `Index_All` (`costDetailsID`,`shortName`);

--
-- Indexes for table `Currency`
--
ALTER TABLE `Currency`
  ADD PRIMARY KEY (`currencyCode`),
  ADD UNIQUE KEY `currencyCode` (`currencyCode`);

--
-- Indexes for table `DetailedSubject`
--
ALTER TABLE `DetailedSubject`
  ADD PRIMARY KEY (`detailedSubjectID`),
  ADD KEY `detailedSubjectID` (`detailedSubjectID`);

--
-- Indexes for table `Downtime`
--
ALTER TABLE `Downtime`
  ADD PRIMARY KEY (`downtimeID`),
  ADD KEY `IssueID` (`issueID`);

--
-- Indexes for table `DowntimeType`
--
ALTER TABLE `DowntimeType`
  ADD PRIMARY KEY (`downtimeTypeID`);

--
-- Indexes for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  ADD PRIMARY KEY (`externalLoginID`),
  ADD UNIQUE KEY `externalLoginID` (`externalLoginID`);

--
-- Indexes for table `ExternalLoginType`
--
ALTER TABLE `ExternalLoginType`
  ADD PRIMARY KEY (`externalLoginTypeID`),
  ADD UNIQUE KEY `externalLoginTypeID` (`externalLoginTypeID`);

--
-- Indexes for table `Fund`
--
ALTER TABLE `Fund`
  ADD PRIMARY KEY (`fundID`),
  ADD UNIQUE KEY `fundCode` (`fundCode`);

--
-- Indexes for table `GeneralDetailSubjectLink`
--
ALTER TABLE `GeneralDetailSubjectLink`
  ADD PRIMARY KEY (`generalDetailSubjectLinkID`),
  ADD KEY `generalDetailSubjectLinkID` (`generalDetailSubjectLinkID`),
  ADD KEY `Index_All` (`generalSubjectID`,`detailedSubjectID`),
  ADD KEY `Index_generalSubject` (`generalSubjectID`),
  ADD KEY `Index_detailedSubject` (`detailedSubjectID`);

--
-- Indexes for table `GeneralSubject`
--
ALTER TABLE `GeneralSubject`
  ADD PRIMARY KEY (`generalSubjectID`),
  ADD KEY `generalSubjectID` (`generalSubjectID`);

--
-- Indexes for table `ImportConfig`
--
ALTER TABLE `ImportConfig`
  ADD PRIMARY KEY (`importConfigID`);

--
-- Indexes for table `ImportHistory`
--
ALTER TABLE `ImportHistory`
  ADD PRIMARY KEY (`importHistoryID`);

--
-- Indexes for table `IsbnOrIssn`
--
ALTER TABLE `IsbnOrIssn`
  ADD PRIMARY KEY (`isbnOrIssnID`),
  ADD KEY `resourceID` (`resourceID`),
  ADD KEY `isbnOrIssn` (`isbnOrIssn`);

--
-- Indexes for table `Issue`
--
ALTER TABLE `Issue`
  ADD PRIMARY KEY (`issueID`),
  ADD KEY `creatorID` (`creatorID`);

--
-- Indexes for table `IssueContact`
--
ALTER TABLE `IssueContact`
  ADD PRIMARY KEY (`issueContactID`);

--
-- Indexes for table `IssueEmail`
--
ALTER TABLE `IssueEmail`
  ADD PRIMARY KEY (`issueEmailID`),
  ADD KEY `IssueID` (`issueID`);

--
-- Indexes for table `IssueEntityType`
--
ALTER TABLE `IssueEntityType`
  ADD PRIMARY KEY (`entityTypeID`);

--
-- Indexes for table `IssueRelationship`
--
ALTER TABLE `IssueRelationship`
  ADD PRIMARY KEY (`issueRelationshipID`),
  ADD KEY `issueID` (`issueID`,`entityID`,`entityTypeID`);

--
-- Indexes for table `LicenseStatus`
--
ALTER TABLE `LicenseStatus`
  ADD PRIMARY KEY (`licenseStatusID`),
  ADD UNIQUE KEY `licenseStatusID` (`licenseStatusID`);

--
-- Indexes for table `NoteType`
--
ALTER TABLE `NoteType`
  ADD PRIMARY KEY (`noteTypeID`);

--
-- Indexes for table `OrderType`
--
ALTER TABLE `OrderType`
  ADD PRIMARY KEY (`orderTypeID`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`organizationID`) USING BTREE;

--
-- Indexes for table `OrganizationRole`
--
ALTER TABLE `OrganizationRole`
  ADD PRIMARY KEY (`organizationRoleID`),
  ADD UNIQUE KEY `organizationRoleID` (`organizationRoleID`);

--
-- Indexes for table `OrgNameMapping`
--
ALTER TABLE `OrgNameMapping`
  ADD PRIMARY KEY (`orgNameMappingID`),
  ADD KEY `importConfigID` (`importConfigID`);

--
-- Indexes for table `Privilege`
--
ALTER TABLE `Privilege`
  ADD PRIMARY KEY (`privilegeID`) USING BTREE;

--
-- Indexes for table `PurchaseSite`
--
ALTER TABLE `PurchaseSite`
  ADD PRIMARY KEY (`purchaseSiteID`);

--
-- Indexes for table `RelationshipType`
--
ALTER TABLE `RelationshipType`
  ADD PRIMARY KEY (`relationshipTypeID`);

--
-- Indexes for table `Resource`
--
ALTER TABLE `Resource`
  ADD PRIMARY KEY (`resourceID`),
  ADD KEY `Index_createDate` (`createDate`),
  ADD KEY `Index_createLoginID` (`createLoginID`),
  ADD KEY `Index_titleText` (`titleText`),
  ADD KEY `Index_statusID` (`statusID`),
  ADD KEY `Index_resourceTypeID` (`resourceTypeID`),
  ADD KEY `Index_resourceFormatID` (`resourceFormatID`),
  ADD KEY `Index_All` (`createDate`,`createLoginID`,`titleText`,`statusID`,`resourceTypeID`,`resourceFormatID`);

--
-- Indexes for table `ResourceAcquisition`
--
ALTER TABLE `ResourceAcquisition`
  ADD PRIMARY KEY (`resourceAcquisitionID`),
  ADD KEY `resourceID` (`resourceID`),
  ADD KEY `organizationID` (`organizationID`),
  ADD KEY `authenticationTypeID` (`authenticationTypeID`),
  ADD KEY `licenseID` (`licenseID`),
  ADD KEY `acquisitionTypeID` (`acquisitionTypeID`),
  ADD KEY `parentResourceID` (`parentResourceID`),
  ADD KEY `accessMethodID` (`accessMethodID`),
  ADD KEY `storageLocationID` (`storageLocationID`),
  ADD KEY `userLimitID` (`userLimitID`),
  ADD KEY `catalogingTypeID` (`catalogingTypeID`),
  ADD KEY `catalogingStatusID` (`catalogingStatusID`);

--
-- Indexes for table `ResourceAdministeringSiteLink`
--
ALTER TABLE `ResourceAdministeringSiteLink`
  ADD PRIMARY KEY (`resourceAdministeringSiteLinkID`),
  ADD KEY `Index_resourceID` (`resourceAcquisitionID`),
  ADD KEY `Index_administeringSiteID` (`administeringSiteID`),
  ADD KEY `Index_All` (`resourceAcquisitionID`,`administeringSiteID`);

--
-- Indexes for table `ResourceAlert`
--
ALTER TABLE `ResourceAlert`
  ADD PRIMARY KEY (`resourceAlertID`);

--
-- Indexes for table `ResourceAuthorizedSiteLink`
--
ALTER TABLE `ResourceAuthorizedSiteLink`
  ADD PRIMARY KEY (`resourceAuthorizedSiteLinkID`),
  ADD KEY `Index_resourceID` (`resourceAcquisitionID`),
  ADD KEY `Index_authorizedSiteID` (`authorizedSiteID`),
  ADD KEY `Index_All` (`resourceAcquisitionID`,`authorizedSiteID`);

--
-- Indexes for table `ResourceFormat`
--
ALTER TABLE `ResourceFormat`
  ADD PRIMARY KEY (`resourceFormatID`) USING BTREE,
  ADD KEY `shortName` (`shortName`);

--
-- Indexes for table `ResourceLicenseLink`
--
ALTER TABLE `ResourceLicenseLink`
  ADD PRIMARY KEY (`resourceLicenseLinkID`),
  ADD KEY `resourceID` (`resourceAcquisitionID`);

--
-- Indexes for table `ResourceLicenseStatus`
--
ALTER TABLE `ResourceLicenseStatus`
  ADD PRIMARY KEY (`resourceLicenseStatusID`),
  ADD KEY `resourceID` (`resourceAcquisitionID`);

--
-- Indexes for table `ResourceNote`
--
ALTER TABLE `ResourceNote`
  ADD PRIMARY KEY (`resourceNoteID`),
  ADD KEY `Index_resourceID` (`entityID`),
  ADD KEY `Index_noteTypeID` (`noteTypeID`),
  ADD KEY `Index_All` (`entityID`,`noteTypeID`);

--
-- Indexes for table `ResourceOrganizationLink`
--
ALTER TABLE `ResourceOrganizationLink`
  ADD PRIMARY KEY (`resourceOrganizationLinkID`),
  ADD KEY `Index_resourceID` (`resourceID`),
  ADD KEY `Index_organizationID` (`organizationID`),
  ADD KEY `Index_All` (`resourceID`,`organizationID`);

--
-- Indexes for table `ResourcePayment`
--
ALTER TABLE `ResourcePayment`
  ADD PRIMARY KEY (`resourcePaymentID`),
  ADD KEY `Index_resourceID` (`resourceAcquisitionID`),
  ADD KEY `Index_year` (`year`),
  ADD KEY `Index_costDetailsID` (`costDetailsID`),
  ADD KEY `Index_invoiceNum` (`invoiceNum`),
  ADD KEY `Index_fundID` (`fundID`),
  ADD KEY `Index_All` (`resourceAcquisitionID`,`fundID`,`year`,`costDetailsID`,`invoiceNum`);

--
-- Indexes for table `ResourcePurchaseSiteLink`
--
ALTER TABLE `ResourcePurchaseSiteLink`
  ADD PRIMARY KEY (`resourcePurchaseSiteLinkID`),
  ADD KEY `Index_resourceID` (`resourceAcquisitionID`),
  ADD KEY `Index_purchaseSiteID` (`purchaseSiteID`),
  ADD KEY `Index_All` (`resourceAcquisitionID`,`purchaseSiteID`);

--
-- Indexes for table `ResourceRelationship`
--
ALTER TABLE `ResourceRelationship`
  ADD PRIMARY KEY (`resourceRelationshipID`),
  ADD KEY `Index_resourceID` (`resourceID`),
  ADD KEY `Index_relatedResourceID` (`relatedResourceID`),
  ADD KEY `Index_All` (`resourceID`,`relatedResourceID`);

--
-- Indexes for table `ResourceStep`
--
ALTER TABLE `ResourceStep`
  ADD PRIMARY KEY (`resourceStepID`),
  ADD KEY `resourceID` (`resourceAcquisitionID`);

--
-- Indexes for table `ResourceSubject`
--
ALTER TABLE `ResourceSubject`
  ADD PRIMARY KEY (`resourceSubjectID`),
  ADD KEY `resourceSubjectID` (`resourceSubjectID`),
  ADD KEY `Index_All` (`resourceID`,`generalDetailSubjectLinkID`),
  ADD KEY `Index_ResourceID` (`resourceID`),
  ADD KEY `Index_GeneralDetailLink` (`generalDetailSubjectLinkID`);

--
-- Indexes for table `ResourceType`
--
ALTER TABLE `ResourceType`
  ADD PRIMARY KEY (`resourceTypeID`),
  ADD KEY `shortName` (`shortName`);

--
-- Indexes for table `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`statusID`),
  ADD KEY `shortName` (`shortName`);

--
-- Indexes for table `Step`
--
ALTER TABLE `Step`
  ADD PRIMARY KEY (`stepID`);

--
-- Indexes for table `StorageLocation`
--
ALTER TABLE `StorageLocation`
  ADD PRIMARY KEY (`storageLocationID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`loginID`);

--
-- Indexes for table `UserGroup`
--
ALTER TABLE `UserGroup`
  ADD PRIMARY KEY (`userGroupID`);

--
-- Indexes for table `UserGroupLink`
--
ALTER TABLE `UserGroupLink`
  ADD PRIMARY KEY (`userGroupLinkID`);

--
-- Indexes for table `UserLimit`
--
ALTER TABLE `UserLimit`
  ADD PRIMARY KEY (`userLimitID`);

--
-- Indexes for table `Workflow`
--
ALTER TABLE `Workflow`
  ADD PRIMARY KEY (`workflowID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AccessMethod`
--
ALTER TABLE `AccessMethod`
  MODIFY `accessMethodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `AcquisitionType`
--
ALTER TABLE `AcquisitionType`
  MODIFY `acquisitionTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `AdministeringSite`
--
ALTER TABLE `AdministeringSite`
  MODIFY `administeringSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `AlertDaysInAdvance`
--
ALTER TABLE `AlertDaysInAdvance`
  MODIFY `alertDaysInAdvanceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `AlertEmailAddress`
--
ALTER TABLE `AlertEmailAddress`
  MODIFY `alertEmailAddressID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Alias`
--
ALTER TABLE `Alias`
  MODIFY `aliasID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AliasType`
--
ALTER TABLE `AliasType`
  MODIFY `aliasTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Attachment`
--
ALTER TABLE `Attachment`
  MODIFY `attachmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AttachmentType`
--
ALTER TABLE `AttachmentType`
  MODIFY `attachmentTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `AuthenticationType`
--
ALTER TABLE `AuthenticationType`
  MODIFY `authenticationTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `AuthorizedSite`
--
ALTER TABLE `AuthorizedSite`
  MODIFY `authorizedSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `CatalogingStatus`
--
ALTER TABLE `CatalogingStatus`
  MODIFY `catalogingStatusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `CatalogingType`
--
ALTER TABLE `CatalogingType`
  MODIFY `catalogingTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Contact`
--
ALTER TABLE `Contact`
  MODIFY `contactID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ContactRole`
--
ALTER TABLE `ContactRole`
  MODIFY `contactRoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `CostDetails`
--
ALTER TABLE `CostDetails`
  MODIFY `costDetailsID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DetailedSubject`
--
ALTER TABLE `DetailedSubject`
  MODIFY `detailedSubjectID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Downtime`
--
ALTER TABLE `Downtime`
  MODIFY `downtimeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DowntimeType`
--
ALTER TABLE `DowntimeType`
  MODIFY `downtimeTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  MODIFY `externalLoginID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ExternalLoginType`
--
ALTER TABLE `ExternalLoginType`
  MODIFY `externalLoginTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Fund`
--
ALTER TABLE `Fund`
  MODIFY `fundID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GeneralDetailSubjectLink`
--
ALTER TABLE `GeneralDetailSubjectLink`
  MODIFY `generalDetailSubjectLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GeneralSubject`
--
ALTER TABLE `GeneralSubject`
  MODIFY `generalSubjectID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ImportConfig`
--
ALTER TABLE `ImportConfig`
  MODIFY `importConfigID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ImportHistory`
--
ALTER TABLE `ImportHistory`
  MODIFY `importHistoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IsbnOrIssn`
--
ALTER TABLE `IsbnOrIssn`
  MODIFY `isbnOrIssnID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Issue`
--
ALTER TABLE `Issue`
  MODIFY `issueID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IssueContact`
--
ALTER TABLE `IssueContact`
  MODIFY `issueContactID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IssueEmail`
--
ALTER TABLE `IssueEmail`
  MODIFY `issueEmailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IssueEntityType`
--
ALTER TABLE `IssueEntityType`
  MODIFY `entityTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `IssueRelationship`
--
ALTER TABLE `IssueRelationship`
  MODIFY `issueRelationshipID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `LicenseStatus`
--
ALTER TABLE `LicenseStatus`
  MODIFY `licenseStatusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `NoteType`
--
ALTER TABLE `NoteType`
  MODIFY `noteTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `OrderType`
--
ALTER TABLE `OrderType`
  MODIFY `orderTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `organizationID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=505;

--
-- AUTO_INCREMENT for table `OrganizationRole`
--
ALTER TABLE `OrganizationRole`
  MODIFY `organizationRoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `OrgNameMapping`
--
ALTER TABLE `OrgNameMapping`
  MODIFY `orgNameMappingID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Privilege`
--
ALTER TABLE `Privilege`
  MODIFY `privilegeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `PurchaseSite`
--
ALTER TABLE `PurchaseSite`
  MODIFY `purchaseSiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `RelationshipType`
--
ALTER TABLE `RelationshipType`
  MODIFY `relationshipTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Resource`
--
ALTER TABLE `Resource`
  MODIFY `resourceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceAcquisition`
--
ALTER TABLE `ResourceAcquisition`
  MODIFY `resourceAcquisitionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceAdministeringSiteLink`
--
ALTER TABLE `ResourceAdministeringSiteLink`
  MODIFY `resourceAdministeringSiteLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceAlert`
--
ALTER TABLE `ResourceAlert`
  MODIFY `resourceAlertID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceAuthorizedSiteLink`
--
ALTER TABLE `ResourceAuthorizedSiteLink`
  MODIFY `resourceAuthorizedSiteLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceFormat`
--
ALTER TABLE `ResourceFormat`
  MODIFY `resourceFormatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ResourceLicenseLink`
--
ALTER TABLE `ResourceLicenseLink`
  MODIFY `resourceLicenseLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceLicenseStatus`
--
ALTER TABLE `ResourceLicenseStatus`
  MODIFY `resourceLicenseStatusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceNote`
--
ALTER TABLE `ResourceNote`
  MODIFY `resourceNoteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceOrganizationLink`
--
ALTER TABLE `ResourceOrganizationLink`
  MODIFY `resourceOrganizationLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourcePayment`
--
ALTER TABLE `ResourcePayment`
  MODIFY `resourcePaymentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourcePurchaseSiteLink`
--
ALTER TABLE `ResourcePurchaseSiteLink`
  MODIFY `resourcePurchaseSiteLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceRelationship`
--
ALTER TABLE `ResourceRelationship`
  MODIFY `resourceRelationshipID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceStep`
--
ALTER TABLE `ResourceStep`
  MODIFY `resourceStepID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceSubject`
--
ALTER TABLE `ResourceSubject`
  MODIFY `resourceSubjectID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ResourceType`
--
ALTER TABLE `ResourceType`
  MODIFY `resourceTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Status`
--
ALTER TABLE `Status`
  MODIFY `statusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Step`
--
ALTER TABLE `Step`
  MODIFY `stepID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `StorageLocation`
--
ALTER TABLE `StorageLocation`
  MODIFY `storageLocationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `UserGroup`
--
ALTER TABLE `UserGroup`
  MODIFY `userGroupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `UserGroupLink`
--
ALTER TABLE `UserGroupLink`
  MODIFY `userGroupLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `UserLimit`
--
ALTER TABLE `UserLimit`
  MODIFY `userLimitID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Workflow`
--
ALTER TABLE `Workflow`
  MODIFY `workflowID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
