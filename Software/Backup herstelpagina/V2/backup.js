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
                                                $("input[value=\"Opslaan\"]").click(function() {   // Save on click when all steps have been scrolled through
                                                    $('#' + action.element_name + '_changed').val(1);
                                                });
                                             };
    }
}

let port, datalogger, reader, writer;

async function dataloggerRequest(windowNr) {
    try {
        await dataloggerConnect(windowNr);
    }
    catch(error) { // If the request failed, report it and close port
        console.log(error)
        $('#serialStatus'+windowNr+',#_serialStatus'+windowNr).html("Failed");
        await writer.releaseLock();
        await reader.releaseLock();
        await port.close();
    }
}

async function dataloggerConnect(windowNr) {
    $('#serialStatus'+windowNr+',#_serialStatus'+windowNr).html("Connecting...");
    port = await navigator.serial.requestPort();    // Let user select a port
    await port.open({ baudRate: 9600 });    // Open selected port

    setTimeout(function() {  // Wait 2s until connected
        dataloggerWrite(windowNr, "json")
    }, 2000);
}

async function dataloggerWrite(windowNr, request="") {
    $('#serialStatus'+windowNr+',#_serialStatus'+windowNr).html("Writing...");
    writer = port.writable.getWriter();

    const encoder = new TextEncoder();
    const dataArrayBuffer = encoder.encode(request).buffer;

    await writer.write(dataArrayBuffer);

    writer.releaseLock();

    setTimeout(function() {  // Wait 2s until connected
        dataloggerRead(windowNr)
    }, 2000);
}

async function dataloggerRead(windowNr) {
    $('#serialStatus'+windowNr+',#_serialStatus'+windowNr).html("Reading...");
    reader = port.readable.getReader();
    const decoder = new TextDecoder();

    let receivedString = "";

    while (true) {
        const { value, done } = await reader.read();
        if (done) break;

        receivedString += decoder.decode(value);

        if (receivedString.endsWith('\n')) {
            datalogger = JSON.parse(receivedString);    // Parse recieved string into JSON object
            $('#_temp'+windowNr+',#temp'+windowNr).val(datalogger.temp);   // Autofill the recieved data in the corresponding input fields
            $('#_temp_kast'+windowNr+',#temp_kast'+windowNr).val(datalogger.temp_kast);
            $('#_humidity'+windowNr+',#humidity'+windowNr).val(datalogger.humidity);
            $('#_dew_point'+windowNr+',#dew_point'+windowNr).val(datalogger.dew_point);

            receivedString = '';
            break;
        }
    }

    reader.releaseLock();

    await port.close(); // Close selected port
    $('#serialStatus'+windowNr+',#_serialStatus'+windowNr).html("Finished!");
}