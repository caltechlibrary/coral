<?php

// @file reports/ajax_htmldata.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

ob_start();

$action = $_GET['action'];

if ($action === 'getReportParameters') {
    $report = ReportFactory::makeReport($_GET['reportID']);

    // get parameters
    Parameter::$ajax_parmValues = array();

    foreach ( $report->getParameters() as $parm ) {
        $parm->form();
    }
} else if ($action === 'getChildParameters') {
    $parm = ParameterFactory::makeParam($_GET['reportID'],$_GET['parentReportParameterID']);
    $parm->ajaxGetChildParameters();
} else if ($action === 'getChildUpdate') {
    $parm = ParameterFactory::makeParam($_GET['reportID'],$_GET['reportParameterID']);
    $parm->ajaxGetChildUpdate();
} else {
    echo _("Action $action not set up!");
}

ob_end_flush();
?>
