<?php

// @file resources/api/index.php
// @TODO changes to the Composer setup for the API are likely needed

require_once __DIR__ . '/../../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/..');

$api = new Api();
$cost = new Cost();

if (!$api->isAllowed()) {
    header('HTTP/1.0 403 Forbidden');
    echo "Unauthorized IP: " . $_SERVER['REMOTE_ADDR'];
    die();
}

Flight::route('/proposeResource/', function(){

    $user = $api->userExists(Flight::request()->data['user']) ? Flight::request()->data['user'] : 'API';
    $status = new Status();
    $resource = new Resource();
    $resource->createDate = date( 'Y-m-d' );
    $resource->createLoginID = $user;
    $resource->statusID = $status->getIDFromName('progress');
    $resource->updateDate                   = '';
    $resource->updateLoginID                = '';
    $resource->orderNumber                  = '';
    $resource->systemNumber                 = '';
    $resource->userLimitID                  = '';
    $resource->authenticationUserName       = '';
    $resource->authenticationPassword       = '';
    $resource->storageLocationID            = '';
    $resource->registeredIPAddresses        = '';
    $resource->coverageText                 = '';
    $resource->archiveDate                  = '';
    $resource->archiveLoginID               = '';
    $resource->workflowRestartDate          = '';
    $resource->workflowRestartLoginID       = '';
    $resource->currentStartDate             = '';
    $resource->currentEndDate               = '';
    $resource->subscriptionAlertEnabledInd  = '';
    $resource->authenticationTypeID         = '';
    $resource->accessMethodID               = '';
    $resource->recordSetIdentifier          = '';
    $resource->hasOclcHoldings              = '';
    $resource->numberRecordsAvailable       = '';
    $resource->numberRecordsLoaded          = '';
    $resource->bibSourceURL                 = '';
    $resource->catalogingTypeID             = '';
    $resource->catalogingStatusID           = '';
    $resource->mandatoryResource            = '';
    $resource->resourceID                   = null;

    $fieldNames = array("titleText", "descriptionText", "providerText", "resourceURL", "resourceAltURL", "noteText", "resourceTypeID", "resourceFormatID");
    foreach ($fieldNames as $fieldName) {
        $resource->$fieldName = Flight::request()->data->$fieldName;
    }
    try {
        $resource->save();
        $resourceID = $resource->primaryKey;
        $resource = new Resource(new NamedArguments(array('primaryKey' => $resourceID)));

		if (isset(Flight::request()->data->isbn)){
		    $isbnIssnArray = (is_array(Flight::request()->data->isbn))? Flight::request()->data->isbn : array(Flight::request()->data->isbn);
			$resource->setIsbnOrIssn($isbnIssnArray);
		}

		// Create the default order
		$resourceAcquisition = new ResourceAcquisition();
		$resourceAcquisition->resourceID = $resourceID;
		$resourceAcquisition->subscriptionStartDate = date("Y-m-d");
		$resourceAcquisition->subscriptionEndDate = date("Y-m-d");
		$resourceAcquisition->acquisitionTypeID = Flight::request()->data->acquisitionTypeID;
		$resourceAcquisition->save();

        //add administering site
        if (Flight::request()->data['administeringSiteID']) {
            foreach (Flight::request()->data['administeringSiteID'] as $administeringSiteID) {
                $resourceAdministeringSiteLink = new ResourceAdministeringSiteLink();
                $resourceAdministeringSiteLink->resourceAdministeringSiteLinkID = '';
                $resourceAdministeringSiteLink->resourceAcquisitionID = $resourceAcquisition->resourceAcquisitionID;
                $resourceAdministeringSiteLink->administeringSiteID = $administeringSiteID;
                try {
                    $resourceAdministeringSiteLink->save();
                } catch (Exception $e) {
                    echo $e->getMessage();
                }
            }
        }

        // add home location
        foreach (array("homeLocationNote" => "Home Location") as $key => $value) {
            if (Flight::request()->data[$key]) {
                $noteType = new NoteType();
                $noteTypeID = $value ? $api->createNoteType($value) : $noteType->getInitialNoteTypeID();
                $resourceNote = new ResourceNote();
                $resourceNote->resourceNoteID   = '';
                $resourceNote->updateLoginID    = $user;
                $resourceNote->updateDate       = date( 'Y-m-d' );
                $resourceNote->noteTypeID       = $noteTypeID;
                $resourceNote->tabName          = 'Product';
                $resourceNote->entityID         = $resourceID;
                $resourceNote->noteText         = Flight::request()->data[$key];
                $resourceNote->save();
            }
        }

        // General notes
        $noteText = '';
        foreach (array("noteText" => "Note", "providerText" => "Provider", "publicationYear" => "Publication Year or order start date", "edition" => "Edition", "holdLocation" => "Hold location", "patronHold" => "Patron hold", "neededByDate" => "Urgent") as $key => $value) {
            if (isset(Flight::request()->data[$key])) {
                $noteText .= $value . ": " . Flight::request()->data[$key] . "\n";
            }

        }
        if ($noteText) {
            $noteType = new NoteType();
            $noteTypeID = $noteType->getInitialNoteTypeID();
            $resourceNote = new ResourceNote();
            $resourceNote->resourceNoteID   = '';
            $resourceNote->updateLoginID    = $user;
            $resourceNote->updateDate       = date( 'Y-m-d' );
            $resourceNote->noteTypeID       = $noteTypeID;
            $resourceNote->tabName          = 'Product';
            $resourceNote->entityID         = $resourceID;
            $resourceNote->noteText         = $noteText;
            $resourceNote->save();
        }

        // add existing license and/or license required
        $noteText = '';
        foreach (array("licenseRequired" => "License required?", "existingLicense" => "Existing License?") as $key => $value) {
            $noteText .= $value . " " . Flight::request()->data[$key] . "\n";
        }
        if ($noteText) {
            $noteTypeID = $api->createNoteType("License Type");
            $resourceNote = new ResourceNote();
            $resourceNote->resourceNoteID   = '';
            $resourceNote->updateLoginID    = $user;
            $resourceNote->updateDate       = date( 'Y-m-d' );
            $resourceNote->noteTypeID       = $noteTypeID;
            $resourceNote->tabName          = 'Acquisitions';
            $resourceNote->entityID         = $resourceAcquisition->resourceAcquisitionID;
            $resourceNote->noteText         = $noteText;
            $resourceNote->save();
        }

        // add CM Ranking
        foreach (array("CMRanking" => "CM Ranking") as $key => $value) {
            if (Flight::request()->data[$key]) {
                $noteTypeID = $api->createNoteType("CM Ranking");
                $resourceNote = new ResourceNote();
                $resourceNote->resourceNoteID   = '';
                $resourceNote->updateLoginID    = $user;
                $resourceNote->updateDate       = date( 'Y-m-d' );
                $resourceNote->noteTypeID       = $noteTypeID;
                $resourceNote->tabName          = 'Product';
                $resourceNote->entityID         = $resourceID;
                $resourceNote->noteText         = $value . ": " . Flight::request()->data[$key];
                $resourceNote->save();
            }
        }

        // add CM Important Factor
        $noteText = '';
        foreach (array("ripCode" => "RIP code", "subjectCoverage" => "Subject coverage", "audience" => "Audience", "frequency" => "Frequency and language", "access" => "Access via indexes", "contributingFactors" => "Contributing factors") as $key => $value) {
            if (Flight::request()->data[$key]) {
                $noteText .= $value . ": " . Flight::request()->data[$key] . "\n";
            }
        }
        if ($noteText) {
            $noteTypeID = $api->createNoteType("CM Important Factor");
            $resourceNote = new ResourceNote();
            $resourceNote->resourceNoteID   = '';
            $resourceNote->updateLoginID    = $user;
            $resourceNote->updateDate       = date( 'Y-m-d' );
            $resourceNote->noteTypeID       = $noteTypeID;
            $resourceNote->tabName          = 'Product';
            $resourceNote->entityID         = $resourceID;
            $resourceNote->noteText         = $noteText;
            $resourceNote->save();
        }

        // add fund and cost
        if (Flight::request()->data['cost'] || Flight::request()->data['fund']) {
            $rp = new ResourcePayment();
            $rp->resourcePaymentID = '';
            $rp->selectorLoginID = $user;
            $rp->year = '';
            $rp->subscriptionStartDate = '';
            $rp->subscriptionEndDate = '';
            $rp->costDetailsID = '';
            $rp->costNote = '';
            $rp->invoiceNum = '';
            $rp->resourceAcquisitionID = $resourceAcquisition->resourceAcquisitionID;
            $rp->paymentAmount = $cost->costToInteger(Flight::request()->data['cost']);
            $rp->currencyCode = 'USD';
            $rp->orderTypeID = 2;
            $rp->priceTaxExcluded = '';
            $rp->priceTaxIncluded = '';
            $rp->taxRate = '';
            $fundCode = Flight::request()->data['fund'];
			// Check if the fund already exists

			$fundObj = new Fund();
			$fundID = $fundObj->getFundIDFromFundCode($fundCode);

			// Add it if not
			if (!$fundID) {
               $fundObj->fundID = '';
			   $fundObj->fundCode = $fundCode;
			   $fundObj->shortName = $fundCode;
               $fundObj->archived = null;
			   $fundObj->save();
			}
			// Create the resourcePayment
			$rp->fundID = $fundID;
            $rp->save();
        }


      $resourceAcquisition->enterNewWorkflow();


    } catch (Exception $e) {
        Flight::json(array('error' => $e->getMessage()));
    }
    Flight::json(array('resourceID' => $resourceID));

});

