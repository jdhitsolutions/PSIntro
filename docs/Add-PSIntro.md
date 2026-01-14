---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Add-PSIntro

## SYNOPSIS

Add Start-PSIntro to your PowerShell profile.

## SYNTAX

```yaml
Add-PSIntro [-ModuleStatus] [-Tutorial] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

You can use this command to add a Start-PSIntro command to your PowerShell profile. This will cause the Start-PSIntro command to run automatically each time you start a new PowerShell session. You can customize the command by using the ModuleStatus and Tutorial parameters which will add the corresponding parameters to the Start-PSIntro command in your profile.

If the profile script does not exist, you will be prompted to create it.

You will need to manually edit the profile script to remove or modify the Start-PSIntro command if you want to change or stop this behavior.

## EXAMPLES

### Example 1

```powershell
PS C:\> Add-PSIntro -ModuleStatus
```

This will add the command `Start-PSIntro -ModuleStatus` to the end of your PowerShell profile script for the current user in the current PowerShell host.

## PARAMETERS

### -ModuleStatus

Include the ModuleStatus parameter.

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

Include the Tutorial parameter.

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### none

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[New-PSProfile](New-PSProfile.md)

[Get-ProfileStatus](Get-ProfileStatus.md)
