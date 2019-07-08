-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 08, 2019 at 06:10 PM
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
-- Database: `coral_usage`
--

-- --------------------------------------------------------

--
-- Table structure for table `ExternalLogin`
--

CREATE TABLE `ExternalLogin` (
  `externalLoginID` int(10) UNSIGNED NOT NULL,
  `publisherPlatformID` int(10) UNSIGNED DEFAULT NULL,
  `platformID` int(10) UNSIGNED DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `loginURL` varchar(245) DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ImportLog`
--

CREATE TABLE `ImportLog` (
  `importLogID` int(10) UNSIGNED NOT NULL,
  `loginID` varchar(45) NOT NULL,
  `importDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `layoutCode` varchar(45) DEFAULT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `archiveFileURL` varchar(145) DEFAULT NULL,
  `logFileURL` varchar(145) DEFAULT NULL,
  `details` varchar(245) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ImportLogPlatformLink`
--

CREATE TABLE `ImportLogPlatformLink` (
  `importLogPlatformLinkID` int(11) NOT NULL,
  `platformID` int(11) DEFAULT NULL,
  `importLogID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Layout`
--

CREATE TABLE `Layout` (
  `layoutID` int(11) NOT NULL,
  `layoutCode` varchar(45) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `resourceType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Layout`
--

INSERT INTO `Layout` (`layoutID`, `layoutCode`, `name`, `resourceType`) VALUES
(1, 'JR1_R3', 'Journals (JR1) R3', 'Journal'),
(2, 'JR1a_R3', 'Journals (JR1) R3 archive', 'Journal'),
(3, 'JR1_R4', 'Journals (JR1) R4', 'Journal'),
(4, 'JR1a_R4', 'Journals (JR1) R4 archive', 'Journal'),
(5, 'BR1_R3', 'Books (BR1) R3', 'Book'),
(6, 'BR1_R4', 'Books (BR1) R4', 'Book'),
(7, 'BR2_R3', 'Book Sections (BR2) R3', 'Book'),
(8, 'BR2_R4', 'Book Sections (BR2) R4', 'Book'),
(9, 'DB1_R3', 'Database (DB1) R3', 'Database'),
(10, 'DB1_R4', 'Database (DB1) R4', 'Database');

-- --------------------------------------------------------

--
-- Table structure for table `LogEmailAddress`
--

CREATE TABLE `LogEmailAddress` (
  `logEmailAddressID` int(11) NOT NULL,
  `emailAddress` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `MonthlyUsageSummary`
--

CREATE TABLE `MonthlyUsageSummary` (
  `monthlyUsageSummaryID` int(11) NOT NULL,
  `titleID` int(11) NOT NULL,
  `publisherPlatformID` int(11) NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `archiveInd` tinyint(1) DEFAULT NULL,
  `usageCount` int(11) DEFAULT NULL,
  `overrideUsageCount` int(11) DEFAULT NULL,
  `outlierID` int(10) UNSIGNED DEFAULT NULL,
  `ignoreOutlierInd` tinyint(3) UNSIGNED DEFAULT '0',
  `mergeInd` tinyint(1) UNSIGNED DEFAULT '0',
  `activityType` varchar(45) DEFAULT NULL,
  `sectionType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Outlier`
--

CREATE TABLE `Outlier` (
  `outlierID` int(11) NOT NULL,
  `outlierLevel` int(11) DEFAULT NULL,
  `overageCount` int(11) DEFAULT NULL,
  `overagePercent` int(3) DEFAULT NULL,
  `color` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Outlier`
--

INSERT INTO `Outlier` (`outlierID`, `outlierLevel`, `overageCount`, `overagePercent`, `color`) VALUES
(1, 1, 50, 200, 'yellow'),
(2, 2, 100, 300, 'orange'),
(3, 3, 200, 400, 'red');

-- --------------------------------------------------------

--
-- Table structure for table `Platform`
--

CREATE TABLE `Platform` (
  `platformID` int(11) NOT NULL,
  `organizationID` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `reportDisplayName` varchar(150) DEFAULT NULL,
  `reportDropDownInd` tinyint(1) UNSIGNED DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `PlatformNote`
--

CREATE TABLE `PlatformNote` (
  `platformNoteID` int(11) NOT NULL,
  `platformID` int(11) DEFAULT NULL,
  `startYear` int(4) DEFAULT NULL,
  `endYear` int(4) DEFAULT NULL,
  `counterCompliantInd` tinyint(1) UNSIGNED DEFAULT NULL,
  `noteText` text
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
(2, 'add/edit');

-- --------------------------------------------------------

--
-- Table structure for table `Publisher`
--

CREATE TABLE `Publisher` (
  `publisherID` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `PublisherPlatform`
--

CREATE TABLE `PublisherPlatform` (
  `publisherPlatformID` int(11) NOT NULL,
  `publisherID` int(11) DEFAULT NULL,
  `platformID` int(11) DEFAULT NULL,
  `organizationID` int(10) UNSIGNED DEFAULT NULL,
  `reportDisplayName` varchar(150) NOT NULL,
  `reportDropDownInd` tinyint(1) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `PublisherPlatformNote`
--

CREATE TABLE `PublisherPlatformNote` (
  `publisherPlatformNoteID` int(10) UNSIGNED NOT NULL,
  `publisherPlatformID` int(10) UNSIGNED NOT NULL,
  `startYear` int(4) UNSIGNED DEFAULT NULL,
  `endYear` int(4) UNSIGNED DEFAULT NULL,
  `noteText` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `SushiService`
--

CREATE TABLE `SushiService` (
  `sushiServiceID` int(11) NOT NULL,
  `platformID` int(11) DEFAULT NULL,
  `publisherPlatformID` int(11) DEFAULT NULL,
  `serviceURL` varchar(300) DEFAULT NULL,
  `wsdlURL` varchar(300) DEFAULT NULL,
  `requestorID` varchar(300) DEFAULT NULL,
  `customerID` varchar(300) DEFAULT NULL,
  `login` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `security` varchar(300) DEFAULT NULL,
  `serviceDayOfMonth` varchar(300) DEFAULT NULL,
  `noteText` varchar(300) DEFAULT NULL,
  `releaseNumber` varchar(45) DEFAULT NULL,
  `reportLayouts` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Title`
--

CREATE TABLE `Title` (
  `titleID` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `resourceType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TitleIdentifier`
--

CREATE TABLE `TitleIdentifier` (
  `titleIdentifierID` int(11) NOT NULL,
  `titleID` int(11) DEFAULT NULL,
  `identifier` varchar(25) DEFAULT NULL,
  `identifierType` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `loginID` varchar(50) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `privilegeID` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`loginID`, `lastName`, `firstName`, `privilegeID`) VALUES
('coral_admin', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Version`
--

CREATE TABLE `Version` (
  `version` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Version`
--

INSERT INTO `Version` (`version`) VALUES
('1.2');

-- --------------------------------------------------------

--
-- Table structure for table `YearlyUsageSummary`
--

CREATE TABLE `YearlyUsageSummary` (
  `yearlyUsageSummaryID` int(11) NOT NULL,
  `titleID` int(11) NOT NULL,
  `publisherPlatformID` int(11) NOT NULL,
  `year` int(4) DEFAULT NULL,
  `archiveInd` tinyint(1) DEFAULT NULL,
  `totalCount` int(11) DEFAULT NULL,
  `ytdHTMLCount` int(11) DEFAULT NULL,
  `ytdPDFCount` int(11) DEFAULT NULL,
  `overrideTotalCount` int(10) UNSIGNED DEFAULT NULL,
  `overrideHTMLCount` int(10) UNSIGNED DEFAULT NULL,
  `overridePDFCount` int(10) UNSIGNED DEFAULT NULL,
  `mergeInd` tinyint(1) UNSIGNED DEFAULT '0',
  `activityType` varchar(45) DEFAULT NULL,
  `sectionType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  ADD PRIMARY KEY (`externalLoginID`) USING BTREE;

--
-- Indexes for table `ImportLog`
--
ALTER TABLE `ImportLog`
  ADD PRIMARY KEY (`importLogID`) USING BTREE;

--
-- Indexes for table `ImportLogPlatformLink`
--
ALTER TABLE `ImportLogPlatformLink`
  ADD PRIMARY KEY (`importLogPlatformLinkID`),
  ADD KEY `Index_platformID` (`platformID`);

--
-- Indexes for table `Layout`
--
ALTER TABLE `Layout`
  ADD PRIMARY KEY (`layoutID`);

--
-- Indexes for table `LogEmailAddress`
--
ALTER TABLE `LogEmailAddress`
  ADD PRIMARY KEY (`logEmailAddressID`);

--
-- Indexes for table `MonthlyUsageSummary`
--
ALTER TABLE `MonthlyUsageSummary`
  ADD PRIMARY KEY (`monthlyUsageSummaryID`) USING BTREE,
  ADD KEY `Index_titleID` (`titleID`),
  ADD KEY `Index_publisherPlatformID` (`publisherPlatformID`),
  ADD KEY `Index_year` (`year`),
  ADD KEY `Index_TPPYMA` (`titleID`,`publisherPlatformID`,`year`,`month`,`archiveInd`);

--
-- Indexes for table `Outlier`
--
ALTER TABLE `Outlier`
  ADD PRIMARY KEY (`outlierID`);

--
-- Indexes for table `Platform`
--
ALTER TABLE `Platform`
  ADD PRIMARY KEY (`platformID`);

--
-- Indexes for table `PlatformNote`
--
ALTER TABLE `PlatformNote`
  ADD PRIMARY KEY (`platformNoteID`) USING BTREE;

--
-- Indexes for table `Privilege`
--
ALTER TABLE `Privilege`
  ADD PRIMARY KEY (`privilegeID`) USING BTREE;

--
-- Indexes for table `Publisher`
--
ALTER TABLE `Publisher`
  ADD PRIMARY KEY (`publisherID`);

--
-- Indexes for table `PublisherPlatform`
--
ALTER TABLE `PublisherPlatform`
  ADD PRIMARY KEY (`publisherPlatformID`);

--
-- Indexes for table `PublisherPlatformNote`
--
ALTER TABLE `PublisherPlatformNote`
  ADD PRIMARY KEY (`publisherPlatformNoteID`) USING BTREE;

--
-- Indexes for table `SushiService`
--
ALTER TABLE `SushiService`
  ADD PRIMARY KEY (`sushiServiceID`),
  ADD KEY `Index_publisherPlatformID` (`publisherPlatformID`),
  ADD KEY `Index_platformID` (`platformID`);

--
-- Indexes for table `Title`
--
ALTER TABLE `Title`
  ADD PRIMARY KEY (`titleID`),
  ADD KEY `Index_title` (`title`);

--
-- Indexes for table `TitleIdentifier`
--
ALTER TABLE `TitleIdentifier`
  ADD PRIMARY KEY (`titleIdentifierID`),
  ADD KEY `Index_titleID` (`titleID`),
  ADD KEY `Index_issn` (`identifier`) USING BTREE,
  ADD KEY `Index_ISSNType` (`identifierType`) USING BTREE;

--
-- Indexes for table `YearlyUsageSummary`
--
ALTER TABLE `YearlyUsageSummary`
  ADD PRIMARY KEY (`yearlyUsageSummaryID`) USING BTREE,
  ADD KEY `Index_titleID` (`titleID`),
  ADD KEY `Index_publisherPlatformID` (`publisherPlatformID`),
  ADD KEY `Index_year` (`year`),
  ADD KEY `Index_TPPYA` (`titleID`,`publisherPlatformID`,`year`,`archiveInd`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ExternalLogin`
--
ALTER TABLE `ExternalLogin`
  MODIFY `externalLoginID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ImportLog`
--
ALTER TABLE `ImportLog`
  MODIFY `importLogID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ImportLogPlatformLink`
--
ALTER TABLE `ImportLogPlatformLink`
  MODIFY `importLogPlatformLinkID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Layout`
--
ALTER TABLE `Layout`
  MODIFY `layoutID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `LogEmailAddress`
--
ALTER TABLE `LogEmailAddress`
  MODIFY `logEmailAddressID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `MonthlyUsageSummary`
--
ALTER TABLE `MonthlyUsageSummary`
  MODIFY `monthlyUsageSummaryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Outlier`
--
ALTER TABLE `Outlier`
  MODIFY `outlierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Platform`
--
ALTER TABLE `Platform`
  MODIFY `platformID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PlatformNote`
--
ALTER TABLE `PlatformNote`
  MODIFY `platformNoteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Privilege`
--
ALTER TABLE `Privilege`
  MODIFY `privilegeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Publisher`
--
ALTER TABLE `Publisher`
  MODIFY `publisherID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PublisherPlatform`
--
ALTER TABLE `PublisherPlatform`
  MODIFY `publisherPlatformID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PublisherPlatformNote`
--
ALTER TABLE `PublisherPlatformNote`
  MODIFY `publisherPlatformNoteID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SushiService`
--
ALTER TABLE `SushiService`
  MODIFY `sushiServiceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Title`
--
ALTER TABLE `Title`
  MODIFY `titleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TitleIdentifier`
--
ALTER TABLE `TitleIdentifier`
  MODIFY `titleIdentifierID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `YearlyUsageSummary`
--
ALTER TABLE `YearlyUsageSummary`
  MODIFY `yearlyUsageSummaryID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
