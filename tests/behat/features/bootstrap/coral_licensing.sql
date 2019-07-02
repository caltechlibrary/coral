-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 02, 2019 at 05:42 PM
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
-- Database: `coral_licensing`
--

-- --------------------------------------------------------

--
-- Table structure for table `Attachment`
--

CREATE TABLE `Attachment` (
  `attachmentID` int(10) NOT NULL,
  `licenseID` int(10) DEFAULT NULL,
  `sentDate` date DEFAULT NULL,
  `attachmentText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AttachmentFile`
--

CREATE TABLE `AttachmentFile` (
  `attachmentFileID` int(10) UNSIGNED NOT NULL,
  `attachmentID` int(10) UNSIGNED NOT NULL,
  `attachmentURL` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CalendarSettings`
--

CREATE TABLE `CalendarSettings` (
  `calendarSettingsID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL,
  `value` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CalendarSettings`
--

INSERT INTO `CalendarSettings` (`calendarSettingsID`, `shortName`, `value`) VALUES
(1, 'Days Before Subscription End', '730'),
(2, 'Days After Subscription End', '90'),
(3, 'Resource Type(s)', '1'),
(4, 'Authorized Site(s)', '1');

-- --------------------------------------------------------

--
-- Table structure for table `Consortium`
--

CREATE TABLE `Consortium` (
  `consortiumID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Document`
--

CREATE TABLE `Document` (
  `documentID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL,
  `documentTypeID` int(10) UNSIGNED NOT NULL,
  `licenseID` int(10) UNSIGNED NOT NULL,
  `effectiveDate` date DEFAULT NULL,
  `expirationDate` date DEFAULT NULL,
  `documentURL` varchar(200) DEFAULT NULL,
  `parentDocumentID` int(10) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DocumentType`
--

CREATE TABLE `DocumentType` (
  `documentTypeID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `DocumentType`
--

INSERT INTO `DocumentType` (`documentTypeID`, `shortName`) VALUES
(1, 'SERU'),
(2, 'Internal Acknowledgment'),
(3, 'Agreement'),
(4, 'Countersigned Agreement'),
(5, 'Amendment'),
(6, 'Consortium Authorization Statement'),
(7, 'Order Form');

-- --------------------------------------------------------

--
-- Table structure for table `Expression`
--

CREATE TABLE `Expression` (
  `expressionID` int(10) UNSIGNED NOT NULL,
  `documentID` int(10) UNSIGNED NOT NULL,
  `expressionTypeID` int(10) UNSIGNED NOT NULL,
  `documentText` text,
  `simplifiedText` text,
  `lastUpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `productionUseInd` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExpressionNote`
--

CREATE TABLE `ExpressionNote` (
  `expressionNoteID` int(10) NOT NULL,
  `expressionID` int(10) DEFAULT NULL,
  `note` varchar(2000) DEFAULT NULL,
  `displayOrderSeqNumber` int(10) DEFAULT NULL,
  `lastUpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExpressionQualifierProfile`
--

CREATE TABLE `ExpressionQualifierProfile` (
  `expressionID` int(10) UNSIGNED NOT NULL,
  `qualifierID` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ExpressionType`
--

CREATE TABLE `ExpressionType` (
  `expressionTypeID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL,
  `noteType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ExpressionType`
--

INSERT INTO `ExpressionType` (`expressionTypeID`, `shortName`, `noteType`) VALUES
(1, 'Authorized Users', 'Internal'),
(2, 'Interlibrary Loan', 'Display'),
(3, 'Coursepacks', 'Display'),
(4, 'eReserves', 'Display'),
(5, 'Post Cancellation Access', 'Internal'),
(6, 'General Notes', 'Internal'),
(7, 'Jurisdiction (Choice of Forum)', 'Internal'),
(8, 'Third Party Archiving', 'Internal'),
(9, 'Confidentiality Clause', 'Internal'),
(10, 'Multi-year Term', 'Internal');

-- --------------------------------------------------------

--
-- Table structure for table `License`
--

CREATE TABLE `License` (
  `licenseID` int(10) UNSIGNED NOT NULL,
  `consortiumID` int(10) UNSIGNED DEFAULT NULL,
  `organizationID` int(10) UNSIGNED DEFAULT NULL,
  `shortName` tinytext NOT NULL,
  `statusID` int(10) UNSIGNED DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  `createDate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE `Organization` (
  `organizationID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Organization`
--

INSERT INTO `Organization` (`organizationID`, `shortName`) VALUES
(1, 'Accessible Archives Inc'),
(2, 'ACCU Weather Sales and Services, Inc'),
(3, 'Adam Matthew Digital Ltd'),
(4, 'Agricultural History Society'),
(5, 'Agricultural Institute of Canada'),
(6, 'AICPA'),
(7, 'Akademiai Kiado'),
(8, 'Albert C. Muller'),
(9, 'Alexander Street Press, LLC'),
(10, 'Allen Press'),
(11, 'Alliance for Children and Families'),
(12, 'American Academy of Religion'),
(13, 'American Association for Cancer Research (AACR)'),
(14, 'American Association for the Advancement of Science (AAAS)'),
(15, 'American Association of Immunologists, Inc.'),
(16, 'American Concrete Institute (ACI)'),
(17, 'American Council of Learned Societies (ACLS)'),
(18, 'American Counseling Association'),
(19, 'American Economic Association (AEA)'),
(20, 'American Fisheries Society'),
(21, 'American Geophysical Union'),
(22, 'American Insitute of Physics (AIP)'),
(23, 'American Institute of Aeronautics and Astronautics (AIAA)'),
(24, 'American Library Association (ALA)'),
(25, 'American Mathematical Society (AMS)'),
(26, 'American Medical Association (AMA)'),
(27, 'American Meteorological Society (AMS)'),
(28, 'American Physical Society (APS)'),
(29, 'American Physiological Society'),
(30, 'American Phytopathological Society'),
(31, 'American Psychiatric Publishing'),
(32, 'American Psychological Association (APA)'),
(33, 'American Society for Cell Biology'),
(34, 'American Society for Clinical Investigation'),
(35, 'American Society for Horticultural Science'),
(36, 'American Society for Nutrition'),
(37, 'American Society for Testing and Materials (ASTM)'),
(38, 'American Society of Agronomy'),
(39, 'American Society of Civil Engineers (ASCE)'),
(40, 'American Society of Limnology and Oceanography (ASLO)'),
(41, 'American Society of Plant Biologists'),
(42, 'American Society of Tropical Medicine and Hygiene'),
(43, 'American Statistical Association'),
(44, 'Ammons Scientific Limited'),
(45, 'Annual Reviews'),
(46, 'Antiquity Publications Limited'),
(47, 'Applied Probability Trust'),
(48, 'Army Times Publishing Company'),
(49, 'ARTstor Inc'),
(50, 'Asempa Limited'),
(51, 'Association of Research Libraries (ARL)'),
(52, 'Atypon Systems Inc'),
(53, 'Augustine Institute'),
(54, 'Barkhuis Publishing'),
(55, 'Begell House, Inc'),
(56, 'Beilstein'),
(57, 'Belser Wissenschaftlicher Dienst Ltd'),
(58, 'Berg Publishers'),
(59, 'Berghahn Books'),
(60, 'Berkeley Electronic Press'),
(61, 'BIGresearch LLC'),
(62, 'BioMed Central'),
(63, 'BioOne'),
(64, 'Blackwell Publishing'),
(65, 'BMJ Publishing Group Limited'),
(66, 'Boopsie, INC.'),
(67, 'Botanical Society of America'),
(68, 'Boyd Printing'),
(69, 'Brepols Publishers'),
(70, 'Brill'),
(71, 'Bulletin of the Atomic Scientists'),
(72, 'Bureau of National Affairs, Inc'),
(73, 'Business Monitor International'),
(74, 'CABI Publishing'),
(75, 'Cambridge Crystallographic Data Centre'),
(76, 'Cambridge Scientific Abstracts'),
(77, 'Cambridge University Press'),
(78, 'Canadian Association of African Studies'),
(79, 'Canadian Mathematical Society'),
(80, 'Carbon Disclosure Project'),
(81, 'CareerShift LLC'),
(82, 'CCH Incorporated'),
(83, 'Centro de Investigaciones Sociologicas'),
(84, 'Chemical Abstracts Service (CAS)'),
(85, 'Chiniquy Collection'),
(86, 'Chorus America'),
(87, 'Chronicle of Higher Education'),
(88, 'Colegio de Mexico'),
(89, 'College Art Association'),
(90, 'Company of Biologists Ltd'),
(91, 'Competitive Media Reporting, LLC (TNS Media Intelligence TNSMI)'),
(92, 'Consejo Superior de Investigaciones Cientificas (CSIC)'),
(93, 'Consumer Electronics Association'),
(94, 'Cornell University Library'),
(95, 'Corporacion Latinobarometro'),
(96, 'Corporation for National Research Initiatives (CNRI)'),
(97, 'CQ Press'),
(98, 'CSIRO Publishing'),
(99, 'Current History, Inc'),
(100, 'Dialog'),
(101, 'Dialogue Foundation'),
(102, 'Digital Distributed Community Archive'),
(103, 'Digital Heritage Publishing Limited'),
(104, 'Duke University Press'),
(105, 'Dun and Bradstreet Inc'),
(106, 'Dunstans Publishing Ltd'),
(107, 'East View Information Services'),
(108, 'EBSCO'),
(109, 'Ecological Society of America'),
(110, 'Edinburgh University Press'),
(111, 'EDP Sciences'),
(112, 'Elsevier'),
(113, 'Encyclopaedia Britannica Online'),
(114, 'Endocrine Society'),
(115, 'Entomological Society of Canada'),
(116, 'Equinox Publishing Ltd'),
(117, 'European Mathematical Society Publishing House'),
(118, 'European Society of Endocrinology'),
(119, 'Evolutionary Ecology Ltd'),
(120, 'ExLibris'),
(121, 'Experian Marketing Solutions, Inc.'),
(122, 'FamilyLink.com, Inc.'),
(123, 'FamilyLink.com, Inc.'),
(124, 'Faulkner Information Services'),
(125, 'Federation of American Societies for Experimental Biology'),
(126, 'Forrester Research, Inc'),
(127, 'Franz Steiner Verlag'),
(128, 'Genetics Society of America'),
(129, 'Geographic Research, Inc'),
(130, 'GeoScienceWorld'),
(131, 'Global Science Press'),
(132, 'Grove Dictionaries, Inc'),
(133, 'GuideStar USA, Inc'),
(134, 'H.W. Wilson Company'),
(135, 'H1 Base, Inc'),
(136, 'Hans Zell Publishing'),
(137, 'Haworth Press'),
(138, 'Heldref Publications'),
(139, 'HighWire Press'),
(140, 'Histochemical Society'),
(141, 'Human Kinetics Inc.'),
(142, 'IBISWorld USA'),
(143, 'Idea Group Inc'),
(144, 'IEEE'),
(145, 'Incisive Media Ltd'),
(146, 'Indiana University Mathematics Journal'),
(147, 'Informa Healthcare USA, Inc'),
(148, 'Information Resources, Inc'),
(149, 'INFORMS'),
(150, 'Ingentaconnect'),
(151, 'Institute of Mathematics of the Polish Academy of Sciences'),
(152, 'Institute of Physics (IOP)'),
(153, 'Institution of Engineering and Technology (IET)'),
(154, 'Institutional Shareholder Services Inc'),
(155, 'InteLex'),
(156, 'Intellect'),
(157, 'Intelligence Research Limited'),
(158, 'International Press'),
(159, 'IOS Press'),
(160, 'IPA Source, LLC'),
(161, 'Irish Newspaper Archives Ltd'),
(162, 'ITHAKA'),
(163, 'IVES Group, Inc'),
(164, 'Japan Focus'),
(165, 'John Benjamins Publishing Company'),
(166, 'JSTOR'),
(167, 'Karger'),
(168, 'Keesings Worldwide, LLC'),
(169, 'KLD Research and Analytics Inc'),
(170, 'Landes Bioscience'),
(171, 'LexisNexis'),
(172, 'Librairie Droz'),
(173, 'Library of Congress, Cataloging Distribution Service'),
(174, 'Lipper Inc'),
(175, 'Liverpool University Press'),
(176, 'Lord Music Reference Inc'),
(177, 'M.E. Sharpe, Inc'),
(178, 'Manchester University Press'),
(179, 'Marine Biological Laboratory'),
(180, 'MarketResearch.com, Inc'),
(181, 'Marquis Who\'s Who LLC'),
(182, 'Mary Ann Liebert, Inc'),
(183, 'Massachusetts Medical Society'),
(184, 'Mathematical Sciences Publishers'),
(185, 'Mediamark Research and Intelligence, LLC'),
(186, 'Mergent, Inc'),
(187, 'Metropolitan Opera'),
(188, 'Mintel International Group Limited'),
(189, 'MIT Press'),
(190, 'MIT'),
(191, 'Morningstar Inc.'),
(192, 'National Academy of Sciences'),
(193, 'National Gallery Company Ltd'),
(194, 'National Research Council of Canada'),
(195, 'Nature Publishing Group'),
(196, 'Naxos Digital Services Limited'),
(197, 'Neilson Journals Publishing'),
(198, 'New York Review of Books'),
(199, 'NewsBank, Inc'),
(200, 'OCLC'),
(201, 'Otto Harrassowitz'),
(202, 'Ovid'),
(203, 'Oxford Centre of Hebrew and Jewish Studies'),
(204, 'Oxford University Press'),
(205, 'Paradigm Publishers'),
(206, 'Paratext'),
(207, 'Peeters Publishers'),
(208, 'Philosophy Documentation Center'),
(209, 'Portland Press Limited'),
(210, 'Preservation Technologies LP'),
(211, 'Project Muse'),
(212, 'ProQuest LLC'),
(213, 'Psychoanalytic Electronic Publishing Inc'),
(214, 'R.R. Bowker'),
(215, 'Religious and Theological Abstracts, Inc'),
(216, 'Reuters Loan Pricing Corporation'),
(217, 'Risk Management Association (RMA)'),
(218, 'Rivista di Studi italiani'),
(219, 'Robert Blakemore'),
(220, 'Rockefeller University Press'),
(221, 'Roper Center for Public Opinion Research'),
(222, 'Royal Society of Chemistry'),
(223, 'Royal Society of London'),
(224, 'SAGE Publications'),
(225, 'Scholarly Digital Editions'),
(226, 'Seminario Matematico of the University of Padua'),
(227, 'Simmons Market Research Bureau Inc'),
(228, 'SISMEL - Edizioni del Galluzzo'),
(229, 'Social Explorer'),
(230, 'Societe Mathematique de France'),
(231, 'Society for Endocrinology'),
(232, 'Society for Experimental Biology and Medicine'),
(233, 'Society for General Microbiology'),
(234, 'Society for Industrial and Applied Mathematics (SIAM)'),
(235, 'Society for Leukocyte Biology'),
(236, 'Society for Neuroscience'),
(237, 'Society for Reproduction and Fertility'),
(238, 'Society of Antiquaries of Scotland'),
(239, 'Society of Environmental Toxicology and Chemistry'),
(240, 'SPIE'),
(241, 'Springer'),
(242, 'Standard and Poor\'s'),
(243, 'Stanford University'),
(244, 'Swank Motion Pictures, Inc'),
(245, 'Swiss Chemical Society'),
(246, 'Tablet Publishing (London)'),
(247, 'Taylor and Francis'),
(248, 'Teachers College Record'),
(249, 'Terra Scientific Publishing Company'),
(250, 'Tetrad Computer Applications Inc'),
(251, 'The Academy of the Hebrew Language'),
(252, 'Thesaurus Linguae Graecae'),
(253, 'Thomas Telford Ltd'),
(254, 'Thomson Financial Inc'),
(255, 'Thomson Gale'),
(256, 'Thomson RIA'),
(257, 'Thomson Scientific Inc. (Institute for Scientific Information, Inc.)'),
(258, 'Trans Tech Publications'),
(259, 'Transportation Research Board'),
(260, 'U.S. Department of Commerce'),
(261, 'UCLA Chicano Studies Research Center Press'),
(262, 'University of Barcelona'),
(263, 'University of Buckingham Press'),
(264, 'University of California Press'),
(265, 'University of Chicago Press'),
(266, 'University of Houston Department of Mathematics'),
(267, 'University of Illinois Press'),
(268, 'University of Iowa'),
(269, 'University of Pittsburgh'),
(270, 'University of Toronto Press Inc'),
(271, 'University of Toronto'),
(272, 'University of Virginia Press'),
(273, 'University of Wisconsin Press'),
(274, 'Universum USA'),
(275, 'Uniworld Business Publications, Inc'),
(276, 'Value Line, Inc'),
(277, 'Vanderbilt University'),
(278, 'Vault, Inc'),
(279, 'Verlag C.H. Beck'),
(280, 'Verlag der Zeitschrift fur Naturforschung '),
(281, 'W.S. Maney and Son Ltd'),
(282, 'Walter de Gruyter'),
(283, 'White Horse Press'),
(284, 'Wiley'),
(285, 'World Scientific'),
(286, 'World Trade Press'),
(287, 'Worldwatch Institute'),
(288, 'Yankelovich Inc');

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
(3, 'view only'),
(4, 'restricted');

-- --------------------------------------------------------

--
-- Table structure for table `Qualifier`
--

CREATE TABLE `Qualifier` (
  `qualifierID` int(10) UNSIGNED NOT NULL,
  `expressionTypeID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Qualifier`
--

INSERT INTO `Qualifier` (`qualifierID`, `expressionTypeID`, `shortName`) VALUES
(1, 2, 'Not Clear'),
(2, 2, 'Not Reviewed'),
(3, 2, 'Prohibited'),
(4, 2, 'Permitted'),
(5, 3, 'Not Clear'),
(6, 3, 'Not Reviewed'),
(7, 3, 'Prohibited'),
(8, 3, 'Permitted');

-- --------------------------------------------------------

--
-- Table structure for table `SFXProvider`
--

CREATE TABLE `SFXProvider` (
  `sfxProviderID` int(10) UNSIGNED NOT NULL,
  `documentID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(245) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Signature`
--

CREATE TABLE `Signature` (
  `signatureID` int(10) UNSIGNED NOT NULL,
  `documentID` int(10) UNSIGNED NOT NULL,
  `signatureTypeID` int(10) UNSIGNED NOT NULL,
  `signatureDate` date DEFAULT NULL,
  `signerName` tinytext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `SignatureType`
--

CREATE TABLE `SignatureType` (
  `signatureTypeID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `SignatureType`
--

INSERT INTO `SignatureType` (`signatureTypeID`, `shortName`) VALUES
(1, 'Agent'),
(2, 'Consortium'),
(3, 'Internal'),
(4, 'Provider');

-- --------------------------------------------------------

--
-- Table structure for table `Status`
--

CREATE TABLE `Status` (
  `statusID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Status`
--

INSERT INTO `Status` (`statusID`, `shortName`) VALUES
(1, 'Awaiting Document'),
(2, 'Complete'),
(3, 'Document Only'),
(4, 'Editing Expressions'),
(5, 'NLR');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `loginID` varchar(50) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `privilegeID` int(10) UNSIGNED DEFAULT NULL,
  `emailAddressForTermsTool` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`loginID`, `lastName`, `firstName`, `privilegeID`, `emailAddressForTermsTool`) VALUES
('coral_admin', NULL, NULL, 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Attachment`
--
ALTER TABLE `Attachment`
  ADD PRIMARY KEY (`attachmentID`) USING BTREE,
  ADD KEY `licenseID` (`licenseID`);

--
-- Indexes for table `AttachmentFile`
--
ALTER TABLE `AttachmentFile`
  ADD PRIMARY KEY (`attachmentFileID`) USING BTREE;

--
-- Indexes for table `CalendarSettings`
--
ALTER TABLE `CalendarSettings`
  ADD PRIMARY KEY (`calendarSettingsID`);

--
-- Indexes for table `Consortium`
--
ALTER TABLE `Consortium`
  ADD PRIMARY KEY (`consortiumID`);

--
-- Indexes for table `Document`
--
ALTER TABLE `Document`
  ADD PRIMARY KEY (`documentID`),
  ADD KEY `licenseID` (`licenseID`),
  ADD KEY `documentTypeID` (`documentTypeID`),
  ADD KEY `parentDocumentID` (`parentDocumentID`);

--
-- Indexes for table `DocumentType`
--
ALTER TABLE `DocumentType`
  ADD PRIMARY KEY (`documentTypeID`);

--
-- Indexes for table `Expression`
--
ALTER TABLE `Expression`
  ADD PRIMARY KEY (`expressionID`),
  ADD KEY `documentID` (`documentID`),
  ADD KEY `expressionTypeID` (`expressionTypeID`);

--
-- Indexes for table `ExpressionNote`
--
ALTER TABLE `ExpressionNote`
  ADD PRIMARY KEY (`expressionNoteID`),
  ADD KEY `expressionID` (`expressionID`);

--
-- Indexes for table `ExpressionQualifierProfile`
--
ALTER TABLE `ExpressionQualifierProfile`
  ADD PRIMARY KEY (`expressionID`,`qualifierID`);

--
-- Indexes for table `ExpressionType`
--
ALTER TABLE `ExpressionType`
  ADD PRIMARY KEY (`expressionTypeID`);

--
-- Indexes for table `License`
--
ALTER TABLE `License`
  ADD PRIMARY KEY (`licenseID`),
  ADD KEY `organizationID` (`organizationID`),
  ADD KEY `consortiumID` (`consortiumID`),
  ADD KEY `statusID` (`statusID`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`organizationID`) USING BTREE;

--
-- Indexes for table `Privilege`
--
ALTER TABLE `Privilege`
  ADD PRIMARY KEY (`privilegeID`) USING BTREE;

--
-- Indexes for table `Qualifier`
--
ALTER TABLE `Qualifier`
  ADD PRIMARY KEY (`qualifierID`),
  ADD KEY `expressionTypeID` (`expressionTypeID`);

--
-- Indexes for table `SFXProvider`
--
ALTER TABLE `SFXProvider`
  ADD PRIMARY KEY (`sfxProviderID`),
  ADD KEY `documentID` (`documentID`);

--
-- Indexes for table `Signature`
--
ALTER TABLE `Signature`
  ADD PRIMARY KEY (`signatureID`),
  ADD KEY `documentID` (`documentID`),
  ADD KEY `signatureTypeID` (`signatureTypeID`);

--
-- Indexes for table `SignatureType`
--
ALTER TABLE `SignatureType`
  ADD PRIMARY KEY (`signatureTypeID`);

--
-- Indexes for table `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`statusID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`loginID`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Attachment`
--
ALTER TABLE `Attachment`
  MODIFY `attachmentID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AttachmentFile`
--
ALTER TABLE `AttachmentFile`
  MODIFY `attachmentFileID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CalendarSettings`
--
ALTER TABLE `CalendarSettings`
  MODIFY `calendarSettingsID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Consortium`
--
ALTER TABLE `Consortium`
  MODIFY `consortiumID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Document`
--
ALTER TABLE `Document`
  MODIFY `documentID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DocumentType`
--
ALTER TABLE `DocumentType`
  MODIFY `documentTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Expression`
--
ALTER TABLE `Expression`
  MODIFY `expressionID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ExpressionNote`
--
ALTER TABLE `ExpressionNote`
  MODIFY `expressionNoteID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ExpressionType`
--
ALTER TABLE `ExpressionType`
  MODIFY `expressionTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `License`
--
ALTER TABLE `License`
  MODIFY `licenseID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `organizationID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `Privilege`
--
ALTER TABLE `Privilege`
  MODIFY `privilegeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Qualifier`
--
ALTER TABLE `Qualifier`
  MODIFY `qualifierID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `SFXProvider`
--
ALTER TABLE `SFXProvider`
  MODIFY `sfxProviderID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Signature`
--
ALTER TABLE `Signature`
  MODIFY `signatureID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SignatureType`
--
ALTER TABLE `SignatureType`
  MODIFY `signatureTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Status`
--
ALTER TABLE `Status`
  MODIFY `statusID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
