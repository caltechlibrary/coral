<?php
$resourceID = $_GET['resourceID'];
$resourceAcquisitionID = $_GET['resourceAcquisitionID'];
$archivedFlag = (!empty($_GET['archived']) && $_GET['archived'] == 1) ? true:false;

$resource = new Resource(new NamedArguments(array('primaryKey' => $resourceID)));
$resourceAcquisition = new ResourceAcquisition(new NamedArguments(array('primaryKey' => $resourceAcquisitionID)));
$util = new Utility();
$html = new Html();

//display any organization level downtimes for the resource
$organizationArray = $resource->getOrganizationArray();

if (count($organizationArray) > 0) {
	echo '<h3 class="text-center">' . _("Organizational") . '</h3>';

	$downtimedOrgs = array();
	foreach ($organizationArray as $orgData) {
		if (!in_array($orgData['organizationID'],$downtimedOrgs)) {
			$organization = new Organization(new NamedArguments(array('primaryKey' => $orgData['organizationID'])));

			$orgDowntimes = $organization->getDowntime($archivedFlag);

			if(count($orgDowntimes) > 0) {
				foreach ($orgDowntimes as $downtime) {
					echo $html->generateDowntimeHtml($downtime);
				}
			} else {
				echo "<br><p>" . _("There are no organization level downtimes.") . "</p><br>";
			}

			$orgDowntimes = null;
			$downtimedOrgs[] = $orgData['organizationID'];
		}
	}
}

//display any resource level downtimes for the resource (shows any other resources associated with the downtime, too)
$resourceDowntimes = $resourceAcquisition->getDowntime($archivedFlag);
echo '<h3 class="text-center">' . _("Resources") . '</h3>';
if(count($resourceDowntimes) > 0) {
	foreach ($resourceDowntimes as $downtime) {
		echo $html->generateDowntimeHtml($downtime);
	}
} else {
	echo "<br><p>" . _("There are no order level downtimes.") . "</p><br>";
}
?>
