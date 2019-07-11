<?php

/**
 * Generate and format HTML.
 */
class Html {

  public function generateDowntimeHtml($downtime, $associatedEntities = NULL) {
    $html = '';
    $html .= '<div class="downtime">';
    $html .= '<dl><dt>' . _('Type:') . '</dt><dd>' . $downtime->shortName . '</dd><dt>' . _('Downtime Start:') . '</dt><dd>' . $downtime->startDate . '</dd><dt>' . _('Downtime Resolved:') . '</dt><dd>';
    if ($downtime->endDate != NULL) {
      $html .= $downtime->endDate;
    }
    else {
      $html .= '<a class="thickbox" href="ajax_forms.php?action=getResolveDowntimeForm&height=363&width=345&modal=true&downtimeID=' . $downtime->downtimeID . '">' . _('Resolve') . '</a>';
    }
    $html .= '</dd>';
    if ($downtime->subjectText) {
      $html .= '<dt>' . _('Linked issue:') . '</dt><dd>' . $downtime->subjectText . '</dd>';
    }
    if ($downtime->note) {
      $html .= '<dt>' . _('Note:') . '</dt><dd>' . $downtime->note . '</dd>';
    }
    $html .= '</dl></div>';
    return $html;
  }

  public function generateIssueHtml($issue, $associatedEntities = NULL) {
    $html = '';
    $html .= '<div class="issue">';
    if (!$issue->dateClosed) {
      $html .= '<a class="thickbox action closeIssueBtn" href="ajax_forms.php?action=getCloseIssueForm&issueID=' . $issue->issueID . '&height=120&width=345&modal=true">' . _('close') . '</a>';
      if ($associatedEntities && $associatedEntities[0]['entityType'] == 1) {
        $html .= '<a class="thickbox action" href="ajax_forms.php?action=getNewDowntimeForm&organizationID=' . $associatedEntities[0]['id'] . '&issueID=' . $issue->issueID . '&height=200&width=390&modal=true">' . _('downtime') . '</a>';
      }
      else {
        $html .= '<a class="thickbox action" href="ajax_forms.php?action=getNewDowntimeForm&resourceID=' . $GLOBALS['resourceID'] . '&issueID=' . $issue->issueID . '&height=200&width=390&modal=true">' . _('downtime') . '</a>';
      }
    }
    $html .= '<dl><dt>' . _('Date reported:') . '</dt><dd>' . $issue->dateCreated . '</dd>';
    if ($issue->dateClosed) {
      $html .= '<dt>' . _('Date closed:') . '</dt><dd>' . $issue->dateClosed . '</dd><dt>' . _('Resolution') . '</dt><dd>' . $issue->resolutionText . '</dd>';
    }
    $html .= '<dt>' . _('Contact(s):') . '</dt><dd>';
    $contacts = $issue->getContacts();
    if ($contacts) {
      $html .= '<ul class="contactList">';
      foreach ($contacts as $contact) {
        $html .= '<li><a href="mailto:' . urlencode($contact['emailAddress']) . '"?Subject=RE: ' . $issue->subjectText . '">' . $contact['name'] . '</a></li>';
      }
      $html .= '</ul>';
    }
    $html .= '</dd><dt>' . _('Applies to:') . '</dt><dd>';
    if ($associatedEntities) {
      $temp = '';
      foreach ($associatedEntities as $entity) {
        $temp .= ' ' . $entity['name'] . ',';
      }
      $html .= rtrim($temp, ',');
    }
    $html .= '</dd><dt>' . _('Subject:') . '</dt><dd>' . $issue->subjectText . '</dd><dt class="block">' . _('Body:') . '</dt><dd>' . $issue->bodyText . '</dd></dl></div>';
    return $html;
  }

  public function getResourceTypesAsDropdown($server, $headers, $body) {
      $response = Unirest\Request::post($server . "getResourceTypes/", $headers, $body);
      echo '<select name="resourceTypeID" class="pure-u-1 pure-u-md-1-4">';
      foreach ($response->body as $resourceType) {
          echo ' <option value="' . $resourceType->resourceTypeID  . '">' . $resourceType->shortName . "</option>";
      }
      echo '</select>';
  }

  public function getAcquisitionTypesAsRadio($server, $headers, $body) {
      $response = Unirest\Request::post($server . "getAcquisitionTypes/", $headers, $body);
      foreach ($response->body as $AcquisitionType) {
          $default = (isset($AcquisitionType->shortName) && strtolower($AcquisitionType->shortName) == "approved")? ' checked':'' ;  //Replace 'approved' with your default
          if (strtolower($AcquisitionType->shortName) == "approved" || strtolower($AcquisitionType->shortName) == "needs approval") {
              echo ' <label for="acquisitionType'.$AcquisitionType->acquisitionTypeID.'" class="pure-radio"> ';
              echo ' <input id="acquisitionType'.$AcquisitionType->acquisitionTypeID.'" type="radio" name="acquisitionTypeID" value="' . $AcquisitionType->acquisitionTypeID . '" '.$default.'> ';
              echo $AcquisitionType->shortName . '</label>';
          }
      }
  }

