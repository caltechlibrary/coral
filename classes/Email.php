<?php

// @file classes/Email.php

class Email extends BaseObject {

	protected $to;
	protected $subject;
	protected $message;
	protected $headers = array();

	protected $from = "";
	protected $replyTo = "";

	protected function nameIsBasic($name) {
		return preg_match('/^(to)|(subject)|(message)$/', $name);
	}

	protected function getHeaders() {
		$output = '';

		foreach ($this->headers as $header) {
			$output .= $header->text();
		}
		//append from and reply to
		$output .= "From: " . $this->from . "\r\n";
		$output .= "Reply-To: " . $this->replyTo . "\r\n";
		$output .= "Content-Type: text/html; charset=UTF-8" . "\r\n";

		return $output;
	}

	public function setValueForKey($key, $value) {
		if ($this->nameIsBasic($key)) {
			parent::setValueForKey($key, $value);
		} else {
			$this->headers[$key] = new EmailHeader(new NamedArguments(array('name' => $key, 'body' => $value)));
		}
	}

	public function fullMessage() {
		return $this->getHeaders() . "\n" . $this->to . "\n" . $this->subject . "\n" . $this->message;
	}

	public function send(){
		return mail($this->to, $this->subject, $newMessage, rtrim($this->getHeaders()));
	}

}

?>
