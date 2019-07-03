<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Mink\Exception\ElementNotFoundException;
use Behat\Mink\Exception\ElementTextException;
use Behat\Mink\Exception\ResponseTextException;
use Behat\MinkExtension\Context\RawMinkContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawMinkContext {

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance. You can also pass arbitrary
   * arguments to the context constructor through behat.yml.
   */
  public function __construct() {}

  const TIMEOUT = 10;

  /** @var \Behat\MinkExtension\Context\MinkContext */
  private $minkContext;

  /** @BeforeScenario */
  public function gatherContexts(BeforeScenarioScope $scope) {
    $environment = $scope->getEnvironment();
    $this->minkContext = $environment->getContext('Behat\MinkExtension\Context\MinkContext');
  }

  /**
   * @BeforeScenario @reset_licensing
   */
  public function resetLicensingDb(BeforeScenarioScope $scope) {
    $db = new mysqli('db', 'root', 'foobar', 'coral_licensing');

    if ($db->connect_error) {
      exit('Connection failed: ' . $db->connect_error);
    }

    if ($tables = $db->query('SHOW TABLES')) {
      while ($table = $tables->fetch_array(MYSQLI_NUM)) {
        $db->query('DROP TABLE IF EXISTS ' . $table[0]);
      }
    }

    // This SQL file contains an export of the Licensing database in the state
    // immediately following installation; no licenses have been added to it.
    $sql = file_get_contents(__DIR__ . '/coral_licensing.sql');
    if (!$db->multi_query($sql)) {
      exit('Database reset failed.');
    }

    $db->close();
  }

  /**
   * @BeforeScenario @reset_organizations
   */
  public function resetOrganizationsDb(BeforeScenarioScope $scope) {
    $db = new mysqli('db', 'root', 'foobar', 'coral_organizations');

    if ($db->connect_error) {
      exit('Connection failed: ' . $db->connect_error);
    }

    if ($tables = $db->query('SHOW TABLES')) {
      while ($table = $tables->fetch_array(MYSQLI_NUM)) {
        $db->query('DROP TABLE IF EXISTS ' . $table[0]);
      }
    }

    // This SQL file contains an export of the Organizations database in the state
    // immediately following installation; no organizations have been added to it.
    $sql = file_get_contents(__DIR__ . '/coral_organizations.sql');
    if (!$db->multi_query($sql)) {
      exit('Database reset failed.');
    }

    $db->close();
  }

  /**
   * @BeforeScenario @reset_resources
   */
  public function resetResourcesDb(BeforeScenarioScope $scope) {
    $db = new mysqli('db', 'root', 'foobar', 'coral_resources');

    if ($db->connect_error) {
      exit('Connection failed: ' . $db->connect_error);
    }

    if ($tables = $db->query('SHOW TABLES')) {
      while ($table = $tables->fetch_array(MYSQLI_NUM)) {
        $db->query('DROP TABLE IF EXISTS ' . $table[0]);
      }
    }

    // This SQL file contains an export of the Resources database in the state
    // immediately following installation; no resources have been added to it.
    $sql = file_get_contents(__DIR__ . '/coral_resources.sql');
    if (!$db->multi_query($sql)) {
      exit('Database reset failed.');
    }

    $db->close();
  }

  /**
   * @When /^I wait for (\d+) seconds$/
   */
  public function iWaitForSeconds($seconds) {
    $this->getSession()->wait($seconds * 1000);
  }

  /**
   * Wait for a element.
   *
   * @When (I )wait :count second(s) until I see :element element
   */
  public function iWaitSecondsForElement($seconds, $element) {
    $i = 0;
    while ($i < $seconds) {
      try {
        $this->minkContext->assertElementOnPage($element);

        return;
      } catch (ElementNotFoundException $e) {
        ++$i;
        sleep(1);
      }
    }

    $message = "The element '$element' was not found after a $seconds seconds timeout";
    throw new ResponseTextException($message, $this->getSession());
  }

  /**
   * @When (I )wait until I see :element element
   */
  public function iWaitForElement($element) {
    $this->iWaitSecondsForElement(self::TIMEOUT, $element);
  }

  /**
   * Checks, that the element contains specified text after timeout.
   *
   * @When (I )wait :count second(s) until I see :text in the :element element
   */
  public function iWaitSecondsUntilISeeInTheElement($seconds, $text, $element) {
    $i = 0;
    while ($i < $seconds) {
      try {
        $this->minkContext->assertElementContainsText($element, $text);

        return;
      } catch (ElementTextException $e) {
        ++$i;
        sleep(1);
      }
    }

    $message = "The text '$text' was not found after a $seconds seconds timeout";
    throw new ResponseTextException($message, $this->getSession());
  }

  /**
   * Checks, that the page should contains specified text after given timeout.
   *
   * @When (I )wait :count second(s) until I see :text
   */
  public function iWaitSecondsUntilISee($seconds, $text) {
    $this->iWaitSecondsUntilISeeInTheElement($seconds, $text, 'html');
  }

  /**
   * Checks, that the element contains specified text after timeout.
   *
   * @When (I )wait until I see :text in the :element element
   */
  public function iWaitUntilISeeInTheElement($text, $element) {
    $this->iWaitSecondsUntilISeeInTheElement(self::TIMEOUT, $text, $element);
  }

  /**
   * @When (I )wait until I see :text
   */
  public function iWaitUntilISee($text) {
    $this->iWaitSecondsUntilISeeInTheElement(self::TIMEOUT, $text, 'html');
  }

}
