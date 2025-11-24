#
# Module manifest for module 'PSIntro'
#
@{
    RootModule           = 'PSIntro.psm1'
    ModuleVersion        = '0.10.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'e5e4f309-b2ec-43e0-ac18-4a136a112487'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A welcome screen for PowerShell and a set of brief tutorials designed for absolute beginners.'
    PowerShellVersion    = '7.5'
    FunctionsToExport    = 'Start-PSTutorial','Get-PSIntro','Get-ModuleStatus'
    RequiredModules      = ''
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = 'PSIntro','PSWelcome'

    PrivateData          = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
            # RequireLicenseAcceptance = $false
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}

