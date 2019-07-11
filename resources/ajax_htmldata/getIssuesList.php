<?php
$resourceID = $_GET['resourceID'];
$resourceAcquisitionID = $_GET['resourceAcquisitionID'];
$archivedFlag = (!empty($_GET['archived']) && $_GET['archived'] == 1) ? true:false;

$resource = new Resource(new NamedArguments(array('primaryKey' => $resourceID)));
$resourceAcquisition = new ResourceAcquisition(new NamedArguments(array('primaryKey' => $resourceAcquisitionID)));
$util = new Utility();
$html = new Html();

//display any organization level issues for the resource
$organizationArray = $resource->getOrganizationArray();

if (count($organizationArray) > 0) {
	echo '<h3 class="text-center">' . _("Organizational") . '</h3>';

	$issuedOrgs = array();
	foreach ($organizationArray as $orgData) {
		if (!in_array($orgData['organizationID'],$issuedOrgs)) {
			$organization = new Organization(new NamedArguments(array('primaryKey' => $orgData['organizationID'])));
			$orgIssues = $organization->getIssues($archivedFlag);

			if(count($orgIssues) > 0) {
				foreach ($orgIssues as $issue) {
					echo $html->generateIssueHtml($issue, array(array('name' => $orgData['organization'], 'id' => $orgData['organizationID'], 'entityType' => 1)));
				}
			}

			$orgIssues = null;
			$issuedOrgs[] = $orgData['organizationID'];
		}
	}
	if (count($issuedOrgs) < 1) {
		echo "<br><p>" . _("There are no organization level issues.") . "</p><br>";
	}
}

//display any resource level issues for the resource (shows any other resources associated with the issue, too)
$resourceIssues = $resourceAcquisition->getIssues($archivedFlag);
echo '<h3 class="text-center">' . _("Resources") . '</h3>';
if(count($resourceIssues) > 0) {
	foreach ($resourceIssues as $issue) {
		$associatedEntities = array();
		if ($associatedResources = $issue->getAssociatedResources()) {
			foreach ($associatedResources as $resource) {
				$associatedEntities[] = array("name"=>$resource->titleText,"id"=>$resource->resourceID,"entityType"=>2);
			}
		}
		echo $html->generateIssueHtml($issue, $associatedEntities);
	}
} else {
	echo "<br><p>" . _("There are no order level issues.") . "</p><br>";
}
?>
