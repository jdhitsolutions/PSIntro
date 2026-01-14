#an interactive tutorial for PowerShell profiles

param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters
$title = "$($titleStyle)$($strings.profileTutorialTitle)$reset"
if ($IsCoreCLR) {
    $psh = 'pwsh'
}
else {
    $psh = 'powershell'
}

#endregion

#region content

$intro = @"

Ein häufiges PowerShell-Thema, über das Sie lesen und sprechen hören werden, ist die Verwendung eines
PowerShell-{0}Profilskripts{1}. Dies ist eine besondere Art von Skriptdatei, die zum Konfigurieren Ihrer
PowerShell-Sitzung verwendet wird.

Möchten Sie immer, dass eine bestimmte Variable oder ein neues PSDrive definiert ist, wenn Sie PowerShell
starten? Anstatt die Befehle jedes Mal manuell auszuführen, wenn Sie eine neue PowerShell-Sitzung starten,
können Sie sie in ein PowerShell-Profilskript legen und sie werden automatisch ausgeführt, wenn Sie
eine PowerShell-Sitzung starten.

Es gibt jedoch tatsächlich eine Hierarchie von PowerShell-Profilskripten, die PowerShell-Einsteiger
verwirrend finden. Und auf Windows-Plattformen gibt es ein weiteres potenzielles Hindernis, dem Sie begegnen
könnten.

"@ -f $highLight, $reset

#what is a profile script
$p1 = @"
Ein PowerShell-Profilskript ist wie jedes andere Skript. Es ist eine Textdatei mit der Dateierweiterung {5}.ps1{3}.
Der Inhalt der Skriptdatei sind die gleichen Befehle, die Sie interaktiv ausführen können.

Beispielsweise könnten Sie diese Zeile in einer PowerShell-Sitzung ausführen, um eine Variable zu definieren.

