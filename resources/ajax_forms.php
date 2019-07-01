<?php

// @file resources/ajax_forms.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

include_once 'user.php';

$action = $_GET['action'];
if (!preg_match('/^[A-Za-z]+$/', $action) || !(include "ajax_forms/$action.php")){
	echo _("Form action ") . $action . _(" not set up!");
}

?>
