<?php
	session_start();
	// "install/index.php" will check if CORAL is installed and version is current
	require_once("install/index.php");

	// Include file of language codes
	include_once 'LangCodes.php';
	$lang_name = new LangCodes();

	// Verify the language of the browser
	global $http_lang;
	if(isset($_COOKIE["lang"])){
		$http_lang = $_COOKIE["lang"];
	}else{
		$codeL = $lang_name->getBrowserLanguage();
		$http_lang = $lang_name->getLanguage($codeL);
		if($http_lang == "")
		  $http_lang = "en_US";
	}
	putenv("LC_ALL=$http_lang");
	setlocale(LC_ALL, $http_lang.".utf8");
	bindtextdomain("messages", dirname(__FILE__) . "/locale");
	textdomain("messages");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>eRM - eResource Management</title>
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/indexstyle.css" type="text/css" media="screen" />
	<link rel="icon" href="images/favicon.ico" />
	<script type="text/javascript" src="js/plugins/jquery.js"></script>
	<script type="text/javascript" src="js/plugins/Gettext.js"></script>

	<?php
		// Add translation for the JavaScript files
		global $http_lang;
		$str = substr($_SERVER["HTTP_ACCEPT_LANGUAGE"],0,5);
		$default_l = $lang_name->getLanguage($str);
		if($default_l==null || empty($default_l)){$default_l=$str;}
		if(isset($_COOKIE["lang"])){
			if($_COOKIE["lang"]==$http_lang && $_COOKIE["lang"] != "en_US"){
				echo "<link rel='gettext' type='application/x-po' href='./locale/".$http_lang."/LC_MESSAGES/messages.po' />";
			}
		}else if($default_l==$http_lang && $default_l != "en_US"){
				echo "<link rel='gettext' type='application/x-po' href='./locale/".$http_lang."/LC_MESSAGES/messages.po' />";
		}
	?>
</head>
<body>

	<header>
		<div class="title-main"><strong><?php echo _("eRM");?></strong> &bullet; <?php echo _("eResource Management");?></div>
		<nav class="language-select"><?php echo _("Change language:");?>
			<select name="lang" id="lang" class="dropDownLang">
				<?php
				// Get all translations on the 'locale' folder
				$route='locale';
				$lang[]="en_US"; // add default language
				if (is_dir($route)) {
					if ($dh = opendir($route)) {
						while (($file = readdir($dh)) !== false) {
							if (is_dir("$route/$file") && $file!="." && $file!=".."){
								$lang[]=$file;
							}
						}
						closedir($dh);
					}
				}else {
					echo "<br>"._("Invalid translation route!");
				}
				// Get language of navigator
				$defLang = $lang_name->getBrowserLanguage();

				// Show an ordered list
				sort($lang);
				for($i=0; $i<count($lang); $i++){
					if(isset($_COOKIE["lang"])){
						if($_COOKIE["lang"]==$lang[$i]){
							echo "<option value='".$lang[$i]."' selected='selected'>".$lang_name->getNameLang($lang[$i])."</option>";
						}else{
							echo "<option value='".$lang[$i]."'>".$lang_name->getNameLang($lang[$i])."</option>";
						}
					}else{
						if($defLang==substr($lang[$i],0,5)){
							echo "<option value='".$lang[$i]."' selected='selected'>".$lang_name->getNameLang($lang[$i])."</option>";
						}else{
							echo "<option value='".$lang[$i]."'>".$lang_name->getNameLang($lang[$i])."</option>";
						}
					}
				}
				?>
			</select>
		</nav>
	</header>

	<section class="icons">
		<?php
		$mainPageIcon = "";
		$modules = [ "resources" => _("Resources"), "licensing" => _("Licensing"), "organizations" => _("Organizations"), "usage" => _("Usage Statistics"), "management" => _("Management") ];

		foreach ($modules as $key => $value)
		{
			$module = "";
			try
			{
				$mod_conf = Config::getSettingsFor($key);
				if (isset($mod_conf["enabled"]) && $mod_conf["enabled"] == "Y")
				{
					$module = "<a href='{$key}/'><img src='images/icon-{$key}.png' class='rollover' /><span>{$value}</span></a>";
				}
			}
			catch (Exception $e)
			{
				if ($e->getCode() != Config::ERR_VARIABLES_MISSING)
				{
					throw $e;
				}
			}

			if (empty($module))
			{
				$module = "<div class='main-page-icons-off'><img src='images/icon-{$key}-off.png'><span>{$value}</span></div>";
			}
			$mainPageIcon .= "<div class='main-page-icons'>$module</div>";
		}
		echo $mainPageIcon;
		?>
	</section>

	<footer><?php echo _("Powered by");?><img src="images/logo-coral.jpg" /></footer>

	<script type="text/javascript">
		/*
		 * Functions to change the language with the dropdown
		 */
		$("#lang").change(function() {
			setLanguage($("#lang").val());
			location.reload();
		});
		// Create a cookie with the code of language
		function setLanguage(lang) {
			var wl = window.location, now = new Date(), time = now.getTime();
			var cookievalid=2592000000; // 30 days (1000*60*60*24*30)
			time += cookievalid;
			now.setTime(time);
			document.cookie ='lang='+lang+';path=/'+';domain='+wl.hostname+';expires='+now;
		}
	</script>
</body>
</html>
