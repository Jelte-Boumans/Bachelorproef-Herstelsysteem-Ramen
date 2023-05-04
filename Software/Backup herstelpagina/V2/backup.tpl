<script>
    let selectedWindows = [{$action->get_value("selectedWindows")}];    // Recieve the selected windows from the database on startup
    let currentStep = {
        {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}    // Make an attribute for every selected window to save to current step
            {if $action->get_value("selectedWindows")}{$windowNr}: 1,{/if}
        {/foreach}
    };
    const stepAmmount = 8;
    
    $(document).ready(function() {
        updateDropdowns();  // Update the dropdowns and the state of the checkboxes on startup, needed for when data is already saved in database
        updateCheckboxes();

        $("article").css("visibility", "visible");    // Show after done loading
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
            const windowNr = $(this).attr("id");
            if(currentStep[windowNr] < stepAmmount) {
                currentStep[windowNr]++;
                $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").css("visibility", "visible");
            }
            updateSteps(windowNr);

            if(currentStep[windowNr] == stepAmmount) {
                $(this).css("visibility", "hidden");
                $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").prop("disabled", true);

                setTimeout(function() {
                    $("input[alt=\"prevStep\"][id=\""+windowNr+"\"]").prop("disabled", false);
                    $("input[alt=\"finishWindow\"][id=\""+windowNr+"\"]").fadeIn();
                }, 2500);
            }

            return false;
        });

        $("input[alt=\"prevStep\"]").click(function () {
            const windowNr = $(this).attr("id");
            if(currentStep[windowNr] > 1) {
                currentStep[windowNr]--;
                $("input[alt=\"nextStep\"][id=\""+windowNr+"\"]").css("visibility", "visible");
                $("input[alt=\"finishWindow\"][id=\""+windowNr+"\"]").hide();
            }
            updateSteps(windowNr);

            if(currentStep[windowNr] == 1) {
                $(this).css("visibility", "hidden");
            }

            return false;
        });

        $("input[alt=\"finishWindow\"]").click(function () {
            const windowNr = $(this).attr("id");
            $("#steps"+windowNr).hide();
            $("#inputField"+windowNr).fadeIn();
            $("#windowSaved"+windowNr).val("true");
            return false;
        });

        $("input[alt=\"stepInput\"]").change(function() {
            const id = $(this).attr("id").replace("_","");
            if($(this).attr("type") == "checkbox") {
                const checked = $(this).prop('checked');
                $("#"+id).prop('checked', checked);
            }
            else {
                const data = $(this).val();
                $("#"+id).val(data);
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
                $("#dropdown-window".concat(i)).hide(); 
            return;
        }

        // If there is at least one window selected 
        $("#dropdown-window-text").hide();  // Hide the "no windows selected" text
        for(let i = 0; i < 50; i++) {   // Show the selected windows and hide the rest one by one
            if(selectedWindows.includes(i))
                $("#dropdown-window".concat(i)).show();
            else
                $("#dropdown-window".concat(i)).hide();
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
        {if $action->get_value("selectedWindows")}
            {foreach from=explode(",", $action->get_value("selectedWindows")) item=windowNr}
                $("#FOR1740"+{$windowNr}).prop('checked', {$action->get_value(implode("", ["win$windowNr", "_FOR1740"]))});
                $("#rABC"+{$windowNr}).prop('checked', {$action->get_value(implode("", ["win$windowNr", "_rABC"]))});
            {/foreach}
        {/if}
    }

    function updateCrossIcon(coords_, windowNr) {
        let coords = JSON.parse("["+coords_+"]");
        if ($("#cross"+windowNr).is(':hidden')) {   // Show image
            $("#cross"+windowNr).show();
            $("#cross"+windowNr).css("left", coords[0]+122.5+"px");
            $("#cross"+windowNr).css("top", coords[1]+81+"px");
            $("#cross"+windowNr).css("display", 'block');
        }
        else {  // Hide image
            $("#cross"+windowNr).hide();
        }
    }

    function updateSteps(windowNr) {
        for(let i = 1; i <= stepAmmount; i++) $('#step'+i+"-"+windowNr).hide();
        $('#step'+currentStep[windowNr]+"-"+windowNr).show();
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

        {*HTML*}
        <input type="hidden" id="selectedWindows" name="selectedWindows" value="0"/>

        <p id="loading">Even geduld A.U.B.</p>

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
                                <h3>Stap 1</h3>
                                <p>Snij lijmvoeg in 4 stappen.</p>
                                <p>Plaats glasmanipulator haaks op de raam.</p>
                                <p>Snij de lijmvoeg tussen glas en wandbekleding door.</p>
                                <p>Verwijder raam en plaats het glas op een glasbok.</p>
                                <p>Ten slotte snij weg tot er nog ongeveer een 2mm kit blijft hangen.</p>
                            </div>
                    
                            <div hidden id="step2-{$windowNr}">
                                <h3>Stap 2</h3>
                                <p>Reinig het nieuwe raam eerst volledig met Sika Cleaner.</p>
                                <p>Breng het product aan met een propere doek in 1 richting en wrijf met een nieuwe propere doek opnieuw in 1 richting weg.</p><br>
                                Controlefiche FOR1740 afgetekend: <input type="checkbox" id="_FOR1740{$windowNr}" size="10" alt="stepInput" value="{$windowNr}">
                            </div>
                    
                            <div hidden id="step3-{$windowNr}">
                                <h3>Stap 3</h3>
                                <p>Breng aan de binnenzijde van de venster met een mouse Sika Primer 207 aan op de rand van het glas.</p>
                                <p>Breng op de beschadigde delen Sika Primer 207 aan met een mouse.</p>
                                <p><b>Laat minimum 30min drogen!</b></p><br>
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
                    
                            <div hidden id="step4-{$windowNr}">
                                <h3>Stap 4</h3>
                                <p>Breng vervolgens Sika Activator 100 aan over de buitenrand van het glas.</p>
                                <b>Laat minimum 15min drogen!</b>
                                <p>Herhaal dit op de lijmrestanten van het raamkader.</p><br>
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
                    
                            <div hidden id="step5-{$windowNr}">
                                <h3>Stap 5</h3>
                                <p>Plaats de rubber terug op de binnen bekleding.</p>
                                <p>Plaats positioneringsrubbers op de onderkant van de raam opening.</p>
                                <p>Neem het spuitpistool plaats de Lijm/mastiek Sikaflex-268 0.6l erin.</p><br>
                                <table>
                                    <tr><th>Sikaflex268:</th></tr>
                                    <tr>
                                        <td>Batchnummer:</td>
                                        <td><input readonly type="text" size="10" id="_batchnr_SF268{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                                    </tr>
                                    <tr>
                                        <td>Houdbaarheidsdatum:</td>
                                        <td><input type="text" size="10" id="_hdatum_SF268{$windowNr}" alt="stepInput" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                                    </tr>
                                </table>
                            </div>
                    
                            <div hidden id="step6-{$windowNr}">
                                <h3>Stap 6</h3>
                                <p>Spuit Sikaflex 268 powercure rond het raam in de hoek van de raamzitting, maak hiervoor gebruik van de V-spuitmond.</p>
                                <p>Spuit een eerste lijmvoeg in de hoek van het vensterprofiel en een tweede lijmvoeg tegen de eerste lijmvoeg.</p><br>
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
                    
                            <div hidden id="step7-{$windowNr}">
                                <h3>Stap 7</h3>
                                <p>Positioneer met 2 personen en de manipulator het glas in de raamopening op de positioneringsrubbers en duw het glas tegen de rubber van de binnenbekleding</p>
                                <p>Plaats de positioneringsplaatjes.</p>
                                <b>Verwijder de plaatjes na 1u!</b>
                                <p>Snij voorzichtig de naad tussen het glas en raamkader weg.</p>
                                <p>Spuit de voeg tussen het glas en de kast op met siliconespuit met Sikaflex 268 in een niet onderbroken lijmnaad.</p>
                            </div>
                    
                            <div hidden id="step8-{$windowNr}">
                                <h3>Stap 8</h3>
                                <p>Breng afgladmiddel aan op de lijmvoeg</p>
                                <p>Strijk met een hulpstuk voor afkitten van ramen de lijmvoeg af tot een egale naad.</p><br>
                                <table>
                                    <tr><th>Sike Afgladmiddel:</th></tr>
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
                            </div><br>

                            <div style="display: flex; width: 100%; justify-content: space-between;">
                                <input type="button" id="{$windowNr}" value="&larr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px; visibility: hidden;" alt="prevStep">
                                <input type="button" id="{$windowNr}" value="&rarr;" class="jq-button ui-button ui-corner-all ui-widget" style="font-size: 25px;" alt="nextStep">
                                <input type="button" id="{$windowNr}" value="Opslaan" class="jq-button ui-button ui-corner-all ui-widget" style="display: none;" alt="finishWindow">
                            </div>
                        </div>

                        <div id="inputField{$windowNr}" {if not $action->get_value(implode("", ["win$windowNr", "_window_saved"]))}hidden{/if}>
                            <div class="flex-main" style="display: flex;">
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
                                            <td><input type="button" value="Sensor data ophalen" onclick="dataloggerConnect({$windowNr}).catch(console.error);" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br><br></td>
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

        {*/HTML*}

        <a href="javascript:display_action_details({$action->get_id()})"><span style="{$value_type->get_text_style()|escape}">{$value_type->get_text()|escape:'htmlall'}</span></a>
        <div style="display:inline;" id="{$element_name}_optional_info"></div>
        {include file='action_types/instruction_changed.tpl'}
    </div>
{/if}