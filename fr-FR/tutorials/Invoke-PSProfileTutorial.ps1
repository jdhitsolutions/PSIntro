#an interactive tutorial for PowerShell profiles

param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters
$title = "$($titleStyle)$($strings.profileTutorialTitle)$reset"
if ($IsCoreCLR) {
    $psh = 'pwsh'
}
else {
    $psh = 'powershell'
}

#endregion

#region content

$intro = @"

Un sujet PowerShell courant que vous lirez et que vous entendrez discuter est l'utilisation d'un
{0}script de profil{1} PowerShell. Il s'agit d'un type spécial de fichier de script utilisé pour configurer
votre session PowerShell.

Voulez-vous toujours avoir une certaine variable, ou un nouveau lecteur PSDrive défini chaque fois que vous
démarrez PowerShell? Au lieu d'exécuter manuellement les commandes chaque fois que vous démarrez une
nouvelle session PowerShell, vous pouvez les mettre dans un script de profil PowerShell et elles s'exécuteront
automatiquement au démarrage d'une session PowerShell.

Cependant, il existe en réalité une hiérarchie de scripts de profil PowerShell que les débutants PowerShell
trouvent confuse. Et sur les plates-formes Windows, il y a un autre obstacle potentiel que vous pourriez rencontrer.

"@ -f $highLight, $reset

#what is a profile script
$p1 = @"
Un script de profil PowerShell est comme n'importe quel autre script. C'est un fichier texte avec une
extension de fichier {5}.ps1{3}.

Le contenu du fichier de script sont les mêmes commandes que vous pouvez exécuter de manière interactive.

Par exemple, vous pouvez exécuter cette ligne dans une session PowerShell pour définir une variable.

