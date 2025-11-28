# Ein interaktives Tutorial zu PowerShell-Grundlagen

Param(
    [switch]$Full,
    [switch]$Menu
)

if ($isWindows) {
    $root = "\"
}
else {
    $root = "/"
}

$title = "$($titleStyle)Wesentliche PowerShell-Grundlagen$($reset)"

#region Übersetzte Texte (de-DE)
$intro = @"

Um mit PowerShell zu beginnen, sollten Sie einige grundlegende Konzepte und Begriffe kennen. Sie müssen
PowerShell nicht vollständig beherrschen, bevor Sie beginnen, aber Sie sollten ein Grundverständnis
dafür haben, wie es funktioniert, damit Sie wissen, was Sie erwarten können.

"@

$P1 = @"
{0}Was ist PowerShell?{1}

PowerShell besteht aus zwei Hauptkomponenten: der {2}Shell{1} und der {2}Skriptsprache{1}. Die Shell
ist die interaktive Befehlszeilenschnittstelle, in der Sie Befehle und Skripte ausführen können. Die Skriptsprache
ist die Sprache, mit der Sie Skripte schreiben und Aufgaben automatisieren. Dieselben Befehle
und die gleiche Sprache werden in beiden verwendet. Mit anderen Worten: Wenn Sie einen Befehl in der Shell
ausführen können, können Sie ihn auch in einem Skript verwenden.

PowerShell basiert auf dem .NET-Framework und verwendet einen {3}objektorientierten{1} Ansatz. Alles, womit Sie in PowerShell arbeiten,
sind Objekte, nicht Text. Sie {4}müssen{1} jedoch kein .NET-Entwickler sein, um PowerShell zu verwenden.

"@ -f $highLight3,$reset,$highLight,$highLight2,$PSStyle.Underline

$P2 = @"
PowerShell-Befehle werden {3}Cmdlets{1} genannt. Ein Cmdlet ist ein leichter Befehl, der verwendet wird, um
eine bestimmte Aufgabe auszuführen. PowerShell-Befehle folgen einer Verb-Substantiv-Benennungskonvention, die
es einfach macht, sie zu finden und zu verwenden. Es sollte klar sein, was der Befehl {0}Get-Process{1} macht.

$prompt {0}Get-Process{1} {2}pwsh{1}
"@ -f $cmdStyle, $reset,$defaultTokenStyle,$highLight

$P3 = @"
Die Ausgabe eines PowerShell-Befehls ist technisch gesehen ein Objekt, wird jedoch so formatiert, dass sie
leichter lesbar ist.

"@

$P4 = @"

{0}Aliases{1}

PowerShell hat das Konzept von Aliasen. Ein Alias ist ein kurzer Name für ein Cmdlet. Sie sollen
Ihnen beim Tippen Zeit sparen oder den Umstieg für Benutzer anderer Shells erleichtern.

