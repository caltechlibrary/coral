<?php

class EbscoKbVendor extends EbscoKbResult {

    public function getPackages($value)
    {
        $ebscoKb = new EbscoKbService();
        return $ebscoKb->getPackages($this->vendorId);
    }

    public function renderPackageList()
    {
        ob_start();
        $items = $this->packages;
        include_once __DIR__.'/../../../templates/ebscoKbPackageList.php';
        return ob_get_clean();
    }

}