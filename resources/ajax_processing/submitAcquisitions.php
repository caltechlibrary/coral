<?php
		$resourceAcquisitionID = $_POST['resourceAcquisitionID'];
		$resourceID = $_POST['resourceID'];
        $op = $_POST['op'];

		$resourceAcquisition = $resourceAcquisitionID ?
                                new ResourceAcquisition(new NamedArguments(array('primaryKey' => $resourceAcquisitionID))) :
                                new ResourceAcquisition();

		//first set current start Date for proper saving
		if ((isset($_POST['currentStartDate'])) && ($_POST['currentStartDate'] != '')){
			$resourceAcquisition->subscriptionStartDate = date("Y-m-d", strtotime($_POST['currentStartDate']));
		}else{
			$resourceAcquisition->subscriptionStartDate= date("Y-m-d");
		}

		//first set current end Date for proper saving
		if ((isset($_POST['currentEndDate'])) && ($_POST['currentEndDate'] != '')){
			$resourceAcquisition->subscriptionEndDate = date("Y-m-d", strtotime($_POST['currentEndDate']));
		}else{
			$resourceAcquisition->subscriptionEndDate= date("Y-m-d");
		}

		$resourceAcquisition->acquisitionTypeID 				= $_POST['acquisitionTypeID'];
		$resourceAcquisition->orderNumber 						= $_POST['orderNumber'];
		$resourceAcquisition->systemNumber 					= $_POST['systemNumber'];
		$resourceAcquisition->subscriptionAlertEnabledInd 		= isset($_POST['subscriptionAlertEnabledInd']) ? $_POST['subscriptionAlertEnabledInd'] : 0;
		$resourceAcquisition->resourceID 		= $_POST['resourceID'];
		$resourceAcquisition->organizationID    = $_POST['organizationID'];

		try {
            if ($op == 'clone') {
                $resourceAcquisition->resourceAcquisitionID = null;
                $newRAID = $resourceAcquisition->saveAsNew();
                $resourceAcquisition = new ResourceAcquisition(new NamedArguments(array('primaryKey' => $newRAID)));
                $resourceAcquisition->save();
                $resourceAcquisition->cloneFrom($_POST['resourceAcquisitionID']);
                $resourceAcquisitionID = $newRAID;
            } else {
                $resourceAcquisition->save();
                $resourceAcquisitionID = $resourceAcquisition->resourceAcquisitionID;
            }

			//first remove all administering sites, then we'll add them back
			$resourceAcquisition->removePurchaseSites();

			foreach (explode(':::',$_POST['purchaseSites']) as $key => $value){
				if ($value){
					$resourcePurchaseSiteLink = new ResourcePurchaseSiteLink();
					$resourcePurchaseSiteLink->resourceAcquisitionID = $resourceAcquisitionID;
					$resourcePurchaseSiteLink->purchaseSiteID = $value;
					try {
						$resourcePurchaseSiteLink->save();
					} catch (Exception $e) {
						echo $e->getMessage();
					}
				}
			}

		} catch (Exception $e) {
			echo $e->getMessage();
		}

?>
