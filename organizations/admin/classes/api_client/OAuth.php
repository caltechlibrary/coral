<?php

require '../resources/api_client/vendor/autoload.php';

class OAuth {

    function __construct() {
        $config = new Configuration();
        $this->clientid = $config->ils->oauthid;
        $this->clientsecret = $config->ils->oauthsecret;
		$this->tokenURL = $config->ils->ilsApiUrl . "/oauth/token";
		$this->authURL = $config->ils->ilsApiUrl . "/oauth/authorize";
    }

    function getToken() {
		$provider = new \League\OAuth2\Client\Provider\GenericProvider([
			'clientId'                => $this->clientid,
			'clientSecret'            => $this->clientsecret,
			'urlAuthorize'            => $this->authURL,
			'urlAccessToken'          => $this->tokenURL,
			'urlResourceOwnerDetails' => ''
		]);
		try {

			// Try to get an access token using the client credentials grant.
			$accessToken = $provider->getAccessToken('client_credentials');

		} catch (\League\OAuth2\Client\Provider\Exception\IdentityProviderException $e) {

			// Failed to get the access token
			exit($e->getMessage());

		}
		return $accessToken;
    }

}

?>

