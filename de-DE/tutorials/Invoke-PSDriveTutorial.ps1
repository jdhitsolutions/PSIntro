# a tutorial on PSProviders and PSDrives

param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters

if ($isWindows -or ($PSEdition -eq 'Desktop')) {
    $root = '\'
}
else {
    $root = '/'
}

$title = "$($titleStyle)Providers and PSDrives$($reset)"
if ($IsCoreCLR) {
    $psh = 'pwsh'
}
else {
    $psh = 'powershell'
}
#endregion

#region content
$intro = @'

Für PowerShell-Einsteiger ist ein grundlegendes Konzept, das anfangs mysteriös erscheinen kann, der
Begriff eines PowerShell {0}provider{1}. Ein Provider ist eine Softwarekomponente, die als Schnittstelle
zwischen einer zugrundeliegenden Technologie, wie der Windows-Registrierung oder dem Dateisystem, und
PowerShell fungiert. Er macht die zugrundeliegende Technologie über ein {0}PSDrive{1} zugänglich.

Sofern Sie nicht als .NET- oder PowerShell-Entwickler arbeiten, werden Sie selbst keinen Provider
erstellen; Sie verwenden diese jedoch ständig, oft ohne es zu bemerken.

PowerShell enthält mehrere Provider standardmäßig. Zusätzliche Provider können durch importierte
Module bereitgestellt werden. Wenn Sie beispielsweise das ActiveDirectory-Modul importieren, erhalten
Sie ein PSDrive, das als Schnittstelle zu Ihrer Active Directory-Domäne dient und Ihnen erlaubt, die
Domäne wie ein Dateisystem zu durchsuchen.

'@ -f $highLight,$reset

$p1 = @"
Der Provider ermöglicht die Verwendung desselben Cmdlets für verschiedene Technologien. Deshalb heißt
das Cmdlet {0}Get-ChildItem{1} und nicht {4}Get-File{1} oder {4}Get-RegistryKey{1}. In vielen Fällen können
Sie die zugrundeliegende Technologie über das PSDrive so durchsuchen, als wäre es ein Dateisystem.

Der Provider ermöglicht es zudem, dass dasselbe Cmdlet Elemente aus dem Dateisystem oder dem
{2}Function{1} PSDrive abrufen kann. Die Arbeit übernimmt der Provider.

"@ -f $cmdStyle,$reset,$highLight2,$highLight3,$italic

#Get-PSProvider
$p2 = @"
Um die aktuell verwendeten Provider anzuzeigen, führen Sie diesen Befehl aus:

$prompt {0}Get-PSProvider{1}
"@ -f $cmdStyle,$reset

$p3 = @"
Sie sehen unterschiedliche Provider abhängig von Ihrem Betriebssystem und den geladenen Modulen, die
Provider hinzufügen können. Wir betrachten gleich die {0}Drives{1}.

Nicht alle Provider verhalten sich gleich, daher kann ein Cmdlet zwar einen Parameter zur Unterstützung
einer Funktion haben, aber in einem PSDrive, das diese Funktion nicht unterstützt, schlägt das Cmdlet
fehl.

Die {2}ShouldProcess{1}-Fähigkeit bezieht sich auf die Unterstützung des Parameters {3}-WhatIf{1}.
Scheuen Sie sich nicht, diesen auszuprobieren. Unter Windows scheint der Provider {4}SMan{1}
{2}ShouldProcess{1} nicht zu unterstützen, doch Befehle wie dieser:

{5}Set-Item{1} {3}-path{1} {6}WSMan:\localhost\Client\AllowUnencrypted{1} {3}-Value{1} {6}'false'{1} {3}-WhatIf{1}

funktionieren tatsächlich ohne Fehler.

"@ -f $highLight3,$reset,$highLight2,$paramStyle,$highLight,$cmdStyle,$stringStyle

$p4 = @"
Die {0}Filter{1}-Fähigkeit bezieht sich auf eine spezielle Filtertechnik, die in .NET verwendet wird.
Dies wird meist über den Parameter {2}-Filter{1} in einigen Cmdlets angeboten. Das Format des
Parameterwerts hängt vom Provider und Cmdlet ab; die Hilfe sollte die Verwendung erläutern.

Wenn ein Provider {0}Filter{1} nicht unterstützt, bedeutet dies nur, dass der Parameter {2}-Filter{1}
wahrscheinlich nicht funktioniert. Viele Cmdlets bieten jedoch andere Parameter für eine
"Filter"-Funktionalität wie {2}-Name{1}, {2}-Include{1} und {2}-Exclude{1}.

Sie müssen {3}Get-PSProvider{1} nur selten ausführen, außer zur Fehlerbehebung oder aus Neugier.

"@ -f $highLight2,$reset,$paramStyle,$cmdStyle

