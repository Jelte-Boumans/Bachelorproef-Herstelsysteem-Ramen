{if $codeBlock == "steps"}
    {*Controlefiche FOR1740 afgetekend: <input type="checkbox" id="_FOR1740{$windowNr}" size="10" alt="stepInput" value="{$windowNr}">*}
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
            <tr><th>Sika Primer 207:</th></tr>
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
{/if}





{if $codeBlock == "stepsFrontWindows"}
    <div id="step1-{$windowNr}">
        <h2>1. Algemene voorbereiding</h2>
        <h3>Stap 1.1</h3>
        <p>Ontgrendel en open het voorste plafondluik in de stuurpost.</p>
        <b>Draag een stootpet bij het werken in de stuurpost.</b>
        <p>Ontkoppel de connectoren van de ruitverwarming en thermostaat.</p>
    </div>

    <div hidden id="step2-{$windowNr}">
        <h2>1. Algemene voorbereiding</h2>
        <h3>Stap 1.2</h3>
        <p>Plaats een platform aan de kop van het voertuig en activeer de remmen.</p>
        <p>Maak het frontpaneel bovenaan los met een portiersleutel.</p>
        <p>Ontkoppel de stekkers van de koplichten.</p>
    </div>

    <div hidden id="step3-{$windowNr}">
        <h2>1. Algemene voorbereiding</h2>
        <h3>Stap 1.3</h3>
        <p>Neem met 2 personen het frontpaneel weg en leg deze op een veilige plaats.</p>
        <p>Demonteer de 2 handgrepen, draai hiervoor 4 bouten M10x55 los met dopsleutel 16mm bij elke handgreep.</p>
        <p>Tenslotte, demonteer de ruitenwisserarm.</p>
    </div>

    <div hidden id="step4-{$windowNr}">
        <h2>2. Demontage glas</h2>
        <h3>Stap 2.1</h3>
        <p>Plak de aangrenzende lakoppervlakken van de voorruit af met plakband.</p>
        <p>Snij de verlijming van de voorruit V-vormig uit mbv pneumatisch snijgereedschap uitgerust met recht snijblad.</p>
        <b>Draag een veiligheidsbril en snijwerende handschoenen tijdens het werken met de multitool.</b>
        <p>Verwijder de lijmvoeg.</p>
    </div>

    <div hidden id="step5-{$windowNr}">
        <h2>2. Demontage glas</h2>
        <h3>Stap 2.2</h3>
        <p>Vervang het rechte mes op het pneumatisch snijgereedschap door een gehoekt mes.</p>
        <p>Positioneer het mes vlak langs de kopruit en snijdt de verlijming door tussen voorruit en vensterframe.</p>
        <p>Demonteer het rooster aan de binnenzijde van het raam draai hiervoor 3 schroefjes los met een inbussleutel/bits 3.</p>
    </div>

    <div hidden id="step6-{$windowNr}">
        <h2>2. Demontage glas</h2>
        <h3>Stap 2.3</h3>
        <p>Neem de frontaanduider weg.</p>
        <p>Leg een beschermingshoes over de stuurtafel.</p>
        <p>Snij met het pneumatisch snijgereedschap, voorzien van een recht snijblad, rondom het glas langs binnenzijde.</p>
        <p>Reinig de voorruit langs de buitenzijde met Sika Cleaner G+P.</p>
    </div>

    <div hidden id="step7-{$windowNr}">
        <h2>2. Demontage glas</h2>
        <h3>Stap 2.4</h3>
        <p>Hang de hefband van de glasmanipulator aan de haak van de rolbrug.</p>
        <p>Til de glasmanipulator voorzichtig van het pallet.</p>
        <p>Breng de glasmanipulator aan op de te demonteren kopruit.</p>
        <b>Controleer dat de zuignappen overal vlak aansluiten op de kopruit.</b>
        <p>Verwijder de voorruit met behulp van een zuignap.</p>
        <p>Plaats de beschadigde voorruit op de daarvoor voorziene glasbok en beveilig deze tegen vallen.</p>
        <b>Bij werken met de brug mag er maar 1 persoon fysiek de last besturen bij het neerplaatsen.</b>
    </div>

    <div hidden id="step8-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.1</h3>
        <p>Controleer de inhoud van de verlijmingskar en verwijder producten die niet relevant zijn voor de verlijming omwille van contaminatiegevaar van de verlijmingsproducten en oppervlakten.</p>
    </div>

    <div hidden id="step9-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.2.1 - Voorbereiding kast</h3>
        
        <p>Verwijder met een pneumatisch snijgereedschap de achtergebleven losse lijmresten op het vensterframe. Hierbij mag een lijmlaag van 1 à 2 mm overblijven.</p>
        <p>Draag snijwerende handschoenen.</p>
        <p>Controleer het frame op beschadigingen. Grote beschadigingen aan de laklaag dienen herstelt te worden in samenspraak met de schilderswerf.</p>
    </div>

    <div hidden id="step10-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.2.2 - Voorbereiding kast</h3>
        <p>Neem de beschermingsdoek van de stuurtafel weg.</p>
        <p>Reinig de stuurtafel met een stofzuiger.</p>
        <p>Verwijder alle afgesneden lijmresten en zorg voor een propere werkplek voor het verlijmen aan te vangen.</p>
    </div>

    <div hidden id="step11-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.2.3 - Voorbereiding kast</h3>
        <p>Reinig met pluisvrije doek het vensterframe.</p>
        <p>Activeer met Sika Activator 100 en vilt de restanten van de lijmlaag van het vensterframe.</p>
        <b>Laat deze minimum 10min uitwasemen.</b><br><br>
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
        <h2>3. Montage glas</h2>
        <h3>Stap 3.2.4 - Voorbereiding kast</h3>
        <p>Breng met een pad Sika Primer 207 aan op de beschadigde delen van het vensterframe waar geen lijm meer aanwezig is.</p>
        <b>Schud de primer gedurende MINIMUM 1min op waarbij de kogel hoorbaar ratelt.</b>
        <b>Laat deze minimum 10min uitwasemen.</b><br><br>
        <table>
            <tr><th>Sika Primer 207:</th></tr>
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

    <div hidden id="step13-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.2.5 - Voorbereiding kast</h3>
        <p>Breng plakband aan op de binnenzijde van de stuurcabine waar de ruit moet worden gekleefd.</p>
    </div>

    <div hidden id="step14-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.3.1 - Voorbereiding glas</h3>
        <p>Meet de waarde van de verwarmingsweerstanden van de nieuwe kopruit na, ± 150Ω. Bij een te sterk afwijkende waarde mag deze kopruit niet geplaatst worden [135Ω - 165Ω].</p>
    </div>

    <div hidden id="step15-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.3.2 - Voorbereiding glas</h3>
        <p>Reinig de nieuwe ruit met eco degreaser indien de ruit sterk vervuild is.</p>
        <b>Doe beschermende nitril wegwerphandschoenen aan.</b>
        <p>Reinig vervolgens de te verlijmen oppervlakten van de kopruit met Sika Cleaner G+P (0,5L) en pluisvrije doek. Reinig aan de hand van de wipe-on wipe-off methode tot de doek proper blijft.</p>
        <p>Vraag na bij een teamleader of de voorwaarden voor temperatuur en vochtigheid voldaan zijn vooraleer de verlijming te starten. </p>
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

    <div hidden id="step16-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.3.3 - Voorbereiding glas</h3>
        <p>Neem de nieuwe kopruit op met de glasmanipulator en breng deze op ergonomische hoogte.</p>
        <p>Breng met een pad Sika Activator 100 aan op de te verlijmen oppervlakten van de kopruit (zwarte band op het glas & siliconeband rondom het glas) met een dunne laag.</p>
        <p>Veeg onmiddellijk aansluitend het lijmoppervlak op het glas met een droge, propere en vezelvrije doek af (wipe on, wipe off methode).</p>
    </div>

    <div hidden id="step17-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.3.4 - Voorbereiding glas</h3>
        <b>Schud de primer gedurende MINIMUM 1minuut krachtig, de kogel moet hoorbaar ratelen.</b>
        <p>Breng met een nieuwe pad Sika Primer 206 G+P aan op de te verlijmen oppervlakten van de ruit (zwarte band) in een dunne gelijkmatige laag.</p>
        <b>Laat deze ongeveer 30-60min uitwasemen.</b>
    </div>

    <div hidden id="step18-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.3.5 - Voorbereiding glas</h3>
        <p>Breng plakband aan op de buitenzijde kopruit, snij de overtollige plakband weg.</p>
        <b>Doe snijwerende handschoenen aan.</b>
    </div>

    <div hidden id="step19-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.4.1 - Verlijming</h3>
        <b>Doe beschermende nitril wegwerphandschoenen aan.</b>
        <p>Kijk de siliconepomp na op defecten. </p>
        <p>Zorg ervoor dat de accu’s opgeladen zijn.</p>
        <p>Leg de lijm cartridges klaar om de pomp te hervullen. (zowel Sika 268 als Sika 268 Powercure)</p>
        <p>Positioneer de kopruit op ergonomische werkhoogte waarbij een collega de ruit beveiligd tegen rotatie.</p>
    </div>

    <div hidden id="step20-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.4.2 - Verlijming</h3>
        <p>Neem een stuk karton waarop de eerste 10cm lijm kan gespoten worden.</p>
        <p>Spuit de blauw aangeduide delen met Sikaflex 268 op langs de binnenzijde van de kopruit in een driehoekige rups. Breedte ±20mm, hoogte ±15mm.</p>
        <input type="button" value="Foto" onclick="stepPhotoPopUpOpen('window_stap20.png')" role="button" class="jq-button ui-button ui-corner-all ui-widget">
        <p></p>
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
        <h2>3. Montage glas</h2>
        <h3>Stap 3.4.3 - Verlijming</h3>
        <p>Plaats de Sikaflex 268 powercure cartridge in het lijmpistool.</p>
        <b>Voorzie genoeg cartriges powercure zodat, indien nodig, een snelle wisseling mogelijk is.</b>
        <p>Spuit de eerste 10cm op een stuk karton.</p>
        <p>Spuit de rood aangeduide hoeken met Sikaflex 268 powercure op langs de binnenzijde van de kopruit in een driehoekige rups. Breedte ±20mm, hoogte ±15mm.</p>
        <b>Maximum 10minuten tussen verlijmen en plaatsen van de ruit.</b><br><br>
        <input type="button" value="Foto" onclick="stepPhotoPopUpOpen('window_stap21.png')" role="button" class="jq-button ui-button ui-corner-all ui-widget">
        <p></p>
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

    <div hidden id="step22-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.4.4 - Verlijming</h3>
        <p>Spuit de rood aangeduide delen met Sikaflex 268 powercure op de kast, in een driehoekige rups.</p>
        <p>Breedte ±20mm, hoogte ±15mm.</p>
        <b>Breng de lijmrups onderbroken aan met spaties van 50mm.</b>
        <b>Maximum 10minuten tussen verlijmen en plaatsen van de ruit.</b><br>
        <p></p>
        <input type="button" value="Foto" onclick="stepPhotoPopUpOpen('window_stap22.png')" role="button" class="jq-button ui-button ui-corner-all ui-widget">
    </div>

    <div hidden id="step23-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.5.1 - Plaatsen van het glas</h3>
        <p>Centreer de kopruit t.o.v. het vensterframe.</p>
        <p>Plaats de afstandshouders, 1 mm - 2 mm - 4 mm.</p>
        <b>De voegbreedte bedraagt 10mm.</b>
    </div>

    <div hidden id="step24-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.5.2 - Plaatsen van het glas</h3>
        <p>Pas de kopruit centraal op het vensterframe en druk aan tot deze vlak aansluit. De lijm zou zichtbaar uit de naad moeten treden tijdens het aanduwen.</p>
        <b>Bij werken met de brug mag er maar 1 persoon fysiek de last besturen bij het neerplaatsen.</b>
        <p>Beveilig de kopruit tegen wegglijden door houten stopblokken met behulp van de handgrepen tegen de ruit te monteren.</p>
        <b>Hou de kopruit ±1uur ondersteund door middel van de rolbrug.</b>
    </div>

    <div hidden id="step25-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.5.3 - Plaatsen van het glas</h3>
        <p>Verwijder de afstandshouders pas na 4uur.</p>
        <p>Controleer de inhoud van de verlijmingskar.</p>
        <b>Berg de gebruikte primers, activators en ongebruikte lijmtubes terug op in de brandkast.</b>
        <p>Verwijder halflege tubes Sika 268 en Sika 268 Powercure.</p>
    </div>

    <div hidden id="step26-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.1 - Afkitten</h3>
        <b>Het afkitten mag pas aanvangen 12uur na de verlijming.</b>
        <p>Controleer de inhoud van de verlijmingskar.</p>
        <b>Verwijder producten die niet relevant zijn voor het afkitten omwille van contaminatiegevaar van de verlijmingsproducten en oppervlakten.</b>    
    </div>

    <div hidden id="step27-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.2 - Afkitten</h3>
        <p>Kuis de lijmnaden uit met pluisvrije doek en Sika Activator 100 indien de verlijming meer dan 12uur geleden is.</p>
        <b>Laat 20min tot 2u uitwasemen.</b>
        <p>Spuit de voeg tussen kader en raam op met Sikaflex-268. Gebruik hiervoor de ronde spuitmond. </p>
        <b>Let op bij het afkitten dat er geen lucht ingesloten wordt.</b>
    </div>

    <div hidden id="step28-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.3 - Afkitten</h3>
        <p>Breng Seal fluid aan op de afgestreken lijmvoeg aan de buitenzijde.</p>
        <p>Strijk de uittredende lijm vlak met behulp van een afstrijkspatel met een duwende beweging.</p>
        <p>Verwijder de beschermingstape.</p>
        <p>Spuit de naad aan binnenzijde op met Sikaflex-268 in een niet onderbroken rups.</p>
        <b>Let op bij het afkitten dat er geen lucht ingesloten wordt.</b>
    </div>

    <div hidden id="step29-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.4 - Afkitten</h3>
        <p>Breng Seal fluid aan op de lijmvoeg aan de binnenzijde.</p>
        <p>Strijk de lijmvoeg vlak met behulp van een afstrijkspatel met een duwende beweging.</p>
        <p>Verwijder de plakband.</p>
        <p>Verwijder indien nodig de lijmresten en verontreinigingen met Sika remover-208.</p>
        <p>Let op bij het opkuisen dat geen remover in contact komt met de lijmnaad.</p>
    </div>

    <div hidden id="step30-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.5 - Afkitten</h3>
        <p>Open het voorste plafondpaneel in de stuurcabine.</p>
        <b>Draag een stootpet bij het werken in de stuurpost.</b>
        <p>Sluit de connectoren, van de elektrische verwarmingsvelden en thermostaat terug aan.</p>
        <p>Hermonteer de front bestemmingsaanduider.</p>
        <p>Sluit en vergrendel het voorste plafondluik in de stuurcabine.</p>
    </div>

    <div hidden id="step31-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.6 - Afkitten</h3>
        <p>Hermonteer de rooster aan de voorruit met 3 schroeven met inbusmaat 3.</p>
        <p>Hermonteer de handvaten met M10x55 bouten en bijhorende sluitringen en borgveerringen.</p>
        <b>Gebruik steeds een nieuwe borgveerring.</b>
        <p>Draai de bouten M10 op moment, 45Nm, aan met een momentsleutel 10-50 Nm met dopsleutel 16.</p>
        <p>Markeer de bouten met een blauwe markeerstift.</p>
    </div>

    <div hidden id="step32-{$windowNr}">
        <h2>3. Montage glas</h2>
        <h3>Stap 3.6.7 - Afkitten</h3>
        <p>Monteer de ruitenwisserarm en een nieuw ruitenwisserblad.</p>
        <p>Plaats met 2 personen het frontpaneel terug.</p>
        <p>Borg het frontpaneel bovenaan met een portiersleutel.</p>
        <p>Herkoppel de stekkers van de koplampen.</p>
    </div>
{/if}





