<?php

/**
 * Provides methods for importing from the EBSCO KnowledgeBase.
 */
class EbscoKbImport {

  protected $acquisitionTypeId;
  protected $config;
  protected $generalDetailIdCache;
  protected $generalSubjectCache;
  protected $loginID;
  protected $newWorkflow;
  protected $noteText;
  protected $organizationId;
  protected $organizationRoleId;
  protected $orgModule;
  protected $providerText;
  protected $resourceFormatId;
  protected $resourceStatus;
  protected $resourceTypeCache;
  protected $resourceTypeId;
  protected $selection;
  protected $statusId;

  public function __construct(
    string $acquisitionTypeId,
    Configuration $config,
    array $generalDetailIdCache,
    array $generalSubjectCache,
    int $loginID,
    bool $newWorkflow,
    string $noteText,
    int $organizationId,
    int $organizationRoleId,
    string $orgModule,
    string $providerText,
    int $resourceFormatId,
    string $resourceStatus,
    array $resourceTypeCache,
    int $resourceTypeId,
    int $selection,
    int $statusId
  ) {
    $this->acquisitionTypeId = $acquisitionTypeId;
    $this->config = $config;
    $this->generalDetailIdCache = $generalDetailIdCache;
    $this->generalSubjectCache = $generalSubjectCache;
    $this->loginID = $loginID;
    $this->newWorkflow = $newWorkflow;
    $this->noteText = $noteText;
    $this->organizationId = $organizationId;
    $this->organizationRoleId = $organizationRoleId;
    $this->orgModule = $orgModule;
    $this->providerText = $providerText;
    $this->resourceFormatId = $resourceFormatId;
    $this->resourceStatus = $resourceStatus;
    $this->resourceTypeCache = $resourceTypeCache;
    $this->resourceTypeId = $resourceTypeId;
    $this->selection = $selection;
    $this->statusId = $statusId;
  }
    public function createError($target, $text, $context = ''){
        return ['target' => $target, 'text' => _($text), 'context' => $context];
    }
    public function sendErrors($errors){
        header('Content-type: application/json');
        echo json_encode(['type' => 'error', 'error' => $errors]);
        exit;
    }

    public function generateBatchers($parentId, $totalTitles, $batchAmount, $maxReturn){
        $batchers = [];
        $totalBatchersNeeded = ceil($totalTitles/$batchAmount);
        $inc = ceil($batchAmount / $maxReturn);

        for($i=1; $i<=$totalBatchersNeeded; $i++){
            $x = ($i*$inc)-($inc-1);
            $y = $x+($inc-1);
            while($y*$maxReturn >= $totalTitles + $maxReturn){
                $y--;
            }
            $batchers[] = [
                'batchNumber' => $i,
                'batchStart' => ($x * $maxReturn) - $maxReturn + 1,
                'batchEnd' => $y * $maxReturn > $totalTitles ? $totalTitles : $y * $maxReturn,
                'importType' => 'batch',
                'batchAmount' => $batchAmount,
                'offsets' => range($x,$y),
                'parentId' => $parentId,
                'newWorkflow' => $this->newWorkflow,
                'organizationId' => $this->organizationId,
                'resourceFormatId' => $this->resourceFormatId,
                'acquisitionTypeId' => $this->acquisitionTypeId,
                'selection' => $this->selection,
                'packageId' => $this->package->packageId,
                'vendorId' => $this->package->vendorId,
                'resourceStatus' => $this->resourceStatus,
            ];
        }
        return $batchers;
    }

