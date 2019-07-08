<?php

// @file classes/User.php

class User extends DatabaseObject {

  public function allAsArray() {
    $query = "SELECT * FROM User ORDER BY lastName, loginID";
    $result = $this->db->processQuery($query, 'assoc');

    $resultArray = array();
    $rowArray = array();

    if (isset($result['loginID'])){
      foreach (array_keys($result) as $attributeName) {
        $rowArray[$attributeName] = $result[$attributeName];
      }
      array_push($resultArray, $rowArray);
    }else{
      foreach ($result as $row) {
        foreach (array_keys($this->attributeNames) as $attributeName) {
          $rowArray[$attributeName] = $row[$attributeName];
        }
        array_push($resultArray, $rowArray);
      }
    }

    return $resultArray;
  }

  // @TODO refactor for common class
	public function allAsArrayAuth() {
		$query = "SELECT * FROM User ORDER BY 1";
		$result = $this->db->processQuery($query, 'assoc');

		$resultArray = array();
		$rowArray = array();

		if ($result['loginID']){
			foreach (array_keys($result) as $attributeName) {
				$rowArray[$attributeName] = $result[$attributeName];
			}
			array_push($resultArray, $rowArray);
		}else{
			foreach ($result as $row) {
				foreach (array_keys($this->attributeNames) as $attributeName) {
					$rowArray[$attributeName] = $row[$attributeName];
				}
				array_push($resultArray, $rowArray);
			}
		}

		return $resultArray;
	}


  //used for displaying add/update/delete links
  public function canEdit(){
    $privilege = new Privilege(new NamedArguments(array('primaryKey' => $this->privilegeID)));

    if ((mb_strtoupper($privilege->shortName) == 'ADD/EDIT') || (mb_strtoupper($privilege->shortName) == 'ADMIN')){
      return true;
    }else{
      return false;
    }

  }

  //used to formulate display name in case firstname/last name isn't set up or user doesn't exist for drop down
  //format lastname {comma} firstname
  public function getDDDisplayName(){

    if ($this->firstName){
      return $this->lastName . ", " . $this->firstName;
    }else if ($this->loginID){
      return $this->loginID;
    }
  }

  //used to formulate display name in case firstname/last name isn't set up or user doesn't exist
  //format: firstname {space} lastname
  public function getDisplayName(){

    if ($this->firstName){
      return $this->firstName . " " . $this->lastName;
    }else if ($this->loginID){
      return $this->loginID;
    }else{
      return false;
    }
  }

  public function getOpenSession(){

    $util = new Utility();

    return $util->getSessionCookie();

  }

  //returns array of resource arrays that are in the outstanding queue for this user
  public function getOutstandingTasks(){

    $status = new Status();
    $excludeStatus =  Array();
    $excludeStatus[]=$status->getIDFromName('complete');
    $excludeStatus[]=$status->getIDFromName('archive');

    if (count($excludeStatus) > 1){
      $whereAdd = "AND R.statusID NOT IN (" . implode(",", $excludeStatus) . ")";
    }else if (count($excludeStatus) == 1){
      $whereAdd = "AND R.statusID != '" . implode("", $excludeStatus) . "'";
    }else{
      $whereAdd = "";
    }

    $query = "SELECT DISTINCT R.resourceID, date_format(createDate, '%c/%e/%Y') createDate, titleText, statusID,
            RA.resourceAcquisitionID, RA.acquisitionTypeID,
            date_format(subscriptionStartDate, '%c/%e/%Y') subscriptionStartDate,
            date_format(subscriptionEndDate, '%c/%e/%Y') subscriptionEndDate
      FROM Resource R, ResourceAcquisition RA, ResourceStep RS, UserGroupLink UGL
      WHERE R.resourceID = RA.resourceID
            AND RA.resourceAcquisitionID = RS.resourceAcquisitionID
      AND RS.userGroupID = UGL.userGroupID
      AND UGL.loginID = '" . $this->loginID . "'
      AND (RS.stepEndDate IS NULL OR RS.stepEndDate = '0000-00-00')
      AND (RS.stepStartDate IS NOT NULL AND RS.stepStartDate != '0000-00-00')
      " . $whereAdd . "
      ORDER BY 1 desc";

    $result = $this->db->processQuery($query, 'assoc');

    $resourceArray = array();

    //need to do this since it could be that there's only one request and this is how the dbservice returns result
    if (isset($result['resourceID'])){

      foreach (array_keys($result) as $attributeName) {
        $resultArray[$attributeName] = $result[$attributeName];
      }

      array_push($resourceArray, $resultArray);

    }else{
      foreach ($result as $row) {
        $resultArray = array();
        foreach (array_keys($row) as $attributeName) {
          $resultArray[$attributeName] = $row[$attributeName];
        }

        array_push($resourceArray, $resultArray);
      }
    }


    return $resourceArray;
  }

