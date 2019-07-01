<?php

// @file resources/ajax_processing.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

include_once 'user.php';

$action = $_GET['action'];
if (!preg_match('/^[A-Za-z]+$/', $action) || !(include "ajax_processing/$action.php")){
	echo _("Processing action ") . $action . _(" not set up!");
}

?>