    public function importPackage($this->package){
        $resource = new Resource();
        $existingResource = $resource->getResourceByEbscoKbId($this->package->packageId);
        if ($existingResource){
            //get this resource
            $resource = $existingResource;
        } else {
            //set up new resource
            $resource->createLoginID = $this->loginID;
            $resource->createDate = date( 'Y-m-d' );
            $resource->updateLoginID = '';
            $resource->updateDate = '';
        }
        if($this->resourceTypeId == '-1'){
            $resource->resourceTypeID = $this->getResourceTypeId($this->package->contentType);
        } else {
            $resource->resourceTypeID = $this->resourceTypeId;
        }
        $resource->resourceFormatID = $this->resourceFormatId;
        $resource->acquisitionTypeID = $this->acquisitionTypeId;
        $resource->titleText = $this->package->packageName;
        $resource->statusID	= $this->statusId;
        $resource->orderNumber = '';
        $resource->systemNumber = '';
        $resource->userLimitID = '';
        $resource->authenticationUserName = '';
        $resource->authenticationPassword = '';
        $resource->storageLocationID = '';
        $resource->registeredIPAddresses = '';
        $resource->providerText	= $this->providerText;
        $resource->ebscoKbID = $this->package->packageId;
        try {
            $resource->save();
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not import package', $e->getMessage())]);
        }

        $this->addResourceAcquisition($resource);
        $this->addProvider($resource);
        if(!empty($this->noteText)){
            $this->addNote($resource, 'Product', $this->noteText);
        }

        if(empty($resource->getCurrentWorkflowID())){
            // Create the default order
            $resource->enterNewWorkflow();
        }
        return $resource;

    }

    public function importTitle($title, $parentId = null){
        $resource = new Resource();
        $existingResource = $resource->getResourceByEbscoKbId($title->titleId);
        if ($existingResource){
            //get this resource
            $resource = $existingResource;
        } else {
            //set up new resource
            $resource->createLoginID = $this->loginID;
            $resource->createDate = date( 'Y-m-d' );
            $resource->updateLoginID = '';
            $resource->updateDate = '';
        }

        $resource->resourceTypeID = $this->getResourceTypeId($title->pubType);
        $resource->resourceFormatID = $this->resourceFormatId;
        $resource->acquisitionTypeID = $this->acquisitionTypeId;
        $resource->titleText = $title->titleName;
        $resource->descriptionText = $title->description;
        $resource->statusID	= $this->statusId;
        $resource->orderNumber = '';
        $resource->systemNumber = '';
        $resource->userLimitID = '';
        $resource->authenticationUserName = '';
        $resource->authenticationPassword = '';
        $resource->storageLocationID = '';
        $resource->registeredIPAddresses = '';
        $resource->providerText	= $this->providerText;
        $resource->ebscoKbID = $title->titleId;

        $urlsByCoverage = $title->sortUrlsByCoverage();
        $resource->resourceURL = empty($urlsByCoverage[0]) ? '' : $urlsByCoverage[0]['url'];
        $resource->resourceAltURL = empty($urlsByCoverage[1]) ? '' : $urlsByCoverage[1]['url'];
        // If any additional urls, add to the notes field
        $additionalUrls = null;
        if(!empty($urlsByCoverage[2])){
            $additionalUrls = "Additional Urls\n\n".implode("\n\n", array_map(public function($u){
                return $u['url'];
            }, array_slice($urlsByCoverage,2)));
        }

        try {
            $resource->save();
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not import title', $e->getMessage())]);
        }

        $resourceAcquisition = $this->addResourceAcquisition($resource, implode('; ', $title->coverageTextArray));
        $resource->setIsbnOrIssn($title->isxns);
        $this->addProvider($resource);
        $this->addSubjects($resource, $title->subjects);

        //add notes
        if ($this->providerText && !$this->organizationId && $this->resourceStatus == 'progress') {
            $this->addNote($resource, 'Product', "Provider:  $this->providerText");
        }
        if(isset($additionalUrls)) {
            $this->addNote($resourceAcquisition, 'Access', $additionalUrls);
        }
        if(!empty($this->noteText)){
            $this->addNote($resource, 'Product', $this->noteText);
        }

        if(!empty($parentId)){
            $parents = $resource->getParentResources();
            $parentIds = array_map(public function($parent){
                return $parent->relatedResourceID;
            }, $parents);
            if(!in_array($parentId, $parentIds)){
                $resourceRelationship = new ResourceRelationship();
                $resourceRelationship->resourceID = $resource->primaryKey;
                $resourceRelationship->relatedResourceID = $parentId;
                $resourceRelationship->relationshipTypeID = '1';  //hardcoded because we're only allowing parent relationships
                try {
                    $resourceRelationship->save();
                } catch (Exception $e) {
                    $this->sendErrors([$this->createError('general', 'Could not import resource relationship', $e->getMessage())]);
                }
            }
        }

        // Workflow
        if ($this->newWorkflow && empty($resource->getCurrentWorkflowID())){
            // Create the default order
            $resource->enterNewWorkflow();
        }
        return $resource;

    }

