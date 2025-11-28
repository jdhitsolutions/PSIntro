#an interactive tutorial for Get-Help

Param(
    [switch]$Full,
    [switch]$Menu
)

$cmd = 'Get-Help'
$title = "$($titleStyle)Erste Schritte mit $cmd$reset"

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
    Gets the processes that are running on the local computer.

"@ -f $highLight,$reset

$P4 = @"
Die Befehls{0}syntax{1}, die Sie auch mit {2}Get-Command{1} sehen können.

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] -Id <System.Int32[]> [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] -InputObject <System.Diagnostics.Process[]> [-Module]
    [<CommonParameters>]

    Get-Process -Id <System.Int32[]> -IncludeUserName [<CommonParameters>]

    Get-Process [[-Name] <System.String[]>] -IncludeUserName [<CommonParameters>]

    Get-Process -IncludeUserName -InputObject <System.Diagnostics.Process[]> [<CommonParameters>]

"@ -f $highLight,$reset,$cmdStyle

$P5 = @"
Und eine ausführlichere {0}Beschreibung{1}.

DESCRIPTION
    The `Get-Process` cmdlet gets the processes on a local computer.
    ...

"@ -f $highLight,$reset

$P6 = @"

Die Hilfe zu den meisten Befehlen enthält in der Regel ein oder mehrere Beispiele. Wenn Sie nur die
Beispiele sehen möchten, können Sie Folgendes ausführen:

$prompt {3}help{1} {4}Get-Process{1} {5}-examples{1}

NAME
    Get-Process

SYNOPSIS
    Gets the processes that are running on the local computer.

    {2}Example 1: Get a list of all active processes on the local computer{1}

    Get-Process

    This command gets a list of all active processes running on the local computer.
    For a definition of each column, see the Notes (#notes)section.

    {2}Example 2: Get all available data about one or more processes {1}

    Get-Process winword, explorer | Format-List *

"@ -f $cmdStyle,$reset,$highLight2,$cmdStyle,$defaultTokenStyle,$paramStyle

$P7 = @"

Schließlich können Sie jederzeit die aktuellste Hilfe abrufen, indem Sie den Parameter {0}-Online{1}
verwenden. Wenn ein Online-Link vorhanden ist, wird dieser in Ihrem Standardbrowser geöffnet. Es ist
nicht erforderlich, ihn zu verwenden, aber die Mehrheit der Befehle, die Sie verwenden werden,
unterstützt diese Hilfefunktion. Der Online-Link wird unter RELATED LINKS angezeigt:

RELATED LINKS
    {2}Online Version:
    https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-process?view=powershell-7.5&WT.mc_id=ps-gethelp{1}
    Debug-Process
    Get-Process
    Start-Process
    Stop-Process
    Wait-Process

"@ -f $highLight,$reset,$highLight2

$P8 = @"

Es ist sehr wichtig, dass Sie verstehen, wie man die Hilfesyntax interpretiert.

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] -Id <System.Int32[]> [-Module] [<CommonParameters>]
    ...

Jede Kombination von Parametern wird als {0}Parametersatz{1} bezeichnet. Sie können Parameter nicht
zwischen verschiedenen Sätzen mischen. Im Moment können Sie CommonParameters ignorieren.

"@ -f $highLight,$reset

$P9 = @"
Alles, was Sie in [ ] eingeschlossen sehen, gilt als {0}optional{2}. Das bedeutet, wenn Sie den
{4}Id{2}-Parameter verwenden möchten, müssen Sie ihn angeben, da er nicht in [ ] eingeschlossen ist.

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] {1}-Id{2} <System.Int32[]> [-Module] [<CommonParameters>]
    ...

$prompt {3}Get-Process{2} {4}-Id{2} {5}`$PID{2}
"@ -f $highLight,$highLight3,$reset,$cmdStyle,$paramStyle,$varStyle

$P10 = @"

{0}`$PID{1} ist eine automatische Variable, deren Wert die Prozess-ID der aktuellen PowerShell-Sitzung ist.


"@ -f $highLight,$reset

$P10a = @"
Wenn Sie die Syntax noch einmal betrachten, können Sie den {1}Name{4}-Parameter verwenden, ohne ihn
eingeben zu müssen, da der Parametername in [ ] eingeschlossen ist.

SYNTAX
    Get-Process [{2}[{4}-Name{2}]{4} <System.String[]>] [-FileVersionInfo] [-Module]
    [<CommonParameters>]

Die Syntax zeigt Ihnen, dass der gesamte {1}Name{4}-Parameter optional ist, und wenn Sie ihn verwenden
möchten, müssen Sie den Parameternamen nicht einmal angeben. Dies wird als {0}positionsabhängiger{4}
Parameter bezeichnet.

Der Text innerhalb der {2}< >{4} gibt an, welchen {0}Typ{4} von Parameterwert Sie verwenden sollen.
System.String bedeutet Text. Wenn Sie {2}[]{4} als Teil des Typs sehen, zeigt dies an, dass der Parameter
mehrere durch Kommas getrennte Werte akzeptiert.

$prompt {3}Get-Process{4} {5}pwsh,sys*{4}
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

    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]
    Get-Process -Id <System.Int32[]> -IncludeUserName [<CommonParameters>]
    Get-Process [[-Name] <System.String[]>] -IncludeUserName [<CommonParameters>]
    Get-Process -IncludeUserName -InputObject <System.Diagnostics.Process[]> [<CommonParameters>]

Wenn Sie alle PowerShell‑Prozesse und diejenigen sehen möchten, die mit {0}sys{1} beginnen UND
den Benutzernamen anzeigen möchten, haben Sie eine Idee, welchen Befehl Sie eingeben würden?

"@ -f $highLight2,$reset

$P13 = @"
$prompt {0}Get-Process{3} {1}pwsh,sys*{3} {2}-IncludeUsername{3}
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
Clear-Host
$title
$Intro
$P1
pause
Clear-Host
$P2
pause
$P3
Pause
$P4
pause
$P5
Pause
Clear-Host
$P6
Pause
Clear-Host
$P7
Pause
Clear-Host
$P8
Pause
$P9
Get-Process -id $pid | Out-Host
pause
$P10
pause
Clear-Host
$P10a
Get-Process -name pwsh,sys* | Out-Host
pause
Clear-Host
$P11
Get-Help Get-Process -Parameter *name | Out-Host
"`e[3A"
pause
$P12
Pause
$P13
Get-Process pwsh,sys* -includeUsername | Out-Host
$P14
Pause
Clear-Host
$P15
#endregion

if ($Full) {
    &$tutorials['Get-Member'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}
