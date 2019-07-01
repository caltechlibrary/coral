<?php

// @file resources/resources/cataloging_update.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/..');

include_once '../user.php';

$resourceID = $_POST['resourceID'];
$resourceAcquisitionID = $_POST['resourceAcquisitionID'];

//get this resource
$resource = new Resource(new NamedArguments(array('primaryKey' => $resourceID)));
$resourceAcquisition = new ResourceAcquisition(new NamedArguments(array('primaryKey' => $resourceAcquisitionID)));

$resource->updateLoginID 		= $loginID;
$resource->updateDate			= date( 'Y-m-d H:i:s' );

$_POST['hasOclcHoldings'] = isset($_POST['hasOclcHoldings']) ? intval($_POST['hasOclcHoldings']) : null;

foreach (array('bibSourceURL','catalogingStatusID','catalogingTypeID','numberRecordsAvailable','numberRecordsLoaded','recordSetIdentifier','hasOclcHoldings') as $field) {
  $resourceAcquisition->$field = $_POST[$field];
}
//debug($_POST);
try {
	$resourceAcquisition->save();

} catch (Exception $e) {
	echo $e->getMessage();
}

?>
