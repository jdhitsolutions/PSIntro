---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/f33175
schema: 2.0.0
---

# Add-PSIntro

## SYNOPSIS

Ajouter Start-PSIntro à votre profil PowerShell.

## SYNTAX

```yaml
Add-PSIntro [-ModuleStatus] [-Tutorial] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Vous pouvez utiliser cette commande pour ajouter une commande Start-PSIntro à votre profil PowerShell. Cela entraînera l'exécution automatique de la commande Start-PSIntro à chaque fois que vous commencerez une nouvelle session PowerShell. Vous pouvez personnaliser la commande en utilisant les paramètres -ModuleStatus et -Tutorial, qui ajouteront les paramètres correspondants à la commande Start-PSIntro dans votre profil.

Si le script de profil n'existe pas, il vous sera demandé de le créer.

Vous devrez modifier manuellement le script de profil pour supprimer ou modifier la commande Start-PSIntro si vous souhaitez changer ou arrêter ce comportement.

## EXAMPLES

### Example 1

```powershell
PS C:\> Add-PSIntro -ModuleStatus
```

Cela ajoutera la commande `Start-PSIntro -ModuleStatus` à la fin de votre script de profil PowerShell pour l'utilisateur actuel dans l'hôte PowerShell actuel.

## PARAMETERS

### -ModuleStatus

Inclut le paramètre -ModuleStatus.

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

Inclut le paramètre -Tutorial.

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

Vous invite à confirmer avant d'exécuter le cmdlet.

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

Affiche ce qui se passerait si le cmdlet était exécuté. Le cmdlet n'est pas exécuté.

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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun

## OUTPUTS

### aucun

## NOTES

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[New-PSProfile](New-PSProfile.md)

[Get-ProfileStatus](Get-ProfileStatus.md)
