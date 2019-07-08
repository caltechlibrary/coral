<?php


class ILSClientSelector {

    public function select() {
        $config = new Configuration();
        if ($config->ils->ilsConnector == "koha")
            $ilsClient = new KohaClient();

        return $ilsClient;

    }

}

?>
