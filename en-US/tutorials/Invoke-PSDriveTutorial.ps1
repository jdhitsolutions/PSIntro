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

For PowerShell beginners, a fundamental concept that can be mysterious at first is that of
a PowerShell {0}provider{1}. A provider is a piece of software that acts as an interface between
an underlying technology, like the Windows registry or the file system, and PowerShell. It
exposes the underlying technology to you through a {0}PSDrive{1}.

Unless you are a .NET and PowerShell developer, you will never create a provider, but you will
use them all of the time, even though you may not realize it.

PowerShell includes several providers out-of-the-box. You might get additional providers through
imported modules. For example, when you import the ActiveDirectory module, you will get a PSDrive
that acts as an interface to your Active Directory domain allowing you to navigate the domain like
a file system.

'@ -f $highLight,$reset

$p1 = @"
The provider makes it possible to use the same cmdlet for different technologies. That's why the
cmdlet is called {0}Get-ChildItem{1} and not {4}Get-File{1} or {4}Get-RegistryKey{1}. In many cases, you can
navigate the technology through the PSDrive as if it were a file system.

The provider also makes it possible to the same cmdlet to get items from the file system or the
{2}Function{1} PSDrive. The provider handles the work.

"@ -f $cmdStyle,$reset,$highLight2,$highLight3,$italic

#Get-PSProvider
$p2 = @"
To view the the providers currently in use run this command:

$prompt {0}Get-PSProvider{1}
"@ -f $cmdStyle,$reset

$p3 = @"
You will see different providers depending on your operating system and depending on what modules
you have loaded that might add a provider. We'll look at {0}Drives{1} in a moment.

Not all providers work the same way, so even though a cmdlet might have a parameter to support a
feature, if you use the cmdlet in a PSDrive that doesn't support the feature, the cmdlet will fail.

The {2}ShouldProcess{1} capability refers to supporting the {3}-WhatIf{1} parameter. Although,
don't be afraid to try using it. In Windows, the {4}WSMan{1} provider looks like it doesn't support
{2}ShouldProcess{1}, yet commands like this:

{5}Set-Item{1} {3}-path{1} {6}WSMan:\localhost\Client\AllowUnencrypted{1} {3}-Value{1} {6}'false'{1} {3}-WhatIf{1}

Will actually work without error.

"@ -f $highLight3,$reset,$highLight2,$paramStyle,$highLight,$cmdStyle,$stringStyle

$p4 = @"
The {0}Filter{1} capability refers to a specific filtering technique used in .NET. This is usually
exposed through the {2}-Filter{1} parameter you will see in some cmdlets. The format of the parameter
value will vary depending on the provider and cmdlet. The help should document its use.

If the provider doesn't support {0}Filter{1}, this just means that the {2}-Filter{1} parameter probably
won't work. However, many cmdlets have other parameters that can provide "filtering" functionality
such as {2}-Name{1},{2}-Include{1}, and {2}-Exclude{1}.

You shouldn't need to run {3}Get-PSProvider{1} very often except for troubleshooting or curiosity.

"@ -f $highLight2,$reset,$paramStyle,$cmdStyle

#Get-PSDrive
$p5 = @"
{3}PSDrives{2}

Each provider will create one or more {0}PSDrives{2}. Each drive is an interface to the underlying
technology. PowerShell will create a number of PSDrives automatically when you start a new
PowerShell session. You can use {1}Get-PSDrive{2} to discover the PSDrives defined in your current
session.

$prompt {1}Get-PSDrive{2}
"@ -f $highlight2,$cmdStyle,$reset,$highLight3

$p6 = @"

You should automatically have a PSDrive for every logical drive as seen by the operating system,
such as C:\ on Windows or \ on Linux. Although, as you'll see, the {0}FileSystem{1} PSDrives you
see here are independent of the operating system.

"@ -f $highLight,$reset

#other providers
$p7 = @"
The non-filesystem drives are often of most interest to PowerShell beginners.

