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
$title = "$($titleStyle)Essential PowerShell Fundamentals$($reset)"

$intro = @"

To get started with PowerShell, there are a few essential concepts and terms that you should
understand. You don't need to master PowerShell before you begin using it, but you need to
have a basic understanding of how it works so you know what to expect.

"@

$P1 = @"
{0}What is PowerShell?{1}

PowerShell consists of two main components: the {2}shell{1} and the {2}scripting language{1}. The shell
is the interactive command line interface where you can run commands and scripts. The scripting
language is the language that you use to write scripts and automate tasks. The same commands
and language are used in both. In other words, if you can run a command in the shell, you can
also use it in a script.

PowerShell is built on the .NET framework and takes an {3}object{1} approach. Everything you work
with in PowerShell is an object, not text. However, you do not need to be a .NET developer to use
PowerShell.

"@ -f $highLight3, $reset,$highLight,$highLight2

$P2 = @"
PowerShell commands are called {3}cmdlets{1}. A cmdlet is a lightweight command that is used to
perform a specific task. PowerShell commands follow a verb-noun naming convention, which makes
them easy to find and use. It should be clear what the {0}Get-Process{1} command does.

$prompt {0}Get-Process{1} {2}pwsh{1}
"@ -f $cmdStyle, $reset,$defaultTokenStyle,$highLight

$P3 = @"
The output of a PowerShell command is technically an object, but it is formatted to make it
easier to read.

"@

$P4 = @"

{0}Aliases{1}

PowerShell has a concept of aliases. An alias is a short name for a cmdlet. They are intended
to save you time when typing commands or to provide a transition for users of other shells.

$prompt {2}dir{1} {3}$root{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle

$P5 = @"

However, you are not running the native {3}dir{1} command. You are running an alias for the
native PowerShell command {0}Get-ChildItem.{1} Running this command is the same as using the alias.

$prompt {0}Get-ChildItem{1} {2}$root{1}

"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight

$P6 = @"

This means you must use parameters for the PowerShell command with the alias.

$prompt {0}dir{1} {2}`$home{1} {3}-Directory -Hidden{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$paramStyle

$P7 = @"
You can use the {0}Get-Alias{1} cmdlet to discover defined aliases in PowerShell.

"@ -f $cmdStyle,$reset,$highLight

$P8 = @"
{0}The Pipeline{1}

The PowerShell paradigm is based on the concept of objects passing through a {6}pipeline{1}. The
pipeline is indicated with the | symbol.

Think of the pipeline as a conveyor belt where objects are passed from one command to another. Each
command in the pipeline performs a specific task on the object and then passes it to the following
command. This allows you to build complex commands and scripts by combining simple commands.

$prompt {2}Get-Process{1} | {2}Sort-Object{1} {3}WorkingSet{1} {4}-Descending{1} | {2}Select-Object{1} {4}-first {5}5{1}

"@ -f $highLight3, $reset,$cmdStyle,$defaultTokenStyle,$paramStyle,$numberStyle,$highlight

$P9 =@"
The first command is getting all processes on the local computer. The output of this command
is a collection of process objects. The second command is sorting the collection of process
objects by the WorkingSet property in descending order.

You will learn how to discover object properties with {0}Get-Member{1}.

The sorted process objects are then passed to the third command, {0}Select-Object{1}, which selects
the first five objects. PowerShell displays the output of the last command in the pipeline.

If you want to perform this task frequently, you can put the commands in a script file. The
output is the same as if you had run the commands interactively in the shell, without having
to retype the command.

"@ -f $cmdStyle,$reset

$P10 = @"
{0}Variables{1}

Like many scripting and shell languages, PowerShell understands variables. A variable holds
a value, such as a string of text or a number. Use the {2}`${1} character to define a variable.

$prompt {3}`$i{1} = {4}123{1}
$prompt {3}`$n{1} = {5}"pw*"{1}

"@ -f $highLight3, $reset,$highLight,$varStyle,$numberStyle,$stringStyle

$P11 = @"
You can also save the output of a PowerShell command or expression to a variable.

$prompt {3}`$files{1} {2}={1} {0}Get-ChildItem{1} {3}-Path{1} {4}`$HOME{1} {3}-file{1} | {0}Sort-Object{1} {3}-Property{1} {6}LastWriteTime{1} | {0}Select-Object{1} {3}-first{1} {5}5{1}

"@ -f $cmdStyle,$reset,$operatorStyle,$paramStyle,$varStyle,$numberStyle,$defaultTokenStyle

$P12 = @"
When you want to use a variable, you can reference it by its name with the `$ character.

$prompt {0}`$i{2}*{1}2{2}
"@ -f $varStyle,$numberStyle,$reset

$P13 = @"
$prompt {0}Get-Process{1} {2}`$n{1}
"@ -f $cmdStyle,$reset,$varStyle

$P14 = @"

You can use the variable in a pipelined expression.

$prompt {0}`$files{1} | {2}Group-Object{1} {3}-property{1} {4}Extension{1} | {2}Sort-Object{0} {4}Count{1} {3}-Descending{1}
"@ -f $varStyle,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P15 = @"
Note that objects can change in the pipeline based on the command. The {2}`$files{1} variable contains
file objects. The {0}Group-Object{1} command creates a new object type with different properties. These
objects are then piped to the {0}Sort-Object{1} command.

Can you guess what command you would run to get all PowerShell variables?

"@ -f $cmdStyle,$reset,$highLight

$P16 = @"
$Prompt {0}Get-Variable{1}
"@ -f $cmdStyle,$reset

$P17 = @"
PowerShell has many built-in variables that you can use.

$prompt {0}`$PSEdition{1}
"@ -f $varStyle,$reset

$P17a = @"
$prompt {0}`$PSVersionTable{1}
"@ -f $varStyle,$reset
$P18 = @"

Once you complete the other tutorials, you should be able to begin running PowerShell commands
from the console.

"@

## Run the tutorial
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

if ($full) {
    &"$PSScriptRoot\..\tutorials\Invoke-GetCommandTutorial.ps1" -Full
}
elseif ($Menu) {
    Start-PSTutorial
}