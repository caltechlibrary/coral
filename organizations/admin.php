<?php

// @file organizations/admin.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Administration');
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;

//ensure user has admin permissions
if ($user->isAdmin()){
	?>
	<table class="headerTable">
	<tr><td align='left'>
	<span class="headerText"><?php echo _("Users");?></span>&nbsp;&nbsp;<span id='span_User_response'></span><span id='span_newUser' class='adminAddInput'><a href='ajax_forms.php?action=getAdminUserUpdateForm&height=185&width=250&modal=true' class='thickbox' id='expression'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add user")."' />";?></a></span>

	<br />
	<div id='div_User'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>

	<br />
	<br />


	<table class="headerTable">
	<tr><td align='left'>
	<span class="headerText"><?php echo _("Organization Role");?></span>&nbsp;&nbsp;<span id='span_OrganizationRole_response'></span><span id='span_newOrganizationRole' class='adminAddInput'><a href='javascript:showAdd("OrganizationRole");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add organization role")."' />";?></a></span>

	<br />
	<div id='div_OrganizationRole'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>

	<br />
	<br />

	<table class="headerTable">
	<tr><td align='left'>
	<span class="headerText"><?php echo _("Contact Role");?></span>&nbsp;&nbsp;<span id='span_ContactRole_response'></span><span id='span_newContactRole' class='adminAddInput'><a href='javascript:showAdd("ContactRole");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add contact role")."' />";?></a></span>

	<br />
	<div id='div_ContactRole'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>


	<br />
	<br />

	<table class="headerTable">
	<tr><td align='left'>
	<span class="headerText"><?php echo _("Alias Type");?></span>&nbsp;&nbsp;<span id='span_AliasType_response'></span>	<span id='span_newAliasType' class='adminAddInput'><a href='javascript:showAdd("AliasType");'><?php echo "<img id='Add' class='AdminAddIcon' src='images/plus.gif' title= '"._("Add alias type")."' />";?></a></span>

	<br />
	<div id='div_AliasType'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>

	<br />
	<br />

	<table class="headerTable">
	<tr><td align='left'>
	<span class="headerText"><?php echo _("External Login Type");?></span>&nbsp;&nbsp;<span id='span_ExternalLoginType_response'></span><span id='span_newExternalLoginType' class='adminAddInput'><a href='javascript:showAdd("ExternalLoginType");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add external login type")."' />";?></a></span>

	<br />
	<div id='div_ExternalLoginType'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>


  <br /><br /><table class="headerTable">
    <tr><td align='left'>
      <span class="headerText"><?php echo _("Issue Type");?></span>&nbsp;&nbsp;<span id='span_IssueLogType_response'></span><span id='span_newIssueLogType' class='adminAddInput'><a href='javascript:showAdd("IssueLogType");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add issue type")."' />";?></a></span>

      <br />
      <div id='div_IssueLogType'>
        <img src = "images/circle.gif"><?php echo _("Loading...");?>
      </div>
    </td></tr>
  </table>
  <br />
  <br />

	<script type="text/javascript" src="js/admin.js"></script>
	<?php

//end else for admin
}else{
	echo _("You do not have permissions to access this screen.");
}

include 'templates/footer.php';
?>
