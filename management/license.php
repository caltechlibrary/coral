<?php

// @file management/license.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$licenseID=$_GET['licenseID'];
$license = new License(new NamedArguments(array('primaryKey' => $licenseID)));

//set this to turn off displaying the title header in header.php
$pageTitle=$license->shortName;
$noHead=1;
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;


//determine if we should display the SFX tab - if user is admin and if configured in settings to use SFX
$util = new Utility();
$displaySFX = 0;
if (($user->isAdmin()) && ($util->useTermsTool())){
	$displaySFX=1;
}

//as long as license id is valid...
if ($license->shortName){

?>


<input type='hidden' name='licenseID' id='licenseID' value='<?php echo $licenseID; ?>'>

<div id='div_licenseHead'>

</div>

</center>

<input type='hidden' name='licenseID' id='licenseID' value='<?php echo $license->licenseID; ?>'>

<div style="width: 899px;" id ='div_displayDocuments'>
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="sidemenu">
				<div class="sidemenuselected" style='position: relative; width: 91px'><a href='javascript:void(0)' class='showDocuments'><?php echo _("Documents");?></a></div>
				<!-- <div class='sidemenuunselected'><a href='javascript:void(0)' class='showExpressions'>Expressions</a></div> -->
				<?php if ($displaySFX == "1"){ ?><div class='sidemenuunselected'><a href='javascript:void(0)' class='showSFXProviders'><?php echo _("Terms Tool");?></a></div><?php } ?>
				<div class='sidemenuunselected'><a href='javascript:void(0)' class='showAttachments'><?php echo _("Attachments");?></a><br />&nbsp;<span class='span_AttachmentNumber'></span></div>
			</td>
			<td class='mainContent'>
				<div id='div_documents'>
				<img src = "images/circle.gif"><?php echo _("Loading...");?>
				</div>
				<br />
				<div id='div_archives'>
				</div>
				<div id='div_notes'>
				</div>
			</td>
		</tr>
	</table>
</div>



<div id ='div_displayExpressions' style='display:none;width:899px;'>
	<table cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr>
			<td class="sidemenu">
				<div class="sidemenuunselected"><a href='javascript:void(0)' class='showDocuments'><?php echo _("Documents");?></a></div>
				<div class='sidemenuselected' style='position: relative; width: 91px'><a href='javascript:void(0)' class='showExpressions'><?php echo _("Expressions");?></a></div>
				<?php if ($displaySFX == "1"){ ?><div class='sidemenuunselected'><a href='javascript:void(0)' class='showSFXProviders'><?php echo _("Terms Tool");?></a></div><?php } ?>
				<div class='sidemenuunselected'><a href='javascript:void(0)' class='showAttachments'><?php echo _("Attachments");?></a><br />&nbsp;<span class='span_AttachmentNumber'></span></div>
			</td>
			<td class='mainContent'>
				<div id='div_expressions'>
				<img src = "images/circle.gif"><?php echo _("Loading...");?>
				</div>
			</td>
		</tr>
	</table>
</div>


<div id ='div_displaySFXProviders' style='display:none;width:899px;'>
	<table cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr>
			<td class="sidemenu">
				<div class="sidemenuunselected"><a href='javascript:void(0)' class='showDocuments'><?php echo _("Documents");?></a></div>
				<div class='sidemenuunselected'><a href='javascript:void(0)' class='showExpressions'><?php echo _("Expressions");?></a></div>
				<div class='sidemenuselected' style='position: relative; width: 91px'><a href='javascript:void(0)' class='showSFXProviders'><?php echo _("Terms Tool");?></a></div>
				<div class='sidemenuunselected'><a href='javascript:void(0)' class='showAttachments'><?php echo _("Attachments");?></a><br />&nbsp;<span class='span_AttachmentNumber'></span></div>
			</td>
			<td class='mainContent'>
				<div id='div_sfxProviders'>
				<img src = "images/circle.gif"><?php echo _("Loading...");?>
				</div>
			</td>
		</tr>
	</table>
</div>


<div id ='div_displayAttachments' style='display:none;width:899px;'>
	<table cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr>
			<td class="sidemenu">
				<div class="sidemenuunselected"><a href='javascript:void(0)' class='showDocuments'><?php echo _("Documents");?></a></div>
<!--				<div class='sidemenuunselected'><a href='javascript:void(0)' class='showExpressions'>Expressions</a></div> -->
				<?php if ($displaySFX == "1"){ ?><div class='sidemenuunselected'><a href='javascript:void(0)' class='showSFXProviders'><?php echo _("Terms Tool");?></a></div><?php } ?>
				<div class='sidemenuselected' style='position: relative; width: 91px'><a href='javascript:void(0)' class='showAttachments'><?php echo _("Attachments");?></a><br />&nbsp;<span class='span_AttachmentNumber'></span></div>
			</td>
			<td class='mainContent'>
				<div id='div_attachments'>
				<img src = "images/circle.gif"><?php echo _("Loading...");?>
				</div>
			</td>
		</tr>
	</table>
</div>


<script type="text/javascript" src="js/license.js"></script>

<?php
} //end license validity check

include 'templates/footer.php';
?>
