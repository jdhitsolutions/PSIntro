#an interactive tutorial for Get-Command

Param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters

$cmd = 'Get-Command'

$title = "$($titleStyle)Erste Schritte mit $cmd$reset"

#endregion

#region content
$Intro = @"

{0}Get-Command{2} ist eines der grundlegenden PowerShell-Cmdlets. Sie können diesen Befehl verwenden,
um PowerShell-Befehle zu entdecken. Diese Befehle folgen der Verb-Nomen-Benennungskonvention. Das Verb
stammt aus einer Standardliste von Verben, die Sie mit dem Befehl {0}Get-Verb{2} sehen können. Das
Nomen ist die Einzahl des Objekts, mit dem Sie arbeiten möchten, wie {1}Service{1} oder {1}Prozess{2}.

"@ -f $cmdStyle, $highLight,$reset

$P1 = @"
Befehle in PowerShell können entweder {0}Cmdlets{1} oder {0}Funktionen{1} sein. {0}Cmdlets{1}
sind kompilierte Befehle, die auf .NET-Klassen basieren und für die Verwendung in PowerShell entwickelt
wurden. {0}Funktionen{1} sind ähnlich wie Cmdlets, jedoch nicht kompiliert. Funktionen werden in der
Skriptsprache von PowerShell geschrieben. Funktionen werden genauso ausgeführt wie Cmdlets. Es gibt
keinen Ausführungsunterschied, nur Unterschiede in der Art ihrer Implementierung.

"@ -f $highLight,$reset

$P2 = @"
Verwenden Sie {0}Get-Command{2}, um Befehle zu finden. Angenommen, Sie suchen nach Befehlen zur Verwaltung
von Prozessen. Sie können {0}Get-Command{2} verwenden, um verfügbare Befehle mit Platzhaltern zu
entdecken.

$prompt {0}Get-Command{2} {1}*prozess*{2}
"@ -f $cmdStyle,$defaultTokenStyle,$reset

$P3 = @"

Sie könnten auch {0}Anwendungen{1} sehen, das sind Programme, die in %PATH% gefunden werden. Sie
können Ihre Suche auf PowerShell-Befehle einschränken, indem Sie einen Befehlstyp angeben.

$prompt {2}Get-Command{1} {4}-CommandType{1} {3}Function,Cmdlet{1}
"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle,$paramStyle

$P4 = @"
In der Ausgabe sehen Sie den Befehlstyp und den Namen des PowerShell-Befehls.
"@

$P5 = @"

Beachten Sie die Verb-Nomen-Benennungskonvention. Die Quelle ist der Name des PowerShell-{0}Moduls{1},
das den Befehl enthält. Ein Modul ist ein Paket verwandter Befehle. Viele Module werden mit PowerShell
ausgeliefert. Später werden Sie lernen, wie Sie zusätzliche Module aus dem PowerShell Gallery
installieren können.

Die {0}Version{1} ist die Versionsnummer des Moduls.
"@ -f $highLight,$reset

$P5a = @"

Sobald Sie den gewünschten Befehl eingegrenzt haben, verwenden Sie {2}Get-Command{1}, um die Syntax
oder die Ausführungsweise anzuzeigen.

$prompt {2}Get-Command{1} {3}Get-Process{1} {4}-syntax{1}
"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle,$paramStyle

$P6 = @"

Die Befehlsyntax zeigt den Namen des Befehls, {2}Get-Process{1}, gefolgt von einer Reihe von
{0}Parametern{1}. Jeder Parametername wird mit einem Bindestrich angezeigt, wie {3}-Name{1} und
{3}-Id{1}. Nach jedem Parameter steht ein Hinweis, welchen Typ von Parameterwert Sie angeben müssen.

Um die Parameter besser zu verstehen, verwenden Sie {2}Get-Help{1}, um mehr zu erfahren.

"@ -f $highLight,$reset,$cmdStyle,$paramStyle
#endregion

#region run the tutorial

$pages = @(
    {
        Clear-Host
        $title
        $Intro
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P2
        (Get-Command *process* | Select-Object -First 10 | Out-Host) ; "$e[1A...`n" | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P3
        (Get-Command -CommandType Function, Cmdlet | Select-Object -First 10 | Out-Host) ; "$e[1A...`n" | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P4
        Pause $script:pg $pgCount
    },
    {
        $P5
         $script:pg++ ;Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P5a
        Get-Command Get-Process -Syntax | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P6
        $script:pg++ ; Pause $script:pg $pgCount
    }
)

#keep a navigation page counter
$pgCount = 7
<#
There is an overlap in functionality between $i and $pg but they are
separate counters because there may be times I need to display a "page"
of information into two pages and want to maintain a page number.
#>
for ($script:i = 0; $script:i -lt $pages.count; $script:i++) {
    Invoke-Command -ScriptBlock $pages[$script:i]
}
#endregion

if ($full) {
    &$tutorials['Get-Help'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}