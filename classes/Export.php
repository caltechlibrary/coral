<?php

/**
 * Provides helper methods for exporting data.
 */
class Export {

  function arrayToCsvRow($array) {
    $escaped_array = array_map('escape_csv', $array);
    return implode(',', $escaped_array) . "\r\n";
  }

  function escapeCsv($value) {
    // replace \n with \r\n
    $value = preg_replace('/(?<!\r)\n/', "\r\n", $value);
    // escape quotes
    $value = str_replace('"', '""', $value);
    return '"' . $value . '"';
  }

}
