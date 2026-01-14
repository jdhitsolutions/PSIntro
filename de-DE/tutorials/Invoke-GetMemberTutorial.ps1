#an interactive tutorial for Get-Member

Param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters
$cmd = 'Get-Member'
$title = "$($titleStyle)Erste Schritte mit $cmd$reset"
if ($IsCoreCLR) {
    $psh = 'pwsh'
} else {
    $psh = 'powershell'
}
#endregion

#region content

$Intro = @"

Der {0}Get-Member{1}-Cmdlet ist ein Befehl, den Sie in PowerShell häufig verwenden werden. Sie werden mehr
aus PowerShell herausholen, wenn Sie wissen, wie man ihn benutzt. Der Befehl hat das Alias {4}gm{1}.

Eine der größten Herausforderungen für PowerShell-Anfänger ist zu verstehen, dass PowerShell in der Pipeline
mit {3}Objekten{1} arbeitet und nicht mit einfachem Text. Wenn Sie einen Befehl in PowerShell ausführen, gibt
er ein Objekt zurück, das zur besseren Lesbarkeit oft formatiert dargestellt wird.

$prompt {0}Get-Process{1} {2}$psh{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$highLight2

$P1 = @"
Das {0}Get-Process{1}-Cmdlet schreibt ein Objekt, das einen Prozess repräsentiert, in die PowerShell-Pipeline.
{3}Gehen Sie nicht davon aus, dass die Spaltenüberschriften die Eigenschaften eines Objekts sind{1}. Viele
PowerShell-Befehle sind so gestaltet, dass sie Informationen leicht lesbar darstellen. Höchstwahrscheinlich
gibt es mehr am Objekt, als auf dem Bildschirm angezeigt wird.

Hier kommt {0}Get-Member{1} ins Spiel. Sie können die Ausgabe eines Befehls an Get-Member pipen und
PowerShell zeigt die {4}Members{1} des Objekts an. Das sind die Merkmale, die ein Objekt beschreiben.

"@ -f $cmdStyle,$reset,$defaultTokenStyle,$warnStyle,$highlight

$P2 = @"
Native .NET-Objekte haben {0}Properties{1} und {0}Methods{1}. Eine Property beschreibt ein Merkmal
des Objekts wie Name oder ProcessID. Eine Method ist eine programmatische Aktion, die Sie mit dem Objekt
ausführen können, z. B. Kill. Machen Sie sich jetzt nicht zu viele Gedanken über Methoden. Normalerweise
finden Sie einen PowerShell-Befehl, der die Methode für Sie bereitstellt.

PowerShell erweitert ein Objekt außerdem mit zusätzlichen Mitgliedern:

  {2}AliasProperty{1}   - ein alternativer Name für eine andere Property.
  {2}NoteProperty{1}    - eine statische Notiz oder Anmerkung zum Objekt.
  {2}ScriptProperty{1}  - eine Property, deren Wert durch Ausführen von PowerShell-Code ermittelt wird.

Möglicherweise sehen Sie auch {2}PropertySet{1}, das eine Zusammenstellung von Properties darstellt.

"@ -f $highLight,$reset,$highLight2

$P3 = @"
Nun, da Sie ein Grundverständnis davon haben, wie ein Objekt beschrieben wird, führen wir
{0}Get-Member{1} aus.

$prompt {0}Get-Process{1} {2}$psh{1} | {0}Get-Member{1}

"@ -f $cmdStyle,$reset,$defaultTokenStyle

$P4 = @"
   TypeName: System.Diagnostics.Process

{3}Name    MemberType    Definition{2}
{3}----    ----------    ----------{2}
Handles AliasProperty Handles = Handlecount
Name    AliasProperty Name = ProcessName
NPM     AliasProperty NPM = NonpagedSystemMemorySize64
...

Oben in der Ausgabe von {0}Get-Member{2} sehen Sie den {1}TypeName{2}. Das ist der Objekttyp. Das
{0}Get-Process{2}-Cmdlet schreibt {1}System.Diagnostics.Process{2}-Objekte in die Pipeline.
Sie können außerdem die {4}Alias{2}-Properties erkennen. Das bedeutet, wenn Sie eine dieser Eigenschaften
verwenden möchten, können Sie den Aliasnamen, z. B. Handles, oder die Definition, z. B. HandleCount, benutzen.

"@ -f $cmdStyle,$highLight,$reset,$table,$highLight2

$P5 = @"
Wenn Sie weiter nach unten scrollen, sehen Sie die Methoden des Prozessobjekts.

Dispose                   Method     void Dispose(), void IDisposable.Dispose()
Equals                    Method     bool Equals(System.Object obj)
GetHashCode               Method     int GetHashCode()
GetLifetimeService        Method     System.Object GetLifetimeService()
GetType                   Method     type GetType()
InitializeLifetimeService Method     System.Object InitializeLifetimeService()
Kill                      Method     void Kill(), void Kill(bool entireProcessTree)
...

Der Wert in der Definition wie {0}void{1}, {0}bool{1} oder {0}int{1} gibt an, welchen Typ
von Objekt die Methode zurückgibt. Der Typ {0}void{1} bedeutet, dass die Methode keinen Wert zurückgibt.
Um die Methoden müssen Sie sich im Moment nicht kümmern.

"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle

$P6 = @"
Wichtiger für Sie sind die Properties.

HandleCount         Property   int HandleCount {{get;}}
HasExited           Property   bool HasExited {{get;}}
Id                  Property   int Id {{get;}}
MachineName         Property   string MachineName {{get;}}
MainModule          Property   System.Diagnostics.ProcessModule MainModule {{get;}}
MainWindowHandle    Property   System.IntPtr MainWindowHandle {{get;}}
MainWindowTitle     Property   string MainWindowTitle {{get;}}
MaxWorkingSet       Property   System.IntPtr MaxWorkingSet {{get;set;}}
...

Der Wert in der Definition wie {0}string{1}, {0}bool{1} oder {0}int{1} gibt den Typ des Property-Werts an.
Die Einträge {2}get{1} und {2}set{1} zeigen an, ob die Property nur lesbar ist ({2}get{1}) oder auch gesetzt
werden kann ({2}set{1}). Konzentrieren Sie sich nicht zu sehr auf get/set — PowerShell-Befehle übernehmen
meistens diese Aufgaben für Sie.

"@ -f $highLight,$reset,$highLight3

$P7 = @"
Sie werden auch {0}ScriptProperty{1}-Mitglieder sehen.

CommandLine                ScriptProperty System.Object CommandLine {{get=…}}
Company                    ScriptProperty System.Object Company {{get=`$this.Mainmodule.FileVersion…}}
CPU                        ScriptProperty System.Object CPU {{get=`$this.TotalProcessorTime.TotalSe…}}
Description                ScriptProperty System.Object Description {{get=`$this.Mainmodule.FileVer…}}

Das sind Properties, deren Werte durch Ausführen von PowerShell-Code gewonnen werden. Sie können diese
Properties genauso verwenden wie andere Properties.

Sie können {2}Get-Member{1} anweisen, nur bestimmte Mitgliedstypen anzuzeigen, mit dem Parameter
{3}MemberType{1}.

$prompt {2}Get-Process{1} {4}$psh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}ScriptProperty{1}

"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P8 = @"
Wenn Sie {0}alle{1} Property-Typen sehen möchten, pipen Sie einen Befehl so an {2}Get-Member{1}:

{2}Get-Process{1} {4}$psh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}Properties{1}

Sobald Sie die Properties identifiziert haben, die Sie verwenden möchten, können Sie sie in PowerShell einsetzen:

$prompt {2}Get-Process{1} | {2}Where-Object{1} {4}WS{1} {5}-gt{1} {6}10mb{1} |
>> {2}Sort-Object{1} WS {3}-Descending{1} | {2}Select-Object{1} {4}ID,Handles,WS,Name,StartTime{1} {3}-first{1} {6}5{1} |
>> {2}Format-Table{1}
>>

"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

$P9 = @"
PowerShell dreht sich um Objekte. {0}Get-Member{1} ist der beste Weg, um herauszufinden, wie ein Objekt
aufgebaut ist, damit Sie es mit PowerShell-Befehlen verwenden und die PowerShell-Pipeline effektiv nutzen können.

Für weitere Informationen lesen Sie die Hilfeseite zu {0}Get-Member{1} und sehen Sie sich die Beispiele an.

"@ -f $cmdStyle,$reset
$cmd = 'Get-Member'
$title = "$($titleStyle)Erste Schritte mit$cmd$reset"

#endregion

#region run the tutorial

$pages = @(
    {
        Clear-Host
        $title
        $Intro
        Get-Process $psh | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P2
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P3
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P4
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
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
        "$e[2A"
        Get-Process -Id $pid | Get-Member -MemberType ScriptProperty | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P8
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        "$e[2A"
        Get-Process | Where-Object WS -GT 10mb | Sort-Object WS -Descending |
        Select-Object ID, Handles, WS, Name, StartTime -First 5 | Format-Table | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P9
        $script:pg++ ; Pause $script:pg $pgCount
    }
)
#keep a navigation page counter
$pgCount = 12

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
  #this is the last lesson in the set. No action needed.
}
elseif ($menu) {
    Start-PSTutorial
}