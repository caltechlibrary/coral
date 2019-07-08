<?php

// @file usage/sushiSchedule.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();

$util = new Utility();
$config = new Configuration();


// find sushi services which need to be run today
$day = date("j");
$sushiServices = new SushiService();
$sushiServicesArray = $sushiServices->getByDayOfMonth($day);

$emailLog = "<h2>" . count($sushiServicesArray) . _(" SUSHI runs found for day: ") . $day . "</h2>";

foreach ($sushiServicesArray as $sushiService){
	$sushiService->setImportDates();
	$emailLog .= "<h3>" . $sushiService->getServiceProvider() . "</h3>";

 	//try to run!
	try {
		$emailLog .= nl2br($sushiService->runAll($_POST['overwritePlatform']));
	} catch (Exception $e) {
		$emailLog .= nl2br($e->getMessage());
	}

}


//if more than one run, send email
if (count($sushiServicesArray) > 0) {

	$emailLog .= "<br /><br />" . _("Log in to ") . "<a href='" . $util->getPageURL() . "sushi.php'>" . _("Sushi Administration") . "</a>" . _(" for more information.");

	//send email to email addresses listed in DB
	$logEmailAddress = new LogEmailAddress();
	$emailAddresses = array();

	foreach ($logEmailAddress->allAsArray() as $emailAddress){
		$emailAddresses[] = $emailAddress['emailAddress'];
	}

	if (count($emailAddresses) > 0){
		$email = new Email();
		$email->to 			= implode(", ", $emailAddresses);
		$email->subject		= _("SUSHI Scheduled run log for ") . format_date(date) . " - " . count($sushiServicesArray) . _(" runs");
		$email->message		= $emailLog;


		if ($email->send()) {
			echo _("Run complete.  Log has been emailed to ") . implode(", ", $emailAddresses);
		}else{
			echo _("Email to ") . implode(", ", $emailAddresses) . _(" Failed!");
		}
	}

}else{
	echo _("Nothing to see here!  (no sushi scheduled today)");
}


echo "<br /><br />" . $emailLog;

?>
