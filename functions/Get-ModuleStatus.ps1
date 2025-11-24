function Get-ModuleStatus {
    [cmdletBinding()]
    param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            HelpMessage = 'Enter the names of PowerShell modules to check.'
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$Module = @('PSReadline', 'Microsoft.PowerShell.PSResourceGet')
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $modVersion"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under $($PSVersionTable.PSVersion)"

        $moduleList = [System.Collections.Generic.List[string]]::New()

    } #begin
    process {
        Foreach ($m in $Module) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Adding $m to the list"
            $moduleList.AddRange([string[]]$m)
        }
    } #process
    end {
        Write-Information $moduleList -Tags data
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Validating $($moduleList.count) modules"
        $find = Find-PSResource -Name $moduleList -Type Module -Verbose:$False

        foreach ($item in $find) {
            $local = Get-Module -name $item.Name -ListAvailable -Verbose:$False |
            Sort-Object -Property Version |
            Select-Object -Last 1 -ExpandProperty Version

            [PSCustomObject]@{
                Name         = $item.Name
                Online       = $item.Version
                Installed    = $local
                UpdateNeeded = $item.Version -gt $local
            }
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}