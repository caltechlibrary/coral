<?php

// @file usage/sushi.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();

//print header
$pageTitle=_('SUSHI Import');
include 'templates/header.php';



//this a SUSHI Service ID has been passed in, it needs to be run
if ((isset($_POST['sushiServiceID'])) and ($_POST['sushiServiceID'] > 0)) {
	$sushiServiceID = $_POST['sushiServiceID'];
 	$sushiService = new SushiService(new NamedArguments(array('primaryKey' => $sushiServiceID)));

 	$sushiService->setImportDates($_POST['startDate'], $_POST['endDate']);

 	//try to run!
	try {
		$logText = $sushiService->runAll($_POST['overwritePlatform']);
	} catch (Exception $e) {
		$logText = $e->getMessage();
	}

	$logText = "<div class='headerText'>" . _("Sushi Output Log:") . "</div>" . nl2br($logText) . "<br /><br />";
}

?>

	<script type="text/javascript" src="js/sushi.js"></script>

	<table class="headerTable" style="background-image:url('images/header.gif');background-repeat:no-repeat;">
		<tr><td>
			<table style='width:897px;'>
			<tr style='vertical-align:top'>
			<td><span class="headerText"><?php echo _("SUSHI Administration");?></span><br /></td>
			<td style='text-align:right;'>&nbsp;</td>
			</tr>
			</table>


			<a href='ajax_forms.php?action=getAddPlatformForm&height=150&width=325&modal=true' class='thickbox' id='uploadDocument'><?php echo _("Add new platform for SUSHI");?></a>

			<br /><br /><div id="div_run_feedback"><?php

if (isset($logText)) {
	echo $logText;
}

?></div><br />
			<div class="headerText" style='margin-bottom:9px;'><?php echo _("Outstanding Import Queue");?>&nbsp;&nbsp;&nbsp;<span id='span_outstanding_feedback'></span></div>
			<div id="div_OutstandingSushiImports"></div>

			<br /><br /><br />
			<div class="headerText" style='margin-bottom:9px;'><?php echo _("Last Failed SUSHI Imports");?>&nbsp;&nbsp;&nbsp;<span id='span_failed_feedback'></span></div>
			<div id="div_FailedSushiImports"></div>

			<br /><br /><br />
			<div class="headerText" style='margin-bottom:9px;'><?php echo _("All SUSHI Services");?>&nbsp;&nbsp;&nbsp;<span id='span_upcoming_feedback'></span></div>
			<div id="div_AllSushiServices"></div>



		</td></tr>
	</table>



<?php
  //print footer
  include 'templates/footer.php';

?>
