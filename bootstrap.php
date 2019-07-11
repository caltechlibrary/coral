<?php

// @file bootstrap.php

// use the autoloader from composer
require_once __DIR__ . '/vendor/autoload.php';

$lang_name = new LangCodes();

// Verify the language of the browser
$GLOBALS['http_lang'] = NULL;

if(isset($_COOKIE["lang"])) {
  $GLOBALS['http_lang'] = $_COOKIE["lang"];
} else {
  $codeL = str_replace("-","_",substr($_SERVER["HTTP_ACCEPT_LANGUAGE"],0,5));
  $GLOBALS['http_lang'] = $lang_name->getLanguage($codeL);

  if($GLOBALS['http_lang'] == "") {
    $GLOBALS['http_lang'] = "en_US";
  }
}