$prompt {0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

Vous pouvez utiliser la même commande :

{0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

et l'insérer dans un script de profil PowerShell. Parce que les scripts de profil PowerShell s'exécutent
{4}automatiquement{3} au démarrage d'une nouvelle session PowerShell, cette variable serait définie dans
votre session.

$prompt {0}`$CustomVar{3}
foo789

"@ -f $varStyle, $operatorStyle, $stringStyle, $reset, $highLight3, $highLight2

#powershell versions
$p2 = @"

Sur les plates-formes Windows, il est possible d'exécuter Windows PowerShell et PowerShell 7 côte à côte.
Chaque version possède {0}son propre ensemble{1} de scripts de profil. Cela signifie que par défaut, une
configuration effectuée pour Windows PowerShell {2}ne sera pas{1} utilisée dans PowerShell 7.

Les plates-formes non-Windows ne peuvent exécuter que PowerShell 7, ce n'est donc pas un problème sur ces systèmes.

"@ -f $highLight, $reset, $warnStyle

#hosting
$p3 = @"
Avant d'entrer dans les détails techniques, vous devez comprendre un aspect souvent négligé de PowerShell.
Nous avons tendance à penser aux commandes et au code qui constituent PowerShell comme un {0}moteur de gestion{1}.
Comme un moteur automobile, il n'est d'aucune utilité en lui-même. Il doit faire partie d'une construction plus
grande. Dans le monde automobile, nous placerions le moteur dans une voiture ou un camion. Dans PowerShell, le moteur
doit être {2}hébergé{1} dans une application.

Ceci est appelé l'{3}application hôte{1} ou hôte.

Vous pouvez afficher l'application hébergeant votre session PowerShell en exécutant {4}Get-Host{1}.

$prompt {4}Get-Host{1}
"@ -f $highLight2, $reset, $highLight3, $highlight, $cmdStyle

$p4 = @"
Ou vous pouvez utiliser la variable intégrée {0}`$host{1}.

$prompt {0}`$host{1}

"@ -f $varStyle, $reset

#other apps like VSCode
$p5 = @"
Vous passerez la plupart de votre temps dans ConsoleHost. Pensez à cela comme l'expérience PowerShell standard
ou par défaut. Cependant, d'autres applications peuvent également héberger PowerShell. Lorsque vous êtes dans
une session PowerShell à distance utilisant le protocole WSMan, c'est une autre application hôte.

Deux exemples courants d'autres hôtes que vous êtes susceptible de rencontrer sont PowerShell ISE et le terminal
intégré dans Visual Studio Code. Vous pouvez vérifier cela en exécutant {2}Get-Host{1} ou simplement en affichant
le nom de l'hôte.

L'exemple suivant est ce que vous verriez dans Visual Studio Code.

$prompt {3}`$host.name{1}
Visual Studio Code Host

Il est important que vous compreniez le concept d'une application hôte car il {4}n'y a aucune garantie que toutes les
fonctionnalités PowerShell sont prises en charge dans tous les hôtes{1}.

"@ -f $italic, $reset, $cmdStyle, $varStyle, $warnStyle

#scope
$p6 = @"
Jusqu'à présent, nous avons examiné la version PowerShell et l'hôte. Il y a un autre attribut PowerShell qui affecte
les scripts de profil et c'est la {0}portée{1}. Pensez à cela comme une sphère d'influence.

En ce qui concerne les scripts de profil, nous avons deux portées. Il y a une portée pour {2}AllUsers{1} et une pour
{3}CurrentUser{1}.

La portée {2}AllUsers{1} s'applique à tout utilisateur PowerShell. Cette portée est appliquée au niveau du système,
généralement où se trouvent les fichiers exécutables PowerShell. Vous devez disposer de privilèges élevés pour
gérer les choses à ce niveau.

La portée {3}CurrentUser{1} est généralement vous. Cette portée est basée dans votre profil de bureau, ce qui
signifie que vous n'avez pas besoin de privilèges spéciaux.

"@ -f $highLight, $reset, $highLight2, $highLight3

#$profile

$p7 = @"
Bien que les scripts de profil PowerShell soient des fichiers .ps1, les chemins sont {0}codés en dur{1} et {2}ne peuvent
pas être modifiés.{1}

Lorsque vous démarrez une session PowerShell, PowerShell recherche les scripts de profil et les exécute automatiquement.

Vous pouvez utiliser la variable intégrée {3}`$profile{1} pour afficher l'emplacement.

$prompt {3}`$profile{1}
"@ -f $highLight3, $reset, $warnStyle, $varStyle

$p8 = @"
Vous devriez remarquer que le chemin fait référence à votre profil utilisateur. Il est important de noter que ce
fichier {0}n'existe pas par défaut{1}. Il est également possible que certaines parties du chemin n'existent pas.

"@ -f $warnStyle, $reset

$p9 = @"
La variable {0}`$profile{1} est un peu plus compliquée qu'elle ne le paraît. Il existe des propriétés supplémentaires
qui reflètent les scripts de profil délimités.

$prompt {0}`$profile{1} {3}|{1} {2}Select-Object{1} {4}*host*{1} {3}|{1} {2}Format-List{1}
"@ -f $varStyle, $reset, $cmdStyle, $defaultTokenStyle, $stringStyle

$p10 = @"

Techniquement, il y a {5}quatre{0} scripts de profil PowerShell. Vous pouvez les voir listés ici avec leurs chemins
codés en dur. {6}Aucun de ces scripts de profil n'existe par défaut.{0}

Pour tous les scripts détectés, PowerShell les exécutera dans cet ordre en passant de la portée la plus large à
la plus étroite. Rappelez-vous, l'{1}hôte{0} est l'application hôte telle que {2}ConsoleHost{0} ou {3}Visual Studio Code Host{0}.

Si vous utilisez plusieurs scripts de profil, l'effet est {4}cumulatif{0}.

"@ -f $reset, $highLight, $highLight2, $highLight3, $underLine, $italic, $warnStyle

#checking status
$p11 = @"
Le module {1}PSIntro{0} inclut une commande que vous pouvez exécuter pour voir facilement si des scripts de profil
PowerShell existent. Les emplacements sans fichier de script doivent s'afficher en rouge.

$prompt {2}Get-ProfileStatus{0}

"@ -f $reset, $highLight2, $cmdStyle

#creating a profile script

$p12 = @"
Vous pouvez créer manuellement l'un des scripts de profil PowerShell en utilisant le chemin spécifique
et le nom de fichier. Sur les machines non-Windows, attention à la casse. Ou vous pouvez utiliser PowerShell
et la variable {1}`$profile{0}. Vous pouvez référencer les différents scripts de profil en tant que
propriétés d'objet. Utilisez la commande {2}New-Item{0} pour créer le fichier.

L'exemple utilise le paramètre {3}-WhatIf{0} pour montrer ce que PowerShell aurait fait sans créer
réellement le fichier. Utilisez {3}-Force{0} pour créer les parties manquantes du chemin.

$prompt {2}New-Item{0} {3}-path{0} {4}`$profile.CurrentUserCurrentHost{0} {3}-Force -WhatIf{0}
"@ -f $reset, $varStyle, $cmdStyle, $paramStyle, $varStyle

#common profile entries
#psdrives
#variables
#pre-loading modules
#custom functions
$p13 = @"
Une fois le script créé, modifiez-le à l'aide de votre éditeur de code préféré. En général,
utilisez des commandes PowerShell qui s'exécuteront sans intervention de l'utilisateur. Les scripts
s'exécutent automatiquement {1}sous votre contexte utilisateur{0} au lancement de PowerShell, il est
donc important de les maintenir sécurisés. La signature de code est en dehors de la portée de ce tutoriel
mais c'est quelque chose que vous pourriez vouloir considérer pour vos scripts de profil.

Entrez dans votre script de profil des commandes appropriées pour la version PowerShell et l'hôte.
Les commandes dans votre script sont exécutées du début à la fin.

Vous pourriez vouloir définir une variable que vous utiliserez souvent :

{2}`$zip = 68106{0}

Vous pouvez définir un lecteur PSDrive :

{2}New-PSDrive -Name W -PSProvider FileSystem -Root c:\work{0}

Bien que PowerShell chargera automatiquement les modules, vous pourriez vouloir les pré-charger dans votre
profil :

{2}Import-Module Microsoft.PowerShell.PSResourceGet{0}

Ou peut-être voulez-vous définir une fonction personnalisée :

{2}Function Get-SessionRunTime {{
    `$thisSession = Get-Process -id `$pid
    `$ts = New-TimeSpan -start `$thisSession.StartTime -end (Get-Date)
    `$ts.ToString()
}}{0}

