<?php

// @file resources/dashboard_yearly_costs_exports.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$dates = new Dates();

    $startYear = $_POST['startYear'];
    if (!$startYear) $startYear = date('Y');

    $endYear = $_POST['endYear'];
    if (!$endYear) $endYear = date('Y');

    $resourceTypeID = $_POST['resourceTypeID'];
    $acquisitionTypeID = $_POST['acquisitionTypeID'];
    $orderTypeID = $_POST['orderTypeID'];
    $subjectID = $_POST['subjectID'];
    $costDetailsID = $_POST['costDetailsID'];
    $groupBy = $_POST['groupBy'];
    $csv = $_POST['csv'];

    $dashboard = new Dashboard();
    $query = $dashboard->getQueryYearlyCosts($resourceTypeID, $startYear, $endYear, $acquisitionTypeID, $orderTypeID, $subjectID, $costDetailsID, $groupBy);
    $results = $dashboard->getResults($query);
    if ($groupBy == "GS.shortName") $groupBy = "generalSubject";

    $export = new Export();

    $replace = array("/", "-");
    $excelfile = "dashboard_export_" . str_replace( $replace, "_", $dates->formatDate( date( 'Y-m-d' ) ) ).".csv";

    header("Pragma: public");
    header("Content-type: text/csv");
    header("Content-Disposition: attachment; filename=\"" . $excelfile . "\"");
    echo _("Dashboard Yearly Costs Export") . " " . date('Y-m-d') . "\r\n";
    $query = $dashboard->displayExportParameters($resourceTypeID, $startYear, $endYear, $acquisitionTypeID, $orderTypeID, $subjectID, $costDetailsID, $groupBy);
    echo "\r\n";

    $costDetails = new CostDetails();
    $costDetailsArray = $costDetails->allAsArray();

    $columnHeaders = array(
      _("Record ID"),
      _("Name"),
      _("Resource Type"),
      _("Subject"),
      _("Acquisition Type"),
    );
    for ($i = $startYear; $i <= $endYear; $i++) {
        foreach ($costDetailsArray as $costDetail) {
            if ($costDetailsID && $costDetail['costDetailsID'] != $costDetailsID) continue;
            $columnHeaders[] = $costDetail['shortName'] . " / $i";
        }
    }
    echo $export->arrayToCsvRow($columnHeaders);

    $count = sizeof($results);
    $currentCount = 1;
    foreach ($results as $result) {
        $subject = $result['generalSubject'] && $result['detailedSubject'] ?
            $result['generalSubject'] . " / " . $result['detailedSubject'] :
            $result['generalSubject'] . $result['detailedSubject'];

        if ($result['resourceID'] != null) {
            $dashboardValues = array(
                $result['resourceID'],
                $result['titleText'],
                $result['resourceType'],
                $subject,
                $result['acquisitionType'],
            );
        } else {
            $dashboardValues = array($currentCount == $count ? _('Total') : _("Sub-Total:") . " " . $result[$groupBy], '', '', '', '');
        }
        for ($i = $startYear; $i <= $endYear; $i++) {
            foreach ($costDetailsArray as $costDetail) {
                if ($costDetailsID && $costDetail['costDetailsID'] != $costDetailsID) continue;
                $dashboardValues[] =  $result[$costDetail['shortName'] . " / $i"];
            }
        }

        echo $export->arrayToCsvRow($dashboardValues);
        $currentCount++;
    }
?>
