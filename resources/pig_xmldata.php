<?php

// @file resources/pig_xmldata.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

session_start();

$config = new Configuration();
$util = new Utility();

if ($config->settings->pIG != 'Y') { die(); }

$search = array(
    "orderBy" => urldecode($_GET['orderBy']),
    "page" => urldecode($_GET['page']),
    "recordsPerPage" => urldecode($_GET['recordsPerPage']),
    "startWith" => urldecode($_GET['startWith']),
    "name" => urldecode($_GET['name']),
    "descriptionText" => urldecode($_GET['descriptionText']),
    "providerText" => urldecode($_GET['providerText']),
    "generalSubjectID" => urldecode($_GET['generalSubjectID']),
    "resourceTypeID" => urldecode($_GET['resourceTypeID']),
);

header("Content-type: text/xml");
$xml_output = "<?xml version=\"1.0\"?>\n";
$xml_output .= "<resources>\n";

switch ($_GET['action']) {

    case 'getPigSearchResources':

        if($search) {
            Resource::setSearch($search);
        } else {
            Resource::setSearch($_POST['search']);
        }

        $queryDetails = PigResource::getPigSearchDetails();
        $whereAdd = $queryDetails["where"];
        $page = $queryDetails["page"];
        $orderBy = $queryDetails["order"];
        $recordsPerPage = $queryDetails["perPage"];

        //numbers to be displayed in records per page dropdown
            $recordsPerPageDD = array(10,25,50,100);

            //determine starting rec - keeping this based on 0 to make the math easier, we'll add 1 to the display only
            //page will remain based at 1
            if ($page == '1'){
                $startingRecNumber = 0;
            }else{
                $startingRecNumber = ($page * $recordsPerPage) - $recordsPerPage;
            }


            //get total number of records to print out and calculate page selectors
            $resourceObj = new PigResource();
            $totalRecords = $resourceObj->searchPigCount($whereAdd);

            //reset pagestart to 1 - happens when a new search is run but it kept the old page start
            if ($totalRecords < $startingRecNumber){
                $page = 1;
                $startingRecNumber = 1;
            }

            $limit = $startingRecNumber . ", " . $recordsPerPage;

            $resourceArray = array();
            $resourceArray = $resourceObj->searchPig($whereAdd, $orderBy, $limit);

            if (count($resourceArray) == 0){
                //echo "<br /><br /><i>Sorry, no requests fit your query</i>";
                $i=0;
            }else{
                //maximum number of pages to display on screen at one time
                $maxDisplay = 25;

                $displayStartingRecNumber = $startingRecNumber + 1;
                $displayEndingRecNumber = $startingRecNumber + $recordsPerPage;

                if ($displayEndingRecNumber > $totalRecords){
                    $displayEndingRecNumber = $totalRecords;
                }

                foreach ($resourceArray as $resource){
                    $xml_output .= "\t<resource>\n";
                    $xml_output .= "\t\t<resourceID>" . $resource['resourceID'] . "</resourceID>\n";

                    if ($_GET['titleTextckbox'] == 'ON') {
                        $titleText = htmlspecialchars($resource['titleText']);
                        $xml_output .= "\t\t<titleText>" . $titleText . "</titleText>\n";
                    }
                    if ($_GET['providerTextckbox'] == 'ON') {
                        $providerText = htmlspecialchars($resource['providerText']);
                        $xml_output .= "\t\t<providerText>" . $providerText . "</providerText>\n";
                    }
                    if ($_GET['descriptionTextckbox'] == 'ON') {
                        $descriptionText = htmlspecialchars($resource['descriptionText']);
                        $xml_output .= "\t\t<descriptionText>" . $descriptionText . "</descriptionText>\n";
                    }
                    if ($_GET['generalSubjectckbox'] == 'ON') {
                        //get subjects for this tab
                        $sanitizedInstance = array();
                        $generalDetailSubjectIDArray = array();
                        $resourceRecord = new Resource(new NamedArguments(array('primaryKey' => $resource['resourceID'])));

                            foreach ($resourceRecord->getGeneralDetailSubjectLinkID() as $instance) {
                                foreach (array_keys($instance->attributeNames) as $attributeName) {
                                    $sanitizedInstance[$attributeName] = $instance->$attributeName;
                                }

                                $sanitizedInstance[$instance->primaryKeyName] = $instance->primaryKey;
                                array_push($generalDetailSubjectIDArray, $sanitizedInstance);

                            }

                            if (count($generalDetailSubjectIDArray) > 0){

                                $generalSubjectID = 0;

                                    foreach ($generalDetailSubjectIDArray as $generalDetailSubjectID){
                                        $generalSubject = new GeneralSubject(new NamedArguments(array('primaryKey' => $generalDetailSubjectID[generalSubjectID])));

                                        if ($generalDetailSubjectID['generalSubjectID'] != $generalSubjectID) {
                                            $generalSubject = htmlspecialchars($generalSubject->shortName);
                                            $xml_output .= "\t\t<generalSubject>" . $generalSubject . "</generalSubject>\n";
                                        }

                                        $generalSubjectID = $generalDetailSubjectID['generalSubjectID'];
                                    }

                            }

                    }
                    if ($_GET['resourceTypeckbox'] == 'ON') {
                        $resourceType = htmlspecialchars($resource['resourceTypeID']);
                        $xml_output .= "\t\t<resourceType>" . $resourceType . "</resourceType>\n";
                    }
                    $resourceURL = htmlspecialchars($resource['resourceURL']);
                    $xml_output .= "\t\t<resourceURL>" . $resourceURL . "</resourceURL>\n";

                    $xml_output .= "\t</resource>\n";
                }

            }

        break;


    default:

       break;


}

$xml_output .= "</resources>";

echo $xml_output;
