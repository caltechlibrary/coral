<?php

// @file classes/Configuration.php

class Configuration extends DynamicObject {

	public function init(NamedArguments $arguments) {
		$global_config = parse_ini_file(BASE_DIR . "../common/configuration.ini", true);
		$arguments->setDefaultValueForArgumentName("filename", BASE_DIR . "/admin/configuration.ini");
		$module_config = parse_ini_file($arguments->filename, true);
		$config = array_replace_recursive($global_config, $module_config);

		// use other DBs for tests
		if($config["settings"]["environment"] === "test") {
			$this->switchAllDbsToTest($config);
		}

		// Save config array content as Configuration properties
		foreach ($config as $section => $entries) {
      $this->$section = (new Utility())->objectFromArray($entries);
		}
	}


	private function switchAllDbsToTest(&$config) {
		$config["database"]["name"] = "coral_auth_test";
		$config["database"]["username"] = "coral_test";
		$config["database"]["password"] = "coral_test";

		if(isset($config["database"]["usageDatabaseName"])) {
			$config["database"]["usageDatabaseName"] = "coral_usage_test";
		}

		if(isset($config["settings"]["authDatabaseName"])) {
			$config["settings"]["authDatabaseName"] = "coral_auth_test";
		}

		if(isset($config["settings"]["licensingDatabaseName"])) {
			$config["settings"]["licensingDatabaseName"] = "coral_licensing_test";
		}

		if(isset($config["settings"]["organizationsDatabaseName"])) {
			$config["settings"]["organizationsDatabaseName"] = "coral_organizations_test";
		}

		if(isset($config["settings"]["resourcesDatabaseName"])) {
			$config["settings"]["resourcesDatabaseName"] = "coral_resources_test";
		}
	}
}

?>
