# An interactive tutorial for PowerShell basics

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

$title = "$($titleStyle)Fondamentaux Essentiels de PowerShell$($reset)"

#region content
$intro = @"

Pour commencer avec PowerShell, il y a quelques concepts et termes essentiels que vous devez comprendre.
Il n'st pas nécessaire de maîtriser PowerShell avant de commencer à l'utiliser, mais il est
important d'avoir une compréhension de base de son fonctionnement afin de savoir à quoi s'attendre.

"@

$P1 = @"
{0}Qu'est-ce que PowerShell?{1}

PowerShell se compose de deux composants principaux : le {2}shell{1} et le {2}langage de script{1}.
Le shell est l'interface de ligne de commande interactive où vous pouvez exécuter des commandes et
des scripts. Le langage de script est le langage que vous utilisez pour écrire des scripts et
automatiser des tâches. Les mêmes commandes et le même langage sont utilisés dans les deux cas.
En d'autres termes, si vous pouvez exécuter une commande dans le shell, vous pouvez aussi l'utiliser
dans un script.

PowerShell est basé sur le framework .NET et adopte une approche orientée {3}objet{1}. Tout ce avec
quoi vous travaillez dans PowerShell est un objet, et non du texte. Cependant, {4}il n'est pas
nécessaire{1} d'être développeur .NET pour utiliser PowerShell.

"@ -f $highLight3, $reset,$highLight,$highLight2,$PSStyle.Underline

$P2 = @"
Les commandes PowerShell sont appelées {3}cmdlets{1}. Une cmdlet est une commande légère utilisée pour
effectuer une tâche spécifique. Les commandes PowerShell suivent une convention de nommage verbe-nom, ce qui
les rend faciles à trouver et à utiliser. Ce que fait la commande {0}Get-Process{1} devrait être clair.

$prompt {0}Get-Process{1} {2}pwsh{1}
"@ -f $cmdStyle, $reset,$defaultTokenStyle,$highLight

$P3 = @"
Le résultat d'une commande PowerShell est techniquement un objet, mais il est formaté pour le rendre
plus facile à lire.

"@

$P4 = @"
{0}Alias{1}

PowerShell a un concept d'alias. Un alias est un nom court pour une cmdlet. Ils sont destinés
à vous faire gagner du temps lors de la saisie de commandes ou à faciliter la transition pour les
utilisateurs d'autres shells.

$prompt {2}dir{1} {3}$root{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle

$P5 = @"
Cependant, vous n'exécutez pas la commande native {3}dir{1}. Vous exécutez un alias pour la
commande native PowerShell {0}Get-ChildItem.{1} L'exécution de cette commande est identique à
l'utilisation de l'alias.

$prompt {0}Get-ChildItem{1} {2}$root{1}

"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight

$P6 = @"
Cela signifie que vous devez utiliser les paramètres de la commande PowerShell avec l'alias.

$prompt {0}dir{1} {2}`$home{1} {3}-Directory -Hidden{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$P7 = @"
Vous pouvez utiliser la cmdlet {0}Get-Alias{1} pour découvrir les alias définis dans PowerShell.

"@ -f $cmdStyle,$reset,$highLight

$P8 = @"
{0}Le Pipeline{1}

Le paradigme PowerShell est basé sur le concept d'objets passant par un {6}pipeline{1}. Le
pipeline est indiqué par le symbole |.

Pensez au pipeline comme à un tapis roulant où les objets sont passés d'une commande à une autre.
Chaque commande dans le pipeline effectue une tâche spécifique sur l'objet puis le passe à la commande
suivante. Cela vous permet de créer des commandes et des scripts complexes en combinant des commandes simples.

$prompt {2}Get-Process{1} | {2}Sort-Object{1} {3}WorkingSet{1} {4}-Descending{1} | {2}Select-Object{1} {4}-first {5}5{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle,$paramStyle,$numberStyle,$highlight

$P9 =@"
La première commande récupère tous les processus sur l'ordinateur local. Le résultat de cette commande
est une collection d'objets de processus. La deuxième commande trie la collection d'objets de processus
par la propriété WorkingSet dans l'ordre décroissant.

Vous apprendrez à découvrir les propriétés des objets avec {0}Get-Member{1}.

Les objets de processus triés sont ensuite passés à la troisième commande, {0}Select-Object{1},
qui sélectionne les cinq premiers objets. PowerShell affiche le résultat de la dernière commande dans
le pipeline.

Si vous souhaitez effectuer cette tâche fréquemment, vous pouvez placer les commandes dans un fichier script.
Lerésultat est le même que si vous aviez exécuté les commandes de manière interactive dans le shell,
sans avoirà retaper la commande.

"@ -f $cmdStyle,$reset

$P10 = @"
{0}Variables{1}

Comme de nombreux langages de script et de shell, PowerShell comprend les variables. Une variable contient
une valeur, telle qu'une chaîne de texte ou un nombre. Utilisez le caractère {2}`${1} pour définir une variable.

$prompt {3}`$i{1} = {4}123{1}
$prompt {3}`$n{1} = {5}"pw*"{1}

"@ -f $highLight3, $reset,$highLight,$varStyle,$numberStyle,$stringStyle

$P11 = @"
Vous pouvez également enregistrer le résultat d'une commande ou expression PowerShell dans une variable.

$prompt {3}`$files{1} {2}={1} {0}Get-ChildItem{1} {3}-Path{1} {4}`$HOME{1} {3}-file{1} | {0}Sort-Object{1} {3}-Property{1} {6}LastWriteTime{1} | {0}Select-Object{1} {3}-first{1} {5}5{1}

"@ -f $cmdStyle,$reset,$operatorStyle,$paramStyle,$varStyle,$numberStyle,$defaultTokenStyle

$P12 = @"
Lorsque vous souhaitez utiliser une variable, vous pouvez y faire référence par son nom avec le caractère `$.

$prompt {0}`$i{2}*{1}2{2}
"@ -f $varStyle,$numberStyle,$reset

$P13 = @"

$prompt {0}Get-Process{1} {2}`$n{1}
"@ -f $cmdStyle,$reset,$varStyle

$P14 = @"
Vous pouvez utiliser la variable dans une expression avec pipeline.

$prompt {0}`$files{1} | {2}Group-Object{1} {3}-property{1} {4}Extension{1} | {2}Sort-Object{0} {4}Count{1} {3}-Descending{1}
"@ -f $varStyle,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P15 = @"
Notez que les objets peuvent changer dans le pipeline en fonction de la commande. La variable {2}`$files{1} contient
des objets de fichier. La commande {0}Group-Object{1} crée un nouveau type d'objet avec différentes propriétés. Ces
objets sont ensuite transmis à la commande {0}Sort-Object{1}.

Pouvez-vous deviner quelle commande vous exécuteriez pour obtenir toutes les variables PowerShell?

"@ -f $cmdStyle,$reset,$highLight

$P16 = @"
$Prompt {0}Get-Variable{1}
"@ -f $cmdStyle,$reset

$P17 = @"
PowerShell possède de nombreuses variables intégrées que vous pouvez utiliser.

$prompt {0}`$PSEdition{1}
"@ -f $varStyle,$reset

$P17a = @"
$prompt {0}`$PSVersionTable{1}
"@ -f $varStyle,$reset

$P18 = @"

Une fois que vous aurez terminé les autres tutoriels, vous devriez être en mesure de commencer à exécuter
des commandes PowerShell depuis la console.

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
clear-host
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