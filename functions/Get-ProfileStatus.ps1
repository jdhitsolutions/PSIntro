function Get-ProfileStatus {
    [cmdletbinding()]
    [OutputType('ProfileStatusInfo')]
    param( )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.Starting -f $($MyInvocation.MyCommand))"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.usingVersion -f $modVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.runningPS -f $($PSVersionTable.PSVersion))"
    } #begin

    process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.getProfile)"
        $profile.PSObject.Properties.Where({ $_.name -match 'host' }).foreach({
            [PSCustomObject]@{
                PSTypeName  = 'ProfileStatusInfo'
                ProfileName = $_.Name
                Path        = $_.value
                Exists      = Test-Path $_.Value
            }
        })
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] $($strings.ending -f $($MyInvocation.MyCommand))"
    } #end

} #close Get-ProfileStatus