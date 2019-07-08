<?php

// @file classes/DBServiceReports.php

class DBServiceReports {
	protected static $db = null;
	protected $error;
	private static $_instance; //The single instance


/*
	Get an instance of the Database
	@return Instance
	*/
	public static function getInstance() {
		if(!self::$_instance) { // If no instance then make one
			self::$_instance = new self();
		}
		return self::$_instance;
	}


	public function __construct($dbname = null){
		Config::init();
		if (!self::$db && !(self::$db = new mysqli(Config::$database->host, Config::$database->username, Config::$database->password))){
			throw new RuntimeException("There was a problem with the database: " . self::$db->error);
		}else if ($dbname){
			if (!self::$db->select_db($dbname)){
				throw new RuntimeException("There was a problem with the database: " . self::$db->error);
			}
		}else if (!(self::$db->select_db(Config::$database->name))){
			throw new RuntimeException("There was a problem with the database: " . self::$db->error);
		}

		if ($dbname)
			$this->selectDB($dbname);
	}

    public function error() {
        return self::$db->error;
    }

    public static function setDatabase(mysqli $db) {
        self::$db = null;
        if ($db && $db->ping()) {
            self::$db = $db;
            return true;
        }
        return false;
    }

	public function selectDB($databaseName){
		// $databaseName='coral_reporting_pprd';
		if (!self::$db->select_db($databaseName)){
			throw new RuntimeException("There was a problem with the database: " . self::$db->error);
		}
		return $this;
	}
	public static function getDatabase(){
		return self::$db;
	}
	public static function query($sql){
        if (strlen(trim("$sql"))===0) {
            throw new RuntimeException("Empty DB Query");
        }

		if (!($result = self::$db->query($sql))) {
			throw new RuntimeException("There was a problem with the database: " . self::$db->error);
        } else if ($result instanceof mysqli_result){
			return new DBResult($result);
		}else if ($result){
			return self::$db->insert_id;
		}
		return array();
	}
	public static function escapeString($str){
		return self::$db->real_escape_string($str);
	}
}

?>
