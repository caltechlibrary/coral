<?php
function register_have_default_db_user_provider()
{
	$MODULE_VARS = [
		"uid" => "have_default_db_user",
		"translatable_title" => _("Default Database User Configured"),
		"hide_from_completion_list" => true,
	];

	return array_merge( $MODULE_VARS, [
		"bundle" => function($version = 0) use ($MODULE_VARS) {
			return [
				"dependencies_array" => ["have_database_access"],
				"function" => function($shared_module_info) use ($MODULE_VARS) {
					$return = new stdClass();
					$return->yield = new stdClass();
					$return->success = false;
					$return->yield->title = _("Configure Default Database User");
					$return->yield->messages = [];

					$generate_password = function($length)
					{
						$password = '';
						$possibleCharacters = "0123456789"
											. "abcdefghijklmnopqrstuvwxyz"
											. "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
											. "=+-_.,<>@$;:#%*`/";
						while (strlen($password) < $length)
							$password .= $possibleCharacters[mt_rand(0, strlen($possibleCharacters) - 1)];

						return htmlspecialchars($password);
					};
					if (!isset($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]))
						$_SESSION[ $MODULE_VARS["uid"] ]["userdetails"] = [];
					if (!isset($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"]))
						$_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"] = "";
					if (!isset($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"]))
						$_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"] = "";

					$username_field = "default_db_username";
					$password_field = "default_db_password";
					$default_username = !empty($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"]) ? $_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"] : "";
					$default_password = !empty($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"]) ? $_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"] : "";
					$default_username = !empty($_POST[$username_field]) ? $_POST[$username_field] : $default_username;
					$default_password = !empty($_POST[$password_field]) ? $_POST[$password_field] : $default_password;

					require_once "common/DBService.php";
					$_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"] = $default_username;
					$_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"] = $default_password;

					$username_invalid_messasges = function($username){
						$return_messages = [];
						// Limitation in mysql < 5.7 (5.7 changes to a limit of 32 characters)
						if (strlen($username) > 16)
							$return_messages[] = _("Sorry the username is limited to 16 characters.");
						return count($return_messages) > 0 ? $return_messages : false;
					};

					$disallowed_characters = '\\?{}|&~!()^"';
					$password_invalid_messasges = function($pass) use ($disallowed_characters){
						// Be sure to change the message if the test here changes
						$return_messages = [];
						if (strpos($pass, $disallowed_characters) !== false)
							$return_messages[] = sprintf(_("Sorry, we do not allow the characters '%s' in passwords. Please use a different password."), $disallowed_characters);
						return count($return_messages) > 0 ? $return_messages : false;
					};

					if ($password_invalid_messasges($default_password) || $username_invalid_messasges($default_username) || empty($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"]) || empty($_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"]))
					{
						$fields = [
							"username" => [
								"uid" => $username_field,
								"title" => "Regular Database Username",
								"default_value" => empty($default_username) ? "coral_user" : $default_username
							],
							"password" => [
								"uid" => $password_field,
								"title" => "Regular Database Password",
								"default_value" => empty($default_password) ? $generate_password(12) : $default_password
							]
						];
						$instruction = _("During installation and updates Coral needs more privileges to the database than during regular use. "
							. "If Coral has the rights, it will automatically set up a user with appropriate privileges based on these details. "
							. "Otherwise you will need to grant SELECT, INSERT, UPDATE and DELETE to this user on all the coral databases used in this install."
						);

						if ($password_invalid_messasges($default_password))
							$return->yield->messages = $return->yield->messages + $password_invalid_messasges($default_password);
						if ($username_invalid_messasges($default_username))
							$return->yield->messages = $return->yield->messages + $username_invalid_messasges($default_username);

						require "install/templates/have_default_db_user_template.php";
						$return->yield->body = have_default_db_user_template($instruction, $fields);
						return $return;
					}
					else
					{
						$default_db_username = $_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["username"];
						$default_db_password = $_SESSION[ $MODULE_VARS["uid"] ]["userdetails"]["password"];

						$failed_user_grants = [];
						$db_details = [
							"host" => Config::dbInfo('host'),
							"username" => $default_db_username,
							"password" => $default_db_password
						];
						foreach ($shared_module_info["modules_to_use"]["useModule"] as $key => $value)
						{
							if ($value && isset($shared_module_info[$key]["db_name"]))
							{
								$db_details["dbname"] = $shared_module_info[$key]["db_name"];
								try
								{
									$db = $shared_module_info["provided"]["get_db_connection"]( $db_details["dbname"] );
									$slash_pass = addslashes($db_details["password"]);
									try {
										$db_user_result = $db->processQuery("SELECT SUBSTRING_INDEX(USER(),'@',-1)");
										$db_client_host = $db_user_result->fetchRow()[0];
										$db->processQuery("REVOKE ALL ON {$db_details["dbname"]}.* FROM {$db_details["username"]}@{$db_details["host"]}");
									} catch(Exception $e){ }
									$db->processQuery("GRANT SELECT, INSERT, UPDATE, DELETE ON {$db_details["dbname"]}.* TO {$db_details["username"]}@{$db_client_host} IDENTIFIED BY '$slash_pass'");
								}
								catch (Exception $e)
								{
									$failed_user_grants[] = $db_details["dbname"];
								}
							}
						}
						if (!empty($failed_user_grants))
						{
							$db_keys_to_pass_in = [
								"host" => true,
								"username" => true,
								"password" => true
							];
							$db_info = array_intersect_key($db_details, $db_keys_to_pass_in);
							$PARENT_MODULE_VARS = $MODULE_VARS;
							$shared_module_info["registerInstallationTest"]([
								"uid" => "check_user_has_access_db_access",
								"translatable_title" => sprintf(_("Check %s Has DB Access"), $default_db_username),
								"post_installation" => true,
                "bundle" => function($version = 0) use ($db_info, $failed_user_grants) {
									return [
										"function" => function($shared_module_info) use ($db_info, $failed_user_grants) {
											$return = new stdClass();
											$return->yield = new stdClass();
											$return->success = false;
											$return->yield->messages = [];
											$return->yield->title = _("Check DB User Has Access To Databases");

											$db_conn = @new mysqli($db_info["host"], $db_info["username"], $db_info["password"]);
											if ($db_conn->connect_errno)
											{
												switch ($db_conn->connect_errno) {
													case 2002: // ERR_COULD_NOT_CONNECT
														$return->yield->messages[] = _("<b>Error:</b> Could not connect to database at {$db_info["host"]}.");
														break;
													case 1045: // ERR_ACCESS_DENIED
														$return->yield->messages[] = _("Database access was denied from {$db_info["username"]}@{$db_info["host"]}. Please ensure that you can access the database with the password you provided.");
														break;
													default:
														$return->yield->messages[] = _("Mysqli failed for some reason:") . "<br/>" . $db_conn->error;
														break;
												}
												$return->success = false;
											}
											else
											{
												$result = $db_conn->query("SHOW GRANTS FOR CURRENT_USER;");
												if ($result)
												{
													$return->success = true;
													$needed_grants = ['SELECT', 'INSERT', 'UPDATE', 'DELETE'];
													$grants = $result->fetch_all(MYSQLI_ASSOC);
													$grants = array_map('array_shift', $grants);
													foreach ($failed_user_grants as $dbname)
													{
														$grant_arr = array_filter($grants, function($var) use ($dbname) {
															return preg_match("/\b$dbname\b/i", $var);
														});
														// We assume that there will only be one element give permissions to this user on this db
														$grant_str = array_pop($grant_arr);
														//remove everything but permissions
														$privileges = preg_replace('/^GRANT\ (.*)\ ON\ .*$/i', '$1', $grant_str);
														$priv_array = array_map('trim', explode(',', $privileges));

														if (!array_diff($priv_array, $needed_grants) && !array_diff($needed_grants, $priv_array))
														{
															$return->success &= true;
														}
														else if (strtoupper($priv_array[0]) == "ALL PRIVILEGES")
														{
															$return->yield->messages[] = sprintf(_("The idea of having a regular db user is that this user cannot be (too) destructive but right now '%s' has ALL PRIVILEGES!"), $db_info["username"]);
															$return->yield->messages[] = _("Please revoke all privileges:") . "<br /><span class=\"highlight\">REVOKE ALL ON {$dbname}.* FROM {$db_info["username"]}@{$db_info["host"]};</span>";
															$return->yield->messages[] = _("And GRANT the following:") . "<br /><span class=\"highlight\">GRANT SELECT, INSERT, UPDATE, DELETE ON {$dbname}.* TO {$db_info["username"]}@{$db_info["host"]} IDENTIFIED BY '{$db_info["password"]}';</span>";
															$return->success &= false;
														}
														else
														{
															if (array_diff($priv_array, $needed_grants))
															{
																$return->yield->messages[] = sprintf(_("Your regular db user, %s, has more power than necessary. You should remove:"), $db_info["username"]) . " <b>" . join(array_diff($priv_array, $needed_grants), ", ") . "</b>";
																$return->yield->messages[] = "<span class=\"highlight\">REVOKE " . join(array_diff($priv_array, $needed_grants), ", ") . " ON {$dbname}.* FROM {$db_info["username"]}@{$db_info["host"]};</span>";
															}
															if (array_diff($needed_grants, $priv_array))
															{
																$return->yield->messages[] = sprintf(_("Your regular db user, %s, is missing some GRANTs. You need to add:"), $db_info["username"]) . " <b>" . join(array_diff($needed_grants, $priv_array), ", ") . "</b>";
																$return->yield->messages[] = "<span class=\"highlight\">GRANT " . join(array_diff($needed_grants, $priv_array), ", ") . " ON {$dbname}.* TO {$db_info["username"]}@{$db_info["host"]} IDENTIFIED BY '{$db_info["password"]}';</span>";
															}
															$return->success &= false;
														}
													}
												}
												else
												{
													$return->yield->messages[] = sprintf(_('<b>DB Access:</b> User "%s" does not have access to database "%s" (you will need to manually grant permissions).'), $db_info["username"], $db_info["dbname"]);
													$return->yield->messages[] = _("Please revoke all privileges:") . "<br /><span class=\"highlight\">REVOKE ALL ON {$db_info["dbname"]}.* FROM {$db_info["username"]}@{$db_info["host"]};</span>";
													$return->yield->messages[] = _("And GRANT the following:") . "<br /><span class=\"highlight\">GRANT SELECT, INSERT, UPDATE, DELETE ON {$db_info["dbname"]}.* TO {$db_info["username"]}@{$db_info["host"]} IDENTIFIED BY '{$db_info["password"]}';</span>";
													$return->success = false;
												}
											}

											if (!$return->success)
											{
												require_once "install/templates/try_again_template.php";
												$return->yield->body = try_again_template();
											}
											return $return;
										}
									];
								}
							]);
						}
						$shared_module_info["setSharedModuleInfo"]($MODULE_VARS["uid"], "username", $default_db_username);
						$shared_module_info["setSharedModuleInfo"]($MODULE_VARS["uid"], "password", $default_db_password);
						$return->success = true;
					}
					return $return;
				}
			];
		}
	]);
}
