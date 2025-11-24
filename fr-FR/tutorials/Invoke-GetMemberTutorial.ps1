#an interactive tutorial for Get-Member

Param(
  [switch]$Full,
  [switch]$Menu
)

$cmd = 'Get-Member'
$title = "$($titleStyle)Démarrer avec $cmd$reset"

#region content
$Intro = @"

Le cmdlet {0}$cmd{1} est l'un que vous utiliserez souvent dans PowerShell. Vous profiterez davantage de
PowerShell si vous comprenez comment l'utiliser. La commande a un alias {4}gm{1}.

L'un des plus grands défis pour les débutants en PowerShell est de comprendre que PowerShell fonctionne
avec des {3}objets{1} dans un pipeline et non du texte. Lorsque vous exécutez une commande dans PowerShell,
elle renvoie un objet, généralement formaté pour faciliter la lecture.

$prompt {0}Get-Process{1} {2}pwsh{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$highLight2

$P1 = @"
Le cmdlet {0}Get-Process{1} écrit un objet qui représente un processus dans le pipeline PowerShell.
{3}Ne supposez pas que les en-têtes de colonne sont les propriétés d'un objet{1}. De nombreuses
commandes PowerShell sont conçues pour fournir des informations dans un format facile à lire. Il y a
probablement plus dans l'objet que ce que vous voyez à l'écran.

C'est là qu'intervient {0}Get-Member{1}. Vous pouvez rediriger la sortie d'une commande vers Get-Member et
PowerShell affichera les {4}membres{1} de l'objet. Ce sont les caractéristiques qui décrivent un
objet.

"@ -f $cmdStyle,$reset,$defaultTokenStyle,$warnStyle,$highlight

$P2 = @"
Les objets .NET natifs auront des {0}propriétés{1} et des {0}méthodes{1}. Une propriété est une caractéristique qui
décrit l'objet comme le nom (Name) et l'ID du processus (ProcessID). Une méthode est une action programmatique
que vous pouvez effectuer en utilisant l'objet comme Kill. Ne vous inquiétez pas des méthodes maintenant.
Généralement, vous devriez pouvoir trouver une commande PowerShell qui implémente la méthode pour vous.

PowerShell étendra également un objet avec des membres supplémentaires:

  {2}AliasProperty{1} - un nom alternatif pour une autre propriété.
  {2}NoteProperty{1} - une note ou un commentaire statique sur l'objet.
  {2}ScriptProperty{1} - une propriété dont la valeur est dérivée de l'exécution du code PowerShell.

Vous pourriez également voir {2}PropertySet{1} qui est une collection de propriétés.

"@ -f $highLight,$reset,$highLight2

$P3 = @"
Maintenant que vous avez une compréhension de base de la façon dont un objet sera décrit, exécutons
{0}Get-Member{1}.

$prompt {0}Get-Process{1} {2}pwsh{1} | {0}Get-Member{1}

"@ -f $cmdStyle,$reset,$defaultTokenStyle

$P4 = @"
   TypeName: System.Diagnostics.Process

{3}Name    MemberType    Definition{2}
{3}----    ----------    ----------{2}
Handles AliasProperty Handles = Handlecount
Name    AliasProperty Name = ProcessName
NPM     AliasProperty NPM = NonpagedSystemMemorySize64
...

En haut de la sortie de {0}Get-Member{2}, vous verrez le {1}TypeName{2}. C'est le type d'objet.
Le cmdlet {0}Get-Process{2} écrit des objets {1}System.Diagnostics.Process{2} dans le pipeline.
Vous pouvez également voir les propriétés {4}Alias{2}. Cela signifie que lorsque vous devez référencer l'une de
ces propriétés, vous pouvez utiliser le nom d'alias, c'est-à-dire Handles, ou la définition, c'est-à-dire HandleCount.

"@ -f $cmdStyle,$highLight,$reset,$table,$highLight2

$P5 = @"
En faisant défiler vers le bas, vous verrez les méthodes de l'objet processus.

Dispose                   Method     void Dispose(), void IDisposable.Dispose()
Equals                    Method     bool Equals(System.Object obj)
GetHashCode               Method     int GetHashCode()
GetLifetimeService        Method     System.Object GetLifetimeService()
GetType                   Method     type GetType()
InitializeLifetimeService Method     System.Object InitializeLifetimeService()
Kill                      Method     void Kill(), void Kill(bool entireProcessTree)
...

La valeur dans la définition telle que {0}void{1}, {0}bool{1} et {0}int{1} indique quel type d'objet
la méthode renverra. Le type {0}void{1} signifie que la méthode ne renvoie pas de valeur. Vous
ne devriez pas avoir à vous soucier des méthodes d'un objet maintenant.

"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle

$P6 = @"
Ce qui vous importera, ce sont les propriétés.

HandleCount         Property   int HandleCount {{get;}}
HasExited           Property   bool HasExited {{get;}}
Id                  Property   int Id {{get;}}
MachineName         Property   string MachineName {{get;}}
MainModule          Property   System.Diagnostics.ProcessModule MainModule {{get;}}
MainWindowHandle    Property   System.IntPtr MainWindowHandle {{get;}}
MainWindowTitle     Property   string MainWindowTitle {{get;}}
MaxWorkingSet       Property   System.IntPtr MaxWorkingSet {{get;set;}}
...

La valeur dans la définition comme {0}string{1}, {0}bool{1} et {0}int{1} indique le type de la valeur
de propriété. Les valeurs {2}get{1} et {2}set{1} indiquent si la propriété est en lecture seule, c'est-à-dire {2}get{1},
ou si elle peut être modifiée, c'est-à-dire {2}set{1}. Ne vous concentrez pas sur l'obtention et la définition
des propriétés. Les commandes PowerShell s'occuperont de ces tâches pour vous.

"@ -f $highLight,$reset,$highLight3

$P7 = @"
Vous verrez également des membres {0}ScriptProperty{1}.

CommandLine                ScriptProperty System.Object CommandLine {{get=…
Company                    ScriptProperty System.Object Company {{get=`$this.Mainmodule.FileVersion…
CPU                        ScriptProperty System.Object CPU {{get=`$this.TotalProcessorTime.TotalSe…
Description                ScriptProperty System.Object Description {{get=`$this.Mainmodule.FileVer…

Ce sont des propriétés dérivées de l'exécution du code PowerShell. Vous pouvez utiliser ces propriétés
de la même manière que les autres propriétés.

Vous pouvez demander à {2}Get-Member{1} d'afficher des types de membres sélectionnés en utilisant le paramètre {3}MemberType{1}.

$prompt {2}Get-Process{1} {4}pwsh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}ScriptProperty{1}

"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P8 = @"

Si vous voulez voir {0}toutes{1} les types de propriétés, dirigez la commande vers {2}Get-Member{1} comme ceci:

{2}Get-Process{1} {4}pwsh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}Properties{1}

Une fois que vous avez identifié les propriétés que vous souhaitez utiliser, vous pouvez les utiliser dans PowerShell:

$prompt {2}Get-Process{1} | {2}Where-Object{1} {4}WS{1} {5}-gt{1} {6}10mb{1} |
>> {2}Sort-Object{1} WS {3}-Descending{1} | {2}Select-Object{1} {4}ID,Handles,WS,Name,StartTime{1} {3}-first{1} {6}5{1} |
>> {2}Format-Table{1}
>>

"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

$P9 = @"
PowerShell concerne tout les objets. {0}Get-Member{1} est le meilleur moyen de découvrir à quoi ressemble un objet
afin que vous puissiez l'utiliser avec des commandes PowerShell et tirer parti du pipeline PowerShell.

Pour plus d'informations, lisez l'aide pour {0}Get-Member{1} et consultez les exemples.

"@ -f $cmdStyle,$reset
#endregion
#region run the tutorial
Clear-Host
$title
$Intro
Get-Process pwsh | Out-Host
pause
$P1
pause
Clear-Host
$P2
pause
Clear-Host
$P3
pause
$P4
pause
$P5
pause
Clear-Host
$P6
pause
Clear-Host
$P7
pause
"`e[2A"
Get-Process -id $pid | Get-Member -MemberType ScriptProperty | Out-Host
pause
Clear-Host
$P8
pause
"`e[2A"
Get-Process | Where-Object WS -gt 10mb | Sort-Object WS -Descending |
Select-Object ID,Handles,WS,Name,StartTime -first 5 | Format-Table | Out-Host
pause
Clear-Host
$P9
#endregion

if ($Full) {
  #this is the last lesson in the set. No action needed.
}
elseif ($menu) {
    Start-PSTutorial
}