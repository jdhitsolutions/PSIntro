#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @"
continue = Press Enter to continue (Q to quit)
key = Key module status:
menuSelect = Select a menu option
menuTitle = PowerShell Tutorial Menu
psEssentials  = PowerShell Essentials
tutorialPrompt = Would you like to run a set of short interactive tutorial on essential PowerShell fundamentals?
tutorialContinue = Enter Y to continue
tutorialCommand = Run {0}Start-PSTutorial{1} for a list of brief PowerShell tutorials.
tutorialSkip = No problem. You can run {0}Start-PSTutorial{1} at any time.
updateNeeded = You may need to update or install the modules listed above.
upToDate = All key modules are up to date.
welcome = Welcome to PowerShell!
welcome_1 = Use any of the links above to get started learning more about PowerShell.
welcome_2 = It is recommended that you run {0}{1}{2} periodically to get the latest help content for PowerShell.
starting = Starting module command {0}
usingVersion = Using module version {0}
runningPS = Executing in PowerShell v{0}
addingModule = Adding module {0} to the list
validating = Validating {0} modules
ending = Ending module command {0}
quit = Quit
"@