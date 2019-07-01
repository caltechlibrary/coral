<?php

abstract class EbscoKbResult {

    protected $properties = [];

    public function __construct($data = [])
    {
        $this->properties = $data;
    }

    public function __set($name, $value)
    {
        if($this->accessor($name)){
            $this->properties[$name] = $this->{self::setterMethod($name)}($value);
        } else {
            $this->properties[$name] = $value;
        }
    }

    public function __get($name)
    {
        if($this->accessor($name)){
            if (array_key_exists($name, $this->properties)) {
                return $this->{self::getterMethod($name)}($this->properties[$name]);
            } else {
                return $this->{self::getterMethod($name)}();
            }
        }
        if (array_key_exists($name, $this->properties)) {
            return $this->properties[$name];
        }

        $trace = debug_backtrace();
        trigger_error(
            'Undefined property via __get(): ' . $name .
            ' in ' . $trace[0]['file'] .
            ' on line ' . $trace[0]['line'],
            E_USER_NOTICE);
        return null;
    }

    protected static function getterMethod($name){
        return 'get'.ucfirst($name);
    }
    protected static function setterMethod($name){
        return 'get'.ucfirst($name);
    }

    // Check for property accessibility
    protected function accessor($name)
    {
        // Check for available accessors
        if ((method_exists($this, self::getterMethod($name))) ||
            (method_exists($this, self::setterMethod($name)))){
            return true;
        }

        return false;
    }


}