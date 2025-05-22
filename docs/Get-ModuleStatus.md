---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/a14c2e
schema: 2.0.0
---

# Get-ModuleStatus

## SYNOPSIS

{Get key module status

## SYNTAX

```yaml
Get-ModuleStatus [[-Module] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to check the status of key modules. The command will return a list of modules with their online version, installed version, and whether an update is needed.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-ModuleStatus

Name                               Online Installed UpdateNeeded
----                               ------ --------- ------------
Microsoft.PowerShell.PSResourceGet 1.1.1  1.1.1            False
PSReadLine                         2.3.6  2.3.6            False
```

## PARAMETERS

### -Module

The module names to check. As of v0.5.0 the PSReadline and Microsoft.PowerShell.PSResourceGet modules are included by default.  The design of this parameter should be considered under development for now.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS
