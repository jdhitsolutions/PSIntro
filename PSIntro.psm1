
#Write-Host "Detected $([System.Threading.Thread]::CurrentThread.CurrentCulture) culture" -ForegroundColor Yellow

# 17 June 2025 - need to accommodate culture detection problems on non-Windows systems Issue #6
#30 Dec 2025 Detect culture from the current thread
$culture = If ([System.Threading.Thread]::CurrentThread.CurrentUICulture.name) {
   [System.Threading.Thread]::CurrentThread.CurrentUICulture.name
}
else {
    "en-US"
}

$baseDir = Join-Path -Path $PSScriptRoot -ChildPath $culture

#Write-Host "Imported strings from $baseDir" -ForegroundColor yellow
#Write-Host "Detected culture: $culture" -ForegroundColor Yellow
#need to account for InvariantCulture on non-Windows systems
Import-LocalizedData -BindingVariable strings -BaseDirectory $baseDir -UICulture (Get-Culture).Name -FileName PSIntro.psd1

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {. $_.FullName }

#Define style settings used in the tutorials using
#the values defined by the PSReadline module
# 30 Dec 2025 begin revisions to support this module on Windows PowerShell
$e = [char]27
$bel = [char]7
$reset = "$e[0m" # $PSStyle.Reset
$cmdStyle = (Get-PSReadLineOption).CommandColor
$defaultTokenStyle = (Get-PSReadLineOption).DefaultTokenColor
$stringStyle = (Get-PSReadLineOption).StringColor
$varStyle = (Get-PSReadLineOption).VariableColor
$operatorStyle = (Get-PSReadLineOption).OperatorColor
$numberStyle = (Get-PSReadLineOption).NumberColor
$paramStyle = (Get-PSReadLineOption).ParameterColor
$titleStyle = "$e[1;4;92m" #$PSStyle.Foreground.BrightGreen + $PSStyle.Bold + $PSStyle.Underline
$highLight = "$e[1;3;92m"  #$PSStyle.Foreground.Green + $PSStyle.Bold + $PSStyle.Italic
$highLight2 = "$e[96m" #$PSStyle.Foreground.BrightCyan
$highLight3 = "$e[1;93m"  #$PSStyle.Foreground.BrightYellow + $PSStyle.Bold
$warnStyle = "$e[3;91m"  #$PSStyle.Foreground.BrightRed + $PSStyle.Italic
$promptStyle = "$e[38;5;225m"
$table = "$e[1;32m" #$PSStyle.Formatting.TableHeader
$welcomeStyle= "$e[1;3;38;5;13m"
$underLine = "$e[4m"
$italic = "$e[3m"

#capture the user's prompt text. This will be use in the tutorials
#to simulate a PowerShell session and command

#validate a prompt is captured, otherwise use a default
$prompt = ((&prompt | Out-String) -replace "`n|`r", '').Trim()
if ($prompt.Length -eq 0) {
    if ($IsWindows) {
        $prompt = "PS C:\> "
    }
    else {
        $prompt = "PS /home/$([Environment]::UserName)>"
    }
}

#determine the tutorial path
$tutorialPath = Join-Path -Path $PSScriptRoot -ChildPath (Join-Path -path $culture -ChildPath 'tutorials')
if (-Not (Test-Path -Path $tutorialPath)) {
    #use the en-US tutorials if the localized path does not exist
    $tutorialPath = Join-Path -Path $PSScriptRoot -ChildPath 'en-US\tutorials'
}

#define a hashtable of tutorials
$tutorials = @{
    'PowerShell Essentials' = Join-Path -Path $tutorialPath -ChildPath 'Invoke-PSBasicsTutorial.ps1'
    'Get-Command'           = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetCommandTutorial.ps1'
    'Get-Help'              = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetHelpTutorial.ps1'
    'Get-Member'            = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetMemberTutorial.ps1'
    'PowerShell Profiles'   = Join-Path -Path $tutorialPath -ChildPath 'Invoke-PSProfileTutorial.ps1'
    'PSDrives'              = Join-Path -Path $tutorialPath -ChildPath 'Invoke-PSDriveTutorial.ps1'
}

#get module version for use in Verbose messaging
$modVersion = (Import-PowerShellDataFile -Path "$PSScriptRoot\PSIntro.psd1").ModuleVersion