Function Get-PSIntro {
    [cmdletbinding()]
    [Alias('PSIntro','PSWelcome')]
    [OutputType('Object[]')]
    Param(
        [Parameter(HelpMessage = 'Include module status')]
        [switch]$ModuleStatus,
        [Parameter(HelpMessage = 'Show the tutorial prompt')]
        [switch]$Tutorial
    )

    Clear-Host

    $linkStyle = $PSStyle.Underline + $PSStyle.Italic + $PSStyle.Foreground.BrightYellow
    $title = "PowerShell v$($PSVersionTable.PSVersion)"
    $Text = @(
        "PowerShell Documentation  : $($linkStyle)https://learn.microsoft.com/powershell$($PSStyle.Reset)",
        "PowerShell on Slack       : $($linkStyle)https//aka.ms/psslack$($PSStyle.Reset)",
        "PowerShell on Discord     : $($linkStyle)https://aka.ms/psdiscord$($PSStyle.Reset)"
        "PowerShell Team Blog      : $($linkStyle)https://devblogs.microsoft.com/powershell$($PSStyle.Reset)",
        "PowerShell Gallery        : $($linkStyle)https://www.powershellgallery.com$($PSStyle.Reset)",
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

    if ($ModuleStatus) {
        $ModuleInfo = Get-ModuleStatus
        '{0}{1}{2}' -f $cmdStyle, 'Key module status:', $reset
        #create a custom formatted table. Normally this is not a best practice
        #but the output of this command is a presentation of information
        $ModuleInfo | Format-Table Name, @{Name = 'Online'; Expression = { $_.Online }; align = 'right' },
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

    If ($ModuleInfo.UpdateNeeded -contains $True) {
        Write-Host "$($warnStyle)You may need to update or install the modules listed above.$($reset)"
    }
    Else {
        Write-Host "$($highLight2)All key modules are up to date.$($reset)"
    }
} #if ModuleStatus

    If ($Tutorial) {
        $promptStyle
        $r = Read-Host -Prompt 'Would you like to run a short interactive tutorial? (Y/N)'
        $reset

        If ($r -ne 'y') {
            Write-Host "No problem. You can run $($cmdStyle)Start-PSTutorial$($reset) at any time.`n"
        }
        Else {
            &"$PSScriptRoot\..\tutorials\Invoke-PSBasicsTutorial.ps1" -Full
        }
    }
}
