<?php

// @file resources/dashboard_export.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$dates = new Dates();
    include_once 'util.php';

    $year = $_POST['year'];
    if (!$year) $year = date('Y');
    $resourceTypeID = $_POST['resourceTypeID'];
    $acquisitionTypeID = $_POST['acquisitionTypeID'];
    $orderTypeID = $_POST['orderTypeID'];
    $costDetailsID = $_POST['costDetailsID'];
    $subjectID = $_POST['subjectID'];
    $groupBy = $_POST['groupBy'];
    $csv = $_POST['csv'];

    $dashboard = new Dashboard();
    $query = $dashboard->getQuery($resourceTypeID, $year, $acquisitionTypeID, $orderTypeID, $subjectID, $costDetailsID, $groupBy);
    $results = $dashboard->getResults($query);
    if ($groupBy == "GS.shortName") $groupBy = "generalSubject";

    $export = new Export();

    $replace = array("/", "-");
    $excelfile = "dashboard_export_" . str_replace( $replace, "_", $dates->formatDate( date( 'Y-m-d' ) ) ).".csv";

    header("Pragma: public");
    header("Content-type: text/csv");
    header("Content-Disposition: attachment; filename=\"" . $excelfile . "\"");
    echo _("Dashboard Statistics Export") . " " . date('Y-m-d') . "\r\n";
    $query = $dashboard->displayExportParameters($resourceTypeID, $year, null, $acquisitionTypeID, $orderTypeID, $subjectID, $costDetailsID, $groupBy);
    echo "\r\n";

    $columnHeaders = array(
      _("Record ID"),
      _("Name"),
      _("Resource Type"),
      _("Subject"),
      _("Acquisition Type"),
      _("Payment amount"),
    );
    echo $export->arrayToCsvRow($columnHeaders);

    $count = sizeof($results);
    $i = 1;
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
                $result['paymentAmount']
            );
        } else {
            $dashboardValues = array($i == $count ? _('Total') : _("Sub-Total:") . " " . $result[$groupBy], '', '', '', '', $result['paymentAmount']);
        }
        echo $export->arrayToCsvRow($dashboardValues);
        $i++;
    }
?>
