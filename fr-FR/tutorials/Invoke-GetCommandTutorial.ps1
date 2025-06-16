#an interactive tutorial for Get-Command
Param(
    [switch]$Full,
    [switch]$Menu
)

$cmd = 'Get-Command'

$title = "$($titleStyle)Démarrer avec Get-Command$reset"

$Intro = @"

{0}Get-Command{2} est l'une des cmdlets fondamentales de PowerShell. Vous pouvez utiliser cette commande pour
découvrir les commandes PowerShell. Ces commandes suivent une convention de nommage Verbe-Nom. Le
verbe provient d'une liste standard de verbes que vous pouvez voir en exécutant la commande {0}Get-Verb{2}.
Le nom est la forme singulière de ce avec quoi vous voulez travailler, comme {1}Service{1} ou {1}Process{2}.

"@ -f $cmdStyle, $highLight,$reset

$P1 = @"
Les commandes dans PowerShell peuvent être des fonctions ou des cmdlets. Les {0}cmdlets{1} sont des commandes
compilées basées sur des classes .NET conçues pour être utilisées dans PowerShell. Les {0}fonctions{1} sont
comme des cmdlets, sauf qu'elles ne sont pas compilées. Les fonctions sont écrites dans le langage de script
de PowerShell. Les fonctions s'exécutent de la même manière que les cmdlets. Il n'y a pas de différence
d'exécution entre les deux, seulement dans la façon dont elles sont écrites.

"@ -f $highLight,$reset

$P2 = @"
Utilisez {0}Get-Command{2} pour trouver des commandes. Supposons que vous recherchez des commandes pour gérer
les processus. Vous pouvez utiliser {0}Get-Command{2} pour découvrir les commandes disponibles à l'aide de
caractères génériques.

$prompt {0}Get-Command{2} {1}*process*{2}
"@ -f $cmdStyle,$defaultTokenStyle,$reset

$P3 = @"

Vous pourriez également voir des {0}applications{1} qui sont des programmes trouvés dans %PATH%. Vous pouvez
limiter votre recherche aux commandes PowerShell en spécifiant un type de commande.

$prompt {2}Get-Command{1} {4}-CommandType{1} {3}Function,Cmdlet{1}
"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle,$paramStyle

$P4 = @"
Dans la sortie, vous pouvez voir le type de commande et le nom de la commande PowerShell.
"@

$P5 = @"

Remarquez la convention de nommage Verbe-Nom. La source est le nom du {0}module{1} PowerShell qui contient
la commande. Un module est un package de commandes associées. De nombreux modules sont livrés avec PowerShell.
Vous apprendrez éventuellement à installer des modules supplémentaires à partir de la Galerie PowerShell.

Le numéro de {0}Version{1} est le numéro de version du module.
"@ -f $highLight,$reset

$P5a = @"

Une fois que vous avez identifié la commande souhaitée, utilisez {2}Get-Command{1} pour afficher la syntaxe
ou comment exécuter la commande.

$prompt {2}Get-Command{1} {3}Get-Process{1} {4}-syntax{1}
"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle,$paramStyle

$P6 = @"

La syntaxe de la commande montre le nom de la commande, {2}Get-Process{1} suivi d'un ensemble de {0}paramètres{1}.
Chaque nom de paramètre est indiqué par un tiret comme {3}-Name{1} et {3}-Id{1}. Après chaque paramètre figure
une indication du type de valeur de paramètre que vous devez spécifier.

Pour mieux comprendre les paramètres, utilisez {2}Get-Help{1} pour en savoir plus.

"@ -f $highLight,$reset,$cmdStyle,$paramStyle

#run the tutorial
Clear-Host
$title
$Intro

pause
$P1
pause
Clear-Host
$P2
(Get-Command *process* | Select-Object -first 10 | Out-Host) && "`e[1A...`n" | Out-Host
pause
$P3
(Get-Command -CommandType Function,Cmdlet | Select-Object -first 10 | Out-Host)  && "`e[1A...`n" | Out-Host
pause
$P4
pause
$P5
Pause
Clear-Host
$P5a
Get-Command Get-Process -Syntax | Out-Host
pause

$P6

if ($full) {
    &$tutorials['Get-Help'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}