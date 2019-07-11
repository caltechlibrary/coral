<?php

// @file reports/index.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();
ob_start();

// print header
$pageTitle = 'Home';
include 'templates/header.php';

?>

<center>
	<form name="reportlist" method="post" onsubmit=" return daterange_onsubmit()" action="report.php">
		<table class='noborder' cellpadding="0" cellspacing="0" style="width: 699px; text-align: left;">
			<tr>
				<td class="noborder" id="title-td" style="text-align: right;">
					<div id="main-title">
		                <img src="images/title-icon-reports.png" />
		                <span id="main-title-text">
		                	<?php echo _("Usage Reports"); ?>
		                </span>
		                <span id="powered-by-text">
		                	<?php echo _("Powered by");?><img src="images/logo-coral.jpg" />
		                </span>
		            </div>
					<span id="setLanguage">
						<select name="lang" id="lang" class="dropDownLang">
				           <?php
				            // Get all translations on the 'locale' folder
				            $route='locale';
				            $lang[]="en_US"; // add default language
				            if (is_dir($route)) {
				                if ($dh = opendir($route)) {
				                    while (($file = readdir($dh)) !== false) {
				                        if (is_dir("$route/$file") && $file!="." && $file!=".."){
				                            $lang[]=$file;
				                        }
				                    }
				                    closedir($dh);
				                }
				            }else {
				                echo "<br>"._("Invalid translation route!");
				            }
				            // Get language of navigator
				            $defLang = $lang_name->getBrowserLanguage();

				            // Show an ordered list
				            sort($lang);
				            for($i=0; $i<count($lang); $i++){
				                if(isset($_COOKIE["lang"])){
				                    if($_COOKIE["lang"]==$lang[$i]){
				                        echo "<option value='".$lang[$i]."' selected='selected'>".$lang_name->getNameLang($lang[$i])."</option>";
				                    }else{
				                        echo "<option value='".$lang[$i]."'>".$lang_name->getNameLang($lang[$i])."</option>";
				                    }
				                }else{
				                    if($defLang==substr($lang[$i],0,5)){
				                        echo "<option value='".$lang[$i]."' selected='selected'>".$lang_name->getNameLang($lang[$i])."</option>";
				                    }else{
				                        echo "<option value='".$lang[$i]."'>".$lang_name->getNameLang($lang[$i])."</option>";
				                    }
				                }
				            }
				            ?>
				        </select>
					</span>
					<span id="help-span">
						<a href="https://js-erm-helps.bc.sirsidynix.net" target="_blank">
							<?php echo _("Help");?>
						</a><span id='divider'> | </span>
					</span>

				</td>
			</tr>
			<tr>
				<td class="fullborder"><br /> <br />
					<div id='div_report'>
						<label for="reportID">
							<?php echo _("Select Report");?>
						</label>
						<select name='reportID' id='reportID' class='opt'>
							<option value=''></option>
<?php
// get all reports for output in drop down

$db = DBServiceReports::getInstance();
foreach ( $db->query("SELECT reportID, reportName FROM Report ORDER BY 2, 1")->fetchRows(MYSQLI_ASSOC) as $report ){
	echo "<option value='" . $report['reportID'] . "' ";
	if (isset($report['reportID']) && isset($_GET['reportID']) && $report['reportID'] === $_GET['reportID']){
		echo 'selected';
	}
	echo ">" . $report['reportName'] . "</option>";
}
unset($db);
?>
						</select>
					</div>
					<div id='div_parm'>
<?php
if (isset($_GET['reportID']))
{
	$reportID = $_GET['reportID'];
}
else if (isset($_SESSION['reportID']))
{
	$reportID = $_SESSION['reportID'];
	unset($_SESSION['reportID']);
}

if (isset($reportID))
{
	$report = ReportFactory::makeReport($reportID);
	Parameter::$ajax_parmValues = array();
	foreach ( $report->getParameters() as $parm )
	{
		$parm->form();
	}
	Parameter::$ajax_parmValues = null;
}
else
{
	echo "<br />";
}

?>
					</div>
					<input type='hidden' name='rprt_output' value='web'/>
					<br /><br />
					<input type="submit" value="<?php echo _("Submit");?>" name="submitbutton" id="submitbutton"/>
					<input type="button" value="<?php echo _("Reset");?>" name="resetbutton" id="resetbutton" onclick="javascript:clearParms();"/>
				</td>
			</tr>
		</table>
	</form>
</center>
<br />
<br />

<script type="text/javascript" src="js/index.js"></script>

<?php
// print footer
include 'templates/footer.php';
ob_end_flush();
?>
<script>
    $("#lang").change(function() {
        setLanguage($("#lang").val());
        location.reload();
    });

    function setLanguage(lang) {
		var wl = window.location, now = new Date(), time = now.getTime();
        var cookievalid=2592000000; // 30 days (1000*60*60*24*30)
        time += cookievalid;
		now.setTime(time);
		document.cookie ='lang='+lang+';path=/'+';domain='+wl.hostname+';expires='+now;
    }
</script>
