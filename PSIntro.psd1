#
# Module manifest for module 'PSIntro'
#
@{
    RootModule           = 'PSIntro.psm1'
    ModuleVersion        = '1.0.1'
    CompatiblePSEditions = 'Core'
    GUID                 = 'e5e4f309-b2ec-43e0-ac18-4a136a112487'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A welcome screen for PowerShell and a set of brief tutorials designed for absolute beginners. The module also includes a few commands to help absolute PowerShell beginners manage their environment.'
    PowerShellVersion    = '7.5'
    FormatsToProcess     = @(
        'formats\ModuleStatusInfo.format.ps1xml',
        'formats\ProfileStatusInfo.format.ps1xml'
    )
    TypesToProcess       = @()
    FunctionsToExport    = @(
        'Start-PSTutorial',
        'Get-PSIntro',
        'Get-ModuleStatus',
        'Get-ProfileStatus'
    )
    RequiredModules      = @()
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @('PSIntro', 'PSWelcome')
    PrivateData          = @{
        PSData = @{
            Tags                     = @('powershell', 'pwsh', 'tutorial', 'fundamentals')
            LicenseUri               = 'https://github.com/jdhitsolutions/PSIntro/blob/main/License.txt'
            ProjectUri               = 'https://github.com/jdhitsolutions/PSIntro'
            #IconUri                 = ''
            ReleaseNotes             = 'https://github.com/jdhitsolutions/PSIntro/blob/main/CHANGELOG.md'
            RequireLicenseAcceptance = $false

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}

