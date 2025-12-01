---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version: https://jdhitsolutions.com/yourls/566292
schema: 2.0.0
---

# Get-ProfileStatus

## SYNOPSIS

Obtenir l'état des scripts de profil PowerShell pour l'hôte actuel.

## SYNTAX

```yaml
Get-ProfileStatus [<CommonParameters>]
```

## DESCRIPTION

Exécutez cette commande pour obtenir l'état des scripts de profil PowerShell pour l'hôte actuel. La sortie inclut le nom du profil, le chemin et l'indication si le script de profil existe. Les chemins des scripts de profil PowerShell sont codés en dur en fonction du contexte de l'hôte et de l'utilisateur actuel. Les fichiers de script n'existent pas par défaut. Vous devez les créer si vous souhaitez personnaliser votre environnement PowerShell. Notez que vous devrez peut-être également créer des dossiers supplémentaires.

La variable intégrée $profile pointe par défaut vers le script de profil pour l'utilisateur actuel dans l'hôte PowerShell actuel. Consultez le sujet d'aide about_Profiles pour en savoir plus.

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

Les profils qui n'existent pas seront mis en évidence en rouge.

## PARAMETERS

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, consultez [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### ProfileStatusInfo

## NOTES

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[About_Profiles](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles)
