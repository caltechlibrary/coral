<?php

// @file auth/ajax_processing.php

require_once __DIR__ . '/../bootstrap.php';

session_start();

if (isset($_SESSION['loginID'])){
	$loginID=$_SESSION['loginID'];
}

$user = new User(new NamedArguments(array('primaryKey' => $loginID)));


if (($user->isAdminAuth) && ($user->getOpenSession())){

	switch ($_GET['action']) {
		case 'submitUser':
			$util = new Utility();

			//if this is an existing user
			if ((isset($_POST['editLoginID'])) && ($_POST['editLoginID'] != '')){
				$sUser = new User(new NamedArguments(array('primaryKey' => $_POST['editLoginID'])));
			}else{
				//set up new user
				$sUser = new User();
				$sUser->loginID = $_POST['loginID'];
			}

			//only update it if it was sent
			if (isset($_POST['password']) && ($_POST['password'] != '')){
				$prefix = $util->randomString(45);
				$sUser->password 		= $util->hashString('sha512', $prefix . $_POST['password']);
				$sUser->passwordPrefix	= $prefix;
			}

			if ($_POST['adminInd'] == "1"){
				$sUser->adminInd 		= "Y";
			}else{
				$sUser->adminInd 		= "N";
			}

			try {
				$sUser->save();
			} catch (Exception $e) {
				echo $e->getMessage();
			}

			break;

		case 'deleteUser':
			$loginID = $_GET['loginID'];
			$dUser = new User(new NamedArguments(array('primaryKey' => $loginID)));

			try {
				$dUser->delete();
				echo _("User successfully deleted.");
			} catch (Exception $e) {
				echo $e->getMessage();
			}

			break;





		default:
		   echo _("Action ") . $action . _(" not set up!");
		   break;

	}
}

?>