  //returns array of tasks that are in the outstanding queue for this resource and user
  public function getOutstandingTasksByResource($outstandingResourceID){

    $status = new Status();
    $excludeStatus =  Array();
    $excludeStatus[]=$status->getIDFromName('complete');
    $excludeStatus[]=$status->getIDFromName('archive');

    if (count($excludeStatus) > 1){
      $whereAdd = "AND R.statusID NOT IN (" . implode(",", $excludeStatus) . ")";
    }else if (count($excludeStatus) == 1){
      $whereAdd = "AND R.statusID != '" . implode("", $excludeStatus) . "'";
    }else{
      $whereAdd = "";
    }

    $query = "SELECT DISTINCT RS.stepName, date_format(stepStartDate, '%c/%e/%Y') startDate
      FROM Resource R, ResourceAcquisition RA, ResourceStep RS, UserGroupLink UGL
      WHERE R.resourceID = RA.resourceID
            AND RA.resourceAcquisitionID = RS.resourceAcquisitionID
      AND RS.userGroupID = UGL.userGroupID
      AND UGL.loginID = '" . $this->loginID . "'
      AND R.resourceID = '" . $outstandingResourceID . "'
      AND (RS.stepEndDate IS NULL OR RS.stepEndDate = '0000-00-00')
      AND (RS.stepStartDate IS NOT NULL AND RS.stepStartDate != '0000-00-00')
      " . $whereAdd . "
      ORDER BY 1 desc LIMIT 0,25";

    $result = $this->db->processQuery($query, 'assoc');

    $resourceArray = array();

    //need to do this since it could be that there's only one request and this is how the dbservice returns result
    if (isset($result['stepName'])){

      foreach (array_keys($result) as $attributeName) {
        $resultArray[$attributeName] = $result[$attributeName];
      }

      array_push($resourceArray, $resultArray);

    }else{
      foreach ($result as $row) {
        $resultArray = array();
        foreach (array_keys($row) as $attributeName) {
          $resultArray[$attributeName] = $row[$attributeName];
        }

        array_push($resourceArray, $resultArray);
      }
    }


    return $resourceArray;
  }

  public function getRememberLogin(){

    $util = new Utility();

    return $util->getRememberLogin();

  }

  //returns array of resource records that are saved/submitted for this user
  public function getResourcesInQueue($statusName){

    $status = new Status();
    $statusID = $status->getIDFromName($statusName);

    $query = "SELECT resourceID, date_format(createDate, '%c/%e/%Y') createDate, titleText, statusID
      FROM Resource
      WHERE statusID = '" . $statusID . "'
      AND createLoginID = '" . $this->loginID . "'
      ORDER BY 1 desc LIMIT 0,25";

    $result = $this->db->processQuery($query, 'assoc');

    $resourceArray = array();

    //need to do this since it could be that there's only one request and this is how the dbservice returns result
    if (isset($result['resourceID'])){

      foreach (array_keys($result) as $attributeName) {
        $resultArray[$attributeName] = $result[$attributeName];
      }

      array_push($resourceArray, $resultArray);

    }else{
      foreach ($result as $row) {
        $resultArray = array();
        foreach (array_keys($row) as $attributeName) {
          $resultArray[$attributeName] = $row[$attributeName];
        }

        array_push($resourceArray, $resultArray);
      }
    }


    return $resourceArray;
  }

  public function hasOpenSession() {
    $util = new Utility();
    $config = new Configuration();

    $dbName = $config->settings->authDatabaseName;
    $sessionID = $util->getSessionCookie();


    $query = "SELECT DISTINCT sessionID FROM " . $dbName . ".Session WHERE loginID = '" . $this->loginID . "' AND sessionID='" . $sessionID . "'";
    $result = $this->db->processQuery($query, 'assoc');

    if (isset($result['sessionID'])){
      return true;
    }else{
      return false;
    }

  }

  //used only for allowing access to admin page
  public function isAdmin(){
    $privilege = new Privilege(new NamedArguments(array('primaryKey' => $this->privilegeID)));
    if (mb_strtoupper($privilege->shortName) == 'ADMIN'){
      return true;
    }else{
      return false;
    }

  }

