<?php

/**
 * Provides methods for converting costs and integers.
 */
class Cost {

  //commonly used to convert price into integer for insert into database
  public function costToInteger($price) {
      $price = preg_replace("/[^0-9\.]/", "", $price);
      $decimal_place = strpos($price,".");
      if (strpos($price,".") > 0) {
      $cents = '.' . substr($price, $decimal_place+1, 2);
          $price = substr($price,0,$decimal_place);
      }else{
        $cents = '.00';
      }
      $price = preg_replace("/[^0-9]/", "", $price);
      if (is_numeric($price . $cents)){
        return ($price . $cents) * 100;
      }else{
        return false;
      }
  }
  //commonly used to convert integer into a price for display
  public function integerToCost($price) {
    //we know this is an integer
    if ($price > 0){
        return number_format(($price / 100),2,'.',',');
      }else{
        return "";
      }
  }

}
