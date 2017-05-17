ALTER TABLE `ResourceNote` MODIFY `updateDate` timestamp NOT NULL default CURRENT_TIMESTAMP;

ALTER TABLE `ResourceStep` ADD `archivingDate` DATETIME NULL AFTER `stepEndDate`;
ALTER TABLE `ResourceStep` ADD `mailReminderDelay` INT UNSIGNED NULL;
ALTER TABLE `ResourceStep` ADD `note` TEXT NULL;

INSERT INTO `ResourceType` (`resourceTypeID`, `shortName`, `includeStats`) VALUES (NULL, 'Any', NULL);
INSERT INTO `ResourceFormat` (`resourceFormatID`, `shortName`) VALUES (NULL, 'Any');
INSERT INTO `AcquisitionType` (`acquisitionTypeID`, `shortName`) VALUES (NULL, 'Any');
