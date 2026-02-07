function Start-PSTutorial {
    [cmdletbinding()]
    [OutputType('None')]
    param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Specify a tutorial topic otherwise you will be presented with a menu of topics.'
        )]
        [ValidateSet('PowerShell Essentials', 'Get-Command', 'Get-Help', 'Get-Member', 'PSDrives','PowerShell Profiles')]
        [string]$Topic
    )

    #29 Nov 2025 use the private Format-BorderBox function to stylize the menu
    [string[]]$list = @(
        '                    '
        "    1 - $($strings.psEssentials)    ",
        '    2 - Get-Command',
        '    3 - Get-Help',
        '    4 - Get-Member',
        '    5 - PSDrives and Providers'
        '    6 - PowerShell Profiles',
        "    7 - $($strings.quit)"
        '                        '
    )

    # $tutorials is a module-scoped hashtable defined in PSIntro.psm1
    if ($PSBoundParameters.ContainsKey('Topic')) {
        #launch the tutorial from the module-scoped hashtable
        & $tutorials[$Topic]
    }
    else {
        Clear-Host
        Format-BorderBox -text $list -title $strings.menuTitle -BorderColor "$e[93m"
        $script:pg = 0
        try {
            [int]$menuItem = Read-Host "    $e[3;92m$($strings.menuSelect)$($reset) [1-$($list.count - 2)]"
            #The call operator runs each script in a child scope
            switch ($menuItem) {
                1 { &$tutorials['PowerShell Essentials'] -menu }`
                2 { &$tutorials['Get-Command'] -menu }
                3 { &$tutorials['Get-Help'] -menu }
                4 { &$tutorials['Get-Member'] -menu }
                5 { &$tutorials['PSDrives'] -menu}
                6 { &$tutorials['PowerShell Profiles'] -menu }
                7 { "`n" ; break }
            }
        } #Try
        catch {
            #if the user enters any other value, consider it a quit or cancel
        } #Catch
    }
    #write-host "exit menu"
}
