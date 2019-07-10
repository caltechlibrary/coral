<?php

// @file organizations/issues_export.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();

$dates = new Dates();

$organizationID = $_GET['organizationID'];

$export = new Export();

$issueLogObj = new IssueLog();
$issues = $issueLogObj->allExpandedAsArray($organizationID);

$replace = array("/", "-");
$excelfile = "issues_export_" . str_replace( $replace, "_", $dates->formatDate( date( 'Y-m-d' ) ) ).".csv";

header("Pragma: public");
header("Content-type: text/csv");
header("Content-Disposition: attachment; filename=\"" . $excelfile . "\"");

echo $export->arrayToCsvRow(array("Issues Export " . $dates->formatDate( date( 'Y-m-d' ))));

$columnHeaders = array(
  "Organization",
  "Issue Type",
  "Start Date",
  "End Date",
  "Issue Text"
);
echo $export->arrayToCsvRow($columnHeaders);

foreach($issues as $issue) {

	if ($resource['updateDate'] == "0000-00-00"){
		$updateDateFormatted="";
	}else{
		$updateDateFormatted=$dates->formatDate($resource['updateDate']);
	}
  $issueValues = array(
    $issue['name'],
    $issue['shortName'],
    $issue['issueStartDate'],
    $issue['issueEndDate'],
    preg_replace('/\s+/', ' ', trim($issue['noteText'])),
  );

	echo $export->arrayToCsvRow($issueValues);
}
?>