$prompt {2}dir{1} {3}$root{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle

$P5 = @"

Sie führen jedoch nicht den nativen {3}dir{1}-Befehl aus. Sie verwenden einen Alias für den
nativen PowerShell-Befehl {0}Get-ChildItem.{1} Die Ausführung dieses Befehls ist gleichwertig mit der Verwendung des Alias.

$prompt {0}Get-ChildItem{1} {2}$root{1}

"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight

$P6 = @"

Das bedeutet, dass Sie beim Alias die Parameter des PowerShell-Befehls verwenden müssen.

$prompt {0}dir{1} {2}`$home{1} {3}-Directory -Hidden{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$P7 = @"
Sie können das Cmdlet {0}Get-Alias{1} verwenden, um in PowerShell definierte Aliase zu entdecken.

"@ -f $cmdStyle,$reset,$highLight

$P8 = @"
{0}Die Pipeline{1}

Das PowerShell-Paradigma basiert auf dem Konzept von Objekten, die durch eine {6}Pipeline{1} geleitet werden. Die
Pipeline wird durch das |-Symbol angezeigt.

Stellen Sie sich die Pipeline wie ein Förderband vor, auf dem Objekte von einem Befehl zum nächsten weitergegeben werden. Jeder
Befehl in der Pipeline führt eine bestimmte Aufgabe an dem Objekt aus und gibt es dann an den folgenden
Befehl weiter. Auf diese Weise können Sie aus einfachen Befehlen komplexe Befehle und Skripte bauen.

$prompt {2}Get-Process{1} | {2}Sort-Object{1} {3}WorkingSet{1} {4}-Descending{1} | {2}Select-Object{1} {4}-first {5}5{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle,$paramStyle,$numberStyle,$highlight

$P9 =@"
Der erste Befehl holt alle Prozesse auf dem lokalen Computer. Die Ausgabe dieses Befehls
ist eine Sammlung von Prozessobjekten. Der zweite Befehl sortiert die Sammlung von Prozess-
objekten nach der Eigenschaft WorkingSet in absteigender Reihenfolge.

Sie werden lernen, wie Sie Objekt-Eigenschaften mit {0}Get-Member{1} entdecken.

Die sortierten Prozessobjekte werden dann an den dritten Befehl, {0}Select-Object{1}, übergeben, der
die ersten fünf Objekte auswählt. PowerShell zeigt die Ausgabe des letzten Befehls in der Pipeline an.

Wenn Sie diese Aufgabe häufig ausführen möchten, können Sie die Befehle in eine Skriptdatei legen. Die
Ausgabe ist dieselbe, als hätten Sie die Befehle interaktiv in der Shell ausgeführt, ohne sie erneut eingeben zu müssen.

"@ -f $cmdStyle,$reset

$P10 = @"
{0}Variablen{1}

Wie viele Skript- und Shellsprachen kennt PowerShell Variablen. Eine Variable hält
einen Wert, wie zum Beispiel einen Textstring oder eine Zahl. Verwenden Sie das {2}`${1}-Zeichen, um eine Variable zu definieren.

$prompt {3}`$i{1} = {4}123{1}
$prompt {3}`$n{1} = {5}"pw*"{1}

"@ -f $highLight3, $reset,$highLight,$varStyle,$numberStyle,$stringStyle

$P11 = @"
Sie können auch die Ausgabe eines PowerShell-Befehls oder Ausdrucks in einer Variable speichern.

$prompt {3}`$files{1} {2}={1} {0}Get-ChildItem{1} {3}-Path{1} {4}`$HOME{1} {3}-file{1} | {0}Sort-Object{1} {3}-Property{1} {6}LastWriteTime{1} | {0}Select-Object{1} {3}-first{1} {5}5{1}

"@ -f $cmdStyle,$reset,$operatorStyle,$paramStyle,$varStyle,$numberStyle,$defaultTokenStyle

$P12 = @"
Wenn Sie eine Variable verwenden möchten, referenzieren Sie sie mit dem `$-Zeichen vor dem Namen.

$prompt {0}`$i{2}*{1}2{2}
"@ -f $varStyle,$numberStyle,$reset

$P13 = @"
$prompt {0}Get-Process{1} {2}`$n{1}
"@ -f $cmdStyle,$reset,$varStyle

$P14 = @"

Sie können die Variable auch in einem pipelining Ausdruck verwenden.

$prompt {0}`$files{1} | {2}Group-Object{1} {3}-property{1} {4}Extension{1} | {2}Sort-Object{0} {4}Count{1} {3}-Descending{1}
"@ -f $varStyle,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P15 = @"
Beachten Sie, dass sich Objekte in der Pipeline basierend auf dem auszuführenden Befehl ändern können. Die {2}`$files{1}-Variable enthält
Dateiobjekte. Der Befehl {0}Group-Object{1} erstellt einen neuen Objekttyp mit anderen Eigenschaften. Diese
Objekte werden dann an den Befehl {0}Sort-Object{1} weitergereicht.

Können Sie erraten, welchen Befehl Sie ausführen würden, um alle PowerShell-Variablen zu erhalten?

"@ -f $cmdStyle,$reset,$highLight

$P16 = @"
$Prompt {0}Get-Variable{1}
"@ -f $cmdStyle,$reset

$P17 = @"
PowerShell verfügt über viele eingebaute Variablen, die Sie verwenden können.

$prompt {0}`$PSEdition{1}
"@ -f $varStyle,$reset

$P17a = @"
$prompt {0}`$PSVersionTable{1}
"@ -f $varStyle,$reset

$P18 = @"

Sobald Sie die anderen Tutorials abgeschlossen haben, sollten Sie in der Lage sein, PowerShell-Befehle
über die Konsole auszuführen.

"@
#endregion

#region Run the tutorial
Clear-Host

$title
$Intro
pause
$P1
pause
$P2
Get-Process pwsh | Out-Host
pause
$P3
pause
Clear-Host
$P4
Pause
#I am fudging the display
"`e[2A"
(dir $root | Select-Object -first 10 ) && "...`n" | Out-Host
pause
Clear-Host
$P5
"`e[2A"
(Get-ChildItem $root | Select-Object -first 10 | Out-Host) && "`e[1A...`n" #| Out-Default
Pause
Clear-Host
$P6
dir $home -Directory -Hidden | Select-Object -first 5  && "...`n"  | Out-Host
pause
$P7
pause
Clear-Host
$P8
pause
"`e[2A"
Get-Process| Sort-Object WorkingSet -Descending | Select-Object -first 5 | Out-Host
Pause
$P9
pause
Clear-Host
$P10
pause
$i = 123
$n = "pw*"
$P11
pause
$files =  Get-ChildItem -Path $HOME -file | Sort-Object -Property LastWriteTime | Select-Object -first 5
$P12
$i*2 | Out-Host
$P13
Get-Process $n | Out-Host
Pause
Clear-Host
$P14
$files | Group-Object -property Extension | Sort-Object Count -Descending | Out-Host
Pause
$P15
pause
$P16
(Get-Variable | Select-Object -first 10 | Out-Host) && "`e[1A...`n"
Pause
Clear-Host
$P17
$PSEdition | Out-Host
$P17a
$PSVersionTable | Out-Host
$P18
pause

#endregion

if ($full) {
    &$tutorials['Get-Command'] -Full
}
elseif ($Menu) {
    Start-PSTutorial
}