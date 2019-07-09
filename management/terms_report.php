<?php

// @file management/terms_report.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Terms Report');
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;

?>


<table class="headerTable">
<tr><td>
<br />

<b><?php echo _("Limit by Expression Type:");?></b>

<select name='expressionTypeID' id='expressionTypeID' onchange='javascript:updateTermsReport();'>

<?php

	$display = array();
	$expressionType = new ExpressionType();

	foreach($expressionType->allAsArray() as $display) {
		if (($display['noteType'] == 'Display') && ($display['shortName'] != "Interlibrary Loan (additional notes)")){
			if ($display['shortName'] == "Interlibrary Loan"){
				echo "<option value='" . $display['expressionTypeID'] . "' selected>" . $display['shortName'] . "</option>";
			}else{
				echo "<option value='" . $display['expressionTypeID'] . "'>" . $display['shortName'] . "</option>";
			}
		}
	}

?>

</select>


<br />

<div id='div_report'>

</div>

</td>
</tr>
</table>
</center>

<script type="text/javascript" src="js/terms_report.js"></script>
<?php
include 'templates/footer.php';
?>
