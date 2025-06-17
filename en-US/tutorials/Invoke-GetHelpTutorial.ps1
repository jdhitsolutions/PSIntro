#an interactive tutorial for Get-Help

Param(
    [switch]$Full,
    [switch]$Menu
)

$cmd = 'Get-Help'
$title = "$($titleStyle)Getting Started with $cmd$reset"

#region content
$Intro = @"

{0}$cmd{1} is another of the basic PowerShell cmdlets you need to understand how to use. You
will be using this command constantly. You should refer to the help often. Each new release
of PowerShell might introduce new commands, new parameters, new help examples as well as
correcting errors in documentation.

Out of the box, PowerShell ships with a subset of help documentation. Microsoft will also
periodically update help documentation, although there is no notification mechanism. After
every PowerShell update and periodically, you should run {0}Update-Help{1}.

$prompt {0}Update-Help{1}

A few errors are to be expected.
"@ -f $cmdStyle, $reset

$P1 = @"

While learning PowerShell, don't try to memorize how to use a PowerShell command. Instead,
learn to {2}discover{1} how to use it. You can use the {0}$cmd{1} cmdlet or helper function, {2}help{1},
which provides the same information as the cmdlet, but with paged output.

$prompt {3}help{1} {4}Get-Process{1}

"@ -f $cmdStyle,$reset,$highLight,$cmdStyle,$defaultTokenStyle

$P2 = @"

The output headings should be self-explanatory. You can see the command {0}name{1}.

NAME
    Get-Process

"@ -f $highLight,$reset

$P3 = @"
A brief {0}synopsis{1} or explanation about what the command does.

SYNOPSIS
    Gets the processes that are running on the local computer.

"@ -f $highLight,$reset

$P4 = @"
The command {0}syntax{1}, which is the same thing you can see with {2}Get-Command{1}.

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
And a more detailed {0}description{1}.

DESCRIPTION
    The `Get-Process` cmdlet gets the processes on a local computer.
    ...

"@ -f $highLight,$reset

$P6 = @"

Most command help will also include one or more examples. If you want to see only the examples
you can run:

$prompt {3}help{1} {4}Get-Process{1} {5}-examples{1}

NAME
    Get-Process

SYNOPSIS
    Gets the processes that are running on the local computer.

    {2}Example 1: Get a list of all active processes on the local computer{1}

    Get-Process

    This command gets a list of all active processes running on the local computer.
    For a definition of each column, see the Notes (#notes)section.

    {2}Example 2: Get all available data about one or more processes {1}

    Get-Process winword, explorer | Format-List *

"@ -f $cmdStyle,$reset,$highLight2,$cmdStyle,$defaultTokenStyle,$paramStyle

$P7 = @"

Finally, you can always get the most up-to-date help by using the {0}-Online{1} parameter. If there
is an online link, it will open in your default browser. It is not a requirement, but the majority
of the commands you will be using support this help feature. The online link will be displayed
under RELATED LINKS:

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

It is very important that you understand how to interpret the help syntax.

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] -Id <System.Int32[]> [-Module] [<CommonParameters>]
    ...

Each combination of parameters is referred as a {0}parameter set{1}. You cannot mix and match
parameters between sets. For now, you can ignore CommonParameters.

"@ -f $highLight,$reset

$P9 = @"
Anything you see enclosed in [ ] is considered {0}optional{2}. This means that if you want to use
the {4}Id{2} parameter, you must specify it because it is not enclosed in [ ].

SYNTAX
    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]

    Get-Process [-FileVersionInfo] {1}-Id{2} <System.Int32[]> [-Module] [<CommonParameters>]
    ...

$prompt {3}Get-Process{2} {4}-Id{2} {5}`$PID{2}
"@ -f $highLight,$highLight3,$reset,$cmdStyle,$paramStyle,$varStyle

$P10 = @"

{0}`$PID{1} is an automatic variable whose value is the process ID for the current PowerShell session.

"@ -f $highLight,$reset

$P10a = @"
Looking at the syntax again, you can use the {1}Name{4} parameter without having to type it because
the parameter name is enclosed in [ ].

SYNTAX
    Get-Process [{2}[{4}-Name{2}]{4} <System.String[]>] [-FileVersionInfo] [-Module]
    [<CommonParameters>]

The syntax tells you that the entire {1}Name{4} parameter is optional, and if you want to use it,
you don't even need to use the parameter name. This is referred to as a {0}positional{4} parameter.

The text within the {2}< >{4} indicates what {0}type{4} of parameter value to use. System.String means
text. When you see {2}[]{4} as part of the type, this indicates the parameter will accept multiple values
separated by commas.

$prompt {3}Get-Process{4} {5}pwsh,sys*{4}
"@ -f $highLight,$highLight2,$highlight3,$cmdStyle,$reset,$defaultTokenStyle

$P11 = @"
You can always look at parameter detail in the help. You can specify parameter names using wildcards.

$prompt {0}help{3} {2}Get-Process{3} {1}-Parameter{3} {2}*name{3}
"@ -f $cmdStyle,$paramStyle,$defaultTokenStyle,$reset

$P12 = @"
Do you see how these parameters are defined as positional or named? The detail also indicates
if it is a required parameter. Compare this information to how it is displayed in the help.

    Get-Process [[-Name] <System.String[]>] [-FileVersionInfo] [-Module] [<CommonParameters>]
    Get-Process -Id <System.Int32[]> -IncludeUserName [<CommonParameters>]
    Get-Process [[-Name] <System.String[]>] -IncludeUserName [<CommonParameters>]
    Get-Process -IncludeUserName -InputObject <System.Diagnostics.Process[]> [<CommonParameters>]

If you wanted to see all PowerShell processes and those beginning with {0}sys{1} AND show the
user name, do you have an idea of what command you would type?

"@ -f $highLight2,$reset

$P13 = @"
$prompt {0}Get-Process{3} {1}pwsh,sys*{3} {2}-IncludeUsername{3}
"@ -f $cmdStyle,$defaultTokenStyle,$paramStyle,$reset

$P14 = @"

The more time you spend reading help, the easier it will become.

"@

$P15 = @"
One last help item you need to know are the {0}about{4} topics. These are help files about
PowerShell concepts and terminology. All of these topics begin with {1}about_{4}.

Use the {2}help{4} command to display them. Wildcards are allowed and PowerShell will tab complete
the topic name.

$prompt {2}help{4} {3}about_parameters{4}

Now, if you haven't done so in a while, go ahead run {2}Update-Help{4}.

"@ -f $highLight,$highLight2,$cmdStyle,$defaultTokenStyle,$reset
#endregion
#region run the tutorial
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
#endregion

if ($Full) {
    &$tutorials['Get-Member'] -Full
}
elseif ($menu) {
    Start-PSTutorial
}
