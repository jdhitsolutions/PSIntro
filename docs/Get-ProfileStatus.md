---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Get-ProfileStatus

## SYNOPSIS

Get the status of PowerShell profile scripts for the current host.

## SYNTAX

```yaml
Get-ProfileStatus [<CommonParameters>]
```

## DESCRIPTION

Run this command to get the status of PowerShell profile scripts for the current host. The output includes the profile name, path, and whether the profile script exists. The PowerShell profile script paths are hard-coded based on the current host and user context. The script files do not exist by default. You must create them if you want to customize your PowerShell environment. Note that you may also have to create additional folders.

The built-in $profile variable defaults to the profile script for the current user in the current PowerShell host. Read the help topic about_Profiles to learn more.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-ProfileStatus

   Computername: CADENZA [ConsoleHost]

ProfileName            Path                                                                Exists
-----------            ----                                                                ------
AllUsersAllHosts       C:\Program Files\PowerShell\7\profile.ps1                           True
AllUsersCurrentHost    C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1      False
CurrentUserAllHosts    C:\Users\jeff\Documents\PowerShell\profile.ps1                      True
CurrentUserCurrentHost C:\Users\jeff\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 True
```

Profiles that do not exist will be highlighted in red.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### ProfileStatusInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[About_Profiles](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles)
