#an interactive tutorial for Get-Member

Param(
    [switch]$Full
)

$cmd = 'Get-Member'
$title = "$($titleStyle)Getting Started with $cmd$reset"

$Intro = @"

The {0}$cmd{1} cmdlet is one that you will use often in PowerShell. You will get more out of
PowerShell if you understand how to use it. The command has an alias of {4}gm{1}.

One of the biggest challengers for PowerShell beginners is understanding that PowerShell works
with {3}objects{1} in a pipeline and not text. When you run a command in PowerShell it returns an
object, usually formatted to make it easier to read.

$prompt {0}Get-Process{1} {2}pwsh{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$highLight,$highLight2

$P1 = @"

The {0}Get-Process{1} cmdlet is writing an object that represents a process to the PowerShell
pipeline. {3}Don't assume that the column headings are the properties of an object{1}. Many
PowerShell commands are designed to provide information in an easy to read format. More than
likely, there is more to the object than what you see on the screen.

That's where {0}Get-Member{1} comes in. You can pipe the output of a command to Get-Member and
PowerShell will display the properties {4}members{1}. These are the features that describe an
object.
"@ -f $cmdStyle,$reset,$defaultTokenStyle,$warnStyle,$highlight

$P2 = @"

Native .NET objects will have {0}properties{1} and {0}methods{1}. A property is a feature that describes
the object such as Name and ProcessID. A method is a programmatic action that you can take
using the object such as Kill. Don't worry about methods now. Typically, you should be able
to find a PowerShell command that implements the method for you.

PowerShell will also expand an object with additional members:

  {2}AliasProperty{1} - an alternate name for another property.
  {2}NoteProperty{1} - a static note or comment about the object.
  {2}ScriptProperty{1} - a property where the value is derived from running PowerShell code.

You might also see {2}PropertySet{1} which is a collection of properties.
"@ -f $highLight,$reset,$highLight2

$P3 = @"

Now that you have a basic understanding of how an object will be described, let's run
Get-Member.

$prompt {0}Get-Process{1} {2}pwsh{1} | {0}Get-Member{1}
"@ -f $cmdStyle,$reset,$defaultTokenStyle

$P4 = @"

   TypeName: System.Diagnostics.Process

{3}Name    MemberType    Definition{2}
{3}----    ----------    ----------{2}
Handles AliasProperty Handles = Handlecount
Name    AliasProperty Name = ProcessName
NPM     AliasProperty NPM = NonpagedSystemMemorySize64
...

At the top of the output from {0}Get-Member{2} you will see the {1}TypeName{2}. This is the object
type. The {0}Get-Process{2} cmdlet writes {1}System.Diagnostics.Process{2} objects to the pipeline.
You can also see the {4}Alias{2} properties. This means that when you need to reference one of
these properties you can use the alias name, i.e. Handles, or the definition, i.e. HandleCount.
"@ -f $cmdStyle,$highLight,$reset,$table,$highLight2

$P5 = @"

Scrolling down you will see process object methods.

Dispose                   Method     void Dispose(), void IDisposable.Dispose()
Equals                    Method     bool Equals(System.Object obj)
GetHashCode               Method     int GetHashCode()
GetLifetimeService        Method     System.Object GetLifetimeService()
GetType                   Method     type GetType()
InitializeLifetimeService Method     System.Object InitializeLifetimeService()
Kill                      Method     void Kill(), void Kill(bool entireProcessTree)
...

The value in the definition such as {0}void{1}, {0}bool{1}, and {0}int{1} indicate what type of object
the method will return. The {0}void{1} type means that the method does not return a value. You
shouldn't have to worry about an object's methods now.
"@ -f $highLight,$reset,$cmdStyle,$defaultTokenStyle

$P6 = @"

What will matter to you are the properties.

HandleCount         Property   int HandleCount {{get;}}
HasExited           Property   bool HasExited {{get;}}
Id                  Property   int Id {{get;}}
MachineName         Property   string MachineName {{get;}}
MainModule          Property   System.Diagnostics.ProcessModule MainModule {{get;}}
MainWindowHandle    Property   System.IntPtr MainWindowHandle {{get;}}
MainWindowTitle     Property   string MainWindowTitle {{get;}}
MaxWorkingSet       Property   System.IntPtr MaxWorkingSet {{get;set;}}
...

The value in the definition such as {0}string{1}, {0}bool{1}, and {0}int{1}, indicate the type of the property
value. The values {2}get{1} and {2}set{1} indicate if the property is read-only, i.e. {2}get{1}, or if it can
be modified, i.e. {2}set{1}. Don't focus on getting and setting properties. PowerShell commands will
handle those tasks for you.
"@ -f $highLight,$reset,$highLight3

$P7 = @"

You will also see {0}ScriptProperty{1} members.

CommandLine                ScriptProperty System.Object CommandLine {{get=…
Company                    ScriptProperty System.Object Company {{get=`$this.Mainmodule.FileVersion…
CPU                        ScriptProperty System.Object CPU {{get=`$this.TotalProcessorTime.TotalSe…
Description                ScriptProperty System.Object Description {{get=`$this.Mainmodule.FileVer…

These are properties that are derived from running PowerShell code. You can use these properties
the same way as other properties.

You can ask {2}Get-Member{1} to show you selected member types using the {3}MemberType{1} parameter.

$prompt {2}Get-Process{1} {4}pwsh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}ScriptProperty{1}
"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle

$P8 = @"

If you want to see {0}all{1} property types, pipe command to {2}Get-Member{1} like this:

{2}Get-Process{1} {4}pwsh{1} | {2}Get-Member{1} {3}-MemberType{1} {4}Properties{1}

Once you've identified the properties you want to use, you can use them in PowerShell:

$prompt {2}Get-Process{1} | {2}Where-Object{1} {4}WS{1} {5}-gt{1} {6}10mb{1} |
>> {2}Sort-Object{1} WS {3}-Descending{1} | {2}Select-Object{1} {4}ID,Handles,WS,Name,StartTime{1} {3}-first{1} {6}5{1} |
>> {2}Format-Table{1}
>>
"@ -f $highLight,$reset,$cmdStyle,$paramStyle,$defaultTokenStyle,$operatorStyle,$numberStyle

$P9 = @"

PowerShell is all about objects. {0}Get-Member{1} is the best way to discover what an object looks like
so that you can use it with PowerShell commands and take advantage of the PowerShell pipeline.

For more information, read the help for {0}Get-Member{1} and look at the examples.
"@ -f $cmdStyle,$reset
#run the tutorial
Clear-Host
$title
$Intro
Get-Process pwsh | Out-Host
pause
$P1
pause
$P2
pause
Clear-Host
$P3
pause
$P4
pause
$P5
pause
Clear-Host
$P6
pause
Clear-Host
$P7
pause
Get-Process -id $pid | Get-Member -MemberType ScriptProperty | Out-Host
pause
Clear-Host
$P8
pause
Get-Process | Where-Object WS -gt 10mb | Sort-Object WS -Descending |
Select-Object ID,Handles,WS,Name,StartTime -first 5 | Format-Table |Out-Host
pause
$P9

if ($Full) {
  #this is the last lesson in the set. No action needed.
}
else {
    Start-PSTutorial
}