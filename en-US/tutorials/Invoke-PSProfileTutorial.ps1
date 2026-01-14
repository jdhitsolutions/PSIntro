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

A common PowerShell topic you will read about, and hear people discuss, is the use of a PowerShell
{0}profile script{1}. This is a special type of script file that is used to configure your PowerShell
session.

Do you always want to have a certain variable, or a new PSDrive defined every time you start
PowerShell? Instead of manually running the commands every time you start a new PowerShell session,
you can put them in a PowerShell profile script and they will run automatically when you start
a PowerShell session.

However, there is actually a hierarchy of PowerShell profile scripts that PowerShell beginners
find confusing. And on Windows platforms, there is another potential obstacle you might encounter.

"@ -f $highLight, $reset

#what is a profile script
$p1 = @"
A PowerShell profile script is a like any other script. It is a text file with a {5}.ps1{3} file extension.
The contents of the script file are the same commands you can run interactively.

For example you could run this line in a PowerShell session to define a variable.

$prompt {0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

You could take the same command:

{0}`$CustomVar{3}{1} ={3} {2}'foo789'{3}

and insert it into a PowerShell profile script. Because PowerShell profile scripts run {4}automatically{3}
when you start a new PowerShell session, this variable would be defined in your session.

$prompt {0}`$CustomVar{3}
foo789

"@ -f $varStyle, $operatorStyle, $stringStyle, $reset, $highLight3, $highLight2

#powershell versions
$p2 = @"

On Windows platforms it is possible to run Windows PowerShell and PowerShell 7 side-by-side. Each version
has {0}its own set{1} of profile scripts. This means that by default a configuration made for Windows
PowerShell will {2}not{1} be used in PowerShell 7.

Non-Windows platforms can only run PowerShell 7 so this isn't an issue on those systems.

"@ -f $highLight, $reset, $warnStyle

#hosting
$p3 = @"
Before getting into the technical details, you need to understand an often overlooked aspect of PowerShell.
We tend to think of the commands and code that make up PowerShell as a {0}management engine{1}. Like a car
engine, it is of no use by itself. It must be part of a larger construct. In the automotive world we would
place the engine in a car or truck. In PowerShell, the engine must be {2}hosted{1} in an application.

This is referred to as the {3}hosting application{1} or host.

You can view the application hosting your PowerShell session by running {4}Get-Host{1}.

$prompt {4}Get-Host{1}
"@ -f $highLight2, $reset, $highLight3, $highlight, $cmdStyle

$p4 = @"
Or you can use the built-in {0}`$host{1} variable.

$prompt {0}`$host{1}

"@ -f $varStyle, $reset

#other apps like VSCode
$p5 = @"
You will spend most of your time in the ConsoleHost. Think of this is the standard or default
PowerShell experience. However, other applications can also host PowerShell. When you are in a
remote PowerShell session using the WSMan protocol, that is yet another hosting application.

Two common examples of other hosts that you are likely to come across are the PowerShell ISE and
the integrated terminal in Visual Studio Code. You can verify this by running {2}Get-Host{1} or simply
showing the host name.

The following example is what you would see in Visual Studio Code.

$prompt {3}`$host.name{1}
Visual Studio Code Host

It is important that you understand the concept of a hosting application as there is {4}no guarantee
that all PowerShell features are supported in all hosts{1}.

"@ -f $italic, $reset, $cmdStyle, $varStyle, $warnStyle

#scope
$p6 = @"
So far we've looked at PowerShell version and host. There is one more PowerShell attribute that affects
profile scripts and that is {0}scope{1}. Think of this as a sphere of influence.

When it comes to profile scripts we have two scopes. There is a scope for {2}AllUsers{1} and one for the
{3}CurrentUser{1}.

The {2}AllUsers{1} scope applies to any PowerShell user. This scope is applied at the system level, typically
where the PowerShell executable files are found. You need to have elevated privileges to manage things at
this level.

The {3}CurrentUser{1} is typically you. This scope is based in your desktop profile which means you don't need any
special privileges.

"@ -f $highLight, $reset, $highLight2, $highLight3

#$profile

$p7 = @"
Even though PowerShell profile scripts are .ps1 files, the paths are {0}hard-coded{1} and {2}cannot be changed.{1}
When you start a PowerShell session, PowerShell looks for the profile scripts and automatically runs them.

You can use the built-in {3}`$profile{1} variable to view the location.

$prompt {3}`$profile{1}
"@ -f $highLight3, $reset, $warnStyle, $varStyle

$p8 = @"
You should notice that the path refers to your user profile. It is important to note that this file {0}does not
exist by default{1}. It is also possible that some parts of the path do not exist.

"@ -f $warnStyle, $reset

$p9 = @"
The {0}`profile{1} variable is little more complicated than it appears. There are additional properties
that reflect the scoped profile scripts.

$prompt {0}`$profile{1} {3}|{1} {2}Select-Object{1} {4}*host*{1} {3}|{1} {2}Format-List{1}
"@ -f $varStyle, $reset, $cmdStyle, $defaultTokenStyle, $stringStyle

$p10 = @"

Technically, there are {5}four{0} PowerShell profile scripts. You can see them listed here with their hard-code
paths. {6}None of these profile scripts exist by default.{0}

For any scripts that are detected, PowerShell will run them in this order moving from the widest scope to
the most narrow. Remember, the {1}host{0} is the hosting application such as the {2}ConsoleHost{0} or {3}Visual Studio Code Host{0}.

If you are using multiple profile scripts, the effect is {4}cumulative{0}.

"@ -f $reset, $highLight, $highLight2, $highLight3, $underLine, $italic, $warnStyle

#checking status
$p11 = @"
The {1}PSIntro{0} module includes a command you can run to easily see if any PowerShell profile scripts exist.
Locations without a script file should be displayed in red.

$prompt {2}Get-ProfileStatus{0}

"@ -f $reset, $highLight2, $cmdStyle

#creating a profile script

$p12 = @"
You can manually create any of the PowerShell profile scripts using the specific path and file name. On
non-Windows machines watch your casing. Or you can use PowerShell and the {1}`$profile{0} variable. You can
reference the different profile scripts as object properties. Use the {2}New-Item{0} command to create the file.

The example is using the {3}-WhatIf{0} parameter to show what PowerShell would have done without actually creating
the file. Use {3}-Force{0} to create any missing parts of the path.

$prompt {2}New-Item{0} {3}-path{0} {4}`$profile.CurrentUserCurrentHost{0} {3}-Force -WhatIf{0}
"@ -f $reset, $varStyle, $cmdStyle, $paramStyle, $varStyle

#common profile entries
#psdrives
#variables
#pre-loading modules
#custom functions
$p13 = @"
Once the script has been created it, edit it using your preferred code editor. For the most part, use
PowerShell commands that will run without any user intervention. The scripts run automatically {1}under your
user context{0} when you launch PowerShell so it is important that you keep them secure. Code signing is
outside the scope of this tutorial but is something you might want to consider for your profile scripts.

Enter commands in your profile script that are appropriate for the PowerShell version and host. Commands
in your script are executed from beginning to end.

You might want to define a variable you will use often:

{2}`$zip = 68106{0}

You might define a PSDrive:

{2}New-PSDrive -Name W -PSProvider FileSystem -Root c:\work{0}

Even though PowerShell will automatically load modules, you might want to pre-load them in your profile:

{2}Import-Module Microsoft.PowerShell.PSResourceGet{0}

Or maybe you want to define a custom function:

{2}Function Get-SessionRunTime {{
    `$thisSession = Get-Process -id `$pid
    `$ts = New-TimeSpan -start `$thisSession.StartTime -end (Get-Date)
    `$ts.ToString()
}}{0}

You might also want to add command aliases

{2}Set-Alias -name rt -value Get-SessionRunTime{0}
{2}Set-Alias -name dt -value Get-Date{0}

"@ -f $reset, $highLight3, $stringStyle

#credentials - prompting is recommended but better off using Secrets Management
$p14 = @"
You might be tempted to enter credentials in your PowerShell profile script. But be careful.

{1}Never put plaintext passwords in a PowerShell script file{0}

You {2}could{0} use {3}Get-Credential{0} and prompt for a credential in your profile script:

{4}`$admin = Get-Credential company\administrator{0}

This will work, but you'll be prompted every time PowerShell starts with your profile. It is outside
the scope of this tutorial, but you should investigate how to use the {5}Microsoft.PowerShell.SecretManagement{0}
module from Microsoft. You can learn more by visiting:

https://learn.microsoft.com/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules

"@ -f $reset, $warnStyle, $italic, $cmdStyle, $stringStyle, $highLight2

#execution policy
$p15 = @"
On {5}Windows{0} systems, there is one other potential roadblock to using PowerShell profile scripts and that
is the {3}execution policy{0}. PowerShell's execution policy is designed to prevent the {4}unintended{0} execution
of a PowerShell script. One of the policies is {6}Restricted{0} which prevents PowerShell from running any script
file which includes PowerShell profile scripts.

Run {2}Get-ExecutionPolicy{0} to see your current setting.

$prompt {2}Get-ExecutionPolicy{0}
"@ -f $reset, $cmdStyle, $paramStyle, $highLight3, $highLight, $highLight2, $warnStyle

$p16 = @"
If the setting is set to {1}Restricted{0} you will need to modify it using {2}Set-ExecutionPolicy{0} to modify
it. The recommended minimum setting is {4}RemoteSigned{0}.

$prompt {2}Set-ExecutionPolicy{0} {3}RemoteSigned{0}

You only need to set this once. Be aware that in corporate environments, this setting may be
controlled by Group Policy or otherwise restricted.

Read the help topic {3}about_Execution_Policies{0} to learn more:

$prompt {2}help{0} {3}about_Execution_Policies{0}

"@ -f $reset, $warnStyle, $cmdStyle, $stringStyle, $highLight3, $highLight2

#pwsh -noProfile
#help about_profiles
$p17 = @"
Because your PowerShell profile script could make major changes to your session, or if you need to
troubleshoot PowerShell, there may be situations where you want to start a clean PowerShell session
without loading your profile. You can use parameters for the PowerShell executable to launch a new
session without a profile:

$prompt {1}$psh{0} {2}-NoProfile{0}

To see other available parameter and help run:

$prompt {1}$psh{0} {2}-?{0}

"@ -f $reset, $cmdStyle, $paramStyle

$p18 = @"

To learn even more about PowerShell profiles, read the help:

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