Flight::route('/version/', function() {
    Flight::json(array('API' => 'v1'));
});

Flight::route('/getResourceTypes/', function() {
    $rt = new ResourceType();
    $resourceTypeArray = $rt->allAsArray();
    Flight::json($resourceTypeArray);
});

Flight::route('/getResourceType/@id', function($id) {
   $resourceTypeObj = new ResourceType(new NamedArguments(array('primaryKey' => $id)));
    Flight::json($resourceTypeObj->shortName);
});

Flight::route('/getAcquisitionTypes/', function() {
    $acquisitionTypeObj = new AcquisitionType();
    $acquisitionTypeArray = $acquisitionTypeObj->sortedArray();
    Flight::json($acquisitionTypeArray);
});

Flight::route('/getAcquisitionType/@id', function($id) {
    $acquisitionTypeObj = new AcquisitionType(new NamedArguments(array('primaryKey' => $id)));
    Flight::json($acquisitionTypeObj->shortName);
});

Flight::route('/getResourceFormats/', function() {
   $resourceFormatObj = new ResourceFormat();
   $resourceFormatArray = $resourceFormatObj->sortedArray();
    Flight::json($resourceFormatArray);
});

Flight::route('/getResourceFormat/@id', function($id) {
   $resourceFormatObj = new ResourceFormat(new NamedArguments(array('primaryKey' => $id)));
    Flight::json($resourceFormatObj->shortName);
});

Flight::route('/getAdministeringSites/', function() {
   $as = new AdministeringSite();
   $asArray = $as->allAsArray();
    Flight::json($asArray);
});

Flight::route('/getAdministeringSite/@id', function($id) {
   $as = new AdministeringSite(new NamedArguments(array('primaryKey' => $id)));
    Flight::json($as->shortName);
});

Flight::route('/getFundCodes/', function() {
	$funds = new Fund();
	$fundsArray = $funds->allAsArray();
	Flight::json($fundsArray);
});

Flight::route('/getFund/@fundCode', function($fundCode) {
	$fundObj = new Fund();
	$fundID = $fundObj->getFundIDFromFundCode($fundCode);
	$fund = new Fund(new NamedArguments(array('primaryKey' => $fundID)));
	Flight::json($fund->shortName);
});

Flight::route('GET /resources/@id', function($id) {
    $r = new Resource(new NamedArguments(array('primaryKey' => $id)));
	Flight::json($r->asArray());

});

Flight::route('GET /resources/', function() {
    $identifier = Flight::request()->query->identifier;
    if ($identifier) {
        $r = new Resource();
        Flight::json(array_map(function($value) { return $value->asArray(); }, $r->getResourceByIsbnOrISSN($identifier)));
    }
});

Flight::route('GET /resources/@id/packages', function($id) {
    $r = new Resource(new NamedArguments(array('primaryKey' => $id)));
	$parentResourceArray = array();
	$parentResourceIDArray = array();
	foreach ($r->getParentResources() as $instance) {
	   foreach (array_keys($instance->attributeNames) as $attributeName) {
			$sanitizedInstance[$attributeName] = $instance->$attributeName;
		}
		$sanitizedInstance[$instance->primaryKeyName] = $instance->primaryKey;
		array_push($parentResourceIDArray, $sanitizedInstance);
	}

	foreach ($parentResourceIDArray as $parentResource){
		$parentResourceObj = new Resource(new NamedArguments(array('primaryKey' => $parentResource['relatedResourceID'])));
		array_push($parentResourceArray, $parentResourceObj->asArray());
	}
    Flight::json($parentResourceArray);
});

Flight::route('GET /resources/@id/titles', function($id) {
    $r = new Resource(new NamedArguments(array('primaryKey' => $id)));
	$childResourceArray = array();
	$childResourceIDArray = array();
	foreach ($r->getChildResources() as $instance) {
	   foreach (array_keys($instance->attributeNames) as $attributeName) {
			$sanitizedInstance[$attributeName] = $instance->$attributeName;
		}
		$sanitizedInstance[$instance->primaryKeyName] = $instance->primaryKey;
		array_push($childResourceIDArray, $sanitizedInstance);
	}

	foreach ($childResourceIDArray as $childResource){
		$childResourceObj = new Resource(new NamedArguments(array('primaryKey' => $childResource['resourceID'])));
		array_push($childResourceArray, $childResourceObj->asArray());
	}
    Flight::json($childResourceArray);
});

Flight::route('GET /resources/@id/licenses', function($id) {
    $db = DBService::getInstance();
    $r = new Resource(new NamedArguments(array('primaryKey' => $id)));
    $ras = $r->getResourceAcquisitions();
    $licensesArray = array();
    foreach ($ras as $ra) {
        $rla = $ra->getLicenseArray();
        $db->changeDb('licensingDatabaseName');
        foreach($rla as $license) {
            $l = new License(new NamedArguments(array('primaryKey' => $license['licenseID'])));
            array_push($licensesArray, $l->asArray());
        }
        $db->changeDb();
    }
	Flight::json($licensesArray);
});


Flight::route('GET /organizations/@id', function($id) {
    $config = new Configuration();
    $db = DBService::getInstance();
    if ($config->settings->organizationsModule == 'Y') {
        $db->changeDb('organizationsDatabaseName');
        $organization = new Organization(new NamedArguments(array('primaryKey' => $id)));
        Flight::json($organization->asArray());
        $db->changeDb();
    } else {
        $organization = new Organization(new NamedArguments(array('primaryKey' => $id)));
        Flight::json($organization->asArray());
    }
});

Flight::start();
