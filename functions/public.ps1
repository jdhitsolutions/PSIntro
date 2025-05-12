Function Start-PSTutorial {
    [cmdletbinding()]
    [OutputType('None')]
    Param( )

    $list = @"
    $($PSStyle.Underline+$PSStyle.Foreground.Green)Tutorial Menu$($PSStyle.Reset)

    1 - Get-Command
    2 - Get-Help
    3 - Get-Member
    4 - Quit

"@

    $list
    [int]$r = Read-Host '    Select a menu option [1-4]'

    Switch ($r) {
        1 { &"$PSScriptRoot\..\tutorials\Invoke-GetCommandTutorial.ps1" }
        2 { &"$PSScriptRoot\..\tutorials\Invoke-GetHelpTutorial.ps1" }
        3 { &"$PSScriptRoot\..\tutorials\Invoke-GetMemberTutorial.ps1" }
    }
}

Function Get-PSIntro {
    [cmdletbinding()]
    [Alias('PSIntro','PSWelcome')]
    [OutputType('Object[]')]
    Param(
        [Parameter(HelpMessage = 'Do not show the tutorial prompt')]
        [switch]$NoTutorial
    )
    $modules = 'PSReadline', 'Microsoft.PowerShell.PSResourceGet'
    $j = @()
    foreach ($m in $modules) {
        $j += Start-ThreadJob {
            param($Name)
            $find = Find-Module $Name
            $local = Get-Module $Name -ListAvailable |
            Sort-Object -Property Version |
            Select-Object -Last 1 -ExpandProperty Version

            [PSCustomObject]@{
                Name         = $Name
                Online       = $find.version
                Installed    = $local
                UpdateNeeded = $find.version -gt $local
            }
        } -ArgumentList $m
    }
    #get module status from thread jobs started on module import
    $ModuleStatus = $j | Wait-Job | Receive-Job -Wait

    Clear-Host

    $linkStyle = $PSStyle.Underline + $PSStyle.Italic + $PSStyle.Foreground.BrightYellow
    $title = "PowerShell v$($PSVersionTable.PSVersion)"
    $Text = @(
        "PowerShell Documentation  : $($linkStyle)https://learn.microsoft.com/powershell$($PSStyle.Reset)",
        "PowerShell on Slack       : $($linkStyle)https//aka.ms/psslack$($PSStyle.Reset)",
        "PowerShell on Discord     : $($linkStyle)https://aka.ms/psdiscord$($PSStyle.Reset)"
        "PowerShell Team Blog      : $($linkStyle)https://devblogs.microsoft.com/powershell$($PSStyle.Reset)",
        "GitHub Discussion         : $($linkStyle)https://github.com/PowerShell/PowerShell/discussions$($PSStyle.Reset)"
    )

    $head = Format-BorderBox -Text $Text -Title $title -BorderColor $PSStyle.Foreground.BrightGreen
    $intro = @"

$($PSStyle.Bold)Welcome to PowerShell!$($reset)
$head

  Use any of the links above to get started learning more about PowerShell.
  When you can, you should run $($cmdStyle)$($PSStyle.FormatHyperlink('Update-Help','https://learn.microsoft.com/powershell/module/microsoft.powershell.core/update-help?view=powershell
-7.5&WT.mc_id=ps-gethelp'))$($reset) to get the latest help files for PowerShell.

"@

    $intro

    '{0}{1}{2}' -f $cmdStyle, 'Key module status:', $reset
    #create a custom formatted table
    $ModuleStatus | Format-Table Name, @{Name = 'Online'; Expression = { $_.Online }; align = 'right' },
    @{Name = 'Installed'; Expression = { $_.Installed }; align = 'right' },
    @{Name = 'UpdateNeeded'; Expression = {
            If ($_.UpdateNeeded) {
                "$($PSStyle.Foreground.BrightRed)$($_.UpdateNeeded)$($PSstyle.Reset)"
            }
            Else {
                $_.UpdateNeeded
            }
        }; align = 'center'
    }

    If ($ModuleStatus.UpdateNeeded -contains $True) {
        Write-Host "$($warnStyle)You may need to update or install the modules listed above.$($reset)"
    }
    Else {
        Write-Host "$($highLight2)All key modules are up to date.$($reset)"
    }

    If (-Not $NoTutorial) {
        $promptStyle
        $r = Read-Host -Prompt 'Would you like to run a short interactive tutorial? (Y/N)'
        $reset

        If ($r -ne 'y') {
            Write-Host "No problem. You can run $($cmdStyle)Start-PSTutorial$($reset) at any time.`n"
        }
        Else {
            &"$PSScriptRoot\..\tutorials\Invoke-GetCommandTutorial.ps1" -Full
        }
    }
}
