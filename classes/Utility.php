<?php

// @file classes/Utility.php

class Utility {

  public function createMessageFromTemplate($messageType, $resourceID, $resourceTitle, $stepName, $systemNumber, $creator, $note = null){
    $config = new Configuration();

    $templateFile = $this->getCORALPath() . "resources/admin/emails/" . $messageType . ".txt";

    if (file_exists($templateFile)){

      $fh = @fopen($templateFile, 'r');
      $defaultMessage = "";
      while (($buffer = fgets($fh, 4096)) !== false) {
        $defaultMessage .= $buffer;
      }
      if (!feof($fh)) {
        return _("Error: unexpected fgets() fail")."\n";
      }

      fclose($fh);

      //also add on the final link with the system number, if system number is included
      //this is custom for us at ND
      if (($systemNumber != '') && ($config->settings->completionLink != '')){
        $resourceTitleInURL = urlencode($resourceTitle);
        $resourceTitleInURL = str_replace('+', '%20', $resourceTitleInURL);

        $completionLink = str_replace('<ResourceTitle>', $resourceTitleInURL, $config->settings->completionLink);
        $defaultMessage .= _("Edit DDW facet/term selections at: ") . $completionLink;
      }


      //now do the replace
      $defaultMessage = str_replace('<ResourceID>', $resourceID, $defaultMessage);
      $defaultMessage = str_replace('<ResourceRecordURL>', $this->getResourceRecordURL(), $defaultMessage);
      $defaultMessage = str_replace('<ResourceTitle>', $resourceTitle, $defaultMessage);
      $defaultMessage = str_replace('<StepName>', $stepName, $defaultMessage);
      $defaultMessage = str_replace('<SystemNumber>', $systemNumber, $defaultMessage);
      $defaultMessage = str_replace('<Creator>', $creator, $defaultMessage);
      $defaultMessage = str_replace('<Note>', $note, $defaultMessage);

      return $defaultMessage;

    }else{
      return _('Email template file not found: ') . $templateFile;
    }


  }

  //returns file path up to /coral/
  public function getCORALPath(){
    $pagePath = rtrim($_SERVER['DOCUMENT_ROOT'],'/\\').'/';

    $currentFile = $_SERVER["SCRIPT_NAME"];
    $parts = Explode('/', $currentFile);
    for($i=0; $i<count($parts) - 2; $i++){
      if ($parts[$i] != '' && $parts[$i] !='resources'){
        $pagePath .= $parts[$i] . '/';
      }
    }

    return $pagePath;
  }

  //returns page URL up to /coral/
  public function getCORALURL(){
    $pageURL = 'http';
    if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
    $pageURL .= "://";
    if ($_SERVER["SERVER_PORT"] != "80") {
      $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"];
    } else {
      $pageURL .= $_SERVER["SERVER_NAME"];
    }

    $currentFile = $_SERVER["PHP_SELF"];
    $parts = Explode('/', $currentFile);
    for($i=0; $i<count($parts) - 2; $i++){
      if ($parts[$i] != 'resources') {
        $pageURL .= $parts[$i] . '/';
      }
    }

    return $pageURL;
  }

  public function getLicensingURL(){
    return $this->getCORALURL() . "licensing/license.php?licenseID=";
  }

  public function getLoginCookie(){

    if(array_key_exists('CORALLoginID', $_COOKIE)){
      return $_COOKIE['CORALLoginID'];
    }

  }

  public function getOrganizationURL(){
    return $this->getCORALURL() . "organizations/orgDetail.php?organizationID=";
  }

  //returns page URL up to /resources/
  public function getPageURL(){
    return $this->getCORALURL() . "resources/";
  }

  public function getRememberLogin(){

    if(array_key_exists('CORALRemember', $_COOKIE)){
      return $_COOKIE['CORALRemember'];
    }

  }

  //returns page URL for resource record
  public function getResourceRecordURL(){
    return $this->getCORALURL() . "resources/resource.php?resourceID=";
  }

  public function getSessionCookie(){

    if(array_key_exists('CORALSessionID', $_COOKIE)){
      return $_COOKIE['CORALSessionID'];
    }

  }

  public function hashString($hashAlgorithm, $string){

    $hashedString = hash($hashAlgorithm, $string);

    return $hashedString;

  }

  public function objectFromArray($array) {
    $object = new DynamicObject;
    foreach ($array as $key => $value) {
      if (is_array($value)) {
        $object->$key = Utility::objectFromArray($value);
      } else {
        $object->$key = $value;
      }
    }
    return $object;
  }

  public function randomString($stringLength){

    $string = '';
    $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    $charsLength = strlen($chars)-1;

    for ($i = 0;  $i != $stringLength; $i++){
      $randInd = rand(0,$charsLength);
      $string .= substr($chars, $randInd, 1);
    }

    return $string;
  }

  public function secondsFromDays($days) {
    return $days * 24 * 60 * 60;
  }

  public function setLoginCookie($loginID, $time){

    setcookie("CORALLoginID", $loginID, $time, "/" );

  }

  public function setRememberLogin($loginID, $time){

    setcookie("CORALRemember", $loginID, $time);

  }

  public function setSessionCookie($sessionID, $time){

    setcookie("CORALSessionID", $sessionID, $time, "/" );

  }

  public function unixTimeFromMysqlTimestamp($timestamp) {

    // taken from Dan Green, and then modified to be correct
    // http://www.weberdev.com/get_example-1427.html

    $year = substr($timestamp,0,4);
    $month = substr($timestamp,5,2);
    $day = substr($timestamp,8,2);
    $hour = substr($timestamp,11,2);
    $minute = substr($timestamp,14,2);
    $second = substr($timestamp,17,2);
    $newdate = mktime($hour,$minute,$second,$month,$day,$year);

    return $newdate;

  }

}
