#Add a line to the CurrentHostCurrentUser profile to run Get-PSIntro

function Add-PSIntro {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('none')]
    param(
        [Parameter(HelpMessage = 'Include the ModuleStatus parameter')]
        [switch]$ModuleStatus,
        [Parameter(HelpMessage = 'Include the Tutorial parameter')]
        [switch]$Tutorial
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.Starting -f $($MyInvocation.MyCommand))"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.usingVersion -f $modVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] $($strings.runningPS -f $($PSVersionTable.PSVersion))"

        $path = $profile.CurrentUserCurrentHost
        $cmd = 'Get-PSIntro'
        if ($PSBoundParameters.ContainsKey('ModuleStatus')) {
            $cmd += ' -ModuleStatus'
        }
        if ($PSBoundParameters.ContainsKey('Tutorial')) {
            $cmd += ' -Tutorial'
        }

        $c = @"
`n
#$(Get-Date -Format g) $([environment]::UserDomainName)\$([environment]::UserName) : $($strings.addProfileComment)
Import-Module PSIntro
$cmd
"@
    } #begin

    process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.testPath -f $path)"
        #test if profile exists
        if (-not (Test-Path $Path)) {
            Write-Warning $strings.noProfileFound
            #prompt to create it
            if ($PSStyle) {
                $style = $PSStyle.Formatting.Warning
            }
            else {
                $style = ConvertTo-AnsiColor $host.PrivateData.WarningForegroundColor
            }
            $r = Read-Host "$($style)$($strings.profilePrompt)$($reset)"
            if ($r -match 'y|Y') {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.CreatePath -f $path)"
                try {
                    $file = New-Item $path -Force -ErrorAction Stop
                    #the file won't exist if -WhatIf is detected
                    if ($file) {
                        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.updatePath -f $path)"
                        Add-Content -Value $c -Path $path
                    }
                }
                catch {
                    throw $_
                }
            }
        }
        else {
            #test if the profile has already been updated
            $test = Select-String -Pattern '(Get-)?PSIntro' -Path $path -Quiet
            if (-not $test) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($strings.updatePath -f $path)"
                Add-Content -Value $c -Path $path
            }
            else {
                Write-Warning $($strings.cmdFound -f $path)
            }
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] $($strings.ending -f $($MyInvocation.MyCommand))"
    } #end

} #close Add-PSIntro