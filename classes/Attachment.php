<?php

// @file classes/Attachment.php

class Attachment extends DatabaseObject {

	protected function defineRelationships() {}

	protected function overridePrimaryKeyName() {}


	//returns array of AttachmentFile objects
	public function getAttachmentFiles(){

		$query = "SELECT * FROM AttachmentFile where attachmentID = '" . $this->attachmentID . "' ORDER BY attachmentFileID";

		$result = $this->db->processQuery($query, 'assoc');

		$objects = array();

		//need to do this since it could be that there's only one request and this is how the dbservice returns result
		if (isset($result['attachmentFileID'])){

			$object = new AttachmentFile(new NamedArguments(array('primaryKey' => $result['attachmentFileID'])));
			array_push($objects, $object);
		}else{
			foreach ($result as $row) {
				$object = new AttachmentFile(new NamedArguments(array('primaryKey' => $row['attachmentFileID'])));
				array_push($objects, $object);
			}
		}

		return $objects;
	}

}

?>