$prompt {2}Get-PSDrive{1} {3}|{1} {2}Where-Object{1} {3}{{{1}{5}`$_.Provider.Name{1} {3}-ne{1} {4}'FileSystem'{1}{3}}}{1}
"@ -f $highLight,$reset,$cmdStyle,$operatorStyle,$stringStyle,$varStyle

$p8 = @"
You'll see different drives depending on your operating system, loaded modules, or drives that you
might have added.

"@

$p9 = @"
You can access these drives and possibly navigate them like a file system. Remember to use the
colon {6}:{1} after the PSDrive name.

$prompt {0}Get-ChildItem{1} {3}Alias:{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle,$highLight2

$p10 = @"
Many of these PSDrives are used by related cmdlets, which is what you should use.

$prompt {0}Get-Alias{1} {4}|{1} {0}Select-Object{1} {2}-first{1} {5}5{1}
"@ -f $cmdStyle,$reset,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

#New-PSdrive
$p11 = @"
You can create your own PSDrives to any location supported by a Provider, which you may sometimes
see referenced as a {2}PSProvider{1}. Use {0}New-PSDrive{1} to create the drive assignment. You are not
limited to using traditional drive letters. You can use any name you want, although you should avoid
names with spaces or non-alphanumeric characters.

$prompt {0}New-PSDrive{1} {3}-Name{1} {4}tmpHome{1} {3}-PSProvider{1} {4}FileSystem{1} {3}-Root{1} {5}`$home{1}
"@ -f $cmdStyle,$reset,$highLight2,$paramStyle,$stringStyle,$varStyle

$p12 = @"

It is important to note that the operating system won't see your PSDrive. If you create a PSDrive
called {3}W{1} in Windows, that maps to C:\Work, you {5}won't see{1} a {3}W{1} drive in Windows Explorer.
The exception would be persistent PSDrives mapped to a UNC root. ({4}Read the help for {0}New-PSDrive{1}.)
Likewise, if you add a new drive mapping in Windows, there's no guarantee a corresponding PSDrive
will automatically be created in your PowerShell session.

Once created, you can use this location like any other path. Once again, don't forget the colon.

$prompt {0}Get-ChildItem{1} {2}tmpHome:{1} {7}|{1} {0}Select-Object{1} {6}-first{1} {8}3{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$italic,$warnStyle,$paramStyle,$operatorStyle,$numberStyle

#remove PSDrive
$p13 = @"
Any PSDrives that you create will only {4}last for the duration of your PowerShell session.{1} The
next time you start PowerShell, the drive won't be defined. If you have PSDrives that you want to
have every time you start PowerShell, put the {0}New-PSDrive{1} command in your PowerShell profile
script.

An exception to this is on Windows when you map a network drive (UNC) as a {5}persistent{1} drive.
Read the help for {0}New-PSDrive{1} to learn more.

If you want to remove a PSDrive from your session, use {0}Remove-PSDrive{1}. In this situation,
reference the drive name {6}without{1} the colon. As with adding a PSDrive, removing a PSDrive
is completely independent of the operating system.

$prompt {0}Remove-PSDrive{1} {2}-name{1} {3}tmpHome{1}

"@ -f $cmdStyle,$reset,$paramStyle,$stringStyle,$warnStyle,$highLight2,$italic

#dynamic parameters
$p14 = @"
There is one other feature of PSProviders and PSDrives that you will want to take advantage of.
You now know that you can use a cmdlet like {0}Get-ChildItem{1} with different PSDrives. Some cmdlets
are designed with {2}{3}dynamic parameters{1}. These are parameters that are often provider-aware. That is,
the parameter only works with a given PSProvider. Where this can get confusing is that the help may
show the parameter, but it only works in a specific situation.

Here's an example. {0}Get-ChildItem{1} has a {4}-File{1} parameter.

$prompt {0}Get-ChildItem{1} {5}`$pshome{1} {4}-file{1} {6}|{1} {0}Select-Object{1} {4}-first{1} {7}1{1}
"@ -f $cmdStyle,$reset,$italic,$highLight2,$paramStyle,$varStyle,$operatorStyle,$numberStyle

$p15 = @"

However the {2}-File{1} parameter is only available when using a location supported by the FileSystem
PSProvider. Otherwise, you will most likely get an error.

$prompt {0}Get-ChildItem{1} {2}Function:{1} {3}-file{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$p16 = @"
This is why it is very important that you take the time to read the full help and examples for
PowerShell commands.

"@

$p17 = @"
You can learn more about providers in general by running {0}Get-Help{1} {2}about_providers{1}. You
can also get details about a specific provider from a corresponding about topic.

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