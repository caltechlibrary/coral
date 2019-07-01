<?php

// @file classes/Configuration.php

class Configuration extends DynamicObject {

	public function init(NamedArguments $arguments) {
		$global_config = parse_ini_file(BASE_DIR . "../common/configuration.ini", true);
		$arguments->setDefaultValueForArgumentName("filename", BASE_DIR . "/admin/configuration.ini");
		$module_config = parse_ini_file($arguments->filename, true);
		$config = array_replace_recursive($global_config, $module_config);

		// Save config array content as Configuration properties
		foreach ($config as $section => $entries) {
      $this->$section = (new Utility())->objectFromArray($entries);
		}
	}

}
