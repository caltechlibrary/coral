<?php

// @file management/not_available.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Not Available');

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php echo _("Management Module");?> - <?php echo $pageTitle; ?></title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />
  </head>
  <body>
    <center>
      <div class="wrapper">
        <center>
          <table>
            <tr>
              <td style='vertical-align:top;'>
                <div style="text-align:left;">
                  <center>
                    <table class="titleTable" style="background-image:url('images/management-title.jpg');background-repeat:no-repeat;width:900px;text-align:left;">
                      <tr style='vertical-align:bottom'>
                        <td>&nbsp;</td>
                        <td style='text-align:right;'>&nbsp;</td>
                      </tr>
                    </table>
					<table class="headerTable">
                      <tr>
                        <td>
                          <?php
                            if ($_GET['errorMessage']){
                              echo "<h3>" . $_GET['errorMessage'] . "</h3>";
                            }
                            else {
                              echo "<h3>" . _("Please contact your Administrator for access to the Management Module.") . "</h3>";
                            }
                          ?>
                        </td>
                      </tr>
                    </table>
                    <br />
                    <br />
                    <br />
                  </center>
                </div>
              </td>
            </tr>
          </table>
          <br />
        </center>
      </div>
    </center>
  </body>
</html>
