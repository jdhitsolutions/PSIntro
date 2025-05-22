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
