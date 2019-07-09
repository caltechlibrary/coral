-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 09, 2019 at 12:30 AM
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
-- Database: `coral_management`
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
-- Table structure for table `Consortium`
--

CREATE TABLE `Consortium` (
  `consortiumID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Consortium`
--

INSERT INTO `Consortium` (`consortiumID`, `shortName`) VALUES
(1, 'CORAL Documentation');

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
  `parentDocumentID` int(10) UNSIGNED DEFAULT NULL,
  `description` tinytext,
  `revisionDate` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DocumentNote`
--

CREATE TABLE `DocumentNote` (
  `documentNoteID` int(11) NOT NULL,
  `licenseID` int(11) NOT NULL,
  `documentID` int(11) DEFAULT '0',
  `documentNoteTypeID` int(11) NOT NULL,
  `body` text NOT NULL,
  `createDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DocumentNoteType`
--

CREATE TABLE `DocumentNoteType` (
  `documentNoteTypeID` int(11) NOT NULL,
  `shortName` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `DocumentNoteType`
--

INSERT INTO `DocumentNoteType` (`documentNoteTypeID`, `shortName`) VALUES
(9, 'General');

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
(1, 'Checklist');

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
  `createDate` datetime DEFAULT NULL,
  `typeID` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `statusLoginID` varchar(50) DEFAULT NULL,
  `createLoginID` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `license_consortium`
--

CREATE TABLE `license_consortium` (
  `id` int(11) NOT NULL,
  `licenseID` int(11) DEFAULT NULL,
  `consortiumID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='							';

-- --------------------------------------------------------

--
-- Table structure for table `Organization`
--

CREATE TABLE `Organization` (
  `organizationID` int(10) UNSIGNED NOT NULL,
  `shortName` tinytext NOT NULL
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
-- Table structure for table `Qualifier`
--

CREATE TABLE `Qualifier` (
  `qualifierID` int(10) UNSIGNED NOT NULL,
  `expressionTypeID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Table structure for table `Status`
--

CREATE TABLE `Status` (
  `statusID` int(10) UNSIGNED NOT NULL,
  `shortName` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Type`
--

CREATE TABLE `Type` (
  `typeID` int(11) NOT NULL,
  `shortName` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  ADD PRIMARY KEY (`attachmentID`),
  ADD KEY `licenseID` (`licenseID`);

--
-- Indexes for table `AttachmentFile`
--
ALTER TABLE `AttachmentFile`
  ADD PRIMARY KEY (`attachmentFileID`);

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
-- Indexes for table `DocumentNote`
--
ALTER TABLE `DocumentNote`
  ADD PRIMARY KEY (`documentNoteID`),
  ADD KEY `licenseID` (`licenseID`,`documentNoteTypeID`),
  ADD KEY `documentID` (`documentID`);

--
-- Indexes for table `DocumentNoteType`
--
ALTER TABLE `DocumentNoteType`
  ADD PRIMARY KEY (`documentNoteTypeID`);

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
-- Indexes for table `license_consortium`
--
ALTER TABLE `license_consortium`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Organization`
--
ALTER TABLE `Organization`
  ADD PRIMARY KEY (`organizationID`);

--
-- Indexes for table `Privilege`
--
ALTER TABLE `Privilege`
  ADD PRIMARY KEY (`privilegeID`);

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
-- Indexes for table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`typeID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`loginID`);

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
-- AUTO_INCREMENT for table `Consortium`
--
ALTER TABLE `Consortium`
  MODIFY `consortiumID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Document`
--
ALTER TABLE `Document`
  MODIFY `documentID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DocumentNote`
--
ALTER TABLE `DocumentNote`
  MODIFY `documentNoteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DocumentNoteType`
--
ALTER TABLE `DocumentNoteType`
  MODIFY `documentNoteTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `DocumentType`
--
ALTER TABLE `DocumentType`
  MODIFY `documentTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `expressionTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `License`
--
ALTER TABLE `License`
  MODIFY `licenseID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `license_consortium`
--
ALTER TABLE `license_consortium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Organization`
--
ALTER TABLE `Organization`
  MODIFY `organizationID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Privilege`
--
ALTER TABLE `Privilege`
  MODIFY `privilegeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Qualifier`
--
ALTER TABLE `Qualifier`
  MODIFY `qualifierID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `signatureTypeID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Status`
--
ALTER TABLE `Status`
  MODIFY `statusID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Type`
--
ALTER TABLE `Type`
  MODIFY `typeID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
