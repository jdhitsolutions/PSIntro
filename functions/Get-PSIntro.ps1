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

    $linkStyle = "$e[3;4;93m" #$PSStyle.Underline + $PSStyle.Italic + $PSStyle.Foreground.BrightYellow
    $title = "PowerShell v$($PSVersionTable.PSVersion)"
    $Text = @(
        "PowerShell Documentation  : $($linkStyle)https://learn.microsoft.com/powershell$($reset)",
        "PowerShell on Slack       : $($linkStyle)https//aka.ms/psslack$($reset)",
        "PowerShell on Discord     : $($linkStyle)https://aka.ms/psdiscord$($reset)"
        "PowerShell Team Blog      : $($linkStyle)https://devblogs.microsoft.com/powershell$($reset)",
        "PowerShell Gallery        : $($linkStyle)https://www.powershellgallery.com$($reset)"
        )

    if ($IsCoreCLR) {
        $Text+= "GitHub Discussion         : $($linkStyle)https://github.com/PowerShell/PowerShell/discussions$($reset)"
        [string]$updateLink = 'https://learn.microsoft.com/powershell/module/microsoft.powershell.core/update-help?view=powershell-7.5&WT.mc_id=ps-gethelp'
    }
    else {
        [string]$updateLink = 'https://learn.microsoft.com/powershell/module/microsoft.powershell.core/update-help?view=powershell-5.1&WT.mc_id=ps-gethelp'
    }

    $helpLink = "$e]8;;$($updateLink)$bel$('Update-Help')$e]8;;$bel"

    $head = Format-BorderBox -Text $Text -Title $title -BorderColor "$e[92m" #$PSStyle.Foreground.BrightGreen

    #$PSStyle.FormatHyperlink('Update-Help',$updateLink), $reset)
    $intro = @"

$welcomeStyle$($strings.welcome)$($reset)
$head
$reset
  $($strings.welcome_1)
  $($strings.welcome_2 -f $cmdStyle,$helpLink,$reset)

"@

    $intro

    if ($ModuleStatus) {
        $ModuleInfo = Get-ModuleStatus
        '  {0}{1}{2}' -f $cmdStyle, $strings.key, $reset
        #create a custom formatted table. Normally this is not a best practice
        #but the output of this command is a presentation of information

        $ModuleInfo |
        Format-Table Name, @{Name = 'Online'; Expression = { $_.Online }; align = 'right' },
        @{Name = 'Installed'; Expression = { $_.Installed }; align = 'right' },
        @{Name = 'UpdateNeeded'; Expression = {
            If ($_.UpdateNeeded) {
                "$e[91m$($_.UpdateNeeded)$($reset)"
            }
            Else {
                $_.UpdateNeeded
            }
        }; align = 'center'
    }

    If ($ModuleInfo.UpdateNeeded -contains $True) {
        Write-Host "  $($warnStyle)$($strings.UpdateNeeded)$($reset)"
    }
    Else {
        Write-Host "  $($highLight2)$($strings.upToDate)$($reset)"
    }
} #if ModuleStatus

    If ($Tutorial) {
        $promptStyle
        $r = Read-Host -Prompt "  $($strings.tutorialPrompt)`n  $($strings.tutorialContinue)"
        $reset

        If ($r -ne 'y') {
            Write-Host "  $($strings.tutorialSkip -f $cmdStyle,$reset)`n"
        }
        Else {
            &$tutorials['PowerShell Essentials'] -Full
        }
    } #if tutorial prompt
    else {
        #display a message about running Start-PSTutorial
        if ($ModuleStatus) {
            Write-Host "`n" -NoNewline
        }
        Write-Host "  $($strings.tutorialCommand -f $cmdStyle,$reset)`n"
    }
}
