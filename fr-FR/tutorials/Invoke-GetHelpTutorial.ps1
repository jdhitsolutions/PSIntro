#an interactive tutorial for Get-Help
Param(
    [switch]$Full,
    [switch]$Menu
)

$cmd = 'Get-Help'

$title = "$($titleStyle)Démarrer avec $cmd$reset"
$Intro = @"

{0}$cmd{1} est une autre des cmdlets PowerShell de base que vous devez savoir utiliser. Vous
utiliserez cette commande constamment. Vous devriez consulter l'aide fréquemment. Chaque nouvelle version
de PowerShell peut introduire de nouvelles commandes, de nouveaux paramètres, de nouveaux exemples d'aide ainsi que
corriger des erreurs dans la documentation.

PowerShell est livré avec un sous-ensemble de documentation d'aide. Microsoft mettra également
à jour périodiquement la documentation d'aide, bien qu'il n'y ait pas de mécanisme de notification. Après
chaque mise à jour de PowerShell et périodiquement, vous devriez exécuter {0}Update-Help{1}.

$prompt {0}Update-Help{1}

Quelques erreurs sont à prévoir.
"@ -f $cmdStyle, $reset

$P1 = @"

Pendant l'apprentissage de PowerShell, n'essayez pas de mémoriser comment utiliser une commande PowerShell. Au lieu de cela,
apprenez à {2}découvrir{1} comment l'utiliser. Vous pouvez utiliser la cmdlet {0}$cmd{1} ou la fonction d'aide, {2}help{1},
qui fournit les mêmes informations que la cmdlet, mais avec une sortie paginée.

$prompt {3}help{1} {4}Get-Process{1}

"@ -f $cmdStyle,$reset,$highLight,$cmdStyle,$defaultTokenStyle

$P2 = @"

Les en-têtes de sortie devraient être explicites. Vous pouvez voir le {0}nom{1} de la commande.

NAME
    Get-Process

"@ -f $highLight,$reset

$P3 = @"
Un bref {0}synopsis{1} ou une explication sur ce que fait la commande.

SYNOPSIS
    Obtient les processus qui sont en cours d'exécution sur l'ordinateur local.

"@ -f $highLight,$reset

$P4 = @"
La {0}syntaxe{1} de la commande, qui est la même chose que vous pouvez voir avec {2}Get-Command{1}.

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
Et une {0}description{1} plus détaillée.

DESCRIPTION
    La cmdlet `Get-Process` obtient les processus sur un ordinateur local.
    ...

"@ -f $highLight,$reset

$P6 = @"

La plupart des aides de commande incluront également un ou plusieurs exemples. Si vous voulez voir uniquement les exemples,
vous pouvez exécuter:

$prompt {3}help{1} {4}Get-Process{1} {5}-examples{1}

NAME
    Get-Process

SYNOPSIS
    Obtient les processus qui sont en cours d'exécution sur l'ordinateur local.

    {2}Exemple 1: Obtenir une liste de tous les processus actifs sur l'ordinateur local{1}

    Get-Process

    Cette commande obtient une liste de tous les processus actifs exécutés sur l'ordinateur local.
    Pour une définition de chaque colonne, consultez la section Notes (#notes).

    {2}Exemple 2: Obtenir toutes les données disponibles sur un ou plusieurs processus{1}

    Get-Process winword, explorer | Format-List *

"@ -f $cmdStyle,$reset,$highLight2,$cmdStyle,$defaultTokenStyle,$paramStyle

$P7 = @"

Enfin, vous pouvez toujours obtenir l'aide la plus à jour en utilisant le paramètre {0}-Online{1}. S'il existe
un lien en ligne, il s'ouvrira dans votre navigateur par défaut. Ce n'est pas une obligation, mais la majorité
des commandes que vous utiliserez prennent en charge cette fonctionnalité d'aide. Le lien en ligne sera affiché
sous RELATED LINKS:

RELATED LINKS
    {2}Online Version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/
    get-process?view=powershell-7.3&WT.mc_id=ps-gethelp{1}
    Debug-Process
    Get-Process
    Start-Process
    Stop-Process
    Wait-Process

"@ -f $highLight,$reset,$highLight2

$P8 = @"

Il est très important que vous compreniez comment interpréter la syntaxe de l'aide.

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] -Id <System.Int32[]> [-Module] [<CommonParameters>]
    ...

