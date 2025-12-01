---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/a14c2e
schema: 2.0.0
---

# Get-ModuleStatus

## SYNOPSIS

Get key module status

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
PSReadLine                         2.4.5  2.4.5            False
Microsoft.PowerShell.PSResourceGet 1.1.1  1.1.1            False
```

### Example 2

```powershell
PS C:\> Get-ModuleStatus -Module Pester,PSReadline,PackageManagement

Name              Online  Installed UpdateNeeded
----              ------  --------- ------------
Pester            5.7.1   5.7.1            False
PSReadLine        2.4.5   2.4.5            False
PackageManagement 1.4.8.1 1.4.8.1          False
```

Check the status of user-specified modules.

### Example 3

```powershell
PS C:\> Get-Content C:\scripts\MyModules.txt | Get-ModuleStatus

Name                                 Online   Installed UpdateNeeded
----                                 ------   --------- ------------
Microsoft.PowerShell.ConsoleGuiTools 0.7.7    0.7.7            False
Microsoft.PowerShell.Crescendo       1.1.0    1.1.0            False
Microsoft.PowerShell.PlatyPS         1.0.1    1.0.0            True
Microsoft.PowerShell.PSResourceGet   1.1.1    1.1.1            False
Microsoft.WinGet.Client              1.11.460 1.12.350         False
Microsoft.PowerShell.WhatsNew        0.5.5    0.5.5            False
Microsoft.PowerShell.ThreadJob       2.2.0    2.2.0            False
```

Check module status from a list.

## PARAMETERS

### -Module

The module names to check. The PSReadline and Microsoft.PowerShell.PSResourceGet modules are included by default.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: PSReadline, Microsoft.PowerShell.PSResourceGet
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

### ModuleStatusInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
