---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/3d2a4a
schema: 2.0.0
---

# Get-PSIntro

## SYNOPSIS

Zeigt einen PowerShell-Begrüßungsbildschirm an

## SYNTAX

```yaml
Get-PSIntro [-ModuleStatus] [-Tutorial] [<CommonParameters>]
```

## DESCRIPTION

Dieser Befehl zeigt einen PowerShell-Begrüßungs- oder "Splash"-Bildschirm an. Die Anzeige enthält eine Liste von Online-Ressourcen. Wenn Sie den Parameter -ModuleStatus angeben, enthält die Ausgabe den Status wichtiger Module. Das Aktualisieren dieser Module trägt zu einer besseren Benutzererfahrung bei.

Wenn Sie -Tutorial angeben, werden Sie aufgefordert, eine Reihe von Tutorials auszuführen. Die Tutorials sind interaktiv und helfen dem Benutzer, PowerShell zu erlernen. Wenn der Benutzer sich entscheidet, die Tutorials auszuführen, werden diese nacheinander gestartet. Die Tutorials sind als PowerShell-Skripte geschrieben und enthalten eine Kombination aus formatiertem Text und Live-Konsolenausgabe aus der aktuellen PowerShell-Sitzung des Benutzers. Dadurch ist die Ausgabe relevant für die Umgebung des Benutzers.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSIntro -ModuleStatus

Willkommen bei PowerShell!

  PowerShell v7.5.4
 PowerShell Documentation  : https://learn.microsoft.com/powershell
 PowerShell on Slack       : https//aka.ms/psslack
 PowerShell on Discord     : https://aka.ms/psdiscord
 PowerShell Team Blog      : https://devblogs.microsoft.com/powershell
 PowerShell Gallery        : https://www.powershellgallery.com
 GitHub Discussion         : https://github.com/PowerShell/PowerShell/discussions

  Verwenden Sie einen der obigen Links, um mehr über PowerShell zu erfahren.
  Wenn möglich, sollten Sie Update-Help ausführen, um die neuesten Hilfedateien für PowerShell zu erhalten.

Status wichtiger Module:

Name                               Online Installed UpdateNeeded
----                               ------ --------- ------------
PSReadLine                          2.4.5     2.4.5    False
Microsoft.PowerShell.PSResourceGet  1.1.1     1.1.1    False

  Alle wichtigen Module sind auf dem neuesten Stand.

    Führen Sie Start-PSTutorial aus, um eine Liste kurzer PowerShell-Tutorials anzuzeigen.
```

Die Ausgabe wird mit $PSStyle formatiert und gestylt. Die Links sind im Windows Terminal oder ähnlichen Anwendungen anklickbar.

### Example 2

```powershell
PS C:\> Get-PSIntro -Tutorial

Willkommen bei PowerShell!

  PowerShell v7.5.4
 PowerShell Documentation  : https://learn.microsoft.com/powershell
 PowerShell on Slack       : https//aka.ms/psslack
 PowerShell on Discord     : https://aka.ms/psdiscord
 PowerShell Team Blog      : https://devblogs.microsoft.com/powershell
 PowerShell Gallery        : https://www.powershellgallery.com
 GitHub Discussion         : https://github.com/PowerShell/PowerShell/discussions

  Verwenden Sie einen der obigen Links, um mehr über PowerShell zu erfahren.
  Wenn möglich, sollten Sie Update-Help ausführen, um die neuesten Hilfedateien für PowerShell zu erhalten.

  Möchten Sie eine Reihe kurzer interaktiver Tutorials zu den wichtigsten PowerShell-Grundlagen ausführen?

  Geben Sie Y ein, um fortzufahren:
```

Starten Sie die Einführung mit der Tutorialaufforderung.

## PARAMETERS

### -ModuleStatus

Beinhaltet den Status wichtiger Module.

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

Zeigt die Tutorialaufforderung an. Wenn Sie Ja wählen, werden die Tutorials nacheinander ausgeführt. Wenn Sie Nein wählen, beendet der Befehl ohne Ausführung der Tutorials. Sie können Start-PSTutorial jederzeit verwenden, um die Tutorials zu starten und in beliebiger Reihenfolge auszuführen.

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

### CommonParameters

Dieses Cmdlet unterstützt die allgemeinen Parameter: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction und -WarningVariable. Weitere Informationen finden Sie unter [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

Keine

## OUTPUTS

### Object

Objekt

## NOTES

Dieser Befehl hat die Aliase PSIntro und PSWelcome.

Erfahren Sie mehr über PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-PSTutorial](Start-PSTutorial.md)
