<?php

/**
 * Provides helper methods when importing data.
 */
class Import {

  public function searchForShortName($shortName, $array)
  {
    foreach($array as $key=> $val)
    {
      if(strtolower($val['shortName']) == strtolower($shortName)) {
        return $key;
        break;
      }
    }
    return null;
  }

    public function showDedupingColumns($handle, $delimiter, $deduping_columns) {
        $data = fgetcsv($handle, 0, $delimiter);
        print "<h2>"._("Settings")."</h2>";
        print "<p>"._("Importing and deduping isbnOrISSN on the following columns: ") ;
        foreach ($data as $key => $value)
        {
            if (in_array($key, $deduping_columns))
            {
                print $value . "<sup>[" . (intval($key)+1) . "]</sup> ";
            }
        }
        print ".</p>";
        rewind($handle);
    }

    public function showPreview($handle, $delimiter, $count = 5) {
        print "<h2>" . _("Preview") . "</h2>";
        print "<table class=\"linedDataTable\">";
        for ($i = 0; $i <= $count; $i++) {
            $data = fgetcsv($handle, 0, $delimiter);
            if (!$data) break;
            if ($i == 0) {
                print "<tr>";
                foreach ($data as $key => $value) {
                    $column_number = $key + 1;
                    print "<th>$column_number</th>";
                }
                print "</tr>";
            }
            print "<tr>";
            foreach ($data as $key => $value) {
                print $i == 0 ? "<th>" : "<td>";
                print $value;
                print $i == 0 ? "</th>" : "</td>";
            }
            print "</tr>";
        }
        print "</table>";
        rewind($handle);

    }

    public function showColumns($handle, $delimiter) {
        print "<h2>" . _("Columns") . "</h2>";
        $data = fgetcsv($handle, 0, $delimiter);
        print "<table class=\"linedDataTable\"><tr>";
        foreach ($data as $key => $value) {
            $column_number = $key + 1;
            print "<td>" . $column_number . "</td>";
        }
        print "</tr><tr>";
        foreach ($data as $key => $value) {
            print "<td>$value</td>";
        }
        print "</tr></table>";
        rewind($handle);
    }

    public function showMappings($handle, $delimiter, $configuration, $config_array) {
        print "<h2>" . _("Mapping") . "</h2>";
        print "<table class=\"linedDataTable\">";
        print "<tr><th>" . _("Coral field") . "</th><th>" . _("File column") . "</th></tr>";
        $data = fgetcsv($handle, 0, $delimiter);
        foreach ($config_array as $key => $value) {
      // Check for either multi-value fields or single-value fields.
      // Multi-value field information is stored in an array, with
      // 'column' containing the value we are looking for here.
            if ((is_array($configuration[$key]) && !empty($configuration[$key][0]['column'])) || !is_array($configuration[$key]) && $configuration[$key] != '') {
                print "<tr><td>";
                print $value;
                print "</td><td>";
                $coral_field = $configuration[$key];
                $fields = array();
                if (is_array($coral_field)) {
                    foreach ($coral_field as $ckey) {
                        array_push($fields, $data[$ckey['column'] - 1] ? $data[$ckey['column'] - 1] . " (" . $ckey['column'] . ") " : '<em>not found</em>');
                    }
                    print join(' / ', $fields);
                } else {
                    print $data[$configuration[$key] - 1] ? $data[$configuration[$key] - 1] . " ($configuration[$key])" : "<em>not found</em>";
                }
                print "</td></tr>";
            }
        }
        print "</table>";
        rewind($handle);
    }

}
