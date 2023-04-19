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
            for($i = 0; $i < count($FOR1740_array); $i++) {
                $currentWindow = $FOR1740_array[$i];    // Save current window from the list
                $action->set_value("win".$currentWindow."_FOR1740", "true");    // Save "true" in database for every window selected
            }

            $rABC_array = get_request_parameter("rABC");  // Array of which windows had this box checked
            for($i = 0; $i < count($rABC_array); $i++) {
                $currentWindow = $rABC_array[$i];    // Save current window from the list
                $action->set_value("win".$currentWindow."_rABC", "true");    // Save "true" in database for every window selected
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