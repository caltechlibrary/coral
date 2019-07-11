<?php

/**
 * Provides methods for Usage Statistics.
 */
class Usage {

  public function sidemenu($selected_link = '') {
    global $user;
    $links = array(
      'imports' => _("Imports"),
      'titles' => _("Titles"),
      'statistics' => _("Statistics"),
      'logins' => _("Logins"),
      'sushi' => _("Sushi"),
    );
    foreach ($links as $key => $value) {
      $name = mb_convert_case($key, MB_CASE_TITLE, "UTF-8");
      if ($selected_link == $key) {
        $class = 'sidemenuselected';
      } else {
        $class = 'sidemenuunselected';
      }
      if ($key != 'accounts' || $user->accountTabIndicator == '1') {
      ?>
      <div class="<?php echo $class; ?>" style='position: relative; width: 105px'>
         <span class='link'><a href='javascript:void(0)' class='show<?php echo $name; ?>' title='<?php echo $value; ?>'><?php echo $value; ?></a></span>
      </div>
      <?php
      }
    }
  }

}