$prompt {0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

Sie könnten denselben Befehl verwenden:

{0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

und ihn in ein PowerShell-Profilskript einfügen. Da PowerShell-Profilskripte {4}automatisch{3}
ausgeführt werden, wenn Sie eine neue PowerShell-Sitzung starten, wäre diese Variable in Ihrer Sitzung definiert.

$prompt {0}`$CustomVar{3}
foo789

"@ -f $varStyle, $operatorStyle, $stringStyle, $reset, $highLight3, $highLight2

#powershell versions
$p2 = @"

Auf Windows-Plattformen ist es möglich, Windows PowerShell und PowerShell 7 nebeneinander auszuführen.
Jede Version hat {0}ihren eigenen Satz{1} von Profilskripten. Das bedeutet, dass eine Konfiguration, die für
Windows PowerShell erstellt wurde, standardmäßig {2}nicht{1} in PowerShell 7 verwendet wird.

Nicht-Windows-Plattformen können nur PowerShell 7 ausführen, daher ist dies auf diesen Systemen kein Problem.

"@ -f $highLight, $reset, $warnStyle

#hosting
$p3 = @"
Bevor wir in die technischen Details einsteigen, müssen Sie einen oft übersehenen Aspekt von PowerShell
verstehen. Wir neigen dazu, die Befehle und den Code, aus denen PowerShell besteht, als {0}Verwaltungsmotor{1}
zu betrachten. Wie ein Automotor ist er für sich genommen nutzlos. Er muss Teil einer größeren Konstruktion
sein. In der Automobilwelt würden wir den Motor in ein Auto oder einen Lkw einbauen. In PowerShell
muss der Motor in einer Anwendung {2}gehostet{1} werden.

Dies wird als {3}Hosting-Anwendung{1} oder Host bezeichnet.

Sie können die Anwendung, die Ihre PowerShell-Sitzung hostet, anzeigen, indem Sie {4}Get-Host{1} ausführen.

$prompt {4}Get-Host{1}
"@ -f $highLight2, $reset, $highLight3, $highlight, $cmdStyle

$p4 = @"
Oder Sie können die integrierte Variable {0}`$host{1} verwenden.

$prompt {0}`$host{1}

"@ -f $varStyle, $reset

#other apps like VSCode
$p5 = @"
Die meiste Zeit werden Sie im ConsoleHost verbringen. Denken Sie daran als das Standard-oder
Standarde-Erlebnis von PowerShell. Andere Anwendungen können PowerShell jedoch ebenfalls hosten.
Wenn Sie sich in einer entfernten PowerShell-Sitzung über das WSMan-Protokoll befinden, ist dies
eine weitere Hosting-Anwendung.

Zwei häufige Beispiele für andere Hosts, auf die Sie wahrscheinlich stoßen werden, sind PowerShell ISE
und das integrierte Terminal in Visual Studio Code. Sie können dies überprüfen, indem Sie {2}Get-Host{1}
ausführen oder einfach den Hostnamen anzeigen.

Das folgende Beispiel ist das, was Sie in Visual Studio Code sehen würden.

$prompt {3}`$host.name{1}
Visual Studio Code Host

Es ist wichtig, dass Sie das Konzept einer Hosting-Anwendung verstehen, da es {4}keine Garantie gibt,
dass alle PowerShell-Funktionen in allen Hosts unterstützt werden{1}.

"@ -f $italic, $reset, $cmdStyle, $varStyle, $warnStyle

#scope
$p6 = @"
Bisher haben wir uns die PowerShell-Version und den Host angesehen. Es gibt ein weiteres PowerShell-Attribut,
das Profilskripte beeinflusst, und das ist der {0}Scope{1}. Denken Sie daran als Einflussbereich.

Bei Profilskripten gibt es zwei Scopes. Es gibt einen Scope für {2}AllUsers{1} und einen für den
{3}CurrentUser{1}.

Der Scope {2}AllUsers{1} gilt für jeden PowerShell-Benutzer. Dieser Scope wird auf Systemebene angewendet,
typischerweise dort, wo sich die PowerShell-Programmdateien befinden. Sie benötigen erhöhte Rechte,
um Dinge auf dieser Ebene zu verwalten.

Der Scope {3}CurrentUser{1} sind in der Regel Sie. Dieser Scope basiert auf Ihrem Desktop-Profil, was bedeutet,
dass Sie keine besonderen Rechte benötigen.

"@ -f $highLight, $reset, $highLight2, $highLight3

#$profile

$p7 = @"
Auch wenn PowerShell-Profilskripte .ps1-Dateien sind, sind die Pfade {0}fest codiert{1} und {2}können nicht
geändert werden.{1} Wenn Sie eine PowerShell-Sitzung starten, sucht PowerShell nach den Profilskripten und
führt sie automatisch aus.

Sie können die integrierte Variable {3}`$profile{1} verwenden, um den Speicherort anzuzeigen.

$prompt {3}`$profile{1}
"@ -f $highLight3, $reset, $warnStyle, $varStyle

$p8 = @"
Sie sollten feststellen, dass der Pfad auf Ihr Benutzerprofil verweist. Es ist wichtig zu beachten,
dass diese Datei {0}standardmäßig nicht existiert{1}. Es ist auch möglich, dass einige Teile
des Pfads nicht vorhanden sind.

"@ -f $warnStyle, $reset

$p9 = @"
Die Variable {0}`$profile{1} ist etwas komplizierter, als sie scheint. Es gibt zusätzliche Eigenschaften,
die die Scopes der Profilskripte widerspiegeln.

$prompt {0}`$profile{1} {3}|{1} {2}Select-Object{1} {4}*host*{1} {3}|{1} {2}Format-List{1}
"@ -f $varStyle, $reset, $cmdStyle, $defaultTokenStyle, $stringStyle

$p10 = @"

Technisch gesehen gibt es {5}vier{0} PowerShell-Profilskripte. Sie können sie hier mit ihren fest
codierten Pfaden sehen. {6}Keines dieser Profilskripte existiert standardmäßig.{0}

Für alle gefundenen Skripte führt PowerShell sie in dieser Reihenfolge aus, beginnend mit dem
breitesten Scope und hin zum engsten. Denken Sie daran, dass der {1}Host{0} die Hosting-Anwendung ist,
wie der {2}ConsoleHost{0} oder der {3}Visual Studio Code Host{0}.

Wenn Sie mehrere Profilskripte verwenden, ist die Wirkung {4}kumulativ{0}.

"@ -f $reset, $highLight, $highLight2, $highLight3, $underLine, $italic, $warnStyle

#checking status
$p11 = @"
Das Modul {1}PSIntro{0} enthält einen Befehl, mit dem Sie leicht sehen können, ob PowerShell-Profilskripte
existieren. Orte ohne Skriptdatei sollten in Rot angezeigt werden.

$prompt {2}Get-ProfileStatus{0}

"@ -f $reset, $highLight2, $cmdStyle

#creating a profile script

$p12 = @"
Sie können jedes PowerShell-Profilskript manuell mit dem angegebenen Pfad und Dateinamen erstellen.
Auf Nicht-Windows-Computern achten Sie auf die Groß- und Kleinschreibung. Oder Sie können PowerShell
und die Variable {1}`$profile{0} verwenden. Sie können auf die verschiedenen Profilskripte als
Objekteigenschaften verweisen. Verwenden Sie den Befehl {2}New-Item{0}, um die Datei zu erstellen.

Das Beispiel verwendet den Parameter {3}-WhatIf{0}, um zu zeigen, was PowerShell getan hätte, ohne die
Datei tatsächlich zu erstellen. Verwenden Sie {3}-Force{0}, um fehlende Teile des Pfads zu erstellen.

$prompt {2}New-Item{0} {3}-path{0} {4}`$profile.CurrentUserCurrentHost{0} {3}-Force -WhatIf{0}
"@ -f $reset, $varStyle, $cmdStyle, $paramStyle, $varStyle

$p13 = @"
Sobald das Skript erstellt wurde, bearbeiten Sie es mit Ihrem bevorzugten Code-Editor. Verwenden Sie
größtenteils PowerShell-Befehle, die ohne Benutzereingriff ausgeführt werden. Die Skripte laufen
automatisch {1}unter Ihrem Benutzerkontext{0}, wenn Sie PowerShell starten, daher ist es wichtig, dass
Sie sie sicher halten. Code-Signierung liegt außerhalb des Umfangs dieses Tutorials, könnte aber etwas
sein, das Sie für Ihre Profilskripte in Betracht ziehen sollten.

Geben Sie in Ihr Profilskript Befehle ein, die für die PowerShell-Version und den Host geeignet sind.
Befehle in Ihrem Skript werden von Anfang bis Ende ausgeführt.

Sie möchten vielleicht eine Variable definieren, die Sie oft verwenden werden:

{2}`$zip = 68106{0}

Sie können ein PSDrive definieren:

{2}New-PSDrive -Name W -PSProvider FileSystem -Root c:\work{0}

Auch wenn PowerShell Module automatisch lädt, möchten Sie sie vielleicht in Ihrem Profil vorladen:

{2}Import-Module Microsoft.PowerShell.PSResourceGet{0}

Oder vielleicht möchten Sie eine benutzerdefinierte Funktion definieren:

{2}Function Get-SessionRunTime {{
    `$thisSession = Get-Process -id `$pid
    `$ts = New-TimeSpan -start `$thisSession.StartTime -end (Get-Date)
    `$ts.ToString()
}}{0}

