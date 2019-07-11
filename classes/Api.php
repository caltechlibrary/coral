<?php

/**
 * Provides methods for the API.
 */
class Api {

  public function addToDescriptionText(&$body, $inputField){
      if(isset($_POST[$inputField]) && $_POST[$inputField]!=""){
          if(isset($body['descriptionText'])){
              if($body['descriptionText']!= ""){
                  $body['descriptionText'].="\n";
              }
          }else{
              $body['descriptionText']="";
          }
          $body['descriptionText'] .= ucfirst($inputField) . ": " . $_POST[$inputField];
      }
  }

  public function isAllowed() {
      $config = new Configuration();

      // If apiAuthorizedIP is not set, don't allow
      if (!$config->settings->apiAuthorizedIP) { return 0; }

      // If apiAuthorizedIP could not be parsed, don't allow
      $authorizedIP = explode(',', $config->settings->apiAuthorizedIP);
      if (!$authorizedIP) { return 0; }

      // If a matching IP has been found, allow
      if (array_filter($authorizedIP, [$this, 'IpFilter'])) { return 1; }

      return 0;
  }

  // A matching IP is either a complete IP or the start of one (allowing IP range)
  public function IpFilter($var) {
      $pos = strpos($_SERVER['REMOTE_ADDR'], $var);
      return $pos === false ? false : true;
  }

  // Create a note type if it doesn't exist
  // Return noteTypeID
  public function createNoteType($name) {
      $noteType = new NoteType();
      $noteTypeID = $noteType->getNoteTypeIDByName($name);
      if ($noteTypeID) return $noteTypeID;

      $noteType->shortName = $name;
      $noteType->noteTypeID = '';
      $noteType->save();
      return $noteType->noteTypeID;
  }

  public function userExists($user) {
      $createUser = new User(new NamedArguments(array('primaryKey' => $user)));
      return $createUser->loginID ? true : false;
  }

}