#Get-PSDrive
$p5 = @"
{3}PSDrives{2}

Jeder Provider erstellt ein oder mehrere {0}PSDrives{2}. Jeder Laufwerksbuchstabe ist eine
Schnittstelle zur zugrundeliegenden Technologie. PowerShell legt automatisch mehrere PSDrives an,
wenn Sie eine neue Sitzung starten. Mit {1}Get-PSDrive{2} können Sie die in Ihrer aktuellen Sitzung
definierten PSDrives anzeigen.

$prompt {1}Get-PSDrive{2}
"@ -f $highlight2,$cmdStyle,$reset,$highLight3

$p6 = @"

Sie sollten automatisch ein PSDrive für jedes logische Laufwerk haben, wie es vom Betriebssystem
gesehen wird, z. B. C:\ unter Windows oder / unter Linux. Wie Sie jedoch sehen werden, sind die
hier angezeigten {0}FileSystem{1} PSDrives unabhängig vom Betriebssystem.

"@ -f $highLight,$reset

#other providers
$p7 = @"
Nicht-Dateisystem-Laufwerke sind für PowerShell-Einsteiger oft besonders interessant.

$prompt {2}Get-PSDrive{1} {3}|{1} {2}Where-Object{1} {3}{{{1}{5}`$_.Provider.Name{1} {3}-ne{1} {4}'FileSystem'{1}{3}}}{1}
"@ -f $highLight,$reset,$cmdStyle,$operatorStyle,$stringStyle,$varStyle

$p8 = @"
Sie werden je nach Betriebssystem, geladenen Modulen oder hinzugefügten Laufwerken unterschiedliche
Laufwerke sehen.

"@

$p9 = @"
Sie können auf diese Laufwerke zugreifen und sie möglicherweise wie ein Dateisystem durchsuchen.
Denken Sie daran, nach dem PSDrive-Namen den Doppelpunkt {6}:{1} zu verwenden.

$prompt {0}Get-ChildItem{1} {3}Alias:{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle,$highLight2

$p10 = @"
Viele dieser PSDrives werden von zugehörigen Cmdlets verwendet, und genau diese Cmdlets sollten
auch von Ihnen verwendet werden.

$prompt {0}Get-Alias{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

#New-PSdrive
$p11 = @"
Sie können Ihre eigenen PSDrives zu jedem vom Provider unterstützten Ort erstellen; manchmal wird
dabei auch von einem {2}PSProvider{1} gesprochen. Verwenden Sie {0}New-PSDrive{1}, um die Laufwerkszuordnung
zu erstellen. Sie sind nicht auf traditionelle Laufwerksbuchstaben beschränkt; verwenden Sie beliebige
Namen, vermeiden Sie jedoch Namen mit Leerzeichen oder nicht-alphanumerischen Zeichen.

$prompt {0}New-PSDrive{1} {3}-Name{1} {4}tmpHome{1} {3}-PSProvider{1} {4}FileSystem{1} {3}-Root{1} {5}`$home{1}
"@ -f $cmdStyle,$reset,$highLight2,$paramStyle,$stringStyle,$varStyle

$p12 = @"

Es ist wichtig zu beachten, dass das Betriebssystem Ihr PSDrive nicht sehen wird. Wenn Sie unter
Windows ein PSDrive namens {3}W{1} erstellen, das auf C:\Work verweist, werden Sie {5}nicht{1} ein
Laufwerk {3}W{1} im Windows-Explorer sehen. Die Ausnahme sind persistente PSDrives, die auf eine
UNC-Ressource verweisen. ({4}Lesen Sie die Hilfe zu {0}New-PSDrive{1}.) Ebenso ist nicht garantiert,
dass beim Hinzufügen eines neuen Laufwerks in Windows automatisch ein entsprechendes PSDrive in
Ihrer PowerShell-Sitzung erstellt wird.

Sobald es erstellt ist, können Sie diesen Ort wie jeden anderen Pfad verwenden. Denken Sie erneut an den
Doppelpunkt.

$prompt {0}Get-ChildItem{1} {2}tmpHome:{1} {7}|{1} {0}Select-Object{1} {6}-first{1} {8}3{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$italic,$warnStyle,$paramStyle,$operatorStyle,$numberStyle

#remove PSDrive
$p13 = @"
Alle von Ihnen erstellten PSDrives {4}bestehen nur für die Dauer Ihrer PowerShell-Sitzung.{1} Bei
nächstem Start von PowerShell ist das Laufwerk nicht mehr definiert. Wenn Sie PSDrives bei jedem
Start von PowerShell verfügbar haben möchten, legen Sie den Befehl {0}New-PSDrive{1} in Ihr Profilskript.

Eine Ausnahme unter Windows sind Netzlaufwerke (UNC), die als {5}persistent{1} gemappt werden.
Lesen Sie die Hilfe zu {0}New-PSDrive{1}, um mehr zu erfahren.

Wenn Sie ein PSDrive aus Ihrer Sitzung entfernen möchten, verwenden Sie {0}Remove-PSDrive{1}. Geben
Sie dabei den Laufwerksnamen {6}ohne{1} den Doppelpunkt an. Das Entfernen eines PSDrive ist wie das
Hinzufügen vollständig unabhängig vom Betriebssystem.

$prompt {0}Remove-PSDrive{1} {2}-name{1} {3}tmpHome{1}

"@ -f $cmdStyle,$reset,$paramStyle,$stringStyle,$warnStyle,$highLight2,$italic

#dynamic parameters
$p14 = @"
Es gibt noch eine weitere Eigenschaft von PSProviders und PSDrives, von der Sie profitieren sollten.
Sie wissen nun, dass Sie ein Cmdlet wie {0}Get-ChildItem{1} mit unterschiedlichen PSDrives verwenden
können. Einige Cmdlets sind mit {2}{3}dynamischen Parametern{1} ausgestattet. Dabei handelt es sich um
Parameter, die häufig provider-spezifisch sind; das heißt, der Parameter funktioniert nur mit einem
bestimmten PSProvider. Verwirrend wird es, wenn die Hilfe den Parameter anzeigt, er jedoch nur in
bestimmten Situationen funktioniert.

Hier ein Beispiel: {0}Get-ChildItem{1} verfügt über den Parameter {4}-File{1}.

$prompt {0}Get-ChildItem{1} {5}`$pshome{1} {4}-file{1} {6}|{1} {0}Select-Object{1} {4}-first{1} {7}1{1}
"@ -f $cmdStyle,$reset,$italic,$highLight2,$paramStyle,$varStyle,$operatorStyle,$numberStyle

$p15 = @"

Der Parameter {2}-File{1} ist jedoch nur verfügbar, wenn Sie einen von FileSystem unterstützten
Ort verwenden. Andernfalls erhalten Sie höchstwahrscheinlich einen Fehler.

$prompt {0}Get-ChildItem{1} {2}Function:{1} {3}-file{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$p16 = @"
Aus diesem Grund ist es sehr wichtig, sich die Zeit zu nehmen, die vollständige Hilfe und die Beispiele
für PowerShell-Befehle zu lesen.

"@

$p17 = @"
Sie können mehr über Provider im Allgemeinen erfahren, indem Sie {0}Get-Help{1} {2}about_providers{1}
ausführen. Details zu einem bestimmten Provider finden Sie im entsprechenden About-Thema.

$prompt {0}Get-Help{1} {2}about_*_provider{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle


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
        $p1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p2
        Get-PSProvider | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p3
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p4
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p5
        Get-PSDrive | Format-Table -AutoSize | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p6
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p7
        Get-PSDrive | Where-Object {$_.Provider.Name -ne 'FileSystem'} | Format-Table -AutoSize | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p8
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p9
        Get-ChildItem Alias: | Select-Object -first 5 | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p10
        Get-Alias | Select-Object -first 5 | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p11
        if (Test-Path tmpHome:) { Remove-PSDrive tmpHome}
        New-PSDrive -Name tmpHome -PSProvider FileSystem -Root $home -Scope Script | Format-Table -AutoSize | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p12
        Get-ChildItem tmpHome: | Select-Object -first 3 | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p13
        Remove-PSDrive tmpHome -Scope Script
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p14
        Get-ChildItem $pshome -file | Select-Object -first 1 | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p15
        if ($PSEdition -eq 'Desktop') {
            $errMsg = @"
Get-ChildItem : A parameter cannot be found that matches parameter name 'file'.
At line:1 char:25
+ Get-ChildItem Function: -file
+                         ~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Get-ChildItem], ParameterBindingException
    + FullyQualifiedErrorId : NamedParameterNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
"@
        Write-Host $errMsg -ForegroundColor $host.PrivateData.ErrorForegroundColor
        }
        else {
            #On non-Windows systems this causes an error that stops
            #the pipeline and breaks the script, so I'll fake the expected error
           "$($PSStyle.Formatting.Error)Get-ChildItem: A parameter cannot be found that matches parameter name 'file'.$($PSStyle.Reset)"
        }
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p16
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        #suppress Write-Progress
        $p17
        if ($IsCoreCLR) {
            Get-Help about_*_provider -ProgressAction SilentlyContinue| Out-Host
        }
        else {
            $ProgressPreference = "SilentlyContinue"
             Get-Help about_*_provider | Out-Host
        }
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

#this will come before the Profiles tutorial
if ($full) {
    &$tutorials['PowerShell Profiles'] -Full
}
elseif ($Menu) {
    Start-PSTutorial
}