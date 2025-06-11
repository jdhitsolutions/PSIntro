---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Get-PSIntro

## SYNOPSIS

Display a PowerShell welcome screen

## SYNTAX

```yaml
Get-PSIntro [-ModuleStatus] [-Tutorial] [<CommonParameters>]
```

## DESCRIPTION

This command will display a PowerShell welcome or "splash" screen. The display includes a list of online resources. If you include the -ModuleStatus parameter, the output will include the status of key modules. Keeping these modules up to date will help ensure a good user experience.

If you include -Tutorial, you will be prompted to run a set of tutorials. The tutorials are interactive and will help the user learn about PowerShell. If the user chooses to run the tutorials, they will be run consecutively. The tutorials are written as PowerShell scripts with a combination of formatted text and live console output from the user's session. This ensures that output is relevant to the user's environment.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSIntro -ModuleStatus

Welcome to PowerShell!

      PowerShell v7.5.1
 PowerShell Documentation  : https://learn.microsoft.com/powershell
 PowerShell on Slack       : https//aka.ms/psslack
 PowerShell on Discord     : https://aka.ms/psdiscord
 PowerShell Team Blog      : https://devblogs.microsoft.com/powershell
 PowerShell Gallery        : https://www.powershellgallery.com
 GitHub Discussion         : https://github.com/PowerShell/PowerShell/discussions

  Use any of the links above to get started learning more about PowerShell.
  When you can, you should run Update-Help to get the latest help files for PowerShell.

Key module status:

Name                               Online Installed UpdateNeeded
----                               ------ --------- ------------
PSReadline                          2.3.6     2.3.6    False
Microsoft.PowerShell.PSResourceGet  1.1.1     1.1.1    False

All key modules are up to date.
```

The output will for formatted and styled using $PSStyle. The links will be clickable in Windows Terminal or similar.

## PARAMETERS

### -ModuleStatus

Include module status.

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

Show the tutorial prompt. If you select Yes, the tutorials will run consecutively, in order. If you select No, the command will exit without running any tutorials. You can run Start-PSTutorial to launch the tutorials at any time and in any order.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Object

## NOTES

This command has aliases of PSIntro and PSWelcome.

## RELATED LINKS

[Start-PSTutorial](Start-PSTutorial.md)
