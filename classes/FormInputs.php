<?php

/**
 * Provides helper methods for form inputs.
 */
class FormInputs {

    public function buildSelectableHours($fieldNameBase,$defaultHour=8) {
        $html = "<select name=\"{$fieldNameBase}[hour]\">";
        for ($hour=1;$hour<13;$hour++) {
            $html .= "<option".(($hour == $defaultHour) ? ' selected':'').">{$hour}</option>";
        }
        $html .= '</select>';
        return $html;
    }

    public function buildSelectableMinutes($fieldNameBase,$intervals=4) {
        $html = "<select name=\"{$fieldNameBase}[minute]\">";
        for ($minute=0;$minute<=($intervals-1);$minute++) {
            $html .= "<option>".sprintf("%02d",$minute*(60/$intervals))."</option>";
        }
        $html .= '</select>';
        return $html;
    }

    public function buildSelectableMeridian($fieldNameBase) {
        return "<select name=\"{$fieldNameBase}[meridian]\">
                        <option>AM</option>
                        <option>PM</option>
                    </select>";
    }

    public function buildTimeForm($fieldNameBase,$defaultHour=8,$minuteIntervals=4) {
        return $this->buildSelectableHours($fieldNameBase, $defaultHour) . $this->buildSelectableMinutes($fieldNameBase, $minuteIntervals) . $this->buildSelectableMeridian($fieldNameBase);
    }

    private static $hidden = array();
    private static $visible = array();

    public static function getVisible(){
        if (count(FormInputs::$visible))
            return "?" . http_build_query(self::$visible);
        return "";
    }

    public static function getHidden(){
        if (count(FormInputs::$hidden)>0)
            return "<input type='hidden' name=\"" . implode("\"/><input type='hidden' name=\"",FormInputs::$hidden) . "\"/>";
        return "";
    }

    private static function validate($name,$val) {
        if (!is_string($name) || $name=='') {
            throw new InvalidArgumentException("param 'name' needs to be a non-empty string.");
        } else if (is_array($val)) {
            throw new InvalidArgumentException("param 'val' should not be an array.");
        }
    }

    public static function addVisible($name, $val){
        FormInputs::validate($name, $val);
        FormInputs::$visible[$name] = $val;
    }

    public static function addHidden($name, $val){
        FormInputs::validate($name, $val);
        FormInputs::$hidden[] = "$name\" value=\"$val";
    }
}
