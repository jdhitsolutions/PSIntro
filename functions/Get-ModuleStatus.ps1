Function Get-ModuleStatus {
    [cmdletBinding()]
    Param(
        [Parameter(HelpMessage = 'The module names to check.')]
        #these values could be set as a module-scoped variable
        #or exposed as a user preference
        [string[]]$Module = @('PSReadline','Microsoft.PowerShell.PSResourceGet')
    )

    $find = Find-Module $Module
    ForEach ($item in $find) {
        $local = Get-Module $item.Name -ListAvailable |
        Sort-Object -Property Version |
        Select-Object -Last 1 -ExpandProperty Version

        [PSCustomObject]@{
            Name         = $item.Name
            Online       = $item.Version
            Installed    = $local
            UpdateNeeded = $item.Version -gt $local
        }
    }

}