for(var i=0;i<action_type_ids.length;i++){ 
    if (action_types[action_type_ids[i]].value_type_id=='action_value_window'){
        action_types[action_type_ids[i]].validate = function (action){
                                                //check of alles ingevuld is, return true
                                                return true;
                                            };
        action_types[action_type_ids[i]].enable = function (action){
                                                //undo read only
                                            };

        action_types[action_type_ids[i]].disable = function (action){
                                                //set read only
                                            };
        action_types[action_type_ids[i]].changed = function (action){
                                                $('#'+action.element_name+'_changed').val(1); //element was changed
                                            };

                                            
        action_types[action_type_ids[i]].initialize = function (action) {
                                                //init
                                                $('#' + action.element_name + '_container input[type=\'text\']').change(function() {
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                                $('#' + action.element_name + '_container input[type=\'checkbox\']').change(function() {
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                                $("div[role='dialog']").find("button").click(function() {
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                             };
    }
}

let port;
let datalogger;

async function dataloggerConnect(windowNr) {
    try {
        $('#serialStatus'+windowNr).html("Connecting...");
        port = await navigator.serial.requestPort();
        await port.open({ baudRate: 9600 });
    
        setTimeout(function() { // Wait untill connected
            dataloggerRequest(windowNr, "json").catch(console.error);
        }, 2000);
    }
    catch {
        $('#serialStatus'+windowNr).html("");
    }
}

async function dataloggerRequest(windowNr, request="") {
    const writer = port.writable.getWriter();

    const encoder = new TextEncoder();
    const dataArrayBuffer = encoder.encode(request).buffer;

    await writer.write(dataArrayBuffer);

    writer.releaseLock();

    const reader = port.readable.getReader();
    const decoder = new TextDecoder();

    let receivedString = "";
    $('#serialStatus'+windowNr).html("Reading...");

    while (true) {
        const { value, done } = await reader.read();
        if (done) break;

        receivedString += decoder.decode(value);

        if (receivedString.endsWith('\n')) {
            datalogger = JSON.parse(receivedString);
            $('#temp'+windowNr).val(datalogger.temp);
            $('#temp_kast'+windowNr).val(datalogger.temp_kast);
            $('#humidity'+windowNr).val(datalogger.humidity);
            $('#dew_point'+windowNr).val(datalogger.dew_point);

            receivedString = '';
            break;
        }
    }

    reader.releaseLock();
    dataloggerDisconnect(windowNr).catch(console.error);
}

async function dataloggerDisconnect(windowNr) {
    await port.close();
    $('#serialStatus'+windowNr).html("Done!");
}