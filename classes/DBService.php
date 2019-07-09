<?php

// @file classes/DBService.php

class DBService extends BaseObject {

	protected $db;
	protected $config;
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


	protected function init(NamedArguments $arguments) {
		parent::init($arguments);
		$this->config = new Configuration;
		$this->connect();
	}

	protected function dealloc() {
		$this->disconnect();
		parent::dealloc();
	}

	protected function checkForError() {
		if ($this->error = mysqli_error($this->db)) {
			throw new Exception(_("There was a problem with the database: ") . $this->error);
		}
	}

	// @TODO needs tests;
	// differs from management/admin/classes/common/DBService.php
	protected function connect() {
		$host = $this->config->database->host;
		$username = $this->config->database->username;
		$password = $this->config->database->password;
		$databaseName = $this->config->database->name;
		$this->db = mysqli_connect($host, $username, $password, $databaseName);
		$this->checkForError();
        $this->db->set_charset('utf8');
	}

	protected function disconnect() {
		//$this->db->close();
	}

	public function changeDB($databaseName) {
		//$databaseName='coral_reporting_pprd';
		$this->db->select_db($databaseName);
		$this->checkForError();
	}

	public function escapeString($value) {
		return $this->db->escape_string($value);
	}

	public function getDatabase() {
		return $this->db;
	}

    public function query($sql) {
        $result = $this->db->query($sql);
        $this->checkForError();
        return $result;
	}

  // @TODO getModulePath() needs refactoring for common class
  public function log($sql, $query_time) {
    $threshold = $this->config->database->logQueryThreshold;
    if ($this->config->database->logQueries == "Y" && (!$threshold || $query_time >= $threshold)) {
      $util = new Utility();
      $log_path = $util->getModulePath() . "/log";
      $log_file = $log_path . "/database.log";
      $log_string = date("c") . "\n" . $_SERVER['REQUEST_URI'] . "\n" . $sql . "\nQuery completed in " . sprintf("%.3f", round($query_time, 3)) . " seconds";
      error_log($log_string . "\n\n", 3, $log_file);
    }
  }

  // @TODO needs tests;
  // differs from management/admin/classes/common/DBService.php
  // differs from usage/admin/classes/common/DBService.php
	public function processQuery($sql, $type = NULL) {
    	//echo $sql. "<br />";
		$result = $this->db->query($sql);
		$this->checkForError();
		$data = array();

		if ($result instanceof mysqli_result) {
			$resultType = MYSQLI_NUM;
			if ($type == 'assoc') {
				$resultType = MYSQLI_ASSOC;
			}
			while ($row = $result->fetch_array($resultType)) {
				if ($this->db->affected_rows > 1) {
					array_push($data, $row);
				} else {
					$data = $row;
				}
			}
			$result->free();
		} else if ($result) {
			$data = $this->db->insert_id;
		}

		return $data;
	}

	/**
	 * Version of processQuery() that deals with prepared statements. As prepared
	 * statements use variadic functions, much of this function's complexity
	 * comes from wrapping a variadic function in a PHP 5.5 compatible way.
	 *
	 * @param string $query Same format as mysqli::prepare(), with usually one
	 * or more "?" inside it.
	 *
	 * @param string $type Must be "num" or "assoc". Contrary to processQuery(),
	 * it's not an optionnal argument. Due to this function being variadic.
	 *
	 * @param mixed ...$paramsToBind Same format as mysqli_stmt::bind_param()
	 * It's a variadic function based on this PHP 5.5 compatible implementation
	 * https://wiki.php.net/rfc/variadics#introduction
	 * We will be able to simplify this once we require PHP 5.6
	 * https://secure.php.net/manual/en/migration56.new-features.php#migration56.new-features.variadics
	 */
	public function processPreparedQuery($query, $type) {
		$paramsToBind = array_slice(func_get_args(), 2); // additional arguments
		// prepared statements specific code
		$statement = $this->db->prepare($query);
		$this->checkForError();
		// The following is an implementation of the splat operator. This
		// will be simpler with PHP 5.6
		// https://secure.php.net/manual/en/migration56.new-features.php#migration56.new-features.splat
		// We need to pass references to bind_param(), hence the use of refValues()
		call_user_func_array([$statement, "bind_param"], self::refValues($paramsToBind)) ;
		$statement->execute();
		$result = $statement->get_result();

		// same as processQuery()
		$this->checkForError();
		$data = array();

		if ($result instanceof mysqli_result) {
			$resultType = MYSQLI_NUM;
			if ($type == 'assoc') {
				$resultType = MYSQLI_ASSOC;
			}
			while ($row = $result->fetch_array($resultType)) {
				if ($this->db->affected_rows > 1) {
					array_push($data, $row);
				} else {
					$data = $row;
				}
			}
			$result->free();
		} else if ($result) {
			$data = $this->db->insert_id;
		}

		return $data;
	}

	private static function refValues($arr){
		$refs = array();
		foreach($arr as $key => $value) {
			$refs[$key] = &$arr[$key];
		}
		return $refs;
	}
}

?>
