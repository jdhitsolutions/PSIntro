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
    $($PSStyle.Underline+$PSStyle.Foreground.Green)$($strings.menuTitle)$($PSStyle.Reset)

    1 - $($strings.psEssentials)
    2 - Get-Command
    3 - Get-Help
    4 - Get-Member
    5 - Quit

"@

    If ($PSBoundParameters.ContainsKey('Topic')) {
        #launch the tutorial from the module-scoped hashtable
        & $Tutorials[$Topic]
    }
    else {
        Clear-Host
        $list
        [int]$r = Read-Host "    $($strings.menuSelect) [1-5]"

        Switch ($r) {
            1 { &$tutorials['PowerShell Essentials'] -menu }`
            2 { &$tutorials['Get-Command'] -menu}
            3 { &$tutorials['Get-Help'] -menu }
            4 { &$tutorials['Get-Member'] -menu}
        }
    }
}
