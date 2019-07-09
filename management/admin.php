<?php

// @file management/admin.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Administration');
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;

if ($user->isAdmin()){

?>


<table class="headerTable">
<tr><td>
<span class="headerText"><?php echo _("Users");?></span>&nbsp;&nbsp;<span id='span_User_response' class='redText'></span><span id='span_newUser' class='adminAddInput'><a href='ajax_forms.php?action=getAdminUserUpdateForm&height=202&width=288&modal=true' class='thickbox' id='expression'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add")."' />";?></a></span>

<br /><br />
<div id='div_User'>
<img src = "images/circle.gif" /><?php echo _("Loading...");?>
</div>
</td></tr>
</table>

<br />
<br />

<table class="headerTable">
<tr><td>
<span class="headerText"><?php echo _("Document Types");?></span>&nbsp;&nbsp;<span id='span_DocumentType_response'></span><span id='span_newDocumentType' class='adminAddInput'><a href='javascript:showAdd("DocumentType");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add")."' />";?></a></span>

<br /><br />
<div id='div_DocumentType'>
<img src = "images/circle.gif"><?php echo _("Loading...");?>
</div>
</td></tr>
</table>

<br />
<br />

<table class="headerTable">
<tr><td>
<span class="headerText"><?php echo _("Note Types");?></span>&nbsp;&nbsp;<span id='span_DocumentNoteType_response'></span><span id='span_newDocumentNoteType' class='adminAddInput'><a href='javascript:showAdd("DocumentNoteType");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add")."' />";?></a></span>

<br /><br />
<div id='div_DocumentNoteType'>
<img src = "images/circle.gif"><?php echo _("Loading...");?>
</div>
</td></tr>
</table>

<!--
<table class="headerTable">
<tr><td>
<span class="headerText">Expression Types</span>&nbsp;&nbsp;<span id='span_ExpressionType_response'></span>
<br /><span id='span_newExpressionType' class='adminAddInput'><a href='ajax_forms.php?action=getExpressionTypeForm&height=148&width=265&modal=true' class='thickbox' id='expressionType'>add new expression type</a></span>
<br /><br />
<div id='div_ExpressionType'>
<img src = "images/circle.gif">Loading...
</div>
</td></tr>
</table>
-->

<!--

<br />
<br />
<table class="headerTable">
<tr><td>
<span class="headerText">Qualifiers</span>&nbsp;&nbsp;<span id='span_Qualifier_response'></span>
<br /><span id='span_newQualifier' class='adminAddInput'><a href='ajax_forms.php?action=getQualifierForm&height=148&width=295&modal=true' class='thickbox'>add new qualifier</a></span>
<br /><br />
<div id='div_Qualifier'>
<img src = "images/circle.gif">Loading...
</div>
</td></tr>
</table>

<br />
<br />

-->

<!--
<table class="headerTable">
<tr><td>
<span class="headerText">Signature Types</span>&nbsp;&nbsp;<span id='span_SignatureType_response'></span>
<br /><span id='span_newSignatureType' class='adminAddInput'><a href='javascript:showAdd("SignatureType");'>add new signature type</a></span>
<br /><br />
<div id='div_SignatureType'>
<img src = "images/circle.gif">Loading...
</div>
</td></tr>
</table>

<br />
<br />
-->

<!--
<table class="headerTable">
<tr><td>
<span class="headerText">License Statuses</span>&nbsp;&nbsp;<span id='span_Status_response'></span>
<br /><span id='span_newStatus' class='adminAddInput'><a href='javascript:showAdd("Status");'>add new license status</a></span>
<br /><br />
<div id='div_Status'>
<img src = "images/circle.gif">Loading...
</div>
</td></tr>
</table>

<br />
<br />
-->


<?php

$config = new Configuration;

//if the org module is not installed, display provider list for updates
if ($config->settings->organizationsModule != 'Y'){ ?>


	<br />
	<br />

	<table class="headerTable">
	<tr><td>
	<span class="headerText"><?php echo _("Categories");?></span>&nbsp;&nbsp;<span id='span_Consortium_response'></span><span id='span_newConsortium' class='adminAddInput'><a href='javascript:showAdd("Consortium");'><?php echo "<img id='Add' class='addIcon' src='images/plus.gif' title= '"._("Add")."' />";?></a></span>

	<br /><br />
	<div id='div_Consortium'>
	<img src = "images/circle.gif"><?php echo _("Loading...");?>
	</div>
	</td></tr>
	</table>

	<br />
	<br />
<!--
	<table class="headerTable">
	<tr><td>
	<span class="headerText">Providers</span>&nbsp;&nbsp;<span id='span_Organization_response'></span>
	<br /><span id='span_newOrganization' class='adminAddInput'><a href='javascript:showAdd("Organization");'>add new provider</a></span>
	<br /><br />
	<div id='div_Organization'>
	<img src = "images/circle.gif">Loading...
	</div>
	</td></tr>
	</table>
-->
<?php } ?>

<br />

<script type="text/javascript" src="js/admin.js"></script>
								</center>

<?php
}else{
	echo _("You don't have permission to access this page");
}

include 'templates/footer.php';
?>
