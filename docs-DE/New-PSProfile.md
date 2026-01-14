---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# New-PSProfile

## SYNOPSIS

Erstellt ein neues PowerShell-Profilskript.

## SYNTAX

```yaml
New-PSProfile [[-Name] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Erstellt ein neues PowerShell-Profilskript, falls es noch nicht existiert. Standardmäßig wird das Profilskript für den aktuellen Benutzer im aktuellen PowerShell-Host erstellt. Sie können ein anderes Profilskript mit dem Parameter -Name angeben.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PSProfile

    Directory: C:\Users\jeff\Documents\PowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a--             1/8/2026  8:13 AM              0 Microsoft.PowerShell_profile.ps1
```

Dies erstellt das Profilskript für den aktuellen Benutzer im aktuellen PowerShell-Host, falls es noch nicht vorhanden ist. Sie können anschließend das Profilskript bearbeiten, um Ihre Anpassungen hinzuzufügen.

### Example 2

```powershell
PS C:\> Get-ProfileStatus | New-PSProfile -WhatIf
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\profile.ps1".
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1".
WARNING: An existing PowerShell profile script for CurrentUserAllHosts has been found at C:\Users\jeff\Documents\PowerShell\profile.ps1.
What if: Performing the operation "Create File" on target "Destination: C:\Users\jeff\Documents\PowerShell\Microsoft.PowerShell_profile.ps1".
```

Ermittelt den Status aller PowerShell-Profilskripte und leitet die Ergebnisse an New-PSProfile weiter, um fehlende Profilskripte zu erstellen. Der Parameter -WhatIf zeigt an, was passieren würde, ohne tatsächlich Dateien zu erstellen.

## PARAMETERS

### -Name

Erstellt das angegebene PowerShell-Profilskript. Sie können die Tab‑Vervollständigung verwenden, um die verfügbaren Profilskriptnamen anzuzeigen.

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

Zeigt an, was passieren würde, wenn das Cmdlet ausgeführt würde. Das Cmdlet wird nicht ausgeführt.

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

Dieses Cmdlet unterstützt die gemeinsamen Parameter: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction und -WarningVariable. Weitere Informationen finden Sie unter [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.IO.FileInfo

## NOTES

Weitere Informationen zu PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-ProfileStatus](Get-ProfileStatus.md)
