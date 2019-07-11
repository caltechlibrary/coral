<?php

/**
 * Provides helper methods for exporting data.
 */
class Export {

  public function arrayToCsvRow($array) {
    $escaped_array = array_map([$this, 'escapeCsv'], $array);
    return implode(',', $escaped_array) . "\r\n";
  }

  public function escapeCsv($value) {
    // replace \n with \r\n
    $value = preg_replace('/(?<!\r)\n/', "\r\n", $value);
    // escape quotes
    $value = str_replace('"', '""', $value);
    return '"' . $value . '"';
  }

}
