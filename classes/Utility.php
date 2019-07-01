<?php

// @file classes/Utility.php

class Utility {

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

	public function secondsFromDays($days) {
		return $days * 24 * 60 * 60;
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

	//returns file path up to /coral/
	public function getCORALPath(){
		$pagePath = $_SERVER["DOCUMENT_ROOT"];

		$currentFile = $_SERVER["SCRIPT_NAME"];
		$parts = Explode('/', $currentFile);
		for($i=0; $i<count($parts) - 2; $i++){
			$pagePath .= $parts[$i] . '/';
		}

		return $pagePath;
	}

	//returns page URL up to /coral/
	public function getCORALURL(){
		$pageURL = 'http';
    if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on") {
      $pageURL .= "s";
    }
		$pageURL .= "://";
		if ($_SERVER["SERVER_PORT"] != "80") {
		  $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"];
		} else {
		  $pageURL .= $_SERVER["SERVER_NAME"];
		}

		$currentFile = $_SERVER["PHP_SELF"];
		$parts = Explode('/', $currentFile);
		for($i=0; $i<count($parts) - 2; $i++){
			$pageURL .= $parts[$i] . '/';
		}

		return $pageURL;
	}

	//returns page URL up to /auth/
	public function getPageURL(){
		return $this->getCORALURL() . "auth/";
	}




	public function hashString($hashAlgorithm, $string){

		$hashedString = hash($hashAlgorithm, $string);

		return $hashedString;

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


	public function setSessionCookie($sessionID, $time){

		setcookie("CORALSessionID", $sessionID, $time, "/" );

	}


	public function setLoginCookie($loginID, $time){

		setcookie("CORALLoginID", $loginID, $time, "/" );

	}


	public function setRememberLogin($loginID, $time){

		setcookie("CORALRemember", $loginID, $time);

	}

	public function getSessionCookie(){

		if(array_key_exists('CORALSessionID', $_COOKIE)){
			return $_COOKIE['CORALSessionID'];
		}

	}

	public function getRememberLogin(){

		if(array_key_exists('CORALRemember', $_COOKIE)){
			return $_COOKIE['CORALRemember'];
		}

	}


}

?>
