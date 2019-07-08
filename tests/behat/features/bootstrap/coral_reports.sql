-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 08, 2019 at 10:16 PM
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
-- Database: `coral_reports`
--

-- --------------------------------------------------------

--
-- Table structure for table `Report`
--

CREATE TABLE `Report` (
  `reportID` int(11) NOT NULL,
  `reportName` varchar(45) NOT NULL,
  `defaultRecPageNumber` int(11) DEFAULT '100',
  `excelOnlyInd` tinyint(1) DEFAULT NULL,
  `reportDatabaseName` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Report`
--

INSERT INTO `Report` (`reportID`, `reportName`, `defaultRecPageNumber`, `excelOnlyInd`, `reportDatabaseName`) VALUES
(1, 'Usage Statistics by Titles', 100, 0, 'usageDatabaseName'),
(2, 'Usage Statistics by Provider / Publisher', 100, 0, 'usageDatabaseName'),
(3, 'Usage Statistics - Provider Rollup', 100, 0, 'usageDatabaseName'),
(4, 'Usage Statistics - Publisher Rollup', 100, 0, 'usageDatabaseName'),
(5, 'Usage Statistics - Top Resource Requests', 100, 0, 'usageDatabaseName'),
(6, 'Usage Statistics - Yearly Usage Statistics', 100, 0, 'usageDatabaseName');

-- --------------------------------------------------------

--
-- Table structure for table `ReportGroupingColumn`
--

CREATE TABLE `ReportGroupingColumn` (
  `reportID` int(11) NOT NULL,
  `reportGroupingColumnName` varchar(45) NOT NULL,
  `reportGroupingColumnID` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ReportParameter`
--

CREATE TABLE `ReportParameter` (
  `reportParameterID` int(11) NOT NULL,
  `parameterTypeCode` varchar(45) DEFAULT NULL,
  `parameterDisplayPrompt` varchar(45) DEFAULT NULL,
  `parameterAddWhereClause` varchar(500) DEFAULT NULL,
  `parameterAddWhereNumber` int(11) DEFAULT NULL,
  `requiredInd` tinyint(1) DEFAULT NULL,
  `parameterSQLStatement` text,
  `parameterSQLRestriction` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ReportParameter`
--

INSERT INTO `ReportParameter` (`reportParameterID`, `parameterTypeCode`, `parameterDisplayPrompt`, `parameterAddWhereClause`, `parameterAddWhereNumber`, `requiredInd`, `parameterSQLStatement`, `parameterSQLRestriction`) VALUES
(1, 'chk', 'Do not adjust numbers for use violations', 'Overriden', 0, 0, '', ''),
(2, 'txt', 'ISSN/ISBN/DOI', '(ti2.identifier = \'PARM\' OR ti2.identifier = REPLACE(\'PARM\',\"-\",\"\"))', 1, 0, '', ''),
(3, 'txt', 'Title Search', 'upper(t2.title) like upper(\'%PARM%\')', 1, 0, '', ''),
(4, 'dd', 'Provider / Publisher', '(concat(\'PL_\', CAST(Platform.platformID AS CHAR)) = \'PARM\' OR concat(\'PB_\', CAST(pp.publisherPlatformID AS CHAR)) = \'PARM\')', 0, 0, 'SELECT concat(\'PL_\', CAST(Platform.platformID AS CHAR)), reportDisplayName, upper(reportDisplayName) FROM Platform WHERE reportDropDownInd = 1 UNION SELECT concat(\'PB_\', CAST(publisherPlatformID AS CHAR)), reportDisplayName, upper(reportDisplayName) FROM PublisherPlatform WHERE reportDropDownInd = 1 ORDER BY 3', ''),
(5, 'ms', 'Provider', 'concat(\'PL_\', CAST(Platform.platformID AS CHAR)) in (\'PARM\')', 0, 0, 'SELECT concat(\'PL_\', CAST(platformID AS CHAR)), reportDisplayName, upper(reportDisplayName) FROM Platform WHERE reportDropDownInd = 1 ORDER BY 3', ''),
(6, 'ms', 'Publisher', 'concat(\'PB_\', CAST(pp.publisherPlatformID AS CHAR)) in (\'PARM\')', 0, 0, 'SELECT GROUP_CONCAT(DISTINCT concat(\'PB_\', CAST(publisherPlatformID AS CHAR)) ORDER BY publisherPlatformID DESC SEPARATOR \', \'), reportDisplayName, upper(reportDisplayName) FROM PublisherPlatform WHERE reportDropDownInd = 1 GROUP BY reportDisplayName ORDER BY 3', ''),
(7, 'dd', 'Limit', 'limit', 0, 1, 'SELECT 25,25 union SELECT 50,50 union SELECT 100,100 order by 1', ''),
(8, 'dd', 'Year', 'mus.year = \'PARM\'', 0, 0, 'SELECT distinct year, year FROM YearlyUsageSummary ORDER BY 1 asc', ''),
(9, 'dd', 'Year', 'mus.year = \'PARM\'', 0, 0, 'SELECT distinct year, year FROM YearlyUsageSummary yus, PublisherPlatform pp WHERE pp.publisherPlatformID=yus.publisherPlatformID ADD_WHERE ORDER BY 1 asc', 'and (concat(\'PB_\', CAST(yus.publisherPlatformID AS CHAR)) = \'PARM\' or concat(\'PL_\', CAST(pp.platformID AS CHAR)) = \'PARM\')'),
(10, 'dd', 'Year', 'mus.year = \'PARM\'', 0, 0, 'SELECT distinct year, year FROM YearlyUsageSummary yus, PublisherPlatform pp WHERE pp.publisherPlatformID=yus.publisherPlatformID ADD_WHERE ORDER BY 1 asc', ''),
(11, 'dd', 'Year', 'yus.year = \'PARM\'', 0, 0, 'SELECT distinct year, year FROM YearlyUsageSummary yus, PublisherPlatform pp WHERE pp.publisherPlatformID=yus.publisherPlatformID ADD_WHERE ORDER BY 1 asc', 'and (concat(\'PB_\', CAST(yus.publisherPlatformID AS CHAR)) = \'PARM\' or concat(\'PL_\', CAST(pp.platformID AS CHAR)) = \'PARM\')'),
(12, 'dd', 'Date Range', '', 0, 1, 'SELECT distinct year, year FROM YearlyUsageSummary ORDER BY 1 asc', ''),
(13, 'dd', 'Date Range', '', 0, 1, 'SELECT distinct year, year FROM YearlyUsageSummary yus, PublisherPlatform pp WHERE pp.publisherPlatformID=yus.publisherPlatformID ADD_WHERE ORDER BY 1 asc', 'and (concat(\'PB_\', CAST(yus.publisherPlatformID AS CHAR)) = \'PARM\' or concat(\'PL_\', CAST(pp.platformID AS CHAR)) = \'PARM\')'),
(14, 'dd', 'Date Range', '', 0, 1, 'SELECT distinct year, year FROM YearlyUsageSummary yus, PublisherPlatform pp WHERE pp.publisherPlatformID=yus.publisherPlatformID ADD_WHERE ORDER BY 1 asc', ''),
(15, 'dd', 'Resource Type', 't.resourceType= \'PARM\'', 0, 0, 'SELECT distinct resourceType, resourceType FROM Title ORDER BY 1 asc', '');

-- --------------------------------------------------------

--
-- Table structure for table `ReportParameterMap`
--

CREATE TABLE `ReportParameterMap` (
  `reportID` int(11) NOT NULL,
  `reportParameterID` int(11) NOT NULL,
  `parentReportParameterID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ReportParameterMap`
--

INSERT INTO `ReportParameterMap` (`reportID`, `reportParameterID`, `parentReportParameterID`) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 3, 0),
(1, 12, 0),
(1, 15, 0),
(2, 1, 0),
(2, 4, 0),
(2, 13, 4),
(2, 15, 0),
(3, 5, 0),
(3, 14, 0),
(4, 6, 0),
(4, 14, 0),
(5, 1, 0),
(5, 7, 0),
(5, 4, 0),
(5, 11, 4),
(5, 15, 0),
(6, 1, 0),
(6, 4, 0),
(6, 11, 4),
(6, 15, 4);

-- --------------------------------------------------------

--
-- Table structure for table `ReportSum`
--

CREATE TABLE `ReportSum` (
  `reportID` int(11) NOT NULL,
  `reportColumnName` varchar(45) NOT NULL,
  `reportAction` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ReportSum`
--

INSERT INTO `ReportSum` (`reportID`, `reportColumnName`, `reportAction`) VALUES
(1, 'JAN', 'sum'),
(1, 'FEB', 'sum'),
(1, 'MAR', 'sum'),
(1, 'APR', 'sum'),
(1, 'MAY', 'sum'),
(1, 'JUN', 'sum'),
(1, 'JUL', 'sum'),
(1, 'AUG', 'sum'),
(1, 'SEP', 'sum'),
(1, 'OCT', 'sum'),
(1, 'NOV', 'sum'),
(1, 'DEC', 'sum'),
(1, 'QUERY_TOTAL', 'sum'),
(1, 'YTD_HTML', 'sum'),
(1, 'YTD_PDF', 'sum'),
(1, 'YTD_TOTAL', 'sum'),
(2, 'JAN', 'sum'),
(2, 'FEB', 'sum'),
(2, 'MAR', 'sum'),
(2, 'APR', 'sum'),
(2, 'MAY', 'sum'),
(2, 'JUN', 'sum'),
(2, 'JUL', 'sum'),
(2, 'AUG', 'sum'),
(2, 'SEP', 'sum'),
(2, 'OCT', 'sum'),
(2, 'NOV', 'sum'),
(2, 'DEC', 'sum'),
(2, 'QUERY_TOTAL', 'sum'),
(2, 'YTD_HTML', 'sum'),
(2, 'YTD_PDF', 'sum'),
(2, 'YTD_TOTAL', 'sum');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Report`
--
ALTER TABLE `Report`
  ADD PRIMARY KEY (`reportID`);

--
-- Indexes for table `ReportGroupingColumn`
--
ALTER TABLE `ReportGroupingColumn`
  ADD PRIMARY KEY (`reportGroupingColumnID`) USING BTREE;

--
-- Indexes for table `ReportParameter`
--
ALTER TABLE `ReportParameter`
  ADD PRIMARY KEY (`reportParameterID`);

--
-- Indexes for table `ReportParameterMap`
--
ALTER TABLE `ReportParameterMap`
  ADD PRIMARY KEY (`reportID`,`reportParameterID`);

--
-- Indexes for table `ReportSum`
--
ALTER TABLE `ReportSum`
  ADD PRIMARY KEY (`reportID`,`reportColumnName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Report`
--
ALTER TABLE `Report`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ReportGroupingColumn`
--
ALTER TABLE `ReportGroupingColumn`
  MODIFY `reportGroupingColumnID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ReportParameter`
--
ALTER TABLE `ReportParameter`
  MODIFY `reportParameterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ReportParameterMap`
--
ALTER TABLE `ReportParameterMap`
  MODIFY `reportParameterID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
