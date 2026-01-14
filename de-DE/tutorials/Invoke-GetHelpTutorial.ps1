#an interactive tutorial for Get-Help

Param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters
$cmd = 'Get-Help'

$title = "$($titleStyle)Erste Schritte mit $cmd$reset"
#get version specific help
$gpsHelp = Get-Help -Name Get-Process
$onlineVer = $gpsHelp.relatedLinks.navigationLink[0].uri
$exampleCode = if ($gpsHelp.examples.example[0].code) {
    $gpsHelp.examples.example[0].code.insert(0, '    ')
} else {
    "$($gpsHelp.examples.example[0].introduction.Text[0].split("`n").foreach({$_.insert(0,'    ')})| Out-String)"
}
if ($IsCoreCLR) {
    $psh = 'pwsh'
    $exampleRemarks = $gpsHelp.examples.example[0].introduction.text | Select-Object -Skip 2
    $syntaxHighlight = 'Get-Process [{2}[{4}-Name{2}]{4} <System.String[]>] [-FileVersionInfo] [-Module]
    [<CommonParameters>]'
} else {
    $psh = 'powershell'
    $exampleRemarks = $gpsHelp.examples.example[0].remarks[0].text
    $syntaxHighlight = 'Get-Process [{2}[{4}-Name{2}]{4} <System.String[]>] [-ComputerName <System.String[]>] [-FileVersionInfo] [-Module]
    [<CommonParameters>]'
}
#endregion

#region content
$Intro = @"

{0}$cmd{1} ist eines der grundlegenden PowerShell‑Cmdlets, deren Verwendung Sie verstehen müssen. Sie
werden diesen Befehl ständig verwenden. Sie sollten häufig in der Hilfe nachsehen. Jede neue
Version von PowerShell kann neue Befehle, neue Parameter, neue Hilfe‑Beispiele einführen sowie
Fehler in der Dokumentation korrigieren.

Standardmäßig enthält PowerShell nur einen Teil der Hilfedokumentation. Microsoft aktualisiert
die Hilfedateien ebenfalls periodisch, obwohl es keinen Benachrichtigungsmechanismus gibt. Nach
jedem PowerShell‑Update und in regelmäßigen Abständen sollten Sie {0}Update-Help{1} ausführen.

$prompt {0}Update-Help{1}

Einige Fehler sind zu erwarten.
"@ -f $cmdStyle, $reset

$P1 = @"

Beim Erlernen von PowerShell sollten Sie nicht versuchen, sich einzuprägen, wie ein
PowerShell‑Befehl verwendet wird. Lernen Sie stattdessen, wie Sie seine Verwendung {2}entdecken{1}.
Sie können das Cmdlet {0}$cmd{1} oder die Hilfsfunktion {2}help{1} verwenden, die dieselben
Informationen wie das Cmdlet liefert, jedoch seitenweise Ausgabe bietet.

$prompt {3}help{1} {4}Get-Process{1}

"@ -f $cmdStyle,$reset,$highLight,$cmdStyle,$defaultTokenStyle

$P2 = @"

Die Ausgabeüberschriften sollten selbsterklärend sein. Sie können den Befehlsnamen {0}Name{1} sehen.

NAME
    Get-Process

"@ -f $highLight,$reset

$P3 = @"
Eine kurze {0}Kurzbeschreibung{1} oder Erklärung darüber, was der Befehl bewirkt.

SYNOPSIS
    $($gpsHelp.Synopsis)

"@ -f $highLight,$reset

$P4 = @"
Die Befehls{0}syntax{1}, die Sie auch mit {2}Get-Command{1} sehen können.

SYNTAX
    $(($gpsHelp.syntax | Out-String).TrimEnd() -replace 'Get','   Get')

"@ -f $highLight,$reset,$cmdStyle

$P5 = @"
Und eine ausführlichere {0}Beschreibung{1}.

DESCRIPTION
    $(($gpsHelp.description[0] | Out-String).Trim())
    ...

"@ -f $highLight,$reset

$P6 = @"

Die Hilfe zu den meisten Befehlen enthält in der Regel ein oder mehrere Beispiele. Wenn Sie nur die
Beispiele sehen möchten, können Sie Folgendes ausführen:

$prompt {3}help{1} {4}Get-Process{1} {5}-examples{1}

NAME
    Get-Process

SYNOPSIS
     $($gpsHelp.Synopsis)

    {2}$($gpsHelp.examples.example[0].title){1}

$(($exampleCode).TrimEnd())

    $exampleRemarks

    ....

"@ -f $cmdStyle,$reset,$highLight2,$cmdStyle,$defaultTokenStyle,$paramStyle

$P7 = @"

Schließlich können Sie jederzeit die aktuellste Hilfe abrufen, indem Sie den Parameter {0}-Online{1}
verwenden. Wenn ein Online-Link vorhanden ist, wird dieser in Ihrem Standardbrowser geöffnet. Es ist
nicht erforderlich, ihn zu verwenden, aber die Mehrheit der Befehle, die Sie verwenden werden,
unterstützt diese Hilfefunktion. Der Online-Link wird unter RELATED LINKS angezeigt:


RELATED LINKS
    {2}Online Version: $onlineVer{1}
$(($gpsHelp.relatedLinks.navigationLink[1..5]).linkText.split("`n").Foreach({$_.insert(0,'    ')})| Out-String)

"@ -f $highLight,$reset,$highLight2

$P8 = @"

Es ist sehr wichtig, dass Sie verstehen, wie man die Hilfesyntax interpretiert.

SYNTAX
    $(((Get-Command Get-Process -Syntax).split("`n") | Select-Object -Skip 1 -First 3 | Foreach-Object {"`n     $($_)"}) )

    ...

Jede Kombination von Parametern wird als {0}Parametersatz{1} bezeichnet. Sie können Parameter nicht
zwischen verschiedenen Sätzen mischen. Im Moment können Sie CommonParameters ignorieren.

"@ -f $highLight,$reset

$P9 = @"
Alles, was Sie in [ ] eingeschlossen sehen, gilt als {0}optional{2}. Das bedeutet, wenn Sie den
{4}Id{2}-Parameter verwenden möchten, müssen Sie ihn angeben, da er nicht in [ ] eingeschlossen ist.

SYNTAX
    $(($gpsHelp.syntax | Out-String).Trim())

$prompt {3}Get-Process{2} {4}-Id{2} {5}`$PID{2}
"@ -f $highLight,$highLight3,$reset,$cmdStyle,$paramStyle,$varStyle

$P10 = @"

{0}`$PID{1} ist eine automatische Variable, deren Wert die Prozess-ID der aktuellen PowerShell-Sitzung ist.


"@ -f $highLight,$reset

$P10a = @"
Wenn Sie die Syntax noch einmal betrachten, können Sie den {1}Name{4}-Parameter verwenden, ohne ihn
eingeben zu müssen, da der Parametername in [ ] eingeschlossen ist.

SYNTAX
    $syntaxHighlight

Die Syntax zeigt Ihnen, dass der gesamte {1}Name{4}-Parameter optional ist, und wenn Sie ihn verwenden
möchten, müssen Sie den Parameternamen nicht einmal angeben. Dies wird als {0}positionsabhängiger{4}
Parameter bezeichnet.

Der Text innerhalb der {2}< >{4} gibt an, welchen {0}Typ{4} von Parameterwert Sie verwenden sollen.
System.String bedeutet Text. Wenn Sie {2}[]{4} als Teil des Typs sehen, zeigt dies an, dass der Parameter
mehrere durch Kommas getrennte Werte akzeptiert.

$prompt {3}Get-Process{4} {5}$psh,sys*{4}
"@ -f $highLight,$highLight2,$highlight3,$cmdStyle,$reset,$defaultTokenStyle

$P11 = @"
Sie können jederzeit die Parameterdetails in der Hilfe anzeigen. Parameternamen können mit
Platzhaltern angegeben werden.

$prompt {0}help{3} {2}Get-Process{3} {1}-Parameter{3} {2}*name{3}
"@ -f $cmdStyle,$paramStyle,$defaultTokenStyle,$reset

$P12 = @"
Sehen Sie, wie diese Parameter als positionsabhängig oder benannt definiert sind? Die Detailangaben
zeigen auch an ob es sich um einen erforderlichen Parameter handelt. Vergleichen Sie diese Informationen
damit, wie sie in der Hilfe angezeigt werden.

$((Get-Command Get-Process -Syntax).split("`n") | where {$_ -match 'Name'} | Out-String)

Wenn Sie alle PowerShell‑Prozesse und diejenigen sehen möchten, die mit {0}sys{1} beginnen UND
den Benutzernamen anzeigen möchten, haben Sie eine Idee, welchen Befehl Sie eingeben würden?

"@ -f $highLight2,$reset

$P13 = @"
$prompt {0}Get-Process{3} {1}$psh,sys*{3} {2}-IncludeUsername{3}
"@ -f $cmdStyle,$defaultTokenStyle,$paramStyle,$reset

$P14 = @"

Je mehr Zeit Sie mit dem Lesen der Hilfe verbringen, desto einfacher wird es.

"@

$P15 = @"
Ein letztes Hilfethema, das Sie kennen sollten, sind die {0}about{4}-Themen. Dabei handelt es sich um
Hilfedateien zu PowerShell‑Konzepten und -Terminologie. Alle diese Themen beginnen mit {1}about_{4}.

Verwenden Sie den Befehl {2}help{4}, um sie anzuzeigen. Platzhalter sind erlaubt und PowerShell
vervollständigt den Themennamen per Tab.

$prompt {2}help{4} {3}about_parameters{4}

Wenn Sie das schon länger nicht getan haben, führen Sie jetzt {2}Update-Help{4} aus.

"@ -f $highLight,$highLight2,$cmdStyle,$defaultTokenStyle,$reset
#endregion

#region run the tutorial
$pages = @(
    {
        Clear-Host
        $title
        $Intro
        $P1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P2
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P3
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P4
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P5
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P6
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P7
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P8
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P9
        Get-Process -Id $pid | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P10
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P10a
        Get-Process -Name $psh, sys* | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P11
        Get-Help -Name Get-Process -Parameter *name | Out-Host
        "$e[3A"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P12
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P13
        Get-Process $psh,sys* -IncludeUserName | Out-Host
        $P14
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P15
        (Get-Help about_parameters).split("`n")[1..20] ; '...'
        $P16
        $script:pg++ ; Pause $script:pg $pgCount
    }
)
#keep a navigation page counter
$pgCount = $pages.count
<#
There is an overlap in functionality between $i and $pg but they are
separate counters because there may be times I need to display a "page"
of information into two pages and want to maintain a page number.
#>
for ($script:i = 0; $script:i -lt $pages.count; $script:i++) {
    Invoke-Command -ScriptBlock $pages[$script:i]
}

#endregion

if ($Full) {
    &$tutorials['Get-Member'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}