    public function addProvider(Resource $resource){
        if ($this->organizationId && $this->organizationRoleId){

            // create an original list of organzational links
            $linkedOrganizations = array_map(public function($org){
                return ['organizationId' => $org['organizationID'], 'organizationRoleId' => $org['organizationRoleID']];
            }, $resource->getOrganizationArray());
            $linkedOrganizations[] = ['organizationId' => $this->organizationId, 'organizationRoleId' => $this->organizationRoleId];
            $linkedOrganizations = array_map("unserialize", array_unique(array_map("serialize", $linkedOrganizations)));
            // Remove old links
            $resource->removeResourceOrganizations();
            foreach($linkedOrganizations as $link){
                $resourceOrganizationLink = new ResourceOrganizationLink();
                $resourceOrganizationLink->resourceID = $resource->primaryKey;
                $resourceOrganizationLink->organizationID = $link['organizationId'];
                $resourceOrganizationLink->organizationRoleID = $link['organizationRoleId'];
                try {
                    $resourceOrganizationLink->save();
                } catch (Exception $e) {
                    $this->sendErrors([$this->createError('general', 'Could not add resource provider', $e->getMessage())]);
                }
            }
        }
    }

    public function addNote($entity, $tab = 'Product', $text = ''){
        // check if note exists
        if ($tab === 'Product') {
            $existingNotes = $entity->getNotes();
        } else {
            $existingNotes = $entity->getNotes($tab);
        }
        $existingNoteText =  array_map(public function($note){ return $note->noteText; }, $existingNotes);

        if(!in_array($text, $existingNoteText)) {
            $noteType = new NoteType();
            $resourceNote = new ResourceNote();
            $resourceNote->resourceNoteID = '';
            $resourceNote->updateLoginID = $this->loginID;
            $resourceNote->updateDate = date('Y-m-d');
            $resourceNote->noteTypeID = $noteType->getInitialNoteTypeID();
            $resourceNote->tabName = $tab;
            $resourceNote->entityID = $entity->primaryKey;
            $resourceNote->noteText = $text;
            try {
                $resourceNote->save();
            } catch (Exception $e) {
                $this->sendErrors([$this->createError('general', 'Could not add resource note', $e->getMessage())]);
            }
        }
    }

    public function addResourceAcquisition($resource, $coverageText = ''){
        $resourceAcquisition = new ResourceAcquisition();
        $resourceAcquisition->resourceID = $resource->primaryKey;
        $resourceAcquisition->subscriptionStartDate = date("Y-m-d");
        $resourceAcquisition->subscriptionEndDate = date("Y-m-d");
        $resourceAcquisition->coverageText = $coverageText;
        $resourceAcquisition->save();
        return $resourceAcquisition;
    }

    public function addSubjects($resource, $subjects){
        foreach($subjects as $subject){
            $generalSubjectId = $this->getGeneralSubjectId($subject);
            if(empty($generalSubjectId)){
                continue;
            }

            $generalDetailId = $this->getGeneralDetailId($generalSubjectId);
            if(empty($generalDetailId)){
                continue;
            }
            $resourceSubject = new ResourceSubject();
            $resourceSubject->resourceID = $resource->primaryKey;
            $resourceSubject->generalDetailSubjectLinkID = $generalDetailId;

            // Check to see if the subject has already been associated with the resouce.  If not then save.
            if ($resourceSubject->duplicateCheck($resource->primaryKey, $generalDetailId) == 0) {
                $resourceSubject->save();
            }
        }
    }

