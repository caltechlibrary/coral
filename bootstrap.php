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

function format_date($mysqlDate) {
	//see http://php.net/manual/en/function.date.php for options

	//upper case Y = four digit year
	//lower case y = two digit year
	//make sure digit years matches for both directory.php and common.js

	//SUGGESTED: "m/d/Y" or "d-m-Y"
    return strftime(return_date_format(), strtotime($mysqlDate));
}

function resource_sidemenu($selected_link = '') {
  global $user;
  $links = array(
    'product' => _("Product"),
    'orders' => _("Orders"),
    'acquisitions' => _("Acquisitions"),
    'access' => _("Access"),
    'cataloging' => _("Cataloging"),
    'contacts' => _("Contacts"),
    'accounts' => _("Accounts"),
    'issues' => _("Issues"),
    'attachments' => _("Attachments"),
    'workflow' => _("Workflow"),
  );

  foreach ($links as $key => $value) {
    $name = ucfirst($key);
    if ($selected_link == $key) {
      $class = 'sidemenuselected';
    } else {
      $class = 'sidemenuunselected';
    }
    if ($key != 'accounts' || $user->accountTabIndicator == '1') {
    ?>
    <div class="<?php echo $class; ?>" style='position: relative; width: 105px'><span class='link'><a href='javascript:void(0)' class='show<?php echo $name; ?>' title="<?php echo $value; ?>"><?php echo $value; ?></a></span>
      <?php if ($key == 'attachments') { ?>
        <span class='span_AttachmentNumber smallGreyText' style='clear:right; margin-left:18px;'></span>
      <?php } ?>
    </div>
    <?php
    }
  }
}

function return_date_format() {
    $config = new Configuration();
    $config_date_format = $config->settings->date_format;
    if (isset($config_date_format) && $config_date_format != '') {
        $date_format = $config_date_format;
    } else {
        $date_format = "%m/%d/%Y";
    }
    return $date_format;
}

function return_datepicker_date_format() {
    $config = new Configuration();
    $config_date_format = $config->settings->datepicker_date_format;
    if (isset($config_date_format) && $config_date_format != '') {
        $date_format = $config_date_format;
    } else {
        $date_format = "mm/dd/yyyy";
    }
    return $date_format;
}

//Watched function to catch the strings being passed into resource_sidemenu for translation
function watchString($string) {
  return $string;
}
