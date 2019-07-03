<?php

// @file classes/AuthorizedSite.php

class AuthorizedSite extends DatabaseObject {

	protected function defineRelationships() {}

	protected function overridePrimaryKeyName() {}

	//returns recordset of AuthorizedSites
	public function getAllAuthorizedSite(){

		$config = new Configuration;

		//if the Resource module is installed get the Resource database
		if ($config->settings->resourcesModule == 'Y') {
			$dbName = $config->settings->resourcesDatabaseName;

			$query = "SELECT * FROM " . $dbName . ".`AuthorizedSite` order by `shortName`";

			$result = $this->db->processQuery($query, 'assoc');
		}

		return $result;
	}

	//returns number of children for this particular contact role
	public function getNumberOfChildren(){

		$query = "SELECT count(*) childCount FROM ResourceAuthorizedSiteLink WHERE authorizedSiteID = '" . $this->authorizedSiteID . "';";

		$result = $this->db->processQuery($query, 'assoc');

		return $result['childCount'];

	}

}

?>
