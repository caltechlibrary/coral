<?php

// @file resources/importFunds.php

	session_start();

	// CSV configuration
	$required_columns = array('fundCode' => 0, 'shortName' => 0);

	if ($_POST['submit']) {

    require_once __DIR__ . '/../bootstrap.php';
    // Define the MODULE base directory, ending with `/`.
    define('BASE_DIR', __DIR__ . '/');

		$pageTitle='Funds import';
		include 'templates/header.php';
		$uploaddir = 'attachments/';
		$uploadfile = $_FILES['uploadFile']['tmp_name'];
		print '<p>' . _("The file has been successfully uploaded.") . '</p>';

		// Let's analyze this file
		if (($handle = fopen($uploadfile, "r")) !== FALSE) {
			if (($data = fgetcsv($handle)) !== FALSE) {
				$columns_ok = true;
				foreach ($data as $key => $value) {
					$available_columns[$value] = $key;
				}
			} else {
				$error = _("Unable to get columns headers from the file");
			}
		} else {
			$error = _("Unable to open the uploaded file");
		}
		if ($error) {
			print "<p>" . _("Error: ") . $error . "</p>";
		} else {
		// Let's analyze this file
			if (($handle = fopen($uploadfile, "r")) !== FALSE) {
				$row = 0;
				while (($data = fgetcsv($handle)) !== FALSE) {
					$Fund = new Fund();
					$funds = $Fund -> allAsArray();
					// Convert to UTF-8
					$data = array_map(function($row) { return mb_convert_encoding($row, 'UTF-8'); }, $data);
					$Fund->fundCode = array_values($data)['0'];
					$Fund->shortName = array_values($data)['1'];
					$Fund->save();
					$row++;
				}
				print "<h2>" . _("Results") . "</h2>";
				print "<p> $row " . _("rows have been processed.") . "</p>";
			}
		}
	} else {
		?>
			<form enctype="multipart/form-data" action="importFunds.php" method="post" id="importForm">
				<div id='div_updateForm'>
					<div class='formTitle' style='width:245px;'><b><?php echo _("Import Funds");?></b></div><br/>
					<label for="uploadFile"><?php echo _("Select File");?></label>
					<input type="file" name="uploadFile" id="uploadFile"/><br/><br/>
					<input type="submit" name="submit" value='<?php echo _("import");?>' id="import-fund-button" class='submit-button' />
					<input type='button' value='<?php echo _("cancel");?>' onclick="window.parent.tb_remove(); return false;" id="cancel-fund-button" class='cancel-button' />
				</div>
			</form>
		<?php
	}
?>
