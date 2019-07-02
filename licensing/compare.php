<?php

// @file licensing/compare.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Expression Comparison');
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;

?>


<table class="headerTable" style='text-align:left;'>
<tr>
<td>

	<div class="container">

		<div class="left-element">

			<b><?php echo _("Limit by Expression Type:");?></b>&nbsp;

			<select name='expressionTypeID' id='expressionTypeID' style='width:200px;'>

			<?php

				$display = array();
				$expressionType = new ExpressionType();
				$expressionTypeArray = $expressionType->allAsArray();

				foreach($expressionTypeArray as $display) {
					echo "<option value='" . $display['expressionTypeID'] . "'>" . $display['shortName'] . "</option>";
				}

				//get the first expression type so we know what to do with qualifier
				$expressionTypeID = $expressionTypeArray[0]['expressionTypeID'];
				$expressionType = new ExpressionType(new NamedArguments(array('primaryKey' => $expressionTypeID)));

				$qualifierArray = array();
				$qualifierArray = $expressionType->getQualifiers();

			?>

			</select>

			</div>

			<div class="right-element" id='div_Qualifiers'>



			<?php
			if (count($qualifierArray) > 0 ) {
			?>
				<b>Limit by Qualifier:</b>&nbsp;
				<select name='qualifierID' id='qualifierID'>
				<option value='' selected></option>
				<?php

				foreach($qualifierArray as $qualifier) {
					if (($selectedValue == $qualifier->qualifierID) && ($reset != 'Y')){
						echo "<option value='" . $qualifier->qualifierID . "' selected>" . $qualifier->shortName . "</option>\n";
					}else{
						echo "<option value='" . $qualifier->qualifierID . "'>" . $qualifier->shortName . "</option>\n";
					}

				}

				?>
				</select>

			<?php
			}else{
				echo "<input type='hidden' id='qualifierID' value='' />";
			}

			?>

		</div>
	</div>

	<div id='div_list'>

	</div>


</td>
</tr>
</table>
</center>

<script type="text/javascript" src="js/compare.js"></script>
<?php
include 'templates/footer.php';
?>
