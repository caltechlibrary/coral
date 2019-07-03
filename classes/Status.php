<?php

// @file classes/Status.php

class Status extends DatabaseObject {

	protected function defineRelationships() {}

	protected function overridePrimaryKeyName() {}



	//returns number of children for this particular contact role
	public function getNumberOfChildren(){

		$query = "SELECT count(*) childCount FROM Resource WHERE statusID = '" . $this->statusID . "';";

		$result = $this->db->processQuery($query, 'assoc');

		return $result['childCount'];

	}


  // @TODO refactor for common class
  //returns number of children for this particular status
  public function getNumberOfChildrenLicense(){
    $query = "SELECT count(*) childCount FROM License WHERE statusID = '" . $this->statusID . "';";
    $result = $this->db->processQuery($query, 'assoc');
    return $result['childCount'];
  }


	//returns statusID which fits the name parameter passed in
	public function getIDFromName($name){

		$query = "SELECT statusID FROM Status WHERE upper(shortName) like '%" . strtoupper($name) . "%' LIMIT 0,1;";

		$result = $this->db->processQuery($query, 'assoc');

		return $result['statusID'];

	}


}

?>