    public function getGeneralDetailId($generalSubjectId){
        // Search for the cached key
        $cachedKey = array_search($generalSubjectId, $this->generalDetailIdCache);
        if($cachedKey) {
            return $cachedKey;
        }

        // If it doesn't exist, create or get the generalDetailId
        $generalDetail = new GeneralDetailSubjectLink();
        $generalDetailId = $generalDetail->getGeneralDetailID($generalSubjectId, -1);
        if(empty($generalDetailId)){
            // create a new resource type
            $generalDetail->generalSubjectID = $generalSubjectId;
            $generalDetail->detailedSubjectID = -1;
            $generalDetail->save();
            $generalDetailId = $generalDetail->primaryKey;
        }
        // add the key and name to the cache
        $this->generalDetailIdCache[$generalDetailId] = $generalSubjectId;
        return $generalDetailId;
    }

    public function getGeneralSubjectId($subject){
        // Search for the cached key
        $cachedKey = array_search($subject, $this->generalSubjectCache);
        if($cachedKey) {
            return $cachedKey;
        }

        // If it doesn't exist, create or get the subject id
        $generalSubject = new GeneralSubject();
        try{
            $generalSubjectId = $generalSubject->getGeneralSubjectIDByName($subject);
        } catch(Exception $e){
            $this->sendErrors([$this->createError('general', 'Error checking subject'.$subject, $e->getMessage())]);
        }
        if(empty($generalSubjectId)){
            // create a new resource type
            $generalSubject->shortName = $subject;
            try{
                $generalSubjectId = $generalSubject->getGeneralSubjectIDByName($subject);
            } catch(Exception $e){
                $this->sendErrors([$this->createError('general', 'Error saving subject', $e->getMessage())]);
            }
            $generalSubject->save();
            $generalSubjectId = $generalSubject->primaryKey;
        }
        // add the key and name to the cache
        $this->generalSubjectCache[$generalSubjectId] = $subject;
        return $generalSubjectId;
    }

    public function getResourceTypeId($typeName){
        // Search for the cached key
        $cachedKey = array_search($typeName, $this->resourceTypeCache);
        if($cachedKey) {
            return $cachedKey;
        }

        // If it doesn't exist, create or get the resource type id
        $resourceType = new ResourceType();
        $this->resourceTypeId = $resourceType->getResourceTypeIDByName($typeName);
        if(empty($this->resourceTypeId)){
            // create a new resource type
            $resourceType->shortName = $typeName;
            try {
                $resourceType->save();
            } catch (Exception $e) {
                $this->sendErrors([$this->createError('general', 'Could not save new resource type', $e->getMessage())]);
            }
            $this->resourceTypeId = $resourceType->primaryKey;
        }
        // add the key and name to the cache
        $this->resourceTypeCache[$this->resourceTypeId] = $typeName;
        return $this->resourceTypeId;
    }


