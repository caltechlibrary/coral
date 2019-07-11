<?php

/* ------ Class Imports --------- */
/*
 * TODO: Use namespaces
 * This importer need the Organization classes to create new Orgs from EBSCO Kb.
 * But the current classes aren't namespaced and trying to include the classes manually creats conflicts with __autoload()
 * function in directory.php // @TODO review after change to bootstrap.php
 *
 * Right now it's using sql inserts instead of the class methods.
 *
 * When the classes are namespaced, the following code can be cleaned up:
 * Either call the namespaced classes directly:
 *
 *      $organization = new \Organization\Admin\Classes\Domain\Organization
 *
 * OR utilize php's "use" function and then call the class directly, new Organization.
 *
 *      use \Organization\Admin\Classes\Domain\Organization
 *      $organization = new Organization;
 *
 * Then use the class methods to deal with organizations
 */


/* ------ Filter inputs --------- */
// TODO:: switch this to filter_input_array instead
// All
$importType = filter_input(INPUT_POST,'importType', FILTER_SANITIZE_STRING);
$resourceStatus = filter_input(INPUT_POST,'status', FILTER_SANITIZE_STRING);
$organizationId = filter_input(INPUT_POST,'organizationId', FILTER_SANITIZE_NUMBER_INT);
$resourceFormatId = filter_input(INPUT_POST,'resourceFormatId', FILTER_SANITIZE_NUMBER_INT);
$acquisitionTypeId = filter_input(INPUT_POST,'acquisitionTypeId', FILTER_SANITIZE_NUMBER_INT);
$noteText = filter_input(INPUT_POST,'noteText', FILTER_SANITIZE_STRING);
$providerText = trim(filter_input(INPUT_POST,'providerText', FILTER_SANITIZE_STRING));

// Package
$packageId = filter_input(INPUT_POST,'packageId', FILTER_SANITIZE_NUMBER_INT);
$vendorId = filter_input(INPUT_POST,'vendorId', FILTER_SANITIZE_NUMBER_INT);
$providerOption = filter_input(INPUT_POST,'providerOption', FILTER_SANITIZE_STRING);
$parentOrChild = filter_input(INPUT_POST,'providerParentOrChild', FILTER_SANITIZE_STRING);
$resourceTypeId = filter_input(INPUT_POST,'resourceTypeId', FILTER_SANITIZE_NUMBER_INT);
$titleFilter = filter_input(INPUT_POST,'titleFilter', FILTER_SANITIZE_STRING);
$aliasTypeId = filter_input(INPUT_POST,'aliasTypeId', FILTER_SANITIZE_NUMBER_INT);
$workflowOption = filter_input(INPUT_POST, 'workflowOption', FILTER_SANITIZE_STRING);

// Title
$titleId = filter_input(INPUT_POST,'titleId', FILTER_SANITIZE_NUMBER_INT);

// Batch
$selection = filter_input(INPUT_POST,'selection', FILTER_SANITIZE_NUMBER_INT);
$newWorkflow = filter_input(INPUT_POST,'newWorkflow', FILTER_VALIDATE_BOOLEAN);
$offset = filter_input(INPUT_POST, 'offset', FILTER_SANITIZE_NUMBER_INT);
$parentId = filter_input(INPUT_POST, 'parentId', FILTER_SANITIZE_NUMBER_INT);


/* ------ Additional setup --------- */
// Is the org module used
$config = new Configuration;
$orgModule = $config->settings->organizationsModule == 'Y';


//determine status id for all the imports
$status = new Status();
$statusId = $status->getIDFromName($resourceStatus);

// Set the organization role as provider
$organizationRole = new OrganizationRole();
$organizationRoleId = $organizationRole->getProviderID();

// cache for subjects so we don't have to keep pinging the DB to check if an org exists
$generalSubjectCache = [];
$generalDetailIdCache = [];

// cache for resource types so we don't have to keep pinging the DB to check if an org exists
$resourceTypeCache = [];

// Setup the ebsco connection
$ebscoKb = EbscoKbService::getInstance();
$ebscoKbImport = new EbscoKbImport();

