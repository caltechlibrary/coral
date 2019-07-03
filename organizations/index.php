<?php

// @file organizations/index.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

//print header
$pageTitle=_('Home');
include 'templates/header.php';

//used for creating a "sticky form" for back buttons
//except we don't want it to retain if they press the 'index' button
//check what referring script is

if (isset($_SESSION['ref_script']) && $_SESSION['ref_script'] != "orgDetail.php") {
	$reset='Y';
}
else {
  $reset = 'N';
}

$_SESSION['ref_script']=$currentPage;

?>

<div style='text-align:left;'>
<table class="headerTable" style="background-image:url('images/header.gif');background-repeat:no-repeat;">
<tr style='vertical-align:top;'>
<td style="width:155px;padding-right:10px;">
	<table class='noBorder' id='title-search'>
	<tr><td style='text-align:left;width:75px;' align='left'>
	<span style='font-size:130%;font-weight:bold;'><?php echo _("Search");?></span><br />
	<a href='javascript:void(0)' class='newSearch'><?php echo _("new search");?></a>
	</td>
	<td><div id='div_feedback'>&nbsp;</div>
	</td></tr>
	</table>

	<table class='borderedFormTable' style="width:150px">

	<tr>
	<td class='searchRow'><label for='searchName'><b><?php echo _("Name (contains)");?></b></label>
	<br />
	<input type='text' name='searchOrganizationName' id='searchOrganizationName' style='width:145px' value="<?php if ($reset != 'Y' && isset($_SESSION['org_organizationName'])) echo $_SESSION['org_organizationName']; ?>" /><br />
	<div id='div_searchName' style='<?php if ((!isset($_SESSION['org_organizationName'])) || ($reset == 'Y')) echo "display:none;"; ?>margin-left:123px;'><input type='button' name='btn_searchOrganizationName' value='<?php echo _("go!");?>' class='searchButton' /></div>
	</td>
	</tr>


	<tr>
	<td class='searchRow'><label for='searchOrganizationRoleID'><b><?php echo _("Role");?></b></label>
	<br />
	<select name='searchOrganizationRoleID' id='searchOrganizationRoleID' style='width:150px' onchange='javsacript:updateSearch();'>
	<option value=''><?php echo _("All");?></option>
	<?php

		$display = array();
		$organizationRole = new OrganizationRole();

		foreach($organizationRole->allAsArray() as $display) {
			if ((isset($_SESSION['org_organizationRoleID'])) && ($_SESSION['org_organizationRoleID'] == $display['organizationRoleID']) && ($reset != 'Y')) {
				echo "<option value='" . $display['organizationRoleID'] . "' selected>" . $display['shortName'] . "</option>";
			}else{
				echo "<option value='" . $display['organizationRoleID'] . "'>" . $display['shortName'] . "</option>";
			}
		}

	?>
	</select>
	</td>
	</tr>


	<tr>
	<td class='searchRow'><label for='searchContact'><b><?php echo _("Contact Name (contains)");?></b></label>
	<br />
	<input type='text' name='searchContactName' id='searchContactName' style='width:145px' value="<?php if ($reset != 'Y' && isset($_SESSION['org_contactName'])) echo $_SESSION['org_contactName']; ?>" /><br />
	<div id='div_searchContact' style='<?php if ((!isset($_SESSION['org_contactName'])) || ($reset == 'Y')) echo "display:none;"; ?>margin-left:123px;'><input type='button' name='btn_searchContactName' value='<?php echo _("go!");?>' class='searchButton' /></div>
	</td>
	</tr>


	<tr>
	<td class='searchRow'><label for='searchFirstLetter'><b><?php echo _("Starts with");?></b></label>
	<br />
	<?php
	$organization = new Organization();

	$alphArray = range('A','Z');
	$orgAlphArray = $organization->getAlphabeticalList;

	foreach ($alphArray as $letter){
		if ((isset($orgAlphArray[$letter])) && ($orgAlphArray[$letter] > 0)){
			echo "<span class='searchLetter' id='span_letter_" . $letter . "'><a href='javascript:setStartWith(\"" . $letter . "\")'>" . $letter . "</a></span>";
			if ($letter == "N") echo "<br />";
		}else{
			echo "<span class='searchLetter'>" . $letter . "</span>";
			if ($letter == "N") echo "<br />";
		}
	}


	?>
	<br />
	</td>
	</tr>

	</table>
	&nbsp;<a href='javascript:void(0)' class='newSearch' id='sidebar-link-bottom'><?php echo _("new search");?></a>
	</div>
</td>
<td>
<div id='div_searchResults'></div>
</td></tr>
</table>
</div>
<br />
<script type="text/javascript" src="js/index.js"></script>
<script type='text/javascript'>
<?php
  //used to default to previously selected values when back button is pressed
  //if the startWith is defined set it so that it will default to the first letter picked
  if ((isset($_SESSION['org_startWith'])) && ($reset != 'Y')){
	  echo "startWith = '" . $_SESSION['org_startWith'] . "';";
	  echo "$(\"#span_letter_" . $_SESSION['org_startWith'] . "\").removeClass('searchLetter').addClass('searchLetterSelected');";
  }

  if ((isset($_SESSION['org_pageStart'])) && ($reset != 'Y')){
	  echo "pageStart = '" . $_SESSION['org_pageStart'] . "';";
  }

  if ((isset($_SESSION['org_numberOfRecords'])) && ($reset != 'Y')){
	  echo "numberOfRecords = '" . $_SESSION['org_numberOfRecords'] . "';";
  }

  if ((isset($_SESSION['org_orderBy'])) && ($reset != 'Y')){
	  echo "orderBy = \"" . $_SESSION['org_orderBy'] . "\";";
  }

  echo "</script>";

  //print footer
  include 'templates/footer.php';
?>