Vous pouvez également vouloir ajouter des alias de commande

{2}Set-Alias -name rt -value Get-SessionRunTime{0}
{2}Set-Alias -name dt -value Get-Date{0}

"@ -f $reset, $highLight3, $stringStyle

#credentials - prompting is recommended but better off using Secrets Management
$p14 = @"
Vous pourriez être tenté d'entrer des identifiants dans votre script de profil PowerShell. Mais soyez prudent.

{1}Ne mettez jamais de mots de passe en texte brut dans un fichier de script PowerShell{0}

Vous {2}pourriez{0} utiliser {3}Get-Credential{0} et demander un identifiant dans votre script de profil :

{4}`$admin = Get-Credential company\administrator{0}

Cela fonctionnera, mais vous serez invité chaque fois que PowerShell démarre avec votre profil. Il est en dehors
de la portée de ce tutoriel, mais vous devriez enquêter sur la façon d'utiliser le module
{5}Microsoft.PowerShell.SecretManagement{0} de Microsoft. Vous pouvez en savoir plus en visitant :

https://learn.microsoft.com/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules

"@ -f $reset, $warnStyle, $italic, $cmdStyle, $stringStyle, $highLight2

#execution policy
$p15 = @"
Sur les systèmes {5}Windows{0}, il y a un autre obstacle potentiel à l'utilisation de scripts de profil PowerShell
et c'est la {3}politique d'exécution{0}. La politique d'exécution de PowerShell est conçue pour prévenir l'exécution
{4}involontaire{0} d'un script PowerShell. L'une des politiques est {6}Restricted{0} qui empêche PowerShell d'exécuter
n'importe quel fichier de script qui inclut les scripts de profil PowerShell.

Exécutez {2}Get-ExecutionPolicy{0} pour voir votre paramètre actuel.

$prompt {2}Get-ExecutionPolicy{0}
"@ -f $reset, $cmdStyle, $paramStyle, $highLight3, $highLight, $highLight2, $warnStyle

$p16 = @"
Si le paramètre est défini sur {1}Restricted{0}, vous devrez le modifier à l'aide de {2}Set-ExecutionPolicy{0} pour
le modifier. Le paramètre minimum recommandé est {4}RemoteSigned{0}.

$prompt {2}Set-ExecutionPolicy{0} {3}RemoteSigned{0}

Vous ne devez le faire qu'une seule fois. Sachez que dans les environnements d'entreprise, ce paramètre peut être
contrôlé par une stratégie de groupe ou autrement restreint.

Lisez le sujet d'aide {3}about_Execution_Policies{0} pour en savoir plus :

$prompt {2}help{0} {3}about_Execution_Policies{0}

"@ -f $reset, $warnStyle, $cmdStyle, $stringStyle, $highLight3, $highLight2

#pwsh -noProfile
#help about_profiles
$p17 = @"
Parce que votre script de profil PowerShell pourrait apporter des modifications majeures à votre session,
ou si vous avez besoin de dépanner PowerShell, il peut y avoir des situations où vous voulez démarrer
une session PowerShell propre sans charger votre profil : Vous pouvez utiliser des paramètres pour l'exécutable
PowerShell pour lancer une nouvelle session sans profil :

$prompt {1}$psh{0} {2}-NoProfile{0}

Pour voir les autres paramètres disponibles et l'aide, exécutez :

$prompt {1}$psh{0} {2}-?{0}

"@ -f $reset, $cmdStyle, $paramStyle

$p18 = @"

Pour en savoir plus sur les profils PowerShell, lisez l'aide :

$prompt {1}help{0} {2}about_Profiles{0}

"@ -f $reset, $cmdStyle, $stringStyle

#endregion

#region run

$pages = @(
    {
        Clear-Host
        $title
        $Intro
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p2
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p3
        Get-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p4
        $host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p5
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p6
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p7
        $profile.CurrentUserCurrentHost
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p8
        Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p9
        $profile | Select-Object *host* | Format-List | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p10
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p11
        Get-ProfileStatus -verbose:$false | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p12
        New-Item -Path $profile.CurrentUserCurrentHost -Force -WhatIf
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p13
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p14
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p15
        Get-ExecutionPolicy | Out-Host
        "`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p16
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $p17
        &$psh -? | Select-Object -First 12
        "`t...`n"
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $p18
        $script:pg++ ; Pause $script:pg $pgCount
    }
)
#keep a navigation page counter
$pgCount = $pages.count -1
<#
There is an overlap in functionality between $i and $pg but they are
separate counters because there may be times I need to display a "page"
of information into two pages and want to maintain a page number.
#>
for ($script:i = 0;$script:i -lt $pages.count;$script:i++) {
    Invoke-Command -ScriptBlock $pages[$script:i]
}

#endregion

#this should come after Get-Member and be the last tutorial
if ($full) {
    #this is the last lesson in the set. No action needed.
}
elseif ($menu) {
    Start-PSTutorial
}