Chaque combinaison de paramètres est appelée un {0}jeu de paramètres{1}. Vous ne pouvez pas mélanger les
paramètres entre les jeux. Pour l'instant, vous pouvez ignorer CommonParameters.

"@ -f $highLight,$reset

$P9 = @"
Tout ce que vous voyez entre [ ] est considéré comme {0}optionnel{2}. Cela signifie que si vous voulez utiliser
le paramètre {4}Id{2}, vous devez le spécifier car il n'est pas entre [ ].

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] {1}-Id{2} <System.Int32[]> [-Module] [<CommonParameters>]
    ...

$prompt {3}Get-Process{2} {4}-Id{2} {5}`$PID{2}
"@ -f $highLight,$highLight3,$reset,$cmdStyle,$paramStyle,$varStyle

$P10 = @"

{0}`$PID{1} est une variable automatique dont la valeur est l'ID du processus de la session PowerShell actuelle.

"@ -f $highLight,$reset

$P10a = @"
En examinant à nouveau la syntaxe, vous pouvez utiliser le paramètre {1}Name{4} sans avoir à le taper car
le nom du paramètre est entre [ ].

SYNTAX
    Get-Process [{2}[{4}-Name{2}]{4} <System.String[]>] [-FileVersionInfo] [-Module]
    [<CommonParameters>]

La syntaxe vous indique que l'ensemble du paramètre {1}Name{4} est optionnel, et si vous voulez l'utiliser,
vous n'avez même pas besoin d'utiliser le nom du paramètre. C'est ce qu'on appelle un paramètre {0}positionnel{4}.

Le texte entre {2}< >{4} indique quel {0}type{4} de valeur de paramètre utiliser. System.String signifie
du texte. Lorsque vous voyez {2}[]{4} comme partie du type, cela indique que le paramètre acceptera plusieurs valeurs
séparées par des virgules.

$prompt {3}Get-Process{4} {5}pwsh,sys*{4}
"@ -f $highLight,$highLight2,$highlight3,$cmdStyle,$reset,$defaultTokenStyle

$P11 = @"
Vous pouvez toujours consulter les détails des paramètres dans l'aide. Vous pouvez spécifier des noms de paramètres
en utilisant des caractères génériques.

$prompt {0}help{3} {2}Get-Process{3} {1}-Parameter{3} {2}*name{3}
"@ -f $cmdStyle,$paramStyle,$defaultTokenStyle,$reset

$P12 = @"
Voyez-vous comment ces paramètres sont définis comme positionnels ou nommés? Le détail indique également
s'il s'agit d'un paramètre obligatoire. Comparez ces informations à la façon dont elles sont affichées dans l'aide.

    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]
    Get-Process -Id <System.Int32[]> -IncludeUserName [<CommonParameters>]
    Get-Process [[-Name] <System.String[]>] -IncludeUserName [<CommonParameters>]
    Get-Process -IncludeUserName -InputObject <System.Diagnostics.Process[]> [<CommonParameters>]

Si vous vouliez voir tous les processus PowerShell et ceux commençant par {0}sys{1} ET afficher le
nom d'utilisateur, avez-vous une idée de quelle commande vous taperiez?

"@ -f $highLight2,$reset

$P13 = @"
$prompt {0}Get-Process{3} {1}pwsh,sys*{3} {2}-IncludeUsername{3}
"@ -f $cmdStyle,$defaultTokenStyle,$paramStyle,$reset

$P14 = @"

Plus vous passerez de temps à lire l'aide, plus cela deviendra facile.

"@

$P15 = @"
Un dernier élément d'aide que vous devez connaître sont les sujets {0}about{4}. Ce sont des fichiers d'aide sur
les concepts et la terminologie PowerShell. Tous ces sujets commencent par {1}about_{4}.

Utilisez la commande {2}help{4} pour les afficher. Les caractères génériques sont autorisés et PowerShell complétera
automatiquement le nom du sujet.

$prompt {2}help{4} {3}about_parameters{4}

Maintenant, si vous ne l'avez pas fait depuis un moment, allez-y et exécutez {2}Update-Help{4}.

"@ -f $highLight,$highLight2,$cmdStyle,$defaultTokenStyle,$reset

#run the tutorial
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

if ($Full) {
    &$tutorials['Get-Member'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}
