Function Start-PSTutorial {
    [cmdletbinding()]
    [OutputType('None')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Specify a tutorial topic otherwise you will be presented with a menu of topics."
        )]
        [ValidateSet("PowerShell Essentials","Get-Command","Get-Help","Get-Member")]
        [string]$Topic
     )

    $list = @"
    $($PSStyle.Underline+$PSStyle.Foreground.Green)PowerShell Tutorial Menu$($PSStyle.Reset)

    1 - PowerShell Essentials
    2 - Get-Command
    3 - Get-Help
    4 - Get-Member
    5 - Quit

"@

    If ($PSBoundParameters.ContainsKey('Topic')) {
        Switch ($Topic) {
            'PowerShell Essentials' { &"$PSScriptRoot\..\tutorials\Invoke-PSBasicsTutorial.ps1" }
            'Get-Command' { &"$PSScriptRoot\..\tutorials\Invoke-GetCommandTutorial.ps1" }
            'Get-Help' { &"$PSScriptRoot\..\tutorials\Invoke-GetHelpTutorial.ps1" }
            'Get-Member' { &"$PSScriptRoot\..\tutorials\Invoke-GetMemberTutorial.ps1" }
        }
    }
    else {
        Clear-Host
        $list
        [int]$r = Read-Host '    Select a menu option [1-5]'

        Switch ($r) {
            1 { &"$PSScriptRoot\..\tutorials\Invoke-PSBasicsTutorial.ps1" -menu }
            2 { &"$PSScriptRoot\..\tutorials\Invoke-GetCommandTutorial.ps1" -menu}
            3 { &"$PSScriptRoot\..\tutorials\Invoke-GetHelpTutorial.ps1" -menu }
            4 { &"$PSScriptRoot\..\tutorials\Invoke-GetMemberTutorial.ps1" -menu}
        }
    }
}
