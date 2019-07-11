<?php

/**
 * Provides methods for formatting and manipulating dates.
 */
class Dates {

  public function formatDate($date) {
    return strftime($this->returnDateFormat(), strtotime($date));
  }

  public function isNullDate($date) {
    return (!$date || $date == '0000-00-00' || $date == '');
  }

  public function normalizeDate($date) {
    if (($date == '0000-00-00') || ($date == '')) {
      return '';
    }
    else {
      return $this->formatDate($date);
    }
  }

  public function numberToMonth($number) {
    $number = $number - 1;
    $months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return $months[$number];
  }

  public function previousYear($year) {
    return preg_replace_callback('/(19[0-9][0-9]|2[0-9][0-9][0-9])/', function ($matches) {
      return $matches[0] - 1;
    }, $year, 1);
  }

  public function returnDateFormat() {
    $config = new Configuration();
    $config_date_format = $config->settings->date_format;
    if (isset($config_date_format) && $config_date_format != '') {
      $date_format = $config_date_format;
    }
    else {
      $date_format = '%m/%d/%Y';
    }
    return $date_format;
  }

  public function returnDatepickerDateFormat() {
    $config = new Configuration();
    $config_date_format = $config->settings->datepicker_date_format;
    if (isset($config_date_format) && $config_date_format != '') {
      $date_format = $config_date_format;
    }
    else {
      $date_format = 'mm/dd/yyyy';
    }
    return $date_format;
  }

}
