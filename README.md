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

This module grew out of discussions with Jason Helmick about providing a beginner interface to PowerShell for new users. Years ago, some products would offer a "splash" or welcome screen when the application started. This module provides similar functionality for PowerShell. In addition to a splash screen of information, the module also includes a set of interactive tutorials for beginners on core PowerShell concepts.

The module also includes a few commands designed to help absolute beginners get started managing their PowerShell environment.

## [Get-PSIntro](docs/Get-PSIntro.md)

When the user starts PowerShell, they can be presented with this welcome or "splash" screen.

![PSIntro](images/psintro.png)

When run in Windows Terminal, or similar, the links should be clickable, including a link to online help for `Update-Help`. This is a command that could go into a user's profile.

```powershell
Get-PSIntro
```

> *This command has aliases of `psintro` and `pswelcome`.*

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

## [Get-ModuleStatus](docs/Get-ModuleStatus.md)

This information is also available by running `Get-ModuleStatus`.

```powershell
PS C:\> Get-ModuleStatus

Name                               Online Installed UpdateNeeded
----                               ------ --------- ------------
PSReadLine                         2.4.5  2.4.5     False
Microsoft.PowerShell.PSResourceGet 1.1.1  1.1.1     False
```

If the module requires an update, it will be styled in red. This feature is meant to provide a quick reference of critical modules. The default modules were selected as they have a high impact on the user experience.

However, you can pass any list of module names to check their status.

```powershell
PS C:\> Get-Content C:\work\modlist.txt | Get-ModuleStatus

Name                                 Online Installed UpdateNeeded
----                                 ------ --------- ------------
PSReadLine                           2.4.5  2.4.5     False
Microsoft.PowerShell.PSResourceGet   1.1.1  1.1.1     False
Microsoft.PowerShell.ThreadJob       2.2.0  2.1.0     True
Microsoft.PowerShell.ConsoleGuiTools 0.7.7  0.7.7     False
Pester                               5.7.1  5.7.1     False
```

## [Get-ProfileStatus](docs/Get-ProfileStatus.md)

The module also includes a command to display the status of PowerShell profile scripts. It will not create them but it will report the location of each profile script and whether it exists.

![Get-ProfileStatus](images/get-profilestatus.png)

To learn more about profile scripts, read the help documentation:

```powershell
PS C:\>help about_Profiles
```

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

The module contains a set of tutorials written for absolute PowerShell beginners. The tutorials are written as PowerShell scripts with a combination of formatted text and __live__ console output from the user's session. This ensures that output is relevant to the user's environment.

![Interactive tutorial](images/interactive.png)

The tutorials use $PSStyle for formatting.

You can quit a tutorial at any time by entering `q` at the prompt. Note that your progress __will not be saved__.

## Localization

Beginning with v0.8.0 message strings are localized for `en-US` and `fr-FR` cultures. Support for `de-DE` was added in v0.10.0. Tutorials have been translated from English using Claude Sonnet 3.7. All other localization translations were done in VS Code using GPT-5 mini.

> __*I welcome pull requests with human-reviewed translations.*__

If you add a new localization, you should include a culture-specific folder that is properly cased. Inside the folder should be a localized version of `PSIntro.psd1`. There should also be a `tutorials` folder with localized tutorial scripts. Finally, there should be a folder for localized Markdown help files. __Do not localize any of the Markdown headings such as `## Synopsis`__.

This file should be named with the last part of the culture name. For example, if you are providing a Spanish localization using the `es-ES` culture, the docs folder name would be `docs-ES`. All other files would be placed in `es-ES`. I will generate help files from the localized Markdown files with each new release.

## Future Development

This is a list of items under consideration for future development of this module.

- Are there other key modules that should be included by default?
  - Microsoft.PowerShell.ThreadJobs
  - Microsoft.PowerShell.ConsoleGuiTools
  - Pester
- Saving tutorial progress
- Export tutorials to Polyglot notebooks
- Additional tutorial topics:
  - PSReadline fundamentals
  - Using $PSStyle
  - Understanding PSDrives
  - PSResourceGet
  - PowerShell profile scripts
- Create a tutorial authoring framework

Please use the [Discussions](https://github.com/jdhitsolutions/PSIntro/discussions) section of the project's GitHub repository to share your thoughts, ideas, and suggestions.