    // TODO: Update to use Organization domain classes instead of sql calls, see note above
    public function createOrUpdateOrganization($ebscoKbId, $organizationName){
        if($this->orgModule){
            $orgDbName = $this->config->settings->organizationsDatabaseName;
            $dbService = new DBService;

            // search for existing matches
            $selectSql = "SELECT organizationID
    			FROM $orgDbName.Organization
    			WHERE ebscoKbID = $ebscoKbId
    			OR `name` = '$organizationName'
    			LIMIT 0,1";
            try {
                $result = $dbService->query($selectSql);
            } catch (Exception $e) {
                $this->sendErrors([$this->createError('general', 'DB Error when searching for Organization matches via EBSCO Kb ID', $e->getMessage())]);
            }
            $result = $result->fetch_assoc();


            if(empty($result)){
                $now = date( 'Y-m-d H:i:s' );
                $insert = "INSERT INTO $orgDbName.Organization
                  (createDate, createLoginID, updateDate, updateLoginID, `name`, ebscoKbID)
                  VALUES('$now','$this->loginID','','','$organizationName',$ebscoKbId)";
                try {
                    $dbService->query($insert);
                } catch (Exception $e) {
                    $this->sendErrors([$this->createError('general', 'Could not create new organization', $e->getMessage())]);
                }
                return $dbService->db->insert_id;
            } else {
                return $result['organizationID'];
            }
        } else {
            $organization = new Organization;
            $existingOrg = $organization->getOrganizationByEbscoKbId($ebscoKbId);

            // Search for a matching resource
            if ($existingOrg){
                //get this resource
                $organization = $existingOrg;
            } else {
                $existingOrg = $organization->getOrganizationIDByName($organizationName);
                if($existingOrg){
                    $organization = new Organization(new NamedArguments(array('primaryKey' => $existingOrg)));
                } else {
                    //set up new resource
                    $organization->createLoginID 		= $this->loginID;
                    $organization->createDate			= date( 'Y-m-d H:i:s' );
                    $organization->updateLoginID 		= '';
                    $organization->updateDate			= '';
                }
            }
            $organization->ebscoKbID = $ebscoKbId;
            $organization->name = $organizationName;
            try {
                $organization->save();
            } catch (Exception $e) {
                $this->sendErrors([$this->createError('general', 'Could not create or update organization', $e->getMessage())]);
            }
            return $organization->primaryKey;
        }

    }

    // TODO: Update to use Organization domain classes instead of sql calls, see note above
    public function addOrganizationAlias($this->organizationId, $aliasTypeId, $ebscoKbId, $alias){
        $orgDbName = $this->config->settings->organizationsDatabaseName;
        $dbService = new DBService;

        // Check for matching aliases first
        $selectSql = "SELECT *
          FROM $orgDbName.Alias
          WHERE organizationID = $this->organizationId
          AND aliasTypeID = $aliasTypeId
          AND `name` = '$alias'";
        try {
            $result = $dbService->query($selectSql);
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'DB Error when searching for Organization alias matches', $e->getMessage())]);
        }

        $result = $result->fetch_assoc();
        if(!empty($matches)){
            return;
        }

        // Insert the alias
        $insert = "INSERT INTO $orgDbName.Alias
          (organizationID, aliasTypeID, `name`)
          VALUES ($this->organizationId, $aliasTypeId, '$alias')";
        try {
            $dbService->query($insert);
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not save organization alias', $e->getMessage())]);
        }

        // update with the ebscoKbId
        $update = "UPDATE $orgDbName.Organization SET ebscoKbID = $ebscoKbId WHERE organizationID = $this->organizationId";
        try {
            $dbService->query($update);
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not update the organization with the EBSCO Kb ID', $e->getMessage())]);
        }
    }

    // TODO: Update to use Organization domain classes instead of sql calls, see note above
    public function addOrganizationRelationship($parentOrganizationId, $childOrganizationId){
        $orgDbName = $this->config->settings->organizationsDatabaseName;
        $dbService = new DBService;

        // Delete any existing parents from the child
        $deleteParentSql = "DELETE FROM $orgDbName.OrganizationHierarchy WHERE organizationID = $childOrganizationId";
        try {
            $dbService->query($deleteParentSql);
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not delete existing parents', $e->getMessage())]);
        }

        // Insert the new relationship
        $insert = $insert = "INSERT INTO $orgDbName.OrganizationHierarchy
              (organizationID, parentOrganizationID)
              VALUES ($childOrganizationId, $parentOrganizationId)";
        try {
            $dbService->query($insert);
        } catch (Exception $e) {
            $this->sendErrors([$this->createError('general', 'Could not set new organization relationship', $e->getMessage())]);
        }
    }

}
