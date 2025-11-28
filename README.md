# PSIntro

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSintro.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSintro/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSintro.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSintro/)

![](images/PowerShell-transparent-thumb.jpg)

This is an __educational and reference__ module targeted for PowerShell beginner, although everyone is welcome to install and use the module.

## Installation

This module requires PowerShell 7 and should work on Windows, Linux, and macOS. To install the module from the PowerShell Gallery, run the following command:

```powershell
Install-Module PSIntro
```

If you are using the newer, and recommended `Microsoft.PowerShell.PSResourceGet` module, run:

```powershell
Install-PSResource -Name PSIntro
```

## Overview

This module grew out of discussions with Jason Helmick about providing a beginner interface to PowerShell for new users. Years ago, some products would offer a "splash" screen or welcome screen when the application started. This module provides similar functionality for PowerShell. In addition to a splash screen of information, the module also includes a set of interactive tutorials for beginners on core PowerShell concepts.

## [Get-PSIntro](docs/Get-PSIntro.md)

When the user starts PowerShell, they can be presented with this welcome or "splash" screen.

![PSIntro](images/psintro.png)

When run in Windows Terminal, or similar, the links should be clickable, including a link to online help for `Update-Help`. This is a command that could go into a user's profile.

```powershell
Get-PSIntro
```

If the user runs:

```powershell
Get-PSIntro -tutorial
```

This will display the welcome screen with a tutorial prompt.

![Get-PSIntro with tutorial prompt](images/tutorial-prompt.png)

The user can also use the `-ModuleStatus` parameter to display the status of key modules.

```powershell
Get-PSIntro -ModuleStatus
```

![Get-PSIntro with module status](images/psintro-module-status.png)

This feature is meant to provide a quick reference of critical modules. These are modules that have a high impact on the user experience.

This information is also available by running [`Get-ModuleStatus`](docs/Get-ModuleStatus.md).

## [Start-Tutorial](docs/Start-Tutorial.md)

The module includes a set of interactive tutorials. Running `Start-Tutorial` presents a simple menu.

![Start-Tutorial](images/start-pstutorial.png)

Or the user can run the command specifying a topic.

```powershell
PS C:\> Start-Tutorial 'Get-Command'
```

If the user elects to run tutorials from the welcome screen, the tutorials will be run consecutively in a pre-defined order. No menu will be presented.

![Get-Command tutorial](images/gcm-tutorial.png)

## Tutorials

The tutorials are written as PowerShell scripts with a combination of formatted text and __live__ console output from the user's session. This ensures that output is relevant to the user's environment.

![Interactive tutorial](images/interactive.png)

The tutorials use $PSStyle for formatting.

## Localization

Beginning with v0.8.0 message strings are localized for en-US and fr-FR cultures. Support for de-DE was added in v0.10.0. Tutorials have been translated from English using Claude Sonnet 3.7. All other localization translations were done in VS Code using GPT-5 mini. I welcome PRs with human-reviewed translations.

## Future Development

This is a list of items under consideration for future development.

- Are there other key modules that should be included?
- Export tutorials to Polyglot notebooks.
- Additional tutorial topics:
  - PSReadline fundamentals
  - Using $PSStyle
  - Understanding PSDrives
  - PSResourceGet
