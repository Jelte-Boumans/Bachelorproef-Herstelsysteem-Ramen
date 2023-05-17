<script>
    let selectedWindows = [{$action->get_value("selectedWindows")}];    // Recieve the selected windows from the database on startup
    let currentStep = {
        {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}    // Make an attribute for every selected window to save to current step
            {if $action->get_value("selectedWindows")}{$windowNr}: 1,{/if}
        {/foreach}
    };
    const stepAmmount = 23;
    
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

        $("#dialog").dialog({
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

        $('#dialog_open').click(function () {
            updateWindowsList();    // Update the selected window list when you open the popup, needed for displaying data from database
            $('#dialog').dialog("open");
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
            if(currentStep[windowNr] < stepAmmount) {   // If the current step for this window is not the final step
                currentStep[windowNr]++;    // Go to the next step only for this window
                $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").css("visibility", "visible"); // Make the "previous step" button visible
            }
            updateSteps(windowNr);  // Update current visible slide for this window

            if(currentStep[windowNr] == stepAmmount) {  // If the current step is the last one
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
            if(currentStep[windowNr] > 1) {   // If the current step for this window is not the first step
                currentStep[windowNr]--;// Go to the previous step only for this window
                $("input[alt=\"nextStep\"][id=\""+windowNr+"\"]").css("visibility", "visible"); // Make the "next step" button visible
                $("input[alt=\"finishWindow\"][id=\""+windowNr+"\"]").hide();   // Hide the "finish windows" button in case the user goes from the last slide back to the second to last slide
            }
            updateSteps(windowNr);  // Update current visible slide for this window

            if(currentStep[windowNr] == 1) {  // If the current step is the first one
                $(this).css("visibility", "hidden");    // Hide the "previous step" again
            }

            return false;
        });

        $("input[alt=\"finishWindow\"]").click(function () {
            const windowNr = $(this).attr("id");    // When a button is pressed, save the corresponding window number
            $("#steps"+windowNr).hide();    // Hide the steps slideshow for this window
            $("#inputField"+windowNr).fadeIn(); // Show the input field
            $("#windowSaved"+windowNr).val("true"); // Save to the database that all steps have been read
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

    function updateSteps(windowNr) {
        for(let i = 1; i <= stepAmmount; i++) $('#step'+i+"-"+windowNr).hide(); // Hide all slides
        $('#step'+currentStep[windowNr]+"-"+windowNr).show();   // Show the selected slide
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
                <div class="flex-main" style="display: flex;" id="dropdown-window{$windowNr}">
                    <div class="dropdown-producten">
                        <h5>Producten</h5>
                        <table>
                            <tr><th>Sikaflex268 Powercure:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input readonly type="text" size="10" name="batchnr_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268P"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input readonly type="text" size="10" name="hdatum_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268P"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>
                    
                            <tr><th>Sikaflex268:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input readonly type="text" size="10" name="batchnr_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input readonly type="text" size="10" name="hdatum_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sika Activator 100:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input readonly type="text" size="10" name="batchnr_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA100"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input readonly type="text" size="10" name="hdatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA100"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input readonly type="text" size="10" name="odatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA100"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sike Primer 207:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input readonly type="text" size="10" name="batchnr_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SP207"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input readonly type="text" size="10" name="hdatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SP207"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input readonly type="text" size="10" name="odatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SP207"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sike Afgladmiddel:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input readonly type="text" size="10" name="batchnr_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input readonly type="text" size="10" name="hdatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input readonly type="text" size="10" name="odatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA"]))}"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="flex-right" style="flex-direction: column; margin-left: 10px;">
                        <table>
                            <tr><th><h5>Metingen</h5></th></tr>
                            <tr>
                                <td>Temperatuur (°C):</td>
                                <td><input readonly type="text" size="10" name="temp[]" id="temp{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp"]))}"></td>
                            </tr>
                            <tr>
                                <td>Temperatuur kast (°C):</td>
                                <td><input readonly type="text" size="10" name="temp_kast[]" id="temp_kast{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp_kast"]))}"></td>
                            </tr> 
                            <tr>
                                <td>Luchtvochtigheid (%):</td>
                                <td><input readonly type="text" size="10" name="humidity[]" id="humidity{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_humidity"]))}"></td>
                            </tr>
                            <tr>
                                <td>Dauwpunt (°C):</td>
                                <td><input readonly type="text" size="10" name="dew_point[]" id="dew_point{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_dew_point"]))}"></td>
                            </tr>
                            <tr>
                                <td><input disabled type="button" value="Sensor data ophalen" onclick="dataloggerConnect({$windowNr}).catch(console.error);" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br><br></td>
                                <td><p id="serialStatus{$windowNr}"></p></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th><h5>Goedkeuring</h5></th></tr>
                            <tr>
                                <td>Controlefiche FOR1740 afgetekend</td>
                                <td><input disabled type="checkbox" id="FOR1740{$windowNr}" size="10" name="FOR1740[]" value="{$windowNr}"></td>
                            </tr>
                            <tr>
                                <td>Goedkeuring rABC</td>
                                <td><input disabled type="checkbox" id="rABC{$windowNr}" size="10" name="rABC[]" value="{$windowNr}"></td>
                            </tr>                              
                        </table>
                    </div>
                </div>
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
            <input type="button" value="Toevoegen" id="dialog_open" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br>

            <div id="dialog">
                <h1>Selecteer welke ramen vervangen moeten worden:</h1>

                <div id="container">
                    <img src="{$template_dir}/images/window_select.png" class="window-select" usemap="#window_buttons"><br>
                    <map name="window_buttons">
                        {foreach $buttonCoords as $i=>$coords}
                            <area shape="rect" coords={$coords} href="#" alt="{$i+1}">
                            <img src="{$template_dir}/images/window_select_cross.png" class="window-select-cross" id="cross{$i+1}" hidden>
                        {/foreach}
                    </map><br>
                </div>

                <h1>Geselecteerde ramen:</h1>
                <p id="selectedWindowsDisplay"></p>
                <input type="button" value="Reset keuze" id="reset" role="button" class="jq-button ui-button ui-corner-all ui-widget">
            </div>
        </article><br><br>

        <article id="checklist">
            <div id="accordion">
                {for $windowNr=1 to 49}
                    <h3 id="dropdown-window{$windowNr}">Raam {$windowNr}</h3>
                    <div id="dropdown-window{$windowNr}">
                        <div id="steps{$windowNr}" {if $action->get_value(implode("", ["win$windowNr", "_window_saved"]))}hidden{/if}>
                            <div id="step1-{$windowNr}">
                                <h2>1. Algemene voorbereiding</h2>
                                <h3>Stap 1.1</h3>
                                <b>Positioneer de afzuiging zowel in als buiten de kast.</b>
                                <p>Plaats het werkplatform voor het te vervangen glas en blokkeer de remmen op de wielen.</p>
                            </div>
                    
                            <div hidden id="step2-{$windowNr}">
                                <h2>1. Algemene voorbereiding</h2>
                                <h3>Stap 1.2</h3>
                                <p>Snij met de multitool de lijmvoeg aan de buitenzijde in 4 stappen door, let wel op dat de verf niet beschadigd wordt.</p>
                                <b>Draag snijwerende handschoenen, gehoor en gezichtsbescherming</b>
                                <p>Maak een V-vormige insnijding. -> Verwijder de los gesneden lijmvoeg. -> Maak een rechte insnijding door de volledige lijmvoeg.</p>
                                {*Controlefiche FOR1740 afgetekend: <input type="checkbox" id="_FOR1740{$windowNr}" size="10" alt="stepInput" value="{$windowNr}">*}
                            </div>
                    
                            <div hidden id="step3-{$windowNr}">
                                <h2>1. Algemene voorbereiding</h2>
                                <h3>Stap 1.3</h3>
                                <p>Verwijder het platform en ontkoppel indien nodig de laadkabel van de manipulator.</p>
                                <p>Schakel de glasmanipulator in d.m.v. de linkse knop op het bedieningshandvat.</p>
                                <p>Verrijd de manipulator d.m.v. de duimbediening.</p>
                            </div>
                    
                            <div hidden id="step4-{$windowNr}">
                                <h2>2. Demontage glas</h2>
                                <h3>Stap 2.1</h3>
                                <p>Plaats de glasmanipulator haaks op het te verwijderen glas.</p>
                                <p>Positioneer de zuignappen op de gewenste hoogte d.m.v. de afstandsbediening.</p>
                            </div>
                    
                            <div hidden id="step5-{$windowNr}">
                                <h2>2. Demontage glas</h2>
                                <h3>Stap 2.2</h3>
                                <p>Verwijder de dichting tussen glas en wandbekleding aan de binnenzijde.</p>
                                <p>Gebruik hiervoor een vlakke schroevendraaier om los te maken, verwijderen verder met de hand.</p>
                                <p>Snij de lijmvoeg tussen glas en wandbekleding door.</p>
                                <b>Draag snijwerende handschoenen, gehoor en gezichtsbescherming.</b>
                            </div>
                    
                            <div hidden id="step6-{$windowNr}">
                                <h2>2. Demontage glas</h2>
                                <h3>Stap 2.3</h3>
                                <p>Voer een lichte trekbeweging uit met de glasmanipulator door kortstondig op de knop voor de retractie van de arm te duwen.</p>
                                <b>Controleer langs de binnenzijde of het glas volledig los zit.</b>
                                <p>Plaats het glas op een glasbok en vergrendel het glas met de blokkeerstang.</p>
                            </div>
                    
                            <div hidden id="step7-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.1</h3>
                                <p>Controleer altijd de inhoud van de verlijmingskar.</p>
                                <b>Verwijder producten die niet relevant zijn voor de verlijming omwille van contaminatiegevaar van de verlijmingsproducten en oppervlakten.</b>
                            </div>
                    
                            <div hidden id="step8-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.2.1 - Voorbereiding kast</h3>
                                <p>Snij de resterende lijmlaag op de kader weg tot er nog ongeveer een 2mm kit blijft hangen, er mogen geen losse deeltjes meer aanwezig zijn.</p>
                                <p>Kuis de grond rond het raam en binnenzijde van de kast op vooraleer de verlijming te starten.</p>
                                <p>Kuis de verontreinigingen van de lijmnaad adhv de WIPE-ON en WIPE-OFF methode. Blijf deze stap herhalen totdat de doek proper blijft.</p>
                                <p>Breng met een pluisvrije doek Sika activator aan op de lijmresten van het vensterframe.</p>
                                <b>Laat deze minimum 10min uitwasemen.</b>
                            </div>
                            
                            <div hidden id="step9-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.2.2 - Voorbereiding kast</h3>
                                <p>Breng met een pad Sika Primer 207 aan op de zichtbaar beschadigde delen van het vensterframe.</p>
                                <b>Schud de primer minimum 1min op waarbij de kogel hoorbaar ratelt.</b>
                                <b>Laat deze minimum 10min uitwasemen.</b><br><br>
                                <table>
                                    <tr><th>Sike Primer 207:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input type="text" size="10" id="_batchnr_SP207{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SP207"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SP207{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SP207"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Openingsdatum:</td>
                                        <td><input type="text" size="10" id="_odatum_SP207{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SP207"]))}"></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step9-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.2.3 - Voorbereiding kast</h3>
                                <p>Plaats positioneringsrubbers op de onderkant van de raam opening.</p>
                                <p>Bepaal de dikte van de rubbertjes zodat de afstand onder en boven gelijk is.</p>
                                <p>Zorg ervoor dat de rubbers binnen het raamkader blijven.</p>
                            </div>

                            <div hidden id="step10-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.3.1 - Voorbereiding glas</h3>
                                <p>Meet de afmetingen van het nieuwe raam na.</p>
                                <p>Reinig het glasoppervlakte en de rondom liggende siliconerand eerst volledig met Sika Cleaner G+P voor men begint te werken met de primer. </p>
                                <p>Breng het product aan met een niet pluizende doek in 1 richting en wrijf met een opnieuw in 1 richting weg. (WIPE-ON en WIPE-OFF).</p>
                            </div>

                            <div hidden id="step11-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.3.2 - Voorbereiding glas</h3>
                                <p>Breng Sika activator 100 aan op het te verlijmen glasoppervlakte en rondom liggende siliconerand (kopse kant ruit) met vilt in een dunne gelijkmatige laag.</p>
                                <p>Wis direct aansluitend het glasoppervlakte af met een pluisvrije doek (wipe on – wipe off).</p>
                                <b>Laat deze minimum 10min, maximum 2uur uitwasemen.</b><br><br>
                                <table>
                                    <tr><th>Sika Activator 100:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input type="text" size="10" id="_batchnr_SA100{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA100"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SA100{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA100"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Openingsdatum:</td>
                                        <td><input type="text" size="10" id="_odatum_SA100{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA100"]))}"></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step12-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.3.3 - Voorbereiding glas</h3>
                                <p>Breng Sika primer 206 G+P aan binnenzijde van het te verlijmen raamoppervlakte met vilt (01244138) in een dunne gelijkmatige laag.</p>
                                <b>Schud de primer op gedurende minimum 1 minuut waarbij de kogel hoorbaar ratelt.</b>
                                <b>Laat deze minimum 30min, maximum 60min uitwasemen.</b>
                            </div>

                            <div hidden id="step13-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.4.1 - Verlijming</h3>
                                <p>Vraag na bij een teamleader of de voorwaarden voor temperatuur en vochtigheid voldaan zijn vooraleer te starten met verlijmen.</p>
                                <b>Indien de grenswaarden overschreden worden mag er niet verlijmd worden.</b><br><br>
                                <table>
                                    <tr>
                                        <td>Temperatuur (°C):</td>
                                        <td><input type="text" size="10" id="_temp{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_temp"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Temperatuur kast(°C):</td>
                                        <td><input type="text" size="10" id="_temp_kast{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_temp_kast"]))}"></td>
                                    </tr> 
                                    <tr>
                                        <td>Luchtvochtigheid (%):</td>
                                        <td><input type="text" size="10" id="_humidity{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_humidity"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Dauwpunt (°C):</td>
                                        <td><input type="text" size="10" id="_dew_point{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_dew_point"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td><input type="button" value="Sensor data ophalen" onclick="dataloggerRequest({$windowNr}).catch(console.error);" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br><br></td>
                                        <td><p id="_serialStatus{$windowNr}"></p></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step14-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.4.2 - Verlijming</h3>
                                <p>Neem het spuitpistool en plaats de Lijm/mastiek Sikaflex-268 powercure 0.6l erin.</p><br><br>
                                <table>
                                    <tr><th>Sikaflex268 Powercure:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input type="text" size="10" id="_batchnr_SF268P{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268P"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SF268P{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268P"]))}"></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step15-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.4.3 - Verlijming</h3>
                                <p>Spuit Sikaflex 268 powercure rondom het raamkader in de hoek van de raamzitting, maak hiervoor gebruik van de V-spuitmond.</p>
                                <b>Spuit de eerste 10 cm op een stuk karton.</b>
                                <b>Gebruik vinyl wegwerphandschoenen.</b>
                            </div>

                            <div hidden id="step16-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.5.1 - Plaatsen van het glas</h3>
                                <p>Positioneer de glasmanipulator met het nieuwe raam centraal voor het raamkader.</p>
                                <b>De positie van de ruitmarkering boven rechts, van binnenuit leesbaar in acht nemen.</b>
                                <p>Positioneer met 2 personen en de manipulator het glas in de raamopening op de positioneringsrubbers en duw het glas tegen de rubber van de binnenbekleding.</p>
                            </div>

                            <div hidden id="step17-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.5.2 - Plaatsen van het glas</h3>
                                <p>Plaats de positioneringsplaatjes (minimum 1 aan elke zijkant en 2 onder- en bovenaan).</p>
                                <p>Boor telkens met boor 4,2mm (in lijmvoeg) en zet vast met schroef.</p>
                                <p>Positioneer het glas zodat dit gelijk komt te zitten met de kast</p>
                                <b>Let op dat het glas niet te veel naar binnen getrokken wordt, dit dient gelijk te zitten met de kast.</b>
                            </div>

                            <div hidden id="step18-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.5.3 - Plaatsen van het glas</h3>
                                <p>Los de zuignappen van de ruit en verplaats de ramenmanipulator.</p>
                                <p>Verwijder de plaatjes pas na 8u. </p>
                            </div>

                            <div hidden id="step19-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.6.1 - Afkitten</h3>
                                <p>Kleef rondom het venster 1x een pand blauwe sjabloonfolie.</p>
                                <p>Breng deze gecentreerd aan over de op te kitten naad.</p>
                                <p>Snij voorzichtig de naad tussen het glas en raamkader weg.</p>
                                <b>Gebruik snijbestendige handschoenen.</b>
                            </div>

                            <div hidden id="step20-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.6.2 - Afkitten</h3>
                                <p>Spuit de voeg tussen het glas en de kast op met siliconespuit met Sikaflex 268  in een niet onderbroken lijmnaad zodat geen holle ruimtes ontstaan.</p>
                                <table>
                                    <tr><th>Sikaflex268:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input type="text" size="10" id="_batchnr_SF268{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SF268{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step21-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.6.3 - Afkitten</h3>
                                <p>Breng afgladmiddel aan op de lijmvoeg.</p><br>
                                <table>
                                    <tr><th>Sika Afgladmiddel:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input type="text" size="10" id="_batchnr_SA{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SA{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Openingsdatum:</td>
                                        <td><input type="text" size="10" id="_odatum_SA{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA"]))}"></td>
                                    </tr>
                                </table>
                            </div>

                            <div hidden id="step22-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.6.4 - Afkitten</h3>
                                <p>Strijk met een hulpstuk voor afkitten van ramen de lijmvoeg af tot een egale naad.</p>
                                <b>Let op bij het afstrijken dat men duwt en niet trekt > de afdichting mag geen visuele gebreken hebben.</b>
                                <p>Controleer de lijmvoeg op eventuele slecht op gespoten stukken. Indien dit het geval is de slechte stukken opnieuw opspuiten en de vorige 2 stappen herhalen.</p>
                            </div>

                            <div hidden id="step23-{$windowNr}">
                                <h2>3. Monteren van glas</h2>
                                <h3>Stap 3.6.5 - Afkitten</h3>
                                <p>Controleer de lijmvoeg op eventuele slecht op gespoten stukken. Indien dit het geval is de slechte stukken opnieuw opspuiten en de vorige 2 stappen herhalen.</p>
                                <p>Verwijder de plakband van het glas en de kast terwijl de lijm nog nat is. Indien er nog resten zijn overgebleven op het glas of kast moeten deze zo snel mogelijk worden verwijderd met Sika Remover 208.</p>
                                <b>Vermijdt contact met de pas verlijmde voeg.</b>
                                <p>Gooi het vuil, lege kokers, plakband, vodden in de daarvoor voorzien containers.</p>
                            </div>

                            <br>
                            <div style="display: flex; width: 100%; justify-content: space-between;">
                                <input type="button" id="{$windowNr}" value="&larr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px; visibility: hidden;" alt="prevStep">
                                <input type="button" id="{$windowNr}" value="&rarr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px;" alt="nextStep">
                                <input type="button" id="{$windowNr}" value="Opslaan" class="jq-button ui-button ui-corner-all ui-widget" style="display: none;" alt="finishWindow">
                            </div>
                        </div>

                        <div id="inputField{$windowNr}" {if not $action->get_value(implode("", ["win$windowNr", "_window_saved"]))}hidden{/if}>
                            <div class="flex-main" style="display: flex; margin-left: -25px;">
                                <div class="dropdown-producten">
                                    <h5>Producten</h5>
                                    <table>
                                        <input type="hidden" name="windowSaved[]" id="windowSaved{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_window_saved"]))}">
                                        <tr><th>Sikaflex268 Powercure:</th></tr>
                                        <tr>
                                            <td>Batchnummer:</td>
                                            <td><input type="text" size="10" name="batchnr_SF268P[]" id="batchnr_SF268P{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268P"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Houdbaarheidsdatum:</td>
                                            <td><input type="text" size="10" name="hdatum_SF268P[]" id="hdatum_SF268P{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268P"]))}"></td>
                                        </tr>
                                        <tr><td><br></td></tr>
                                
                                        <tr><th>Sikaflex268:</th></tr>
                                        <tr>
                                            <td>Batchnummer:</td>
                                            <td><input type="text" size="10" name="batchnr_SF268[]" id="batchnr_SF268{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Houdbaarheidsdatum:</td>
                                            <td><input type="text" size="10" name="hdatum_SF268[]" id="hdatum_SF268{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                                        </tr>
                                        <tr><td><br></td></tr>

                                        <tr><th>Sika Activator 100:</th></tr>
                                        <tr>
                                            <td>Batchnummer:</td>
                                            <td><input type="text" size="10" name="batchnr_SA100[]" id="batchnr_SA100{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA100"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Houdbaarheidsdatum:</td>
                                            <td><input type="text" size="10" name="hdatum_SA100[]" id="hdatum_SA100{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA100"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Openingsdatum:</td>
                                            <td><input type="text" size="10" name="odatum_SA100[]" id="odatum_SA100{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA100"]))}"></td>
                                        </tr>
                                        <tr><td><br></td></tr>

                                        <tr><th>Sike Primer 207:</th></tr>
                                        <tr>
                                            <td>Batchnummer:</td>
                                            <td><input type="text" size="10" name="batchnr_SP207[]" id="batchnr_SP207{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SP207"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Houdbaarheidsdatum:</td>
                                            <td><input type="text" size="10" name="hdatum_SP207[]" id="hdatum_SP207{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SP207"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Openingsdatum:</td>
                                            <td><input type="text" size="10" name="odatum_SP207[]" id="odatum_SP207{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SP207"]))}"></td>
                                        </tr>
                                        <tr><td><br></td></tr>

                                        <tr><th>Sike Afgladmiddel:</th></tr>
                                        <tr>
                                            <td>Batchnummer:</td>
                                            <td><input type="text" size="10" name="batchnr_SA[]" id="batchnr_SA{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Houdbaarheidsdatum:</td>
                                            <td><input type="text" size="10" name="hdatum_SA[]" id="hdatum_SA{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Openingsdatum:</td>
                                            <td><input type="text" size="10" name="odatum_SA[]" id="odatum_SA{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA"]))}"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="flex-right" style="flex-direction: column; margin-left: 10px;">
                                    <table>
                                        <tr><th><h5>Metingen</h5></th></tr>
                                        <tr>
                                            <td>Temperatuur (°C):</td>
                                            <td><input type="text" size="10" name="temp[]" id="temp{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Temperatuur kast (°C):</td>
                                            <td><input type="text" size="10" name="temp_kast[]" id="temp_kast{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp_kast"]))}"></td>
                                        </tr> 
                                        <tr>
                                            <td>Luchtvochtigheid (%):</td>
                                            <td><input type="text" size="10" name="humidity[]" id="humidity{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_humidity"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td>Dauwpunt (°C):</td>
                                            <td><input type="text" size="10" name="dew_point[]" id="dew_point{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_dew_point"]))}"></td>
                                        </tr>
                                        <tr>
                                            <td><input type="button" value="Sensor data ophalen" onclick="dataloggerRequest({$windowNr}).catch(console.error);" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br><br></td>
                                            <td><p id="serialStatus{$windowNr}"></p></td>
                                        </tr>
                                        <tr><td><br></td></tr>

                                        <tr><th><h5>Goedkeuring</h5></th></tr>
                                        <tr>
                                            <td>Controlefiche FOR1740 afgetekend</td>
                                            <td><input type="checkbox" id="FOR1740{$windowNr}" size="10" name="FOR1740[]" value="{$windowNr}"></td>
                                        </tr>
                                        <tr>
                                            <td>Goedkeuring rABC</td>
                                            <td><input type="checkbox" id="rABC{$windowNr}" size="10" name="rABC[]" value="{$windowNr}"></td>
                                        </tr>                              
                                    </table>
                                </div>
                            </div>
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