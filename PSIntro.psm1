#Write-Host "Detected $((Get-Culture).name)" -ForegroundColor Yellow

# 17 June 2025 - need to accommodate culture detection problems on non-Windows systems Issue #6
$culture = $PSUICulture ? $PSUICulture : "en-US"
$baseDir = Join-Path -Path $PSScriptRoot -ChildPath $culture

#Write-Host "Imported strings from $baseDir" -ForegroundColor yellow
#Write-Host "Detected culture: $culture" -ForegroundColor Yellow
#need to account for InvariantCulture on non-Windows systems
Import-LocalizedData -BindingVariable strings -BaseDirectory $baseDir -UICulture (Get-Culture).Name -FileName PSIntro.psd1

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {. $_.FullName }

#Define style settings used in the tutorials using
#the values defined by the PSReadline module
$reset = $PSStyle.Reset
$cmdStyle = (Get-PSReadLineOption).CommandColor
$defaultTokenStyle = (Get-PSReadLineOption).DefaultTokenColor
$stringStyle = (Get-PSReadLineOption).StringColor
$varStyle = (Get-PSReadLineOption).VariableColor
$operatorStyle = (Get-PSReadLineOption).OperatorColor
$numberStyle = (Get-PSReadLineOption).NumberColor
$paramStyle = (Get-PSReadLineOption).ParameterColor
$titleStyle = $PSStyle.Foreground.BrightGreen + $PSStyle.Bold + $PSStyle.Underline
$highLight = $PSStyle.Foreground.Green + $PSStyle.Bold + $PSStyle.Italic
$highLight2 = $PSStyle.Foreground.BrightCyan
$highLight3 = $PSStyle.Foreground.BrightYellow + $PSStyle.Bold
$warnStyle = $PSStyle.Foreground.BrightRed + $PSStyle.Italic
$promptStyle = "`e[38;5;225m"
$table = $PSStyle.Formatting.TableHeader
$welcomeStyle= "`e[1;3;38;5;13m"

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
    $tutorialPath = Join-Path -Path $PSScriptRoot -ChildPath 'en-us\tutorials'
}

#define a hashtable of tutorials
$Tutorials = @{
    'PowerShell Essentials' = Join-Path -Path $tutorialPath -ChildPath 'Invoke-PSBasicsTutorial.ps1'
    'Get-Command'           = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetCommandTutorial.ps1'
    'Get-Help'              = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetHelpTutorial.ps1'
    'Get-Member'            = Join-Path -Path $tutorialPath -ChildPath 'Invoke-GetMemberTutorial.ps1'
}

#get module version for use in Verbose messaging
$modVersion = (Import-PowerShellDataFile -Path "$PSScriptRoot\PSIntro.psd1").ModuleVersion