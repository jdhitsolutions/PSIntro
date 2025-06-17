# PSIntro

![](images/PowerShell-transparent-thumb.jpg)

This is a reference module for PowerShell beginners. Beginning with v0.8.0 message strings are localized for en-US and fr-FR cultures. Tutorials have been translated from English using Claude Sonnet 3.7.

> __This is a private repository during development. This module is not available on the PowerShell Gallery.__

## [Get-PSIntro](docs/Get-PSIntro.md)

When the user starts PowerShell, they can be presented with this welcome or "splash" screen.

![PSIntro](images/psintro.png)

When run in Windows Terminal, or similar, the links should be clickable, including a link to online help for `Update-Help`. This is a command that could go into a user's profile. I will add code so that the welcome screen can be displayed once every 24 hours.

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

The tutorials are written as PowerShell scripts with a combination of formatted text and live console output from the user's session. This ensures that output is relevant to the user's environment.

![Interactive tutorial](images/interactive.png)

The tutorials use $PSStyle for formatting.

## Future Development

This is a list of items under consideration for future development.

- Are there other key modules that should be included?
- Update `Get-PSIntro` to show the splash screen only once every 24 hours.
