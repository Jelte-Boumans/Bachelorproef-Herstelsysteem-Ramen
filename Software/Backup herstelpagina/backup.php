<?php


class action_value_window extends action_value_type {
    
    private $users, $user;

    function __construct($action){
        parent::__construct($action);
    }

    public static function get_type_name(){
        global $app;
        return $app->get_template_string('window_select', null,'Window select');
    }
    
    public static function get_id(){
        return __class__;
    }
        

    function is_changed($view_mode, $user){
        $name = $this->element_name;
        $changed = get_request_parameter("{$name}_changed");
        if ($changed==1){
            return true;
        }
        return false;
    }

    function update_action($view_mode, $user){
        $action = $this->action;
        $name = $this->element_name;
        if ($this->is_changed($view_mode,$user)){
            $selectedWindows = get_request_parameter("selectedWindows");    // Get selected windows from user input
            $action->set_value("selectedWindows", $selectedWindows);    // Save the string into the database (e.g. "1,3,5" )
            $selectedWindows = explode(",", $selectedWindows);  // Turn into int array, needed in for loop 

            for($i = 0; $i < count($selectedWindows); $i++) {
                $currentWindow = $selectedWindows[$i];  // Save current window from the list
                $action->set_value("win".$currentWindow."_batchnr_SF268P", get_request_parameter("batchnr_SF268P")[($currentWindow-1)]);  // -1 because zero indexed so window 5 = index 4
                $action->set_value("win".$currentWindow."_hdatum_SF268P", get_request_parameter("hdatum_SF268P")[($currentWindow-1)]);
                
                $action->set_value("win".$currentWindow."_batchnr_SF268", get_request_parameter("batchnr_SF268")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_hdatum_SF268", get_request_parameter("hdatum_SF268")[($currentWindow-1)]);
                
                $action->set_value("win".$currentWindow."_batchnr_SA100", get_request_parameter("batchnr_SA100")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_hdatum_SA100", get_request_parameter("hdatum_SA100")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_odatum_SA100", get_request_parameter("odatum_SA100")[($currentWindow-1)]);
                
                $action->set_value("win".$currentWindow."_batchnr_SP207", get_request_parameter("batchnr_SP207")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_hdatum_SP207", get_request_parameter("hdatum_SP207")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_odatum_SP207", get_request_parameter("odatum_SP207")[($currentWindow-1)]);
                
                $action->set_value("win".$currentWindow."_batchnr_SA", get_request_parameter("batchnr_SA")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_hdatum_SA", get_request_parameter("hdatum_SA")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_odatum_SA", get_request_parameter("odatum_SA")[($currentWindow-1)]);
                
                $action->set_value("win".$currentWindow."_temp", get_request_parameter("temp")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_temp_kast", get_request_parameter("temp_kast")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_humidity", get_request_parameter("humidity")[($currentWindow-1)]);
                $action->set_value("win".$currentWindow."_dew_point", get_request_parameter("dew_point")[($currentWindow-1)]);
            }

            $FOR1740_array = get_request_parameter("FOR1740");  // Array of which windows had this box checked
            if($FOR1740_array) {   // If the array is empty, dont attempt to loop through it
                for($i = 0; $i < count($FOR1740_array); $i++) {
                    $currentWindow = $FOR1740_array[$i];    // Save current window from the list
                    $action->set_value("win".$currentWindow."_FOR1740", "true");    // Save "true" in database for every window selected
                }
            }

            $rABC_array = get_request_parameter("rABC");  // Array of which windows had this box checked
            if($rABC_array) {   // If the array is empty, dont attempt to loop through it
                for($i = 0; $i < count($rABC_array); $i++) {
                    $currentWindow = $rABC_array[$i];    // Save current window from the list
                    $action->set_value("win".$currentWindow."_rABC", "true");    // Save "true" in database for every window selected
                }
            }

            //if (is_valid_id($val)) { //beslissing of ales goed is ingevuld
            //    $action->set_action_text("OK");
            //    $val = ACTION_STATUS_OK;
            //} else {
            //    $val = ACTION_STATUS_NOTEXEC;
            //}

            //$action->change($val, time(), $user->get_id());

            parent::update_action($view_mode, $user); //called to do part requests
            $action->save();
            return true;
        }
        return false;
    }

    function to_javascript_array(){
        return parent::to_javascript_array();    
    }

}

/*
        $buttonCoords = array(
            "576,135,622,177",
            "576,291,622,332",
            "451,135,496,177",
            "450,291,497,332",
            "391,135,437,177",
            "391,291,437,332",
            "340,135,387,177",
            "341,291,387,332",
            "288,135,333,177",
            "288,291,333,332",
            "161,135,207,176",
            "162,290,208,332",
            "104,135,150,177",
            "104,291,150,332",
            "636,367,682,409",
            "635,515,681,556",
            "577,367,622,409",
            "577,515,624,556",
            "451,367,497,409",
            "451,515,497,556",
            "391,367,438,409",
            "391,515,437,556",
            "342,367,387,409",
            "341,516,386,557",
            "288,367,334,408",
            "288,514,334,556",
            "161,367,207,409",
            "162,515,208,556",
            "103,367,150,409",
            "104,515,151,556",
            "638,596,684,638",
            "461,742,507,783",
            "582,597,627,639",
            "396,742,443,783",
            "471,596,517,638",
            "345,742,391,783",
            "351,596,398,638",
            "293,742,339,783",
            "297,596,342,638",
            "172,742,217,783",
            "172,597,218,638",
            "583,742,629,784",
            "641,741,687,783",
            "636,134,682,176",
            "636,290,682,331",
            "743,212,788,254",
            "116,597,163,638",
            "11,668,57,710",
            "116,742,162,783",
        );
*/