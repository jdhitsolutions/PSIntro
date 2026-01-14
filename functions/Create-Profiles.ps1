#create the profile scripts

function New-PSProfile {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("System.IO.FileInfo")]
    param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Create the specified PowerShell profile script.'
        )]
        [ValidateSet('CurrentUserCurrentHost', 'CurrentUserAllHosts', 'AllUsersCurrentHost', 'AllUsersAllHosts')]
        [ValidateNotNullOrEmpty()]
        [Alias("ProfileName")]
        [string[]]$Name = 'CurrentUserCurrentHost'
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.Starting -f $($MyInvocation.MyCommand))"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.usingVersion -f $modVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.runningPS -f $($PSVersionTable.PSVersion))"
    } #begin
    process {
        foreach ($item in $Name) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.newProfile -f $item)"
            if (Test-Path $profile.$Item) {
                Write-Warning ($strings.existingProfile -f $item,$profile.$item)
            }
            else {
                New-Item $profile.$item -Force
            }
        }
    } #process
    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] $($strings.ending -f $($MyInvocation.MyCommand))"
    } #end
}