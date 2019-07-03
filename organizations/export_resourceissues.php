<?php

// @file organizations/export_resourceissues.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();

$organizationID = $_GET['organizationID'];
$archivedFlag = (!empty($_GET['archived']) && $_GET['archived'] == 1) ? true:false;

$organization = new Organization(new NamedArguments(array('primaryKey' => $organizationID)));

$exportIssues = array();


$exportIssues = $organization->getExportableIssues($archivedFlag);

header("Pragma: public");
header("Content-type: text/csv");
header("Content-Disposition: attachment; filename=\"issues.csv\"");

if (count($exportIssues) > 0) {
	ob_clean();
	$out = fopen('php://output', 'w');

	fputcsv($out,array_keys($exportIssues[0]));

	foreach ($exportIssues as $issue) {
		fputcsv($out, $issue);
	}
	fclose($out);
}
?>
