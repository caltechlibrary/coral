<?php

// @file auth/ajax_htmldata.php

require_once __DIR__ . '/../bootstrap.php';

switch ($_GET['action']) {


	case 'getUsers':
		$userObj = new User();
		$usersArray = $userObj->allAsArray();


		if (count($usersArray) > 0){
			?>
			<table class='linedDataTable' style='width:340px;'>
				<tr>
				<th>Login ID</th>
				<th>Admin?</th>
				<th style='width:20px;'>&nbsp;</th>
				<th style='width:20px;'>&nbsp;</th>
				</tr>
				<?php

				foreach($usersArray as $userArray) {
					if ($userArray['adminInd'] =='Y' || $userArray['adminInd'] == '1'){
						$isAdmin='Y';
					}else{
						$isAdmin='N';
					}

					echo "<tr>";
					echo "<td>" . $userArray['loginID'] . "</td>";
					echo "<td>" . $isAdmin . "</td>";
					echo "<td><a href='ajax_forms.php?action=getAdminUserUpdateForm&loginID=" . $userArray['loginID'] . "&height=230&width=315&modal=true' class='thickbox'><img src='images/edit.gif' alt='"._("edit password or admin status")."' title='"._("edit password or admin status")."'></a></td>";
					echo "<td><a href='javascript:void(0);' class='deleteUser' id='" . $userArray['loginID'] . "'><img src='images/cross.gif' alt='"._("remove")."' title='"._("remove")."'></a></td>";
					echo "</tr>";
				}

				?>
			</table>
			<a href='ajax_forms.php?action=getAdminUserUpdateForm&loginID=&height=215&width=315&modal=true' class='thickbox' id='addUser'><?php echo _("add new user")?></a>
			<?php

		}else{
			echo "(none found)<br /><a href='ajax_forms.php?action=getUserUpdateForm&loginID=&height=275&width=315&modal=true' class='thickbox' id='addUser'>"._("add new user")."</a>";
		}

		break;






	default:
       echo _("Action ") . $action . _(" not set up!");
       break;


}


?>
