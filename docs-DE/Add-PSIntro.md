---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Add-PSIntro

## SYNOPSIS

Fügt Start-PSIntro zu Ihrem PowerShell-Profil hinzu.

## SYNTAX

```yaml
Add-PSIntro [-ModuleStatus] [-Tutorial] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Mit diesem Befehl können Sie einen Start-PSIntro-Befehl zu Ihrem PowerShell-Profil hinzufügen. Dadurch wird der Befehl Start-PSIntro jedes Mal automatisch ausgeführt, wenn Sie eine neue PowerShell-Sitzung starten. Sie können den Befehl mithilfe der Parameter -ModuleStatus und -Tutorial anpassen, die die entsprechenden Parameter zum Start-PSIntro-Befehl in Ihrem Profil hinzufügen.

Wenn das Profilskript nicht existiert, werden Sie aufgefordert, es zu erstellen.

Sie müssen das Profilskript manuell bearbeiten, um den Start-PSIntro-Befehl zu entfernen oder zu ändern, wenn Sie dieses Verhalten ändern oder stoppen möchten.

## EXAMPLES

### Example 1

```powershell
PS C:\> Add-PSIntro -ModuleStatus
```

Dadurch wird der Befehl `Start-PSIntro -ModuleStatus` an das Ende Ihres PowerShell-Profilskripts für den aktuellen Benutzer im aktuellen PowerShell-Host angefügt.

## PARAMETERS

### -ModuleStatus

Schließt den Parameter -ModuleStatus ein.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tutorial

Schließt den Parameter -Tutorial ein.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Fordert Sie zur Bestätigung auf, bevor das Cmdlet ausgeführt wird.

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

### None

## OUTPUTS

### none

## NOTES

Weitere Informationen zu PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[New-PSProfile](New-PSProfile.md)

[Get-ProfileStatus](Get-ProfileStatus.md)