  public function getResourceFormatsAsDropdown($server, $headers, $body) {
      $response = Unirest\Request::post($server . "getResourceFormats/", $headers, $body);
      echo '<select name="resourceFormatID">';
      foreach ($response->body as $resourceFormat) {
          echo ' <option value="' . $resourceFormat->resourceFormatID . '">' . $resourceFormat->shortName . "</option>\n";
      }
      echo '</select>';
  }

  public function getAdministeringSitesAsDropdown($server, $headers, $body) {
      $response = Unirest\Request::post($server . "getAdministeringSites/", $headers, $body);
      echo '<select name="administeringSiteID[]" multiple="multiple">';
      foreach ($response->body as $administeringSite) {
          echo ' <option value="' . $administeringSite->administeringSiteID . '">' . $administeringSite->shortName . "</option>\n";
      }
      echo '</select>';
  }

  public function getFundCodesAsDropdown($server, $headers, $body) {
    $response = Unirest\Request::post($server . "getFundCodes/", $headers, $body);
    echo "<select name='fund'>\n";
    echo "  <option value=''>unknown</option>\n";
    foreach ($response->body as $fund) {
          if (!is_null($fund->fundCode) && !is_null($fund->shortName) && is_null($fund->archived)){
        echo ' <option value="' . $fund->fundCode . '">' . $fund->shortName ."</option>\n";
      }
    }
    echo '</select>';
  }

  public function nameToID($str) {
    $str = preg_replace('/[^a-zA-Z0-9]/', ' ', $str);
    $str = explode(' ', $str);
    $str = array_map('ucfirst', $str);
    $str = lcfirst(implode('', $str));
    return $str;
  }

  public function humanize($str) {
    $str = trim($str);
    $str = preg_replace('/ID$/i', '', $str);
    $str = preg_replace('/[A-Z]+/', " $0", $str);
    $str = preg_replace('/[^a-z0-9\s+]/i', '', $str);
    $str = preg_replace('/\s+/', ' ', $str);
    $str = explode(' ', $str);
    $str = array_map('ucwords', $str);
    return implode(' ', $str);
  }

  public function label_tag($for, $name = null, $required = false) {
    if ($name === null) {
      $name = (new Html())->humanize($for);
    }

    if ($required) {
      $required_text = '&nbsp;&nbsp;<span class="bigDarkRedText">*</span>';
    } else {
      $required_text = '';
    }

    return '<label for="'. htmlspecialchars($for).'">'.htmlspecialchars($name).':'.$required_text.'</label>';
  }

  public function hidden_field_tag($name, $value, $options = array()) {
    $default_id = (new Html())->nameToID($name);
    $default_options = array('id' => $default_id);
    $options = array_merge($default_options, $options);

    return '<input type="hidden" id="'.htmlspecialchars($options['id']).'" name="'.htmlspecialchars($name).'" value="'.htmlspecialchars($value). '" />';
  }

  public function hidden_search_field_tag($name, $value, $options = array()) {
    return (new Html())->hidden_field_tag("search[".$name."]", $value, $options);
  }

  public function text_field_tag($name, $value, $options = array()) {
    $default_id = (new Html())->nameToID($name);
    $default_options = array('width' => '180px', 'id' => $default_id, 'class' => 'changeInput');
    $options = array_merge($default_options, $options);

    return '<input type="text" id="'.htmlspecialchars($options['id']).'" name="'.htmlspecialchars($name).'" style="width:'.$options['width'].'" class="'.htmlspecialchars($options['class']).'" value="'.htmlspecialchars($value). '" /><span id="span_error_'.htmlspecialchars($options['id']).'" class="smallDarkRedText"></span>';
  }

  public function text_field($field, $object, $options = array()) {
    return (new Html())->text_field_tag($field, $object->$field, $options);
  }

  public function text_search_field_tag($name, $value, $options = array()) {
    $default_options = array('width' => '145px', 'class' => '');
    $options = array_merge($default_options, $options);
    return (new Html())->text_field_tag("search[".$name."]", $value, $options);
  }



  public function select_field($field, $object, $collection, $options = array()) {
    $default_options = array('width' => '180px');
    $options = array_merge($default_options, $options);

    $str = '<select id="'.$field.'" name="'.$field.'" style="width:'.$options['width'].'"><option></option>';
    foreach ($collection as $item) {
      if (is_subclass_of($item, 'DatabaseObject')) {
        $key = $item->getPrimaryKeyName();
        $value = $item->$key;
        $name = $item->shortName;
      } else {
        $value = $item;
        $name = $item;
      }
      if ($value == $object->$field) {
        $str .= '<option value="'.htmlspecialchars($value).'" selected="selected">'.htmlspecialchars($name).'</option>';
      } else {
        $str .= '<option value="'.htmlspecialchars($value).'">'.htmlspecialchars($name).'</option>';
      }
    }
    $str .= '</select><span id="span_error_'.$field.'" class="smallDarkRedText"></span>';
    return $str;
  }
}
