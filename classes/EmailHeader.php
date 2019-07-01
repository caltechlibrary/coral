<?php

// @file classes/EmailHeader.php

class EmailHeader extends DynamicObject {

	protected $fieldName;
	protected $fieldBody;

	const LINE_ENDING = "\n";

	protected function init(NamedArguments $arguments) {
		$this->fieldName = $this->fieldNameFromName($arguments->name);
		$this->fieldBody = $arguments->body;

	}

	protected function fieldNameFromName($name) {
		$headerName = ucfirst($name);
		// Hypenate camelCase
		$headerName = preg_replace('/([a-z])([A-Z])/', '\1-\2', $headerName);
		return $headerName;
	}

	public function text() {
		return self::$this->fieldName . ': ' . $this->fieldBody . "\n";
	}

}
