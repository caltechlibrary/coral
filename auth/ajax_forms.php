<?php

// @file auth/ajax_forms.php

require_once __DIR__ . '/../bootstrap.php';

switch ($_GET['action']) {


	case 'getAdminUserUpdateForm':
		if (isset($_GET['loginID'])) $loginID = $_GET['loginID']; else $loginID = '';

		$eUser = new User(new NamedArguments(array('primaryKey' => $loginID)));

		if ($eUser->isAdmin()){
			$adminInd = 'checked';
		}else{
			$adminInd = '';
		}
		?>


		<div id='div_updateForm'>


		<div class='formTitle' style='width:295px;'><span class='headerText' style='margin-left:7px;'><?php if ($loginID){ echo _("Edit User"); } else { echo _("Add New User"); } ?></span></div>


		<span class='smallDarkRedText' id='span_errors'></span>

		<input type='hidden' id='editLoginID' value='<?php echo $loginID; ?>' />

		<table class="surroundBox" style="width:300px;">
		<tr>
		<td>

			<div style='width:260px; margin:10px;'>

				<label for='submitLoginID' class='formLabel' <?php if ($loginID) { ?>style='margin-bottom:8px;'<?php } ?>><b><?php echo _("Login ID");?></b></label>&nbsp;
				<?php if (!$loginID) { ?><input type='text' id='textLoginID' value='' style='width:110px;'/> <?php } else { echo $loginID; } ?>
				<?php if ($loginID) { ?><div class='smallDarkRedText' style="clear:left;margin-left:5px;margin-bottom:3px;"><?php echo _("Enter password for changes only")?></div> <?php }else{ echo "<br />"; } ?>
				<label for='password' class='formLabel'><b><?php if ($loginID) { echo _("New "); } echo _("Password");?></b></label>&nbsp;
				<input type='password' id='password' value="" style='width:110px;' />
				<br />
				<label for='passwordReenter' class='formLabel'><b><?php echo _("Reenter Password");?></b></label>&nbsp;
				<input type='password' id='passwordReenter' value="" style='width:110px;'/>
				<br />
				<label for='adminInd' class='formLabel'><b><?php echo _("Admin?");?></b></label>&nbsp;
				<input type='checkbox' id='adminInd' value='Y' <?php echo $adminInd; ?> />
				<br />
			</div>

		</td>
		</tr>
		</table>

		<br />
		<table class='noBorderTable' style='width:125px;'>
			<tr>
				<td style='text-align:left;'><input type='button' value='<?php echo _("submit");?>' id ='submitUser' class='submitButton' /></td>
				<td style='text-align:right;'><input type='button' value='<?php echo _("cancel");?>' onclick="window.parent.tb_remove(); return false;" class='submitButton' /></td>
			</tr>
		</table>


		</div>

		<script type="text/javascript" src="js/admin.js"></script>
		<script type="text/javascript">
			//attach enter key event to new input and call add data when hit
		   $('#textLoginID').keyup(function(e) {
               if(e.keyCode == 13) {
                   window.parent.submitUserForm();
               }
        	});
		   $('#password').keyup(function(e) {
               if(e.keyCode == 13) {
                   window.parent.submitUserForm();
               }
        	});
		   $('#passwordReenter').keyup(function(e) {
               if(e.keyCode == 13) {
                   window.parent.submitUserForm();
               }
        	});
			//bind all of the inputs
			$("#submitUser").click(function () {
                window.parent.submitUserForm();
			});
        </script>

		<?php

		break;

	default:
       echo _("Action ") . $action . _(" not set up!");
       break;


}


?>
