---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/2b2ff7
schema: 2.0.0
---

# Start-PSTutorial

## SYNOPSIS

Starten Sie ein interaktives PowerShell-Tutorial

## SYNTAX

```yaml
Start-PSTutorial [-Topic <String>] [<CommonParameters>]
```

## DESCRIPTION

Dieser Befehl dient als Starter für die in dem PSIntro-Modul enthaltenen Tutorials. Sie können ein Tutorial-Thema auswählen. Wenn Sie kein Thema angeben, erhalten Sie ein einfaches Menü mit interaktiven PowerShell-Tutorials. Das Tutorial besteht aus einer Kombination von Texten und Informationen aus Ihrer Host- und PowerShell-Umgebung.

Das Tutorial wird in "Seiten" angezeigt, mit Aufforderungen zum Fortfahren. Drücken Sie `Enter`, um fortzufahren, oder `q`, um zu beenden. Ihr Fortschritt wird nicht gespeichert.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSTutorial

    PowerShell-Tutorial-Menü

    1 - PowerShell-Grundlagen
    2 - Get-Command
    3 - Get-Help
    4 - Get-Member
    5 - PowerShell-Profiles
    6 - Beenden

    Wählen Sie eine Menüoption [1-6]:
```

Geben Sie eine Nummer ein, um das entsprechende Tutorial zu starten. Wenn Sie eine andere Taste eingeben, wird das Programm beendet.

### Example 2

```powershell
PS C:\> Start-PSTutorial -Topic 'Get-Command'
```

Startet das Get-Command-Tutorial.

## PARAMETERS

### -Topic

Geben Sie ein Tutorial-Thema an; andernfalls wird Ihnen ein Menü mit verfügbaren Themen angezeigt.
Gültige Themen sind:

- PowerShell Essentials
- Get-Command
- Get-Help
- Get-Member
- PowerShell Profiles

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Dieses Cmdlet unterstützt die allgemeinen Parameter: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, und -WarningVariable. Für weitere Informationen siehe [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Erfahren Sie mehr über PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
