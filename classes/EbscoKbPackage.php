<?php

class EbscoKbPackage extends EbscoKbResult {

    public function getContentType($value)
    {
        return preg_replace('/(?<!^)([A-Z])/', ' \\1', $value);
    }

    public function getTitles()
    {
        $ebscoKb = EbscoKbService::getInstance();
        $ebscoKb->createQuery(['vendorId' => $this->vendorId, 'packageId' => $this->packageId]);
        $ebscoKb->execute();
        return $ebscoKb->results();
    }

    public function loadResource($resourceId = null)
    {
        if($resourceId){
            $this->resource = new Resource(new NamedArguments(array('primaryKey' => $resourceId)));
        } else {
            $resource = new Resource();
            $this->resource =  $resource->getResourceByEbscoKbId($this->packageId);
        }
    }
}