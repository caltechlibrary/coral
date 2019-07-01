<?php

// @file classes/NamedAgruments.php

class NamedArguments {

	protected $arguments = array();

	public function __construct($array) {
		$this->arguments = $array;
	}

	public function __get($name) {
		if (array_key_exists($name, $this->arguments)) {
			return $this->arguments[$name];
		}
	}

	public function __set($name, $value) {
		$this->arguments[$name] = $value;
	}

	public function setDefaultValueForArgumentName($argumentName, $value) {
		if (!array_key_exists($argumentName, $this->arguments)) {
			$this->arguments[$argumentName] = $value;
		}
	}

	public function toJsonString() {
		return json_encode($this->arguments);
	}

	public function namedArgumentsFromJsonString($string) {
		return new NamedAgruments(json_decode($string, true));
	}

}

?>
