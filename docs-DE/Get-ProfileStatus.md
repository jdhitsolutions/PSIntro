---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Get-ProfileStatus

## SYNOPSIS

Gibt den Status der PowerShell-Profilskripte für den aktuellen Host zurück.

## SYNTAX

```yaml
Get-ProfileStatus [<CommonParameters>]
```

## DESCRIPTION

Führen Sie diesen Befehl aus, um den Status der PowerShell-Profilskripte für den aktuellen Host zu ermitteln. Die Ausgabe enthält den Profilnamen, den Pfad und die Information, ob das Profilskript vorhanden ist. Die Pfade der PowerShell-Profilskripte sind basierend auf dem aktuellen Host- und Benutzerkontext fest kodiert. Die Skriptdateien existieren standardmäßig nicht. Sie müssen diese erstellen, wenn Sie Ihre PowerShell-Umgebung anpassen möchten. Beachten Sie, dass Sie möglicherweise zusätzlich Ordner erstellen müssen.

Die eingebaute Variable $profile verweist standardmäßig auf das Profilskript für den aktuellen Benutzer im aktuellen PowerShell-Host. Lesen Sie das Hilfethema about_Profiles, um mehr zu erfahren.

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

Profile, die nicht vorhanden sind, werden rot hervorgehoben.

## PARAMETERS

### CommonParameters

Dieses Cmdlet unterstützt die gemeinsamen Parameter: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, und -WarningVariable. Weitere Informationen finden Sie unter [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### ProfileStatusInfo

## NOTES

Weitere Informationen zu PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[About_Profiles](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles)
