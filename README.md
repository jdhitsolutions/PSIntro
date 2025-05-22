# PSIntro

![](images/PowerShell-transparent-thumb.jpg)

This is a reference module for PowerShell beginners.

## [Get-PSIntro](docs/Get-PSIntro.md)

When the user starts PowerShell, they can be presented with this welcome screen.

![PSIntro](images/psintro.png)

When run in Windows Terminal, or similar, the links should be clickable, including a link to online help for `Update-Help`.

By default, the user will be prompted to run a brief set of tutorials. Running `Get-PSIntro -NoTutorial` will display the welcome screen without the tutorial prompt. This is a command that could go into a user's profile. I will add code so that the welcome screen can be displayed once every 24 hours.

### Module Status

The user can also use the `-ModuleStatus` parameter to display the status of key modules. This feature is meant to provide a quick reference of critical modules. These are modules that have a high impact on the user experience.

This information is also available by running [`Get-ModuleStatus`[(docs/Get-ModuleStatus.md)].

## [Start-Tutorial](docs/Start-Tutorial.md)

The module includes a set of interactive tutorials. `Start-Tutorial` presents a simple menu.

![Start-Tutorial](images/start-pstutorial.png)

If the user elects to run tutorials from the welcome screen, the three tutorials will be run consecutively.

![Get-Command tutorial](images/gcm-tutorial.png)

## Tutorials

The tutorials are written as PowerShell scripts with a combination of formatted text and live console output from the user's session. This ensures that output is relevant to the user's environment.

![Interactive tutorial](images/interactive.png)

The tutorials use $PSStyle for formatting.

## Future Development

This is a list of items under consideration for future development.

- Move tutorials to culture folder so that they can be localized.
- Are there other key modules that should be included?
- Add a link to the PowerShell Gallery.
- Update `Get-PSIntro` to show the splash screen only once every 24 hours.
- Update `Get-PSIntro` to only show the welcome splash screen with links. No message, module status, or tutorial prompt.
