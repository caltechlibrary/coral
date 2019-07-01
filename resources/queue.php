<?php

// @file resources/queue.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

//set referring page
CoralSession::set('ref_script', $currentPage = '');

$pageTitle=_('My Queue');
include 'templates/header.php';

$tabs = array(array("id"=>"OutstandingTasks","spanClass"=>"OutstandingTasksNumber","text"=>"Outstanding Tasks"),
				array("id"=>"SavedRequests","spanClass"=>"SavedRequestsNumber","text"=>"Saved Requests"),
				array("id"=>"SubmittedRequests","spanClass"=>"SubmittedRequestsNumber","text"=>"Submitted Requests"));

?>


	<table class='headerTable'>
	<tr>
	<td style='margin:0;padding:0;text-align:left;'>
		<table style='width:100%; margin:0;padding:0;'>
		<tr style='vertical-align:top'>
		<td>
		<span class="headerText"><?php echo _("My Queue");?></span>
		<br />
		</td>
		</tr>
		</table>


		<table style='width:890px; text-align:left; vertical-align:top;'>
		<tr>
		<td style='width:170px;vertical-align:top;'>
			<table class='queueMenuTable' style='width:170px;'>
<?php
foreach ($tabs as $tab) {
	echo "		<tr>
					<td>
						<div class='queueMenuLink'>
							<a href='#' id='{$tab['id']}'>"._($tab['text'])."</a>
						</div>
						<span class='task-number span_".$tab['spanClass']." smallGreyText' style='clear:right; margin-left:10px;'></span>
					</td>
				</tr>";
}
?>
			</table>
		</td>
		<td class='queueRightPanel' style='width:720px;margin:0;'>
			<div id='div_QueueContent'>
			<img src = "images/circle.gif" /><?php echo _("Loading...");?>
			</div>
			<div style='margin-top:5px;' class='darkRedText' id='div_error'></div>

		</td>
		</tr>
		</table>



	</td>
	</tr>
	</table>


	<br />
	<br />

	<script type="text/javascript" src="js/queue.js"></script>

<?php
include 'templates/footer.php';
?>
