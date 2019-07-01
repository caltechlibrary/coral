<?php

// @file resources/sendAlerts.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$util = new Utility();
$config = new Configuration();

if ($config->settings->enableAlerts == 'Y'){

	$alertDaysInAdvance = new AlertDaysInAdvance();
	//returns array of all days in advance objects
	$alertDaysArray = $alertDaysInAdvance->all();

	$resourceIDArray = array();

	//loop through each of the days, e.g. 30, 60, 90
	foreach ($alertDaysArray as $alertDays){
		//get resources that fit this criteria
		if (is_numeric($alertDays->daysInAdvanceNumber)){
			foreach($alertDays->getResourcesToAlert() as $resource){
				$resourceIDArray[] = $resource->resourceID;
			}
		}

	}


	if (count($resourceIDArray) > 0){
		//now get unique resource IDs out
		$resourceIDArray = array_unique($resourceIDArray);

		//now loop through each resource and send the email alert
		foreach ($resourceIDArray as $resourceID){

			$resource = new Resource(new NamedArguments(array('primaryKey' => $resourceID)));

			$sendToArray = array();

			//determine who to send the email to
			$alertEmailAddress = new AlertEmailAddress();

			foreach($alertEmailAddress->allAsArray() as $alertEmail){
				$sendToArray[] = $alertEmail['emailAddress'];
			}


			//formulate email to be sent
			$email = new Email();
			$email->to = implode(", ", $sendToArray);
			$email->message = $util->createMessageFromTemplate('Alert', $resourceID, $resource->titleText, '', '', '');
			$email->subject		= "CORAL Alert: " . $resource->titleText;

			$email->send();

		}
	} else {
		echo _("No Resources found fitting alert day criteria");
	}

	//Get all Issues that should be alerted today
	$Issue = new Issue();
	$alertableIssuesArray = $Issue->getAllAlertable();

	//If we have alertable issues then loop over them
	if (count($alertableIssuesArray) > 0){
		foreach($alertableIssuesArray as $alertableIssue) {
			//start building the email body
			$emailMessage = _("This is a reminder that this issue needs to be revisited.\r\n\r\n
			Body: {$alertableIssue['bodyText']}\r\n\r\n
			Applies To: {$alertableIssue['appliesto']}\r\n
			\r\n\r\nContacts: \r\n\r\n
			{$alertableIssue['contacts']}\r\n");

			foreach(explode(",", $alertableIssue['CCs']) as $emailAddr) {
				mail($emailAddr, _("Reminder: {$alertableIssue['subjectText']}"),$emailMessage);
			}
		}
	} else {
		echo _("No Issues found fitting alert day criteria");
	}

    // Workflow alerts
    $workflowObj = new Workflow();
    $query = "select * from ResourceStep where DATE_ADD(stepStartDate, INTERVAL mailReminderDelay DAY) BETWEEN DATE_ADD(NOW(), INTERVAL -1 DAY) AND NOW() AND mailReminderDelay IS NOT NULL";
    $dbresults = $workflowObj->db->processQuery($query, 'assoc');

    if (isset($dbresults['resourceID'])) {
        $results[0] = $dbresults;
    } else {
        $results = $dbresults;
    }

    foreach ($results as $result) {
            $resource = new Resource(new NamedArguments(array('primaryKey' => $result['resourceID'])));
            $userGroup = new UserGroup(new NamedArguments(array('primaryKey' => $result['userGroupID'])));
            $sendToArray = array($userGroup->emailAddress);
            $users = $userGroup->getUsers();
            foreach ($users as $user) {
                $sendToArray[] = $user->emailAddress;
            }
            $email = new Email();
            $email->to = implode(", ", $sendToArray);
            $email->message = $util->createMessageFromTemplate('DueStep', $resource->resourceID, $resource->titleText, $result['stepName'], '', '');
            $email->subject     = _("CORAL Alert: workflow step for ressource ") . $resource->titleText . _(" is due");
            $email->send();
    }


} else {
	echo _("Alerts not enabled in configuration.ini file");
}

?>
