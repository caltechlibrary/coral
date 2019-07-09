<?php

// @file management/in_progress.php

require_once __DIR__ . '/../bootstrap.php';

// Define the MODULE base directory, ending with `/`.
define('BASE_DIR', __DIR__ . '/');

$pageTitle=_('Home');
include 'templates/header.php';

//set referring page
$_SESSION['ref_script']=$currentPage;

?>

<table class="headerTable" style="background-image:url('images/header.gif');background-repeat:no-repeat;">
<tr><td>
<span class="headerText"><?php echo _("Licenses In Progress");?>&nbsp;&nbsp;<a href='index.php'><?php echo _("Browse All");?></a></span>
<br />
<br />
<div id='div_licenses'>

<img src = "images/circle.gif"><?php echo _("Loading...");?>

</div>
</td></tr>
</table>
<script type="text/javascript" src="js/in_progress.js"></script>
<?php
include 'templates/footer.php';
?>
