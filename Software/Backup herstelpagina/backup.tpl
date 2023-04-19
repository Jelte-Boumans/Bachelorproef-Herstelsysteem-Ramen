{if $value_type->is_read_only($competence_level, $view_mode)}
    {*include file="action_types/status.tpl"}
    <div style="display: table-cell;">
      <a href="javascript:display_action_details({$action->get_id()})"><span style="{$value_type->get_text_style()|escape}">{$value_type->get_text()|escape:'htmlall'}:{$value_type->get_selected_user()|escape}</span></a>
    </div>*}
{else}
    
    <div style="display: table-cell;">
        <input type="hidden" id="{$element_name}_changed" name="{$element_name}_changed" value="0"/>

        {*HTML*}
        <input type="hidden" id="selectedWindows" name="selectedWindows" value="0"/>

        <script>
            let selectedWindows = [{$action->get_value("selectedWindows")}];

            $(document).ready(function() {
                updateDropdowns();
                updateCheckboxes();

                for(let i = 0; i < selectedWindows.length; i++) {
                    console.log($("#FOR1740"+selectedWindows[i]).val());
                }

                $("#accordion").accordion({ 
                    collapsible: true, 
                    active: 'none'
                });

                $("#dialog").dialog({
                    title: "Ramen selecteren",
                    width: "auto",
                    autoOpen: false,
                    buttons: {
                        "OK": function() {
                            updateDropdowns()
                            $(this).dialog("close");
                        }
                    }
                });

                $('#dialog_open').click(function () {
                    updateWindowsList();
                    $('#dialog').dialog("open");
                    return false;
                });

                $("area").click(function(){
                    let windowNr = $(this).attr("alt");
                    windowNr = Number(windowNr);
                    if(selectedWindows.includes(windowNr))
                        selectedWindows.splice(selectedWindows.indexOf(windowNr),1);
                    else
                        selectedWindows.push(windowNr);

                    selectedWindows.sort(function(a, b) {
                        return a - b;
                    });

                    updateWindowsList();
                    return false;
                });

                $("#reset").click(function () {
                    selectedWindows = [];
                    $("#selectedWindowsDisplay").html("<b>Geen ramen geselecteerd.</b>");
                    return false;
                });

                return false;
            });

            function updateDropdowns() {
                $('#selectedWindows').val(selectedWindows);
                if(selectedWindows.length == 0) {
                    $("#dropdown-window-text").show();
                    for(let i = 0; i < 50; i++)
                        $("#dropdown-window".concat(i)).hide();
                    return;
                }

                $("#dropdown-window-text").hide();
                let new_windowAmount = selectedWindows.length;
                for(let i = 0; i < 50; i++) {
                    if(selectedWindows.includes(i))
                        $("#dropdown-window".concat(i)).show();
                    else
                        $("#dropdown-window".concat(i)).hide();
                }
            }

            function updateWindowsList() {
                let str = "";
                if(!selectedWindows.length)
                        str = "<b>Geen ramen geselecteerd.</b>";
                else {
                    for(let i = 0; i < selectedWindows.length; i++) {
                        if(str == "")
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
        </script>

        <style>
            .window_select {
                width: 75%;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            .flex-right {
                margin-left: 10px;
                flex-direction: column;
            }

            .flex-main {
                display: flex;
                margin-left: -25px;
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

        <article id="add_windows">
            <h1>Herstelling MR08 Ramen</h1>
            <input type="button" value="Toevoegen" id="dialog_open" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br>

            <div id="dialog">
                <h1>Selecteer welke ramen vervangen moeten worden:</h1>
                <img src="{$template_dir}/images/window_select.png" class="window_select" usemap="#window_buttons"><br>

                <map name="window_buttons">
                    {foreach $buttonCoords as $i=>$coords}
                        <area shape="rect" coords={$coords} href="#" alt="{$i+1}">
                    {/foreach}
                </map><br>

                <h1>Geselecteerde ramen:</h1>
                <p id="selectedWindowsDisplay"></p>
                <input type="button" value="Reset keuze" id="reset" role="button" class="jq-button ui-button ui-corner-all ui-widget">
            </div>
        </article><br><br>

        <article id="checklist">
            <h1>Checklist</h1>
            <div id="accordion">
            {for $windowNr=1 to 49}
                <h3 id="dropdown-window{$windowNr}">Raam {$windowNr}</h3>
                <div class="flex-main" id="dropdown-window{$windowNr}">
                    <div class="dropdown-producten">
                        <h5>Producten</h5>
                        <table>
                            <tr><th>Sikaflex268 Powercure:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input type="text" size="10" name="batchnr_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268P"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input type="text" size="10" name="hdatum_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268P"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>
                    
                            <tr><th>Sikaflex268:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input type="text" size="10" name="batchnr_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input type="text" size="10" name="hdatum_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sika Activator 100:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input type="text" size="10" name="batchnr_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA100"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input type="text" size="10" name="hdatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA100"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input type="text" size="10" name="odatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA100"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sike Primer 207:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input type="text" size="10" name="batchnr_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SP207"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input type="text" size="10" name="hdatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SP207"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input type="text" size="10" name="odatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SP207"]))}"></td>
                            </tr>
                            <tr><td><br></td></tr>

                            <tr><th>Sike Afgladmiddel:</th></tr>
                            <tr>
                                <td>Batchnummer:</td>
                                <td><input type="text" size="10" name="batchnr_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA"]))}"></td>
                            </tr>
                            <tr>
                                <td>Houdbaarheidsdatum:</td>
                                <td><input type="text" size="10" name="hdatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA"]))}"></td>
                            </tr>
                            <tr>
                                <td>Openingsdatum:</td>
                                <td><input type="text" size="10" name="odatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA"]))}"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="flex-right">
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