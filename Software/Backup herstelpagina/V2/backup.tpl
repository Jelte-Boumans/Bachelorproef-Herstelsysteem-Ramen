<script>
    let selectedWindows = [{$action->get_value("selectedWindows")}];    // Recieve the selected windows from the database on startup
    let currentStep = {
        {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}    // Make an attribute for every selected window to save to current step
            {if $action->get_value("selectedWindows")}{$windowNr}: 1,{/if}
        {/foreach}
    };
    const stepAmount = 23;
    const stepAmountFrontWindow = 32;
    
    $(document).ready(function() {
        updateDropdowns();  // Update the dropdowns and the state of the checkboxes on startup, needed for when data is already saved in database
        updateCheckboxes();
        
        $("article").css("visibility", "visible");  // Show after done loading
        $("#loading").hide();

        {if $action->get_value("selectedWindows") && not $value_type->is_read_only($competence_level, $view_mode)}  // If there are any selected windows in the database
            {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}
                updateCrossIcon($("area[alt=\"{$windowNr}\"]").attr("coords"), {$windowNr});  // Show each "cross.png" image one by one
            {/foreach}
        {/if}

        $("#accordion").accordion({ 
            collapsible: true,
            heightStyle: 'content',
            active: 'none'
        });

        $("#window_select_popup").dialog({
            title: "Ramen selecteren",
            width: "auto",
            autoOpen: false,
            buttons: {
                "OK": function() {
                    updateDropdowns();  // Update the dropdowns every time you close the popup
                    $(this).dialog("close");
                }
            }
        });

        $("#step_photos_popup").dialog({
            title: "Foto",
            width: "auto",
            autoOpen: false,
        });

        $('#window_select_popup_open').click(function () {
            updateWindowsList();    // Update the selected window list when you open the popup, needed for displaying data from database
            $('#window_select_popup').dialog("open");
            return false;
        });

        $("area").click(function(){
            let windowNr = $(this).attr("alt"); // The alt attribute of every <area> holds the windowNr
            windowNr = Number(windowNr);

            // Add or remove window numbers from the selected windows array
            if(selectedWindows.includes(windowNr)) {
                selectedWindows.splice(selectedWindows.indexOf(windowNr),1);
                delete currentStep[windowNr];
            }
            else {
                selectedWindows.push(windowNr);
                currentStep[windowNr] = 1;
            }
            // Sort the selected windows array (ascending)
            selectedWindows.sort(function(a, b) {
                return a - b;
            });
            console.log(currentStep)
            // Show or hide a red cross depending on which button is pressed
            let coords = $(this).attr("coords");
            updateCrossIcon(coords, windowNr);

            updateWindowsList();    // Update the list of selected windows at the bottom of the popup
            return false;
        });

        $("#reset").click(function () {
            selectedWindows = [];
            $(".window-select-cross").hide();
            $("#selectedWindowsDisplay").html("<b>Geen ramen geselecteerd.</b>");
            return false;
        });

        $("input[alt=\"nextStep\"]").click(function () {
            const windowNr = $(this).attr("id");    // When a button is pressed, save the corresponding window number

            let maxSteps = 0;
            if(windowNr == 46 || windowNr == 49) {    // The front windows have a different amount of steps
                maxSteps = stepAmountFrontWindow;
            }
            else {
                maxSteps = stepAmount;
            }

            if(currentStep[windowNr] < maxSteps) {   // If the current step for this window is not the final step
                currentStep[windowNr]++;    // Go to the next step only for this window
                $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").css("visibility", "visible"); // Make the "previous step" button visible
            }
            updateSteps(windowNr, maxSteps);  // Update current visible slide for this window

            if(currentStep[windowNr] == maxSteps) {  // If the current step is the last one
                $(this).css("visibility", "hidden");    // Hide the "next step" button
                $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").prop("disabled", true);   // Disable the "previous step" button so it cant be pressed when waiting

                setTimeout(function() { // Wait 2.5 seconds to execute this code
                    $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").prop("disabled", false);  // Enable the "previous step" button
                    $("input[alt=\"finishWindow\"][id=\""+windowNr+"\"]").fadeIn(); // Make the "finish window" button appear
                }, 2500);
            }
            
            return false;
        });

        $("input[alt=\"prevStep\"]").click(function () {
            const windowNr = $(this).attr("id");    // When a button is pressed, save the corresponding window number

            let maxSteps = 0;
            if(windowNr == 46 || windowNr == 49) {    // The front windows have a different amount of steps
                maxSteps = stepAmountFrontWindow;
            }
            else {
                maxSteps = stepAmount;
            }

            if(currentStep[windowNr] > 1) {   // If the current step for this window is not the first step
                currentStep[windowNr]--;// Go to the previous step only for this window
                $("input[alt=\"nextStep\"][id=\""+windowNr+"\"]").css("visibility", "visible"); // Make the "next step" button visible
                $("input[alt=\"finishWindow\"][id=\""+windowNr+"\"]").hide();   // Hide the "finish windows" button in case the user goes from the last slide back to the second to last slide
            }
            updateSteps(windowNr, maxSteps);  // Update current visible slide for this window

            if(currentStep[windowNr] == 1) {  // If the current step is the first one
                $(this).css("visibility", "hidden");    // Hide the "previous step" again
            }

            return false;
        });

        $("input[alt=\"finishWindow\"]").click(function () {
            const windowNr = $(this).attr("id");    // When a button is pressed, save the corresponding window number
            $("#steps"+windowNr).hide();    // Hide the steps slideshow for this window
            $("#inputField"+windowNr).fadeIn(); // Show the input field
            $("#window_saved"+windowNr).val("true"); // Save to the database that all steps have been read
            return false;
        });

        $("input[alt=\"stepInput\"]").change(function() {
            const id = $(this).attr("id").replace("_","");  // Save id (but remove underscore) when you type something in input field
            if($(this).attr("type") == "checkbox") {    // If the changed input is a checkbox
                const checked = $(this).prop('checked');
                $("#"+id).prop('checked', checked); // Duplicate the state of this checkbox to the one in the "finish window" input field
            }
            else {  // If the changed input is a text field
                const data = $(this).val();
                $("#"+id).val(data); // Duplicate the data of this text fied to the one in the "finish window" input field
            }

            return false;
        });

        return false;
    });

    function updateDropdowns() {
        $('#selectedWindows').val(selectedWindows); // Cache the selected windows array to be saved in to the database
        if(selectedWindows.length == 0) {   // If there are no windows selected
            $("#dropdown-window-text").show();  // Display the "no windows selected" text
            for(let i = 0; i < 50; i++) // Hide every dropdown one by one
                $("#dropdown-window"+i).hide(); 
            return;
        }

        // If there is at least one window selected 
        $("#dropdown-window-text").hide();  // Hide the "no windows selected" text
        for(let i = 0; i < 50; i++) {   // Show the selected windows and hide the rest one by one
            if(selectedWindows.includes(i))
                $("#dropdown-window"+i).show();
            else
                $("#dropdown-window"+i).hide();
        }
    }

    function updateWindowsList() {
        let str = "";
        if(!selectedWindows.length) // If there are no selected windows (selectedWindows.length == 0)
                str = "<b>Geen ramen geselecteerd.</b>";
        else {
            for(let i = 0; i < selectedWindows.length; i++) {
                if(str == "")   // If it is the first number to be added
                    str += "Raam " + selectedWindows[i];
                else
                    str += ", raam " + selectedWindows[i];
            }
        }
        $("#selectedWindowsDisplay").html(str);
    }

    function updateCheckboxes() {
        {if $action->get_value("selectedWindows")}  // If any selected windows are saved
            {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}    // Loop through all the selected windows
                $("#FOR1740"+{$windowNr}).prop('checked', {$action->get_value(implode("", ["win$windowNr", "_FOR1740"]))}); // Change checked state of the checkbox depending on the saved state
                $("#rABC"+{$windowNr}).prop('checked', {$action->get_value(implode("", ["win$windowNr", "_rABC"]))});
            {/foreach}
        {/if}
    }

    function updateCrossIcon(coords_, windowNr) {
        let coords = JSON.parse("["+coords_+"]");   // Save coords of area in an array
        if ($("#cross"+windowNr).is(':hidden')) {   // If there is no cross on the window button
            $("#cross"+windowNr).show();    // Show cross image
            $("#cross"+windowNr).css("left", coords[0]+122.5+"px"); // Set position
            $("#cross"+windowNr).css("top", coords[1]+81+"px");
            $("#cross"+windowNr).css("display", 'block');
        }
        else {  // If there is a cross on the window button
            $("#cross"+windowNr).hide();    // Hide cross image
        }
    }

    function updateSteps(windowNr, maxSteps) {
        for(let i = 1; i <= maxSteps; i++) $('#step'+i+"-"+windowNr).hide(); // Hide all slides
        $('#step'+currentStep[windowNr]+"-"+windowNr).show();   // Show the selected slide
    }

    function stepPhotoPopUpOpen(src) {
        $("#step_photo").attr("src", "{$template_dir}/images/"+src)
        $('#step_photos_popup').dialog("open");
    }
</script>

<style>
    article {
        visibility: hidden; /* Hide everything on startup so the screen is less cluttered when loading on startup */
    }

    .window-select {
        width: 80%;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }

    .window-select-cross {
        width: 30px;
        position: absolute;
        display: none;
        pointer-events: none;
    }

    #checklist {
        width: 650px;
    }

    .ui-state-default {
        color: white;
    }

    .ui-state-default:hover {
        color: black;
    }

    .ui-state-default:focus {
        color: black;
    }
</style>

{if $value_type->is_read_only($competence_level, $view_mode)}
    {*include file="action_types/status.tpl"}
    <div style="display: table-cell;">
      <a href="javascript:display_action_details({$action->get_id()})"><span style="{$value_type->get_text_style()|escape}">{$value_type->get_text()|escape:'htmlall'}:{$value_type->get_selected_user()|escape}</span></a>
    </div>*}
    <article id="checklist">
        <div id="accordion">
            {for $windowNr=1 to 49}
                <h3 id="dropdown-window{$windowNr}">Raam {$windowNr}</h3>
                {include file="window_blocks.tpl" codeBlock="inputfield_readonly"}
            {/for}
        </div>
        <p id="dropdown-window-text"><b>Geen ramen geselecteerd.</b></p>
    </article>
{else}
    <div style="display: table-cell;">
        <input type="hidden" id="{$element_name}_changed" name="{$element_name}_changed" value="0"/>
        <input type="hidden" id="selectedWindows" name="selectedWindows" value="0"/>

        <img id="loading" src="{$template_dir}/images/ajax.gif">

        <article id="add_windows">
            <input type="button" value="Toevoegen" id="window_select_popup_open" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br>

            <div id="window_select_popup">
                <h1>Selecteer welke ramen vervangen moeten worden:</h1>

                <img src="{$template_dir}/images/window_select.png" class="window-select" usemap="#window_buttons"><br>
                <map name="window_buttons">
                    {foreach $buttonCoords as $i=>$coords}
                        <area shape="rect" coords={$coords} href="#" alt="{$i+1}">
                        <img src="{$template_dir}/images/window_select_cross.png" class="window-select-cross" id="cross{$i+1}" hidden>
                    {/foreach}
                </map><br>

                <h1>Geselecteerde ramen:</h1>
                <p id="selectedWindowsDisplay"></p>
                <input type="button" value="Reset keuze" id="reset" role="button" class="jq-button ui-button ui-corner-all ui-widget">
            </div>
        </article><br>

        <article id="checklist">
            <div id="step_photos_popup">
                <img id="step_photo">
            </div>

            <div id="accordion">
                {for $windowNr=1 to 49}
                    <h3 id="dropdown-window{$windowNr}">Raam {$windowNr}</h3>
                    <div id="dropdown-window{$windowNr}">
                        <div id="steps{$windowNr}" {if $action->get_value(implode("", ["win$windowNr", "_window_saved"]))}hidden{/if}>
                            {if $windowNr == 46 || $windowNr == 49}
                                {include file="window_blocks.tpl" codeBlock="stepsFrontWindows"}<br>
                            {else}
                                {include file="window_blocks.tpl" codeBlock="steps"}<br>
                            {/if}

                            <div style="display: flex; width: 100%; justify-content: space-between;">
                                <input type="button" id="{$windowNr}" value="&larr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px; visibility: hidden;" alt="prevStep">
                                <input type="button" id="{$windowNr}" value="&rarr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px;" alt="nextStep">
                                <input type="button" id="{$windowNr}" value="Opslaan" class="jq-button ui-button ui-corner-all ui-widget" style="display: none;" alt="finishWindow">
                            </div>
                        </div>

                        <div id="inputField{$windowNr}" {if not $action->get_value(implode("", ["win$windowNr", "_window_saved"]))}hidden{/if}>
                            {include file="window_blocks.tpl" codeBlock="inputfield"}
                        </div>
                    </div>
                {/for}
            </div>
            <p id="dropdown-window-text"><b>Geen ramen geselecteerd.</b></p>
        </article>

        <a href="javascript:display_action_details({$action->get_id()})"><span style="{$value_type->get_text_style()|escape}">{$value_type->get_text()|escape:'htmlall'}</span></a>
        <div style="display:inline;" id="{$element_name}_optional_info"></div>
        {include file='action_types/instruction_changed.tpl'}
    </div>
{/if}