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

Pour les débutants PowerShell, un concept fondamental qui peut sembler mystérieux au début est celui
d'un PowerShell {0}provider{1}. Un provider est un logiciel qui sert d'interface entre une technologie
sous-jacente, comme le registre Windows ou le système de fichiers, et PowerShell. Il expose la
technologie  sous-jacente via un {0}PSDrive{1}.

Sauf si vous êtes développeur .NET ou PowerShell, vous ne créerez jamais de provider, mais vous les
utiliserez tout le temps, même si vous ne vous en rendez pas compte.

PowerShell inclut plusieurs providers prêts à l'emploi. Vous pouvez obtenir des providers supplémentaires
via des modules importés. Par exemple, lorsque vous importez le module ActiveDirectory, vous obtiendrez un
PSDrive qui sert d'interface vers votre domaine Active Directory, vous permettant de naviguer dans le domaine
comme dans un système de fichiers.

'@ -f $highLight,$reset

$p1 = @"
Le provider permet d'utiliser le même cmdlet pour différentes technologies. C'est pourquoi le cmdlet
s'appelle {0}Get-ChildItem{1} et non {4}Get-File{1} ou {4}Get-RegistryKey{1}. Dans de nombreux cas, vous
pouvez parcourir  la technologie via le PSDrive comme s'il s'agissait d'un système de fichiers.

Le provider permet aussi au même cmdlet d'obtenir des éléments depuis le système de fichiers ou
depuis le PSDrive {2}Function{1}. Le provider s'occupe du travail.

"@ -f $cmdStyle,$reset,$highLight2,$highLight3,$italic

#Get-PSProvider
$p2 = @"
Pour afficher les providers actuellement utilisés, exécutez cette commande :

$prompt {0}Get-PSProvider{1}
"@ -f $cmdStyle,$reset

$p3 = @"
Vous verrez des providers différents selon votre système d'exploitation et selon les modules que vous
avez chargés et qui peuvent ajouter un provider. Nous examinerons {0}Drives{1} dans un instant.

Tous les providers ne fonctionnent pas de la même manière ; ainsi, même si un cmdlet dispose d'un
paramètre
pour prendre en charge une fonctionnalité, si vous utilisez le cmdlet dans un PSDrive qui ne prend pas en
charge cette fonctionnalité, le cmdlet échouera.

La capacité {2}ShouldProcess{1} se rapporte à la prise en charge du paramètre {3}-WhatIf{1}. Cependant,
 n'ayez pas peur de l'essayer. Sous Windows, le provider {4}WSMan{1} semble ne pas prendre en charge
 {2}ShouldProcess{1}, pourtant des commandes comme celle-ci :

{5}Set-Item{1} {3}-path{1} {6}WSMan:\localhost\Client\AllowUnencrypted{1} {3}-Value{1} {6}'false'{1} {3}-WhatIf{1}

fonctionneront en fait sans erreur.

"@ -f $highLight3,$reset,$highLight2,$paramStyle,$highLight,$cmdStyle,$stringStyle

$p4 = @"
La capacité {0}Filter{1} se réfère à une technique de filtrage spécifique utilisée en .NET. Elle
est généralement exposée via le paramètre {2}-Filter{1} que vous verrez dans certains cmdlets. Le format
 de la valeur du paramètre varie selon le provider et le cmdlet. L'aide devrait documenter son utilisation.

Si le provider ne prend pas en charge {0}Filter{1}, cela signifie simplement que le paramètre {2}-Filter{1}
ne fonctionnera probablement pas. Cependant, de nombreux cmdlets ont d'autres paramètres qui peuvent fournir une
fonctionnalité de « filtrage » comme {2}-Name{1}, {2}-Include{1} et {2}-Exclude{1}.

Vous ne devriez pas avoir besoin d'exécuter {3}Get-PSProvider{1} très souvent, sauf pour le dépannage ou
par curiosité.

"@ -f $highLight2,$reset,$paramStyle,$cmdStyle

#Get-PSDrive
$p5 = @"
{3}PSDrives{2}

Chaque provider créera un ou plusieurs {0}PSDrives{2}. Chaque lecteur est une interface vers la technologie
sous-jacente. PowerShell créera automatiquement un certain nombre de PSDrives lorsque vous démarrez une
nouvelle session PowerShell. Vous pouvez utiliser {1}Get-PSDrive{2} pour découvrir les PSDrives définis
dans votre session actuelle.

$prompt {1}Get-PSDrive{2}
"@ -f $highlight2,$cmdStyle,$reset,$highLight3

$p6 = @"

Vous devriez automatiquement avoir un PSDrive pour chaque lecteur logique tel que vu par le système
d'exploitation, par exemple C:\ sur Windows ou / sur Linux. Cependant, comme vous le verrez, les PSDrives
{0}FileSystem{1} affichés ici sont indépendants du système d'exploitation.

"@ -f $highLight,$reset

#other providers
$p7 = @"
Les lecteurs non liés au système de fichiers intéressent souvent le plus les débutants PowerShell.

$prompt {2}Get-PSDrive{1} {3}|{1} {2}Where-Object{1} {3}{{{1}{5}`$_.Provider.Name{1} {3}-ne{1} {4}'FileSystem'{1}{3}}}{1}
"@ -f $highLight,$reset,$cmdStyle,$operatorStyle,$stringStyle,$varStyle

$p8 = @"
Vous verrez des lecteurs différents selon votre système d'exploitation, les modules chargés ou les
lecteurs que vous avez pu ajouter.

"@

$p9 = @"
Vous pouvez accéder à ces lecteurs et éventuellement les parcourir comme un système de fichiers.
N'oubliez pas d'utiliser les deux-points {6}:{1} après le nom du PSDrive.

$prompt {0}Get-ChildItem{1} {3}Alias:{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle,$highLight2

$p10 = @"
Beaucoup de ces PSDrives sont utilisés par des cmdlets associés, qui sont ceux que vous devriez utiliser.

$prompt {0}Get-Alias{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

#New-PSdrive
$p11 = @"
Vous pouvez créer vos propres PSDrives vers n'importe quel emplacement pris en charge par un Provider,
que vous verrez parfois référencé comme un {2}PSProvider{1}. Utilisez {0}New-PSDrive{1} pour créer
l'affectation du lecteur. Vous n'êtes pas limité à l'utilisation de lettres de lecteur traditionnelles.
Vous pouvez utiliser n'importe quel nom, bien que vous devriez éviter les noms contenant des espaces ou
des caractères non alphanumériques.

$prompt {0}New-PSDrive{1} {3}-Name{1} {4}tmpHome{1} {3}-PSProvider{1} {4}FileSystem{1} {3}-Root{1} {5}`$home{1}
"@ -f $cmdStyle,$reset,$highLight2,$paramStyle,$stringStyle,$varStyle

$p12 = @"

Il est important de noter que le système d'exploitation ne verra pas votre PSDrive. Si vous créez un
PSDrive appelé {3}W{1} sous Windows qui correspond à C:\Work, vous ne verrez {5}pas{1} un lecteur {3}W{1} dans
l'Explorateur Windows. L'exception serait les PSDrives persistants mappés sur une racine UNC.
({4}Consultez l'aide pour {0}New-PSDrive{1}.)

De même, si vous ajoutez un nouveau mappage de lecteur dans Windows, il n'est pas garanti qu'un PSDrive
correspondant soit automatiquement créé dans votre session PowerShell.

Une fois créé, vous pouvez utiliser cet emplacement comme n'importe quel autre chemin. Encore une fois,
n'oubliez pas les deux-points.

$prompt {0}Get-ChildItem{1} {2}tmpHome:{1} {7}|{1} {0}Select-Object{1} {6}-first{1} {8}3{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$italic,$warnStyle,$paramStyle,$operatorStyle,$numberStyle

#remove PSDrive
$p13 = @"
Tous les PSDrives que vous créez ne {4}durent que pendant la durée de votre session PowerShell.{1} La
prochaine fois que vous lancerez PowerShell, le lecteur ne sera pas défini. Si vous voulez des PSDrives
disponibles à chaque démarrage de PowerShell, placez la commande {0}New-PSDrive{1} dans votre script de
profil PowerShell.

Une exception concerne Windows lorsque vous mappez un lecteur réseau (UNC) comme un lecteur {5}persistant{1}.
Consultez l'aide pour {0}New-PSDrive{1} pour en savoir plus.

Si vous voulez supprimer un PSDrive de votre session, utilisez {0}Remove-PSDrive{1}. Dans ce cas,
référencez le nom du lecteur {6}sans{1} les deux-points. Comme pour l'ajout d'un PSDrive, la suppression
d'un PSDrive est totalement indépendante du système d'exploitation.

$prompt {0}Remove-PSDrive{1} {2}-name{1} {3}tmpHome{1}

"@ -f $cmdStyle,$reset,$paramStyle,$stringStyle,$warnStyle,$highLight2,$italic

#dynamic parameters
$p14 = @"
Il y a une autre fonctionnalité des PSProviders et PSDrives dont vous voudrez tirer parti. Vous savez
maintenant que vous pouvez utiliser un cmdlet comme {0}Get-ChildItem{1} avec différents PSDrives. Certains
cmdlets sont conçus avec des {2}{3}paramètres dynamiques{1}. Ce sont des paramètres souvent
conscients du provider. Autrement dit, le paramètre ne fonctionne qu'avec un PSProvider donné. Cela
peut prêter à confusion car l'aide peut afficher le paramètre, mais il ne fonctionne que dans une
situation spécifique.

Voici un exemple. {0}Get-ChildItem{1} possède un paramètre {4}-File{1}.

$prompt {0}Get-ChildItem{1} {5}`$pshome{1} {4}-file{1} {6}|{1} {0}Select-Object{1} {4}-first{1} {7}1{1}
"@ -f $cmdStyle,$reset,$italic,$highLight2,$paramStyle,$varStyle,$operatorStyle,$numberStyle

$p15 = @"

Cependant, le paramètre {2}-File{1} n'est disponible que lorsque vous utilisez un emplacement pris en
charge par le PSProvider FileSystem. Sinon, vous obtiendrez très probablement une erreur.

$prompt {0}Get-ChildItem{1} {2}Function:{1} {3}-file{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$p16 = @"
C'est pourquoi il est très important de prendre le temps de lire l'aide complète et les exemples des
commandes PowerShell.

"@

$p17 = @"
Vous pouvez en apprendre davantage sur les providers en général en exécutant {0}Get-Help{1} {2}about_providers{1}.
Vous pouvez également obtenir des détails sur un provider spécifique à partir du sujet about correspondant.

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