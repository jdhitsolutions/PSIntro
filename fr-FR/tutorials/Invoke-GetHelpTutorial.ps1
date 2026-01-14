#an interactive tutorial for Get-Help
Param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters

$cmd = 'Get-Help'
$title = "$($titleStyle)Démarrer avec $cmd$reset"

#get version specific help
$gpsHelp = Get-Help -Name Get-Process
$onlineVer = $gpsHelp.relatedLinks.navigationLink[0].uri
$exampleCode = if ($gpsHelp.examples.example[0].code) {
    $gpsHelp.examples.example[0].code.insert(0, '    ')
}else {
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
    $($gpsHelp.Synopsis)

"@ -f $highLight,$reset

$P4 = @"
La {0}syntaxe{1} de la commande, qui est la même chose que vous pouvez voir avec {2}Get-Command{1}.

SYNTAX
    $(($gpsHelp.syntax | Out-String).TrimEnd() -replace 'Get','   Get')

"@ -f $highLight,$reset,$cmdStyle

$P5 = @"
Et une {0}description{1} plus détaillée.

DESCRIPTION
    $(($gpsHelp.description[0] | Out-String).Trim())
    ...

"@ -f $highLight,$reset

$P6 = @"

La plupart des aides de commande incluront également un ou plusieurs exemples. Si vous voulez voir uniquement les exemples,
vous pouvez exécuter:

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

Enfin, vous pouvez toujours obtenir l'aide la plus à jour en utilisant le paramètre {0}-Online{1}. S'il existe
un lien en ligne, il s'ouvrira dans votre navigateur par défaut. Ce n'est pas une obligation, mais la majorité
des commandes que vous utiliserez prennent en charge cette fonctionnalité d'aide. Le lien en ligne sera affiché
sous RELATED LINKS:


RELATED LINKS
    {2}Online Version: $onlineVer{1}
$(($gpsHelp.relatedLinks.navigationLink[1..5]).linkText.split("`n").Foreach({$_.insert(0,'    ')})| Out-String)

"@ -f $highLight,$reset,$highLight2

$P8 = @"

Il est très important que vous compreniez comment interpréter la syntaxe de l'aide.

SYNTAX
    $(((Get-Command Get-Process -Syntax).split("`n") | Select-Object -Skip 1 -First 3 | Foreach-Object {"`n     $($_)"}) )

    ...

Chaque combinaison de paramètres est appelée un {0}jeu de paramètres{1}. Vous ne pouvez pas mélanger les
paramètres entre les jeux. Pour l'instant, vous pouvez ignorer CommonParameters.

"@ -f $highLight,$reset

$P9 = @"
Tout ce que vous voyez entre [ ] est considéré comme {0}optionnel{2}. Cela signifie que si vous voulez utiliser
le paramètre {4}Id{2}, vous devez le spécifier car il n'est pas entre [ ].

SYNTAX
    $(($gpsHelp.syntax | Out-String).Trim())

$prompt {3}Get-Process{2} {4}-Id{2} {5}`$PID{2}
"@ -f $highLight,$highLight3,$reset,$cmdStyle,$paramStyle,$varStyle

$P10 = @"

{0}`$PID{1} est une variable automatique dont la valeur est l'ID du processus de la session PowerShell actuelle.

"@ -f $highLight,$reset

$P10a = @"
En examinant à nouveau la syntaxe, vous pouvez utiliser le paramètre {1}Name{4} sans avoir à le taper car
le nom du paramètre est entre [ ].

SYNTAX
    $syntaxHighlight

La syntaxe vous indique que l'ensemble du paramètre {1}Name{4} est optionnel, et si vous voulez l'utiliser,
vous n'avez même pas besoin d'utiliser le nom du paramètre. C'est ce qu'on appelle un paramètre {0}positionnel{4}.

Le texte entre {2}< >{4} indique quel {0}type{4} de valeur de paramètre utiliser. System.String signifie
du texte. Lorsque vous voyez {2}[]{4} comme partie du type, cela indique que le paramètre acceptera plusieurs valeurs
séparées par des virgules.

$prompt {3}Get-Process{4} {5}$psh,sys*{4}
"@ -f $highLight,$highLight2,$highlight3,$cmdStyle,$reset,$defaultTokenStyle

$P11 = @"
Vous pouvez toujours consulter les détails des paramètres dans l'aide. Vous pouvez spécifier des noms de paramètres
en utilisant des caractères génériques.

$prompt {0}help{3} {2}Get-Process{3} {1}-Parameter{3} {2}*name{3}
"@ -f $cmdStyle,$paramStyle,$defaultTokenStyle,$reset

$P12 = @"
Voyez-vous comment ces paramètres sont définis comme positionnels ou nommés? Le détail indique également
s'il s'agit d'un paramètre obligatoire. Comparez ces informations à la façon dont elles sont affichées dans l'aide.

$((Get-Command Get-Process -Syntax).split("`n") | where {$_ -match 'Name'} | Out-String)

Si vous vouliez voir tous les processus PowerShell et ceux commençant par {0}sys{1} ET afficher le
nom d'utilisateur, avez-vous une idée de quelle commande vous taperiez?

"@ -f $highLight2,$reset

$P13 = @"
$prompt {0}Get-Process{3} {1}$psh,sys*{3} {2}-IncludeUsername{3}
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
