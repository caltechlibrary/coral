<?php

/**
 * Provides methods for menus.
 */
class Menu {

  protected $user;

  public function __construct(User $user) {
    $this->user = $user;
  }

  public function resourcesSideMenu($selected_link = '') {
    $links = array(
      'product' => _("Product"),
      'orders' => _("Orders"),
      'acquisitions' => _("Acquisitions"),
      'access' => _("Access"),
      'cataloging' => _("Cataloging"),
      'contacts' => _("Contacts"),
      'accounts' => _("Accounts"),
      'issues' => _("Issues"),
      'attachments' => _("Attachments"),
      'workflow' => _("Workflow"),
    );
    foreach ($links as $key => $value) {
      $name = ucfirst($key);
      if ($selected_link == $key) {
        $class = 'sidemenuselected';
      } else {
        $class = 'sidemenuunselected';
      }
      if ($key != 'accounts' || $this->user->accountTabIndicator == '1') {
      ?>
      <div class="<?php echo $class; ?>" style='position: relative; width: 105px'><span class='link'><a href='javascript:void(0)' class='show<?php echo $name; ?>' title="<?php echo $value; ?>"><?php echo $value; ?></a></span>
        <?php if ($key == 'attachments') { ?>
          <span class='span_AttachmentNumber smallGreyText' style='clear:right; margin-left:18px;'></span>
        <?php } ?>
      </div>
      <?php
      }
    }
  }

  public function usageSideMenu($selected_link = '') {
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
      if ($key != 'accounts' || $this->user->accountTabIndicator == '1') {
      ?>
      <div class="<?php echo $class; ?>" style='position: relative; width: 105px'>
         <span class='link'><a href='javascript:void(0)' class='show<?php echo $name; ?>' title='<?php echo $value; ?>'><?php echo $value; ?></a></span>
      </div>
      <?php
      }
    }
  }

}
