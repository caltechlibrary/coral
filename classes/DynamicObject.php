<?php

// @file classes/DynamicObject.php

class DynamicObject extends BaseObject {

	protected $properties = array();

	public function valueForKey($key) {
		if (property_exists($this, $key)) {
			return parent::valueForKey($key);
		} else {
			if (array_key_exists($key, $this->properties)) {
				return $this->properties[$key];
			} else {
				return NULL;
			}
		}
	}

	public function setValueForKey($key, $value) {
		if (property_exists($this, $key)) {
			parent::setValueForKey($key, $value);
		} else {
			$this->properties[$key] = $value;
		}
	}

}

?>
