<?php

class EbscoKbCustomerResource extends EbscoKbResult {

    public function getCoverageStatement($value)
    {
        if(!empty($value)){
            return $value;
        }

        $coverage = [];
        foreach($this->managedCoverageList as $c){
            $begin = date_create_from_format('Y-m-d', $c['beginCoverage']);
            if(empty($c['endCoverage'])){
                $coverage[] = 'from '.date_format($begin,'F Y');
            } else {
                $end = date_create_from_format('Y-m-d', $c['endCoverage']);
                $coverage[] = date_format($begin,'F Y').' to '.date_format($end, 'F Y');
            }

        }
        return implode(', ',$coverage);
    }

    public function getEmbargoStatement()
    {

        $embargoValue = $this->getEmbargoValue();
        return empty($embargoValue) ? 'None' : $embargoValue;

    }

    public function getEmbargoValue()
    {
        if(empty($this->managedEmbargoPeriod['embargoUnit'])){
            return null;
        }

        $value = $this->managedEmbargoPeriod['embargoValue'];
        $unit = $value == 1 ? substr($this->managedEmbargoPeriod['embargoUnit'],0,-1) : $this->managedEmbargoPeriod['embargoUnit'];

        return _("$value $unit");
    }
}