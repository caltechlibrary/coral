<?php

/**
 * Provides methods for working with configuration files.
 */
class EbscoKbConfig {

    public function writePhpIni($file, $array)
    {
        $res = array();
        foreach($array as $key => $val)
        {
            if(is_array($val))
            {
                $res[] = "[$key]";
                foreach($val as $skey => $sval) $res[] = "$skey = ".(is_numeric($sval) ? $sval : '"'.addcslashes($sval, '"').'"');
            }
            else $res[] = "$key = ".(is_numeric($val) ? $val : '"'.addcslashes($val, '"').'"');
        }
        $this->safeFileRewrite($file, implode("\r\n", $res));
    }

    public function safeFileRewrite($fileName, $dataToSave)
    {
        if (!is_writable($fileName)) {
            throw new Exception("$fileName is not writeable.");
        }

        if ($fp = fopen($fileName, 'w')) {
            $startTime = microtime(TRUE);

            do {
                $canWrite = flock($fp, LOCK_EX);
                // If lock not obtained sleep for 0 - 100 milliseconds, to avoid collision and CPU load
                if (!$canWrite) {
                    usleep(round(rand(0, 100) * 1000));
                }
            } while ((!$canWrite) and ((microtime(TRUE) - $startTime) < 5));

            //file was locked so now we can store information
            if ($canWrite) {
                fwrite($fp, $dataToSave);
                flock($fp, LOCK_UN);
            }
            fclose($fp);
        }
    }

}
