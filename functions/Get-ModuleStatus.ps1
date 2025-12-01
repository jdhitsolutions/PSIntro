function Get-ModuleStatus {
    [cmdletBinding()]
    [OutputType('ModuleStatusInfo')]
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
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.Starting -f $($MyInvocation.MyCommand))"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.usingVersion -f $modVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.runningPS -f $($PSVersionTable.PSVersion))"

        $moduleList = [System.Collections.Generic.List[string]]::New()
    } #begin
    process {
        Foreach ($m in $Module) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.addingModule -f $m)"
            $moduleList.AddRange([string[]]$m)
        }
    } #process
    end {
        Write-Information $moduleList -Tags data
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] $($strings.validating -f $($moduleList.count))"
        $find = Find-PSResource -Name $moduleList -Type Module -Verbose:$False

        foreach ($item in $find) {
            $local = Get-Module -name $item.Name -ListAvailable -Verbose:$False |
            Sort-Object -Property Version |
            Select-Object -Last 1 -ExpandProperty Version

            [PSCustomObject]@{
                PSTypeName   = 'ModuleStatusInfo'
                Name         = $item.Name
                Online       = $item.Version
                Installed    = $local
                UpdateNeeded = $item.Version -gt $local
            }
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] $($strings.ending -f $($MyInvocation.MyCommand))"
    } #end
}