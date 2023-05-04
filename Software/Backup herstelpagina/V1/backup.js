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
                                                $('#' + action.element_name + '_container input[type=\'text\']').change(function() {    // Save on change of a text type input
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                                $('#' + action.element_name + '_container input[type=\'checkbox\']').change(function() {    // Save on change of a checkbox type input
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                                $("div[role='dialog']").find("button").click(function() {   // Save on click of a button inside the dialog div (OK button in window select screen)
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
        port = await navigator.serial.requestPort();    // Let user select a port
        await port.open({ baudRate: 9600 });    // Open selected port
    
        setTimeout(function() { // Wait untill connected
            dataloggerRequest(windowNr, "json").catch(console.error);   // "json" is the string that will be sent to the arduino
        }, 2000);
    }
    catch { // If the connecting failed, clear the status
        $('#serialStatus'+windowNr).html("");
    }
}

async function dataloggerRequest(windowNr, request="") {
    // WRITE
    const writer = port.writable.getWriter();

    const encoder = new TextEncoder();
    const dataArrayBuffer = encoder.encode(request).buffer;

    await writer.write(dataArrayBuffer);

    writer.releaseLock();

    // READ
    const reader = port.readable.getReader();
    const decoder = new TextDecoder();

    let receivedString = "";
    $('#serialStatus'+windowNr).html("Reading...");

    while (true) {
        const { value, done } = await reader.read();
        if (done) break;

        receivedString += decoder.decode(value);

        if (receivedString.endsWith('\n')) {
            datalogger = JSON.parse(receivedString);    // Parse recieved string into JSON object
            $('#temp'+windowNr).val(datalogger.temp);   // Autofill the recieved data in the corresponding input fields
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
    await port.close(); // Close selected port
    $('#serialStatus'+windowNr).html("Done!");
}