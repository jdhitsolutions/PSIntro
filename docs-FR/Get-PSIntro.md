---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Get-PSIntro

## SYNOPSIS

Affiche un écran de bienvenue PowerShell

## SYNTAX

```yaml
Get-PSIntro [-ModuleStatus] [-Tutorial] [<CommonParameters>]
```

## DESCRIPTION

Cette commande affichera un écran de bienvenue ou "splash" PowerShell. L'affichage comprend une liste de ressources en ligne. Si vous incluez le paramètre -ModuleStatus, la sortie inclura l'état des modules clés. Garder ces modules à jour aidera à garantir une bonne expérience utilisateur.

Si vous incluez -Tutorial, vous serez invité à exécuter un ensemble de tutoriels. Les tutoriels sont interactifs et aideront l'utilisateur à apprendre PowerShell. Si l'utilisateur choisit d'exécuter les tutoriels, ils seront exécutés consécutivement. Les tutoriels sont écrits sous forme de scripts PowerShell avec une combinaison de texte formaté et de sortie de console en direct de la session PowerShell actuelle de l'utilisateur. Cela garantit que la sortie est pertinente pour l'environnement de l'utilisateur.

## EXAMPLES

### Exemple 1

```powershell
PS C:\> Get-PSIntro -ModuleStatus

Bienvenue dans PowerShell !

      PowerShell v7.5.4
 PowerShell Documentation  : https://learn.microsoft.com/powershell
 PowerShell on Slack       : https//aka.ms/psslack
 PowerShell on Discord     : https://aka.ms/psdiscord
 PowerShell Team Blog      : https://devblogs.microsoft.com/powershell
 PowerShell Gallery        : https://www.powershellgallery.com
 GitHub Discussion         : https://github.com/PowerShell/PowerShell/discussions

  Utilisez l'un des liens ci‑dessus pour commencer à en savoir plus sur PowerShell.
  Quand vous le pouvez, exécutez Update-Help pour obtenir les derniers fichiers d'aide pour PowerShell.

État des modules clés:

Name                               Online Installed UpdateNeeded
----                               ------ --------- ------------
PSReadLine                          2.4.5     2.4.5    False
Microsoft.PowerShell.PSResourceGet  1.1.1     1.1.1    False

  Tous les modules clés sont à jour.

  Exécutez Start-PSTutorial pour obtenir une liste de tutoriels PowerShell.
```

La sortie sera formatée et stylisée en utilisant $PSStyle. Les liens seront cliquables dans Windows Terminal ou similaire.

### Exemple 2

```powershell
PS C:\> Get-PSIntro -Tutorial

Bienvenue dans PowerShell !

      PowerShell v7.5.4
 PowerShell Documentation  : https://learn.microsoft.com/powershell
 PowerShell on Slack       : https//aka.ms/psslack
 PowerShell on Discord     : https://aka.ms/psdiscord
 PowerShell Team Blog      : https://devblogs.microsoft.com/powershell
 PowerShell Gallery        : https://www.powershellgallery.com
 GitHub Discussion         : https://github.com/PowerShell/PowerShell/discussions

  Utilisez l'un des liens ci‑dessus pour commencer à en savoir plus sur PowerShell.
  Quand vous le pouvez, exécutez Update-Help pour obtenir les derniers fichiers d'aide pour PowerShell.

  Souhaitez-vous exécuter un ensemble de tutoriels interactifs sur les fondamentaux essentiels de PowerShell ?
  Entrez Y pour continuer :
```

Lancez l'introduction avec l'invite du tutoriel.

## PARAMETERS

### -ModuleStatus

Inclure l'état des modules clés.

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

Afficher l'invite du tutoriel. Si vous sélectionnez Oui, les tutoriels s'exécuteront consécutivement, dans l'ordre. Si vous sélectionnez Non, la commande quittera sans exécuter de tutoriels. Vous pouvez exécuter Start-PSTutorial à tout moment pour lancer les tutoriels dans n'importe quel ordre.

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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Cette commande a des alias de PSIntro et PSWelcome.

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-PSTutorial](Start-PSTutorial.md)
