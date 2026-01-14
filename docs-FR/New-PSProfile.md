---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# New-PSProfile

## SYNOPSIS

Créer un nouveau script de profil PowerShell.

## SYNTAX

```yaml
New-PSProfile [[-Name] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Crée un nouveau script de profil PowerShell s'il n'existe pas déjà. Le comportement par défaut est de créer le script de profil pour l'utilisateur actuel dans l'hôte PowerShell actuel. Vous pouvez spécifier un script de profil différent en utilisant le paramètre -Name.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PSProfile

    Directory: C:\Users\jeff\Documents\PowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a--             1/8/2026  8:13 AM              0 Microsoft.PowerShell_profile.ps1
```

Cela créera le script de profil pour l'utilisateur actuel dans l'hôte PowerShell actuel s'il n'existe pas déjà. Vous pourrez ensuite modifier le script de profil pour ajouter vos personnalisations.

### Example 2

```powershell
PS C:\> Get-ProfileStatus | New-PSProfile -WhatIf
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\profile.ps1".
What if: Performing the operation "Create File" on target "Destination: C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1".
WARNING: An existing PowerShell profile script for CurrentUserAllHosts has been found at C:\Users\jeff\Documents\PowerShell\profile.ps1.
What if: Performing the operation "Create File" on target "Destination: C:\Users\jeff\Documents\PowerShell\Microsoft.PowerShell_profile.ps1".
```

Obtenez le statut de tous les scripts de profil PowerShell et redirigez les résultats vers New-PSProfile pour créer les scripts de profil manquants. Le paramètre -WhatIf est utilisé pour montrer ce qui se passerait sans créer réellement des fichiers.

## PARAMETERS

### -Name

Crée le script de profil PowerShell spécifié. Vous pouvez utiliser la complétion par tabulation pour voir les noms de scripts de profil disponibles

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

### System.String[]

## OUTPUTS

### System.IO.FileInfo

## NOTES

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-ProfileStatus](Get-ProfileStatus.md)
