---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/14ae48
schema: 2.0.0
---

# New-PSProfile

## SYNOPSIS

Create a new PowerShell profile script.

## SYNTAX

```yaml
New-PSProfile [[-Name] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Creates a new PowerShell profile script for if it does not already exist. The default behavior is to create the profile script for the current user in the current PowerShell host. You can specify a different profile script by using the Name parameter.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PSProfile

    Directory: C:\Users\jeff\Documents\PowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a--             1/8/2026  8:13 AM              0 Microsoft.PowerShell_profile.ps1
```

This will create the profile script for the current user in the current PowerShell host if it does not already exist. You can then edit the profile script to add your customizations.

### Example 2

```powershell
PS C:\> Get-ProfileStatus | New-PSProfile -WhatIf
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\profile.ps1".
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1".
WARNING: An existing PowerShell profile script for CurrentUserAllHosts has been found at C:\Users\jeff\Documents\PowerShell\profile.ps1.
What if: Performing the operation "Create File" on target "Destination: C:\Users\jeff\Documents\PowerShell\Microsoft.PowerShell_profile.ps1".
```

Get the status of all PowerShell profile scripts and pipe the results to New-PSProfile to create any missing profile scripts. The -WhatIf parameter is used to show what would happen without actually creating any files.

## PARAMETERS

### -Name

Create the specified PowerShell profile script. You can use tab-completion to see the available profile script names

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ProfileName
Accepted values: CurrentUserCurrentHost, CurrentUserAllHosts, AllUsersCurrentHost, AllUsersAllHosts

Required: False
Position: 0
Default value: CurrentUserCurrentHost
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.IO.FileInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-ProfileStatus](Get-ProfileStatus.md)