/* ------ Check user input errors --------- */
$errors = [];
if(empty($resourceFormatId)) {
    $errors[] = $ebscoKbImport->createError('resourceTypeId', 'No Resource Type selected');
}
if(empty($acquisitionTypeId)) {
    $errors[] = $ebscoKbImport->createError('acquisitionTypeId', 'No Acquisition Type selected');
}
if(empty($importType)){
    $errors[] = $ebscoKbImport->createError('general', 'No import type set');
}
if(empty($statusId)) {
    $errors[] = $ebscoKbImport->createError('general', 'Status not found');
}

if($importType == 'batch'){

    // Is the package id set
    if(!isset($packageId)) {
        $errors[] = $ebscoKbImport->createError('general', 'No package ID found');
    }
    // Is the vendor id set
    if(!isset($vendorId)) {
        $errors[] = $ebscoKbImport->createError('general', 'No vendor ID found');
    }
    // Is the selection set
    if(!isset($selection)) {
        $errors[] = $ebscoKbImport->createError('general', 'Selection not identified');
    }
    // Is the offset set
    if(!isset($offset)){
        $errors[] = $ebscoKbImport->createError('general', 'No offset array provided');
    }
    // Make sure the parent exists
    if(!empty($parentId)){
        try {
            new Resource(new NamedArguments(['primaryKey' => $parentId]));
        } catch (Exception $e){
            $errors[] = $ebscoKbImport->createError('general', 'Parent package does not exist');
        }
    }
}

if($importType == 'package'){
    // Is the package id set
    if(!isset($packageId)) {
        $errors[] = $ebscoKbImport->createError('general', 'No package ID found');
    }
    // Is the vendor id set
    if(!isset($vendorId)) {
        $errors[] = $ebscoKbImport->createError('general', 'No vendor ID found');
    }
    // Is the providerOption set
    if(empty($organizationId) && empty($providerOption)){
        $errors[] = $ebscoKbImport->createError('providerOption', 'Please select a provider import option');
    }
    // Is the alias type option set
    if($providerOption == 'alias' && empty($aliasTypeId)){
        $errors[] = $ebscoKbImport->createError('aliasType', 'Please select an alias type');
    }
    // Is the organization ID set if adding an alias or parent/child relationship
    if(($providerOption == 'parentChild' || $providerOption == 'alias') && empty($organizationId)){
        $errors[] = $ebscoKbImport->createError('organization', 'You must select an organization');
    }
    // alias & parent/child require the org module
    if(($providerOption == 'parentChild' || $providerOption == 'alias') && !$orgModule){
        $errors[] = $ebscoKbImport->createError('organization', 'The organization module is not in use. You cannot import an alias or parent child relationship');
    }
    // If the provider option is parentChild, is the option selected
    if($providerOption == 'parentChild' && empty($parentOrChild)){
        $errors[] = $ebscoKbImport->createError('parentOrChild', 'You must select either a parent or child relationship');
    }
    // Is the title filter set
    if(empty($titleFilter)){
        $errors[] = $ebscoKbImport->createError('titleFilter', 'You must select which set of titles to import');
    }
    // Is the workflow option set
    if($titleFilter != 'none' && empty($workflowOption)){
        $errors[] = $ebscoKbImport->createError('workflowOption', 'You must select if you want to start a workflow for all titles or only the package');
    }
}

if($importType == 'title'){
    // Is the title id set
    if(!isset($titleId)) {
        $errors[] = $ebscoKbImport->createError('general', 'No title ID found');
    }
}

// Send errors to be rendered
if(!empty($errors)){
    $ebscoKbImport->sendErrors($errors);
}