  // @TODO refactor for common class
  //used only for allowing access to admin page for the auth module
	public function isAdminAuth(){
		if ($this->adminInd == 'Y' || $this->adminInd == '1'){
			return true;
		}else{
			return false;
		}

	}

  public function isInGroup($groupID) {
    $query = "SELECT DISTINCT userGroupID FROM UserGroupLink WHERE loginID = '" . $this->loginID . "' AND userGroupID='" . $groupID . "'";
    $result = $this->db->processQuery($query, 'assoc');

    if (isset($result['userGroupID'])){
      return true;
    }else{
      return false;
    }

  }

  public function processLogin($password){

    $util = new Utility();
    $config = new Configuration();

    if($config->ldap->ldap_enabled=="Y"){
      $host = $config->ldap->host;
      $ldaprdn  = $config->ldap->base_dn;     // ldap rdn or dn
      $ldappass = $password;  // associated password
      $filter = "(".$config->ldap->search_key."=".$this->loginID.")"; //search filter
      $ldapport = $config->ldap->port; //ldap server port
      $bindAccount = $config->ldap->bindAccount; //bind account
      $bindPass = $config->ldap->bindPass; //bind password

      // connect to ldap server
      if($ldapport != ''){
        $ldapconn = ldap_connect($host, $ldapport)
            or die(_("Could not connect to LDAP server."));

        ldap_set_option ($ldapconn, LDAP_OPT_REFERRALS, 0);
        ldap_set_option($ldapconn, LDAP_OPT_PROTOCOL_VERSION, 3);

      }else{
        $ldapconn = ldap_connect($host)
            or die(_("Could not connect to LDAP server."));
      }


      if ($ldapconn) {
        if($bindAccount != ""){
          if($bindPass == ''){
            error_log("A bind password must be provided with a bind account");
            die(_("There is a problem with the LDAP configuration, contact your server administrator."));
          }
          //bind to ldap server
          $ldapbind = ldap_bind($ldapconn, $bindAccount, $bindPass);

        }else{
            // binding to ldap server
            //$ldapbind = ldap_bind($ldapconn, $ldaprdn, $ldappass);
            $ldapbind = ldap_bind($ldapconn);
            // verify binding
        }

          if ($ldapbind) {
          //echo "LDAP bind successful...";
          $ldapSearch = ldap_search($ldapconn, $ldaprdn, $filter);

          if($ldapSearch){
            $ldap_result = ldap_get_entries($ldapconn, $ldapSearch);

            $success = ldap_bind($ldapconn, $ldap_result[0]['dn'], $ldappass);

            if(!$success){ return false;}
          }
          else{
              return false;
          }
          }else{
        return false;
          }
      }
    }else{ // built-in auth
      //verify the password is correct
      //get the hashed password
      $pwh = $util->hashString('sha512', $this->passwordPrefix . $password);

      //password failed!!
      if ($this->password != $pwh){
        return false;
      }
    }
    //passed password test

    //create new session
    $sessionID = $util->randomString(100);

    $session = new Session();
    $session->sessionID = $sessionID;
    $session->loginID = $this->loginID;
    $session->timestamp = date( 'Y-m-d H:i:s' );

    $session->save();

    //also set the cookie
    $util->setSessionCookie($sessionID, time() + $config->settings->timeout);
    $util->setLoginCookie($this->loginID, time() + $config->settings->timeout);

    //also set session variable
    $_SESSION['loginID'] = $this->loginID;

    return true;
  }

  public function processLogout(){

    $util = new Utility();
    $config = new Configuration();

    //delete the session record in database
    $sessionID = $util->getSessionCookie();

    if ($sessionID){
      $session = new Session(new NamedArguments(array('primaryKey' => $sessionID)));
      $session->delete();
    }

    //expire the cookie
    $util->setSessionCookie($sessionID, time() - $config->settings->timeout);

    //unset the login session variable
    unset($_SESSION['loginID']);



  }

  public function setRememberLogin(){

    $util = new Utility();

    //expire in 180 days
    return $util->setRememberLogin($this->loginID, time()+60*60*24*180);

  }

  public function unsetRememberLogin(){

    $util = new Utility();

    return $util->setRememberLogin($this->loginID, time()-60);

  }

  protected function defineRelationships() {
    $this->hasOne('Privilege');
  }

  protected function overridePrimaryKeyName() {
    $this->primaryKeyName = 'loginID';
  }

}
