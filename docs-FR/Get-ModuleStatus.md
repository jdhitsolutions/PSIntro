---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/3022e2
schema: 2.0.0
---

# Get-ModuleStatus

## SYNOPSIS

Obtenir l'état des modules clés

## SYNTAX

```yaml
Get-ModuleStatus [[-Module] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour vérifier l'état des modules clés. La commande renverra une liste de modules avec leur version en ligne, leur version installée et indiquera si une mise à jour est nécessaire.

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

Vérifier l'état des modules spécifiés par l'utilisateur.

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

Vérifier l'état des modules à partir d'une liste.

## PARAMETERS

### -Module

Les noms des modules à vérifier. Les modules PSReadline et Microsoft.PowerShell.PSResourceGet sont inclus par défaut.

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

Cette cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

### ModuleStatusInfo

## NOTES

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