/* ------ Batch Import --------- */
if($importType == 'batch'){
    $count = EbscoKbService::$defaultSearchParameters['count'];
    $ebscoKb->createQuery([
        'selection' => $selection,
        'count' => $count,
        'offset' => $offset,
        'type' => 'titles',
        'vendorId' => $vendorId,
        'packageId' => $packageId,
    ]);

    // can we access the packageTitles via Ebsco KB
    // using attempts because sometimes kb times out
    $total_attempts = 5;
    $attempts = 0;
    $attempt_error = '';
    $packageTitles = [];
    do {
        $ebscoKb->execute();
        if(!empty($ebscoKb->error)){
            $attempts++;
            $attempt_error = $ebscoKb->error;
            sleep(1);
            continue;
        }
        $packageTitles = $ebscoKb->results();
        break;
    } while($attempts < $total_attempts);
    if(empty($packageTitles)){
        $ebscoKbImport->sendErrors([$ebscoKbImport->createError('general', 'Could not load package titles', $attempt_error)]);
    }

    // load the full title info from ebsco
    $titleErrors = [];
    foreach($packageTitles as $title){
        try{
            $title = $ebscoKb->getTitle($title->titleId);
            $ebscoKbImport->importTitle($title, $parentId);
        } catch (Exception $e) {
            $titleErrors[] = $ebscoKbImport->createError('general', 'Error importing title '.$title->titleName.' (KbID #'.$title->titleId.') for batch import', $e->getMessage());
        }
    }

    header('Content-type: application/json');
    echo json_encode([
        'complete' => true,
        'titleErrors' => $titleErrors,
    ]);
    exit;

}

/* ------ Title import --------- */
if($importType == 'title'){
    // can we access the package via Ebsco KB
    $title = $ebscoKb->getTitle($titleId);
    if(!empty($ebscoKb->error)){
        $ebscoKbImport->sendErrors([$ebscoKbImport->createError('general', 'Could not get package from ebsco', $ebscoKb->error)]);
    }
    $newWorkflow = true;
    $resource = $ebscoKbImport->importTitle($title);
    header('Content-type: application/json');
    echo json_encode([
        'type' => 'redirect',
        'status' => $newWorkflow ? 'progress' : 'save',
        'resourceId' => $resource->primaryKey
    ]);
    exit;
}

/* ------ Package import --------- */
if($importType == 'package') {

    // can we access the package via Ebsco KB
    $package = $ebscoKb->getPackage($vendorId, $packageId);
    if(!empty($ebscoKb->error)){
        $ebscoKbImport->sendErrors([$ebscoKbImport->createError('general', 'Could not get package from ebsco', $ebscoKb->error)]);
    }

    // setup organization
    switch($providerOption){
        case 'alias':
            $ebscoKbImport->addOrganizationAlias($organizationId, $aliasTypeId, $package->vendorId, $package->vendorName);
            break;
        case 'parentChild':
            // create a record to attached it to the provided organization ID
            $providedOrganizationId = $organizationId;
            $ebscoOrganizationId = $ebscoKbImport->createOrUpdateOrganization($package->vendorId, $package->vendorName);
            // Set which is parent/child
            $parentOrganizationId = $parentOrChild == 'parent' ? $ebscoOrganizationId : $providedOrganizationId;
            $childOrganizationId = $parentOrChild == 'parent' ? $providedOrganizationId : $ebscoOrganizationId;
            $ebscoKbImport->addOrganizationRelationship($parentOrganizationId, $childOrganizationId);
            // Set the import id to the ebsco kb vendor
            $organizationId = $ebscoOrganizationId;
            break;
        case 'import':
            $organizationId = $ebscoKbImport->createOrUpdateOrganization($package->vendorId, $package->vendorName);
            break;
        default:
            break;
    }

    $resource = $ebscoKbImport->importPackage($package);
    $count = EbscoKbService::$defaultSearchParameters['count'];
    switch($titleFilter){
        case 'all':
            $totalTitles = $package->titleCount;
            $selection = 0;
            break;
        case 'selected':
            $totalTitles = $package->selectedCount;
            $selection = 1;
            break;
        default:
            header('Content-type: application/json');
            echo json_encode([
                'type' => 'redirect',
                'status' => 'progress',
                'resourceId' => $resource->primaryKey
            ]);
            exit;
    }

    $newWorkflow = $workflowOption == 'all' ? true : false;

    // generate section batchers
    $batchAmount = $count;
    while(ceil($totalTitles/$batchAmount) > 10){
        $batchAmount += $count;
    }
    $batchers = $ebscoKbImport->generateBatchers($resource->primaryKey, $totalTitles,$batchAmount,$count);

    header('Content-type: application/json');
    echo json_encode(['type' => 'batchers', 'batchers' => $batchers, 'resourceId' => $resource->primaryKey]);
    exit;
}
