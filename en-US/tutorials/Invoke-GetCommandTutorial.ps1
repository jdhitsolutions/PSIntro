#an interactive tutorial for Get-Command

param(
    [switch]$Full,
    [switch]$Menu
)

#region setup
$script:tutorialParam = $PSBoundParameters

$cmd = 'Get-Command'

$title = "$($titleStyle)Getting Started with $cmd$reset"

#endregion

#region content
$Intro = @'

{0}Get-Command{2} is one of the fundamental PowerShell cmdlets. You can use this command to
discover PowerShell commands. These commands follow a Verb-Noun naming convention. The
verb is from a standard list of verbs which you can see by running the {0}Get-Verb{2} command.
The noun is the singular form of the thing you want to work with such as {1}Service{1} or {1}Process{2}.

'@ -f $cmdStyle, $highLight, $reset

$P1 = @'
Commands in PowerShell can be either functions or cmdlets. {0}Cmdlets{1} are compiled commands
based on .NET classes that are designed to be used in PowerShell. {0}Functions{1} are like
cmdlets, except that they are not compiled. Functions are written in PowerShell's scripting
language. Functions are run the same way as cmdlets. There is no execution difference between
the two, only in the way they are written.

'@ -f $highLight, $reset

$P2 = @"
Use {0}Get-Command{2} to find commands. Suppose you are looking for commands to manage processes.
You can use {0}Get-Command{2} to discover available commands using wildcards.

$prompt {0}Get-Command{2} {1}*process*{2}
"@ -f $cmdStyle, $defaultTokenStyle, $reset

$P3 = @"
You might also see {0}applications{1} which are programs found in %PATH%. You can limit your
search to PowerShell commands by specifying a command type.

$prompt {2}Get-Command{1} {4}-CommandType{1} {3}Function,Cmdlet{1}
"@ -f $highLight, $reset, $cmdStyle, $defaultTokenStyle, $paramStyle

$P4 = @'
In the output, you can see the command type and the name of the PowerShell command.

'@

$P5 = @'
Notice the {2}Verb-Noun{1} naming convention. The source is the name of the PowerShell {0}module{1} that
contains the command. A module is a package of related commands. Many modules are shipped with
PowerShell. Eventually, you will learn how to install additional modules from the PowerShell
Gallery.

The {0}Version{1} number is the module version number.

'@ -f $highLight, $reset, $highLight2

$P5a = @"
Once you narrow down the command you want, use {2}Get-Command{1} to show you the syntax or how
to run the command.

$prompt {2}Get-Command{1} {3}Get-Process{1} {4}-syntax{1}
"@ -f $highLight, $reset, $cmdStyle, $defaultTokenStyle, $paramStyle

$P6 = @'

The command syntax shows the command name, {2}Get-Process{1} followed by a set of {0}parameters{1}.
Each parameter name is indicated with a dash such as {3}-Name{1} and {3}-Id{1}. After each parameter is
an indication of what type of parameter value you need to specify.

To better understand the parameters, use {2}Get-Help{1} to learn more.

'@ -f $highLight, $reset, $cmdStyle, $paramStyle
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
        $P1
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P2
        (Get-Command *process* | Select-Object -First 10 | Out-Host) ; "$e[1A...`n" | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P3
        (Get-Command -CommandType Function, Cmdlet | Select-Object -First 10 | Out-Host) ; "$e[1A...`n" | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P4
        Pause $script:pg $pgCount
    },
    {
        $P5
         $script:pg++ ;Pause $script:pg $pgCount
    },
    {
        Clear-Host
        $P5a
        Get-Command Get-Process -Syntax | Out-Host
        $script:pg++ ; Pause $script:pg $pgCount
    },
    {
        $P6
        $script:pg++ ; Pause $script:pg $pgCount
    }
)

#keep a navigation page counter
$pgCount = 7
<#
There is an overlap in functionality between $i and $pg but they are
separate counters because there may be times I need to display a "page"
of information into two pages and want to maintain a page number.
#>
for ($script:i = 0; $script:i -lt $pages.count; $script:i++) {
    Invoke-Command -ScriptBlock $pages[$script:i]
}
#endregion

if ($full) {
    &$tutorials['Get-Help'] -Full
}
elseif ($menu) {
   Start-PSTutorial
}