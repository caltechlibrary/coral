<?php

// @file resources/export.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$dates = new Dates();

function escape_csv($value) {
  // replace \n with \r\n
  $value = preg_replace("/(?<!\r)\n/", "\r\n", $value);
  // escape quotes
  $value = str_replace('"', '""', $value);
  return '"'.$value.'"';
}

function array_to_csv_row($array) {
  $escaped_array = array_map("escape_csv", $array);
  return implode(",",$escaped_array)."\r\n";
}

$queryDetails = Resource::getSearchDetails();
$whereAdd = $queryDetails["where"];
$searchDisplay = $queryDetails["display"];
$orderBy = $queryDetails["order"];

//get the results of the query into an array
$resourceObj = new Resource();
$resourceArray = array();
$resourceArray = $resourceObj->export($whereAdd, $orderBy);



$replace = array("/", "-");
$excelfile = "resources_export_" . str_replace( $replace, "_", $dates->formatDate( date( 'Y-m-d' ) ) ).".csv";

header("Pragma: public");
header("Content-type: text/csv");
header("Content-Disposition: attachment; filename=\"" . $excelfile . "\"");

$columnHeaders = array(
  _("Record ID"),
  _("Name"),
  _("Type"),
  _("Format"),
  _("Date Created"),
  _("User Created"),
  _("Date Updated"),
  _("User Updated"),
  _("Status"),
  _("ISSN/ISBN"),
  _("Resource URL"),
  _("Alt URL"),
  _("Organizations"),
  _("Year"),
  _("Fund Name"),
  _("Fund Code"),
  _("Tax excluded"),
  _("Rate"),
  _("Tax included"),
  _("Payment"),
  _("Currency"),
  _("Details"),
  _("Order Type"),
  _("Cost Note"),
  _("Invoice"),
  _("Aliases"),
  _("Parent Record"),
  _("Child Record"),
  _("Acquisition Type"),
  _("Order Number"),
  _("System Number"),
  _("Purchasing Sites"),
  _("Sub Start"),
  _("Current Sub End"),
  _("Subscription Alert Enabled"),
  _("License Names"),
  _("License Status"),
  _("Authorized Sites"),
  _("Administering Sites"),
  _("Authentication Type"),
  _("Access Method"),
  _("Storage Location"),
  _("Simultaneous User Limit"),
  _("Coverage"),
  _("Username"),
  _("Password"),
  _("Cataloging Type"),
  _("Cataloging Status"),
  _("Catalog Record Set Identifier"),
  _("Catalog Record Source URL"),
  _("Catalog Records Available"),
  _("Catalog Records Loaded"),
  _("OCLC Holdings Updated")
);

echo array_to_csv_row(array(_("Resource Record Export") . " " . $dates->formatDate( date( 'Y-m-d' ))));
if (!$searchDisplay) {
  $searchDisplay = array(_("All Resource Records"));
}
echo array_to_csv_row(array(implode('; ', $searchDisplay)));
echo array_to_csv_row($columnHeaders);

foreach($resourceArray as $resource) {

	$updateDateFormatted=$dates->normalizeDate($resource['updateDate']);
  $resourceValues = array(
	  $resource['resourceID'],
    $resource['titleText'],
    $resource['resourceType'],
    $resource['resourceFormat'],
    $dates->formatDate($resource['createDate']),
    $resource['createName'],
    $updateDateFormatted,
    $resource['updateName'],
    $resource['status'],
    $resource['isbnOrIssn'],
    $resource['resourceURL'],
    $resource['resourceAltURL'],
    $resource['organizationNames'],
    $resource['year'],
    $resource['fundName'],
    $resource['fundCode'],
    $resource['priceTaxExcluded'],
    $resource['taxRate'],
    $resource['priceTaxIncluded'],
    $resource['paymentAmount'],
    $resource['currencyCode'],
    $resource['costDetails'],
    $resource['orderType'],
    $resource['costNote'],
    $resource['invoiceNum'],
    $resource['aliases'],
    $resource['parentResources'],
    $resource['childResources'],
    $resource['acquisitionType'],
    $resource['orderNumber'],
    $resource['systemNumber'],
    $resource['purchasingSites'],
    $resource['subscriptionStartDate'],
    $resource['subscriptionEndDate'],
    ($resource['subscriptionAlertEnabledInd'] ? 'Y' : 'N'),
    $resource['licenseNames'],
    $resource['licenseStatuses'],
    $resource['authorizedSites'],
    $resource['administeringSites'],
    $resource['authenticationType'],
    $resource['accessMethod'],
    $resource['storageLocation'],
    $resource['userLimit'],
    $resource['coverageText'],
    $resource['authenticationUserName'],
    $resource['authenticationPassword'],
    $resource['catalogingType'],
    $resource['catalogingStatus'],
    $resource['recordSetIdentifier'],
    $resource['bibSourceURL'],
    $resource['numberRecordsAvailable'],
    $resource['numberRecordsLoaded'],
    ($resource['hasOclcHoldings'] ? 'Y' : 'N')
  );

	echo array_to_csv_row($resourceValues);
}
?>