{if $codeBlock == "inputfield"}
    <div class="flex-main" style="display: flex; margin-left: -25px;">
        <div class="dropdown-producten">
            <h5>Producten</h5>
            <table>
                <input type="hidden" name="window_saved[]" id="window_saved{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_window_saved"]))}">
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

                <tr><th>Sika Primer 207:</th></tr>
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

                <tr><th>Sika Afgladmiddel:</th></tr>
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
                
                <tr><th><h5>Naam</h5></th></tr>
                <tr>
                    <td>Naam van technieker:</td>
                    <td><input type="text" id="name_technician{$windowNr}" size="10" name="name_technician[]" value="{$action->get_value(implode("", ["win$windowNr", "_name_technician"]))}"></td>
                </tr>
            </table>
        </div>
    </div>
{/if}





{if $codeBlock == "inputfield_readonly"}
    <div class="flex-main" style="display: flex; margin-left: -25px" id="dropdown-window{$windowNr}">
        <div class="dropdown-producten">
            <h5>Producten</h5>
            <table>
                <tr><th>Sikaflex268 Powercure:</th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Batchnummer:</a></td>
                    <td><input readonly type="text" size="10" name="batchnr_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268P"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Houdbaarheidsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="hdatum_SF268P[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268P"]))}"></td>
                </tr>
                <tr><td><br></td></tr>
        
                <tr><th>Sikaflex268:</th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Batchnummer:</a></td>
                    <td><input readonly type="text" size="10" name="batchnr_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SF268"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Houdbaarheidsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="hdatum_SF268[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SF268"]))}"></td>
                </tr>
                <tr><td><br></td></tr>

                <tr><th>Sika Activator 100:</th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Batchnummer:</a></td>
                    <td><input readonly type="text" size="10" name="batchnr_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA100"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Houdbaarheidsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="hdatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA100"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Openingsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="odatum_SA100[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA100"]))}"></td>
                </tr>
                <tr><td><br></td></tr>

                <tr><th>Sika Primer 207:</th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Batchnummer:</a></td>
                    <td><input readonly type="text" size="10" name="batchnr_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SP207"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Houdbaarheidsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="hdatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SP207"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Openingsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="odatum_SP207[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SP207"]))}"></td>
                </tr>
                <tr><td><br></td></tr>

                <tr><th>Sika Afgladmiddel:</th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Batchnummer:</a></td>
                    <td><input readonly type="text" size="10" name="batchnr_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_batchnr_SA"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Houdbaarheidsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="hdatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_hdatum_SA"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Openingsdatum:</a></td>
                    <td><input readonly type="text" size="10" name="odatum_SA[]" value="{$action->get_value(implode("", ["win$windowNr", "_odatum_SA"]))}"></td>
                </tr>
            </table>
        </div>
        <div class="flex-right" style="flex-direction: column; margin-left: 10px;">
            <table>
                <tr><th><h5>Metingen</h5></th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Temperatuur (°C):</a></td>
                    <td><input readonly type="text" size="10" name="temp[]" id="temp{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Temperatuur kast (°C):</a></td>
                    <td><input readonly type="text" size="10" name="temp_kast[]" id="temp_kast{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_temp_kast"]))}"></td>
                </tr> 
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Luchtvochtigheid (%):</a></td>
                    <td><input readonly type="text" size="10" name="humidity[]" id="humidity{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_humidity"]))}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Dauwpunt (°C):</a></td>
                    <td><input readonly type="text" size="10" name="dew_point[]" id="dew_point{$windowNr}" value="{$action->get_value(implode("", ["win$windowNr", "_dew_point"]))}"></td>
                </tr>
                <tr>
                    <td><input disabled type="button" value="Sensor data ophalen" onclick="dataloggerConnect({$windowNr}).catch(console.error);" role="button" class="jq-button ui-button ui-corner-all ui-widget"><br><br></td>
                    <td><p id="serialStatus{$windowNr}"></p></td>
                </tr>
                <tr><td><br></td></tr>

                <tr><th><h5>Goedkeuring</h5></th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Controlefiche FOR1740 afgetekend</a></td>
                    <td><input disabled type="checkbox" id="FOR1740{$windowNr}" size="10" name="FOR1740[]" value="{$windowNr}"></td>
                </tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Goedkeuring rABC</a></td>
                    <td><input disabled type="checkbox" id="rABC{$windowNr}" size="10" name="rABC[]" value="{$windowNr}"></td>
                </tr>
                
                <tr><th><h5>Naam</h5></th></tr>
                <tr>
                    <td><a href="javascript:display_action_details({$action->get_id()})">Naam van technieker:</a></td>
                    <td><input disabled type="text" id="name_technician{$windowNr}" size="10" name="name_technician[]" value="{$action->get_value(implode("", ["win$windowNr", "_name_technician"]))}"></td>
                </tr>
            </table>
        </div>
    </div>
{/if}