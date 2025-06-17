---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Start-PSTutorial

## SYNOPSIS

Start an interactive PowerShell tutorial

## SYNTAX

```yaml
Start-PSTutorial [-Topic <String>] [<CommonParameters>]
```

## DESCRIPTION

This command serves as a launcher for the tutorials included in the PSIntro module. You can select a tutorial topic. If you don't specify a topic, you will get a simple menu of interactive PowerShell tutorials.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSTutorial

    PowerShell Tutorial Menu

    1 - PowerShell Essentials
    2 - Get-Command
    3 - Get-Help
    4 - Get-Member
    5 - Quit

    Select a menu option [1-5]:
```

The menu title will be formatted using $PSStyle.

### Example 2

```powershell
PS C:\> Start-PSTutorial -Topic 'Get-Command'
```

Launch the Get-Command tutorial.

## PARAMETERS

### -Topic

Specify a tutorial topic otherwise you will be presented with a menu of topics.
Valid topics are:

- PowerShell Essentials
- Get-Command
- Get-Help
- Get-Member

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