Sie möchten vielleicht auch Befehls-Aliase hinzufügen

{2}Set-Alias -name rt -value Get-SessionRunTime{0}
{2}Set-Alias -name dt -value Get-Date{0}

"@ -f $reset, $highLight3, $stringStyle

$p14 = @"
Sie könnten versucht sein, Anmeldeinformationen in Ihr PowerShell-Profilskript einzutragen. Aber seien
 Sie vorsichtig.

{1}Legen Sie niemals Klartext-Passwörter in eine PowerShell-Skriptdatei{0}

Sie {2}könnten{0} {3}Get-Credential{0} verwenden und in Ihrem Profilskript nach Anmeldeinformationen fragen:

{4}`$admin = Get-Credential company\administrator{0}

Das funktioniert, aber Sie werden jedes Mal aufgefordert, wenn PowerShell mit Ihrem Profil startet. Es
liegt außerhalb des Umfangs dieses Tutorials, aber Sie sollten untersuchen, wie Sie das Modul
{5}Microsoft.PowerShell.SecretManagement{0} von Microsoft verwenden können.

Sie können mehr erfahren, indem Sie besuchen:

https://learn.microsoft.com/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules

"@ -f $reset, $warnStyle, $italic, $cmdStyle, $stringStyle, $highLight2

#execution policy
$p15 = @"
Auf {5}Windows{0}-Systemen gibt es ein weiteres potenzielles Hindernis für die Verwendung von
PowerShell-Profilskripten, und das ist die {3}Ausführungsrichtlinie{0}. Die Ausführungsrichtlinie
von PowerShell soll die {4}unbeabsichtigte{0} Ausführung eines PowerShell-Skripts verhindern. Eine der
Richtlinien ist {6}Restricted{0}, die PowerShell daran hindert, jede Skriptdatei auszuführen, zu der
auch PowerShell-Profilskripte gehören.

Führen Sie {2}Get-ExecutionPolicy{0} aus, um Ihre aktuelle Einstellung zu sehen.

$prompt {2}Get-ExecutionPolicy{0}
"@ -f $reset, $cmdStyle, $paramStyle, $highLight3, $highLight, $highLight2, $warnStyle

$p16 = @"
Wenn die Einstellung auf {1}Restricted{0} gesetzt ist, müssen Sie sie mit {2}Set-ExecutionPolicy{0} ändern.
Die empfohlene Mindesteinstellung ist {4}RemoteSigned{0}.

$prompt {2}Set-ExecutionPolicy{0} {3}RemoteSigned{0}

Sie müssen dies nur einmal festlegen. Beachten Sie, dass diese Einstellung in Unternehmensumgebungen
durch Gruppenrichtlinien gesteuert oder anderweitig eingeschränkt sein kann.

Lesen Sie das Hilfethema {3}about_Execution_Policies{0}, um mehr zu erfahren:

$prompt {2}help{0} {3}about_Execution_Policies{0}

"@ -f $reset, $warnStyle, $cmdStyle, $stringStyle, $highLight3, $highLight2

#pwsh -noProfile
#help about_profiles
$p17 = @"
Da Ihr PowerShell-Profilskript erhebliche Änderungen an Ihrer Sitzung vornehmen könnte oder
wenn Sie PowerShell beheben müssen, kann es Situationen geben, in denen Sie eine saubere PowerShell-Sitzung
ohne Laden Ihres Profils starten möchten. Sie können Parameter für das PowerShell-Programm verwenden,
um eine neue Sitzung ohne Profil zu starten:

$prompt {1}$psh{0} {2}-NoProfile{0}

Um andere verfügbare Parameter und Hilfe zu sehen, führen Sie aus:

$prompt {1}$psh{0} {2}-?{0}

"@ -f $reset, $cmdStyle, $paramStyle

$p18 = @"

Um noch mehr über PowerShell-Profile zu erfahren, lesen Sie die Hilfe:

$prompt {1}help{0} {2}about_Profiles{0}

"@ -f $reset, $cmdStyle, $stringStyle

#endregion

#region run

$pages = @(
    {
        Clear-Host
        $title
        $Intro
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p2
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p3
        Get-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p4
        $host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p5
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p6
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p7
        $profile.CurrentUserCurrentHost
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p8
        Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p9
        $profile | Select-Object *host* | Format-List | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p10
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p11
        Get-ProfileStatus -verbose:$false | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p12
        New-Item -Path $profile.CurrentUserCurrentHost -Force -WhatIf
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p13
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p14
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p15
        Get-ExecutionPolicy | Out-Host
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p16
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p17
        &$psh -? | Select-Object -First 12
        "`t...`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p18
        $script:pg++ ; Pause $script:pg $pgCount
    }
)
#keep a navigation page counter
$pgCount = $pages.count -1
<#
There is an overlap in functionality between $i and $pg but they are
separate counters because there may be times I need to display a "page"
of information into two pages and want to maintain a page number.
#>
for ($script:i = 0;$script:i -lt $pages.count;$script:i++) {
    Invoke-Command -ScriptBlock $pages[$script:i]
}

#endregion

#this should come after Get-Member and be the last tutorial
if ($full) {
    #this is the last lesson in the set. No action needed.
}
elseif ($menu) {
    Start-PSTutorial
}
