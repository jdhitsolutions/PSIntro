---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Get-ModuleStatus

## SYNOPSIS

Ermittelt den Status wichtiger Module

## SYNTAX

```yaml
Get-ModuleStatus [[-Module] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Verwenden Sie diesen Befehl, um den Status wichtiger Module zu überprüfen. Der Befehl gibt eine Liste der Module mit ihrer Online-Version, installierten Version und der Angabe zurück, ob ein Update erforderlich ist.

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

Überprüft den Status benutzerdefinierter Module.

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

Überprüft den Modulstatus aus einer Liste.

## PARAMETERS

### -Module

Die zu überprüfenden Modulnamen. Die Module PSReadline und Microsoft.PowerShell.PSResourceGet sind standardmäßig enthalten.

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

Dieses Cmdlet unterstützt die Standardparameter: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction und -WarningVariable. Weitere Informationen finden Sie unter [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Erfahren Sie mehr über PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
