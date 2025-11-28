---
external help file: PSIntro-help.xml
Module Name: PSIntro
online version:
schema: 2.0.0
---

# Start-PSTutorial

## SYNOPSIS

Démarrer un tutoriel PowerShell interactif

## SYNTAX

```yaml
Start-PSTutorial [-Topic <String>] [<CommonParameters>]
```

## DESCRIPTION

Cette commande sert de lanceur pour les tutoriels inclus dans le module PSIntro. Vous pouvez sélectionner un sujet de tutoriel. Si vous ne spécifiez pas de sujet, un menu simple de tutoriels PowerShell interactifs vous sera présenté. Le tutoriel se compose d'une combinaison de texte et d'informations provenant de votre hôte et de l'environnement PowerShell.

Le tutoriel s'affichera en « pages » avec des invites pour continuer. Appuyez sur Entrée pour continuer ou 'q' pour quitter. Votre progression ne sera pas sauvegardée.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSTutorial

    Menu du didacticiel PowerShell

    1 - Notions essentielles de PowerShell
    2 - Get-Command
    3 - Get-Help
    4 - Get-Member
    5 - Quit

    Sélectionnez une option de menu [1-5]:
```

Le titre du menu sera formaté en utilisant $PSStyle.

### Example 2

```powershell
PS C:\> Start-PSTutorial -Topic 'Get-Command'
```

Lancez le tutoriel Get-Command.

## PARAMETERS

### -Topic

Spécifiez un sujet de tutoriel ; sinon, un menu de sujets vous sera présenté.
Les sujets valides sont :

- Notions essentielles de PowerShell
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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

En savoir plus sur PowerShell : http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSIntro](Get-PSIntro.md)
