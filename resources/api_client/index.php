<?php

// @file resources/api_client/index.php
// @TODO changes to the Composer setup for the API are likely needed

require_once __DIR__ . '/../../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/..');

$api = new Api();
$cost = new Cost();

$server = "http://coral.local/resources/api/";
$user = $_SERVER['REMOTE_USER'] ? $_SERVER['REMOTE_USER'] : 'API';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
    <link rel="SHORTCUT ICON" href="../images/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!--<link rel="stylesheet" href="pure-min.css">-->
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/grids-responsive-old-ie-min.css">
    <![endif]-->
    <!--[if gt IE 8]><!-->
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/grids-responsive-min.css">
    <!--<![endif]-->

    <link rel="stylesheet" href="../css/style.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="../css/thickbox.css" type="text/css" media="screen" />

    <link rel="stylesheet" href="local.css">
</head>
<body>
    <h1>Simple Resources module API client</h1>
    <h2>Propose a resource</h2>
<?php
$headers = array("Accept" => "application/json");
$body = array();
if (isset($_POST['submitProposeResourceForm'])) {
    $fieldNames = array("user", "titleText", "descriptionText", "isbn", "providerText", "resourceURL", "resourceAltURL", "noteText", "resourceTypeID", "resourceFormatID", "acquisitionTypeID", "administeringSiteID", "homeLocationNote", "licenseRequired", "existingLicense", "publicationYear", "edition", "holdLocation", "patronHold", "CMRanking", "subjectCoverage", "audience", "frequency", "access", "contributingFactors", "ripCode", "fund", "cost", "neededByDate");

    foreach ($fieldNames as $fieldName) {
        if (isset($_POST[$fieldName])) {
			$body[$fieldName] = $_POST[$fieldName];
		}
    }

    /*
     * If you would like to add any additional inputs to the form and have their
     * values added as description text on the resource, uncomment the following lines
     * and add each new input name to the $descriptionFields array.
     */
//    $descriptionFields = array("author");
//
//    foreach ($descriptionFields as $descField){
//        $api->addToDescriptionText($body,$descField);
//    }

	if(!empty($body['neededByDate'])){
		$body['neededByDate'] = 'Needed by '.date("m/d/Y", strtotime($body['neededByDate']));
	} else if(isset($body['neededByDate'])){
		unset($body['neededByDate']);
	}

    $response = Unirest\Request::post($server . "proposeResource/", $headers, $body);
    if (isset($response->body->resourceID)) {
        echo "<p>The resource was correctly submitted (resource " . $response->body->resourceID . ")</p>";
        ?>
        <ul>
            <li>Title: <?php echo $_POST['titleText']; ?></li>
            <li>Description: <?php echo $_POST['descriptionText']; ?></li>
<!--            <li>Author: --><?php //echo $_POST['author']; ?><!--</li>-->
            <li>ISBN/ISSN: <?php echo $_POST['isbn']; ?></li>
            <li>Provider: <?php echo $_POST['providerText']; ?></li>
            <li>URL: <?php echo $_POST['resourceURL']; ?></li>
            <li>URL Alt: <?php echo $_POST['resourceAltURL']; ?></li>
            <li>Publication year or subscription start date: <?php echo $_POST['publicationYear']; ?></li>
            <li>Edition: <?php echo $_POST['edition']; ?></li>
            <li>Hold location: <?php echo $_POST['holdLocation']; ?></li>
            <li>Patron hold (patrons' name, email): <?php echo $_POST['patronHold']; ?></li>
            <li>Rip code (serials): <?php echo $_POST['ripCode']; ?></li>
			<?php
            if (!empty($_POST['fund'])) {
                $fundResponse = Unirest\Request::post($server . "getFund/" . $_POST['fund']);
                echo "<li>Fund shortName: " . $fundResponse->body . "</li>";
			}
			if (!empty($_POST['cost'])){
                echo "<li>Cost: $" . $cost->costToInteger($_POST['cost']) . "</li>";
			}

            $formatResponse = Unirest\Request::post($server . "getResourceFormat/" . $_POST['resourceFormatID']); ?>
            <li>Format: <?php echo $formatResponse->body; ?></li>

            <?php
            if (!empty($_POST['acquisitionTypeID'])) {
                $ATResponse = Unirest\Request::post($server . "getAcquisitionType/" . $_POST['acquisitionTypeID']); ?>
                <li>Acquisition Type: <?php echo $ATResponse->body; ?></li>
            <?php } ?>

            <?php $RTResponse = Unirest\Request::post($server . "getResourceType/" . $_POST['resourceTypeID']); ?>
            <li>Resource Type: <?php echo $RTResponse->body; ?></li>

            <?php
                if (isset($body['administeringSiteID'])) {
                    echo "<li>Library: ";
                    foreach($body['administeringSiteID'] as $as) {
                        $ASResponse = Unirest\Request::post($server . "getAdministeringSite/" . $as);
                        $libraries[] = $ASResponse->body;
                    }
                    echo implode(' / ', $libraries) . "</li>";
                }
            ?>
            <li>License required?: <?php echo $_POST['licenseRequired']; ?></li>
            <li>Existing license?: <?php echo $_POST['existingLicense']; ?></li>
            <li>Home Location: <?php echo $_POST['homeLocationNote']; ?></li>
			<?php
			if (isset($_POST['neededByDate']) && $_POST['neededByDate'] != "") {
				echo '<li>Urgent: Needed by: ' . $body['neededByDate'] . '.</li>';
			} ?>
            <li>Notes: <?php echo $_POST['noteText']; ?></li>
            <li>CM ranking: <?php echo $_POST['CMRanking']; ?></li>
            <li>Subject coverage: <?php echo $_POST['subjectCoverage']; ?></li>
            <li>Audience: <?php echo $_POST['audience']; ?></li>
            <li>Frequency and language: <?php echo $_POST['frequency']; ?></li>
            <li>Access via indexes: <?php echo $_POST['access']; ?></li>
            <li>Contributing factors: <?php echo $_POST['contributingFactors']; ?></li>
        </ul>
        <?php
    } else {
        echo "<p>The resource could not be submitted. (error: " . $response->body->error . ")</p>";
    }
    echo '<a href="index.php">Submit another resource</a>';
} else {
  // Checking if the API is up
  $response = Unirest\Request::get($server . "version/", $headers, $body);
  if ($response->code != 200) {
      if ($response->code == 403) {
        echo "<p>You are not authorized to use this service.</p>";
        echo $response->body;
      }
      elseif ($response->code == 500) {
        echo "<p>This service encountered an error.</p>";
      }
      else{
          echo "<p>There was an error.</p>";
      }
  } else {
?>
    <form name="proposeResourceForm" action="index.php" method="POST" class="pure-form pure-form-stacked">
        <fieldset>
            <legend>Product</legend>
            <div class="pure-g">
                <div class="pure-u-1">
                    <label for="titleText">Title: *</label>
                    <input id="titleText" name="titleText" type="text" class="pure-u-1 pure-u-md-1-2" oninvalid="setCustomValidity('Please submit a title for the resource.')" required/>
                </div>
                <div class="pure-u-1">
                    <label for="descriptionText">Description: </label>
                    <textarea name="descriptionText" rows="5" class="pure-u-1 pure-u-md-1-2"></textarea>
                </div>
<!--                <div class="pure-u-1">-->
<!--                    <label for="author">Author: </label>-->
<!--                    <input name="author" type="text" class="pure-u-1 pure-u-md-1-3"/>-->
<!--                </div>-->
                <div class="pure-u-1">
                    <label for="isbn">ISBN/ISSN: </label>
                    <input name="isbn" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="providerText">Provider: </label>
                    <input name="providerText" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="resourceURL">URL: </label>
                    <input name="resourceURL" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="resourceAltURL">URL Alt: </label>
                    <input name="resourceAltURL" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="publicationYear">Publication year or subscription start date: </label>
                    <input name="publicationYear" type="text" class="pure-u-1 pure-u-md-1-5"/>
                </div>
                <div class="pure-u-1">
                    <label for="edition">Edition: </label>
                    <input name="edition" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="holdLocation">Hold location (patron pickup library for item held)</label>
                    <input name="holdLocation" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="patronHold">Patron hold (patrons' name, email)</label>
                    <input name="patronHold" type="text" class="pure-u-1 pure-u-md-1-3"/>
                </div>
                <div class="pure-u-1">
                    <label for="ripCode">RIP code (serials)</label>
                    <input name="ripCode" type="text" class="pure-u-1 pure-u-md-1-4"/>
                </div>
                <div class="pure-u-1">
                    <label for="fund">Fund code</label>
					<?php getFundCodesAsDropdown($server, $headers, $body); ?>
                </div>
                <div class="pure-u-1">
                    <label id="costLabel" for="cost">Cost</label>
                    <input id="cost" name="cost" type="number" min="0" step="0.01" class="pure-u-1 pure-u-md-1-6"/>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <div class="pure-g">
                <div id='urgentDiv' class="pure-u-1">
                    <label for="urgent" >Urgent?</label>
                    <input id='urgent' type="checkbox" >
                    <label class="urgent" for="neededByDate" >Needed By:</label>
                    <input class="urgent" type="date" id="neededByDate" name="neededByDate" >
                </div>
                <div class="pure-u-1">
                    <label for="resourceFormatID">Format</label>
					<?php getResourceFormatsAsDropdown($server, $headers, $body); ?>
                </div>

                <div class="pure-u-1">
                    <p>Acquisition Type:</p>
					<?php getAcquisitionTypesAsRadio($server, $headers, $body); ?>
                </div>

                <div class="pure-u-1">
                    <label for="resourceTypeID">Resource Type</label>
					<?php getResourceTypesAsDropdown($server, $headers, $body); ?>
                </div>

                <div class="pure-u-1">
                    <label for="administeringSiteID[]">Library</label>
					<?php getAdministeringSitesAsDropdown($server, $headers, $body); ?>
                </div>

                <div class="pure-u-1">
                    <label for="licenseRequired">License required?</label>
                    <input type="radio" name="licenseRequired" value="Yes"/> Yes
                    <input type="radio" name="licenseRequired" value="No"/> No
                    <input type="radio" name="licenseRequired" value="Don't know" checked="checked"/> Don't
                    know
                </div>

                <div class="pure-u-1">
                    <label for="existingLicense">Existing license?</label>
                    <input type="radio" name="existingLicense" value="Yes"/> Yes
                    <input type="radio" name="existingLicense" value="No"/> No
                    <input type="radio" name="existingLicense" value="Don't know" checked="checked"/> Don't
                    know
                </div>

                <div class="pure-u-1">
                    <label for="homeLocationNote">Home Location</label>
                    <select name="homeLocationNote">
                        <option value="Stacks">Stacks</option>
                        <option value="References">References</option>
                        <option value="Reserves">Reserves</option>
                        <option value="Online">Online</option>
                        <option value="Teach DVD">Teach DVD</option>
                        <option value="Circulating DVD">Circulating DVD</option>
                        <option value="Media (Branch)">Media (Branch)</option>
                        <option value="Other">Other (please specify it in Notes)</option>
                    </select>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <div class="pure-g">
                <div class="pure-u-1">
                    <p>Notes</p>
                    <label for="noteText">Include any additional information</label>
                    <textarea name="noteText" rows="5" class="pure-u-1 pure-u-md-1-2"></textarea><br/>
                </div>
            </div>
        </fieldset>


        <h2>The following fields are for collection managers' decision use.</h2>
        <fieldset>
            <label for="CMRanking">CM ranking</label>
            <select name="CMRanking">
                <option value="1">High</option>
                <option value="2">Medium</option>
                <option value="3">Low</option>
            </select>

            <div class="pure-u-1">
                <label for="subjectCoverage">Subject coverage: </label><textarea name="subjectCoverage"></textarea><br />
            </div>

            <div class="pure-u-1">
                <label for="audience">Audience: </label><textarea name="audience"></textarea><br />
            </div>

            <div class="pure-u-1">
                <label for="frequency">Frequency and language: </label><textarea name="frequency"></textarea><br />
            </div>

            <div class="pure-u-1">
                <label for="access">Access via indexes: </label><textarea name="access"></textarea><br />
            </div>

            <div class="pure-u-1">
                <label for="contributingFactors">Contributing factors: </label><textarea name="contributingFactors"></textarea><br />
            </div>

        </fieldset>

        <input type="hidden" name="user" value="<?php echo $user; ?>">

        <button type="submit" class="pure-button pure-button-primary" name="submitProposeResourceForm">
            Submit
        </button>
    </form>

<?php
}
}

function getResourceTypesAsDropdown($server, $headers, $body) {
    $response = Unirest\Request::post($server . "getResourceTypes/", $headers, $body);
    echo '<select name="resourceTypeID" class="pure-u-1 pure-u-md-1-4">';
    foreach ($response->body as $resourceType) {
        echo ' <option value="' . $resourceType->resourceTypeID  . '">' . $resourceType->shortName . "</option>";
    }
    echo '</select>';
}

function getAcquisitionTypesAsRadio($server, $headers, $body) {
    $response = Unirest\Request::post($server . "getAcquisitionTypes/", $headers, $body);
    foreach ($response->body as $AcquisitionType) {
        $default = (isset($AcquisitionType->shortName) && strtolower($AcquisitionType->shortName) == "approved")? ' checked':'' ;  //Replace 'approved' with your default
        if (strtolower($AcquisitionType->shortName) == "approved" || strtolower($AcquisitionType->shortName) == "needs approval") {
            echo ' <label for="acquisitionType'.$AcquisitionType->acquisitionTypeID.'" class="pure-radio"> ';
            echo ' <input id="acquisitionType'.$AcquisitionType->acquisitionTypeID.'" type="radio" name="acquisitionTypeID" value="' . $AcquisitionType->acquisitionTypeID . '" '.$default.'> ';
            echo $AcquisitionType->shortName . '</label>';
        }
    }
}

function getResourceFormatsAsDropdown($server, $headers, $body) {
    $response = Unirest\Request::post($server . "getResourceFormats/", $headers, $body);
    echo '<select name="resourceFormatID">';
    foreach ($response->body as $resourceFormat) {
        echo ' <option value="' . $resourceFormat->resourceFormatID . '">' . $resourceFormat->shortName . "</option>\n";
    }
    echo '</select>';
}

function getAdministeringSitesAsDropdown($server, $headers, $body) {
    $response = Unirest\Request::post($server . "getAdministeringSites/", $headers, $body);
    echo '<select name="administeringSiteID[]" multiple="multiple">';
    foreach ($response->body as $administeringSite) {
        echo ' <option value="' . $administeringSite->administeringSiteID . '">' . $administeringSite->shortName . "</option>\n";
    }
    echo '</select>';
}

function getFundCodesAsDropdown($server, $headers, $body) {
	$response = Unirest\Request::post($server . "getFundCodes/", $headers, $body);
	echo "<select name='fund'>\n";
	echo "  <option value=''>unknown</option>\n";
	foreach ($response->body as $fund) {
        if (!is_null($fund->fundCode) && !is_null($fund->shortName) && is_null($fund->archived)){
			echo ' <option value="' . $fund->fundCode . '">' . $fund->shortName ."</option>\n";
		}
	}
	echo '</select>';
}

?>
</body>
</html>
