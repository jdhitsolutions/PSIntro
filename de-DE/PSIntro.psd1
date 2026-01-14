#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @"
continue = Drücken Sie eine Taste, um fortzufahren (P für die vorherige Seite oder Q zum Beenden)
key = Status der wichtigsten Module:
menuSelect = Wählen Sie eine Menüoption
menuTitle = PowerShell Tutorial Menü
psEssentials = PowerShell Grundlagen
tutorialPrompt = Möchten Sie eine Reihe kurzer interaktiver Tutorials zu den grundlegenden PowerShell-Funktionen ausführen?
tutorialContinue = Geben Sie Y ein, um fortzufahren
tutorialCommand = Führen Sie {0}Start-PSTutorial{1} aus, um eine Liste kurzer PowerShell-Tutorials zu erhalten.
tutorialSkip = Kein Problem. Sie können {0}Start-PSTutorial{1} jederzeit ausführen.
updateNeeded = Möglicherweise müssen Sie die oben aufgeführten Module aktualisieren oder installieren.
upToDate = Alle wichtigen Module sind auf dem neuesten Stand.
welcome = Willkommen bei PowerShell!
welcome_1 = Verwenden Sie einen der obigen Links, um mehr über PowerShell zu lernen.
welcome_2 = Es wird empfohlen, dass Sie {0}{1}{2} regelmäßig ausführen, um die neuesten Hilfsinhalte für PowerShell zu erhalten.
starting = Starten des Modulbefehls {0}
usingVersion = Verwendete Modulversion {0}
runningPS = Ausführung in PowerShell v{0}
addingModule = Modul {0} zur Liste hinzufügen
validating = Validierung von {0} Modulen
ending = Beenden des Modulbefehls {0}
quit = Beenden
getProfile = Abrufen des Status des PowerShell-Profilskripts für den aktuellen Host.
addProfileComment = Get-PSIntro-Eintrag hinzugefügt
noProfileFound = Das Profilskript konnte nicht gefunden werden.
profilePrompt = Möchten Sie es erstellen? Geben Sie Y ein, um die Datei zu erstellen, eine andere Taste zum Abbrechen
cmdFound = Es sieht so aus, als ob ein Befehl für Get-PSIntro bereits im Profilskript {0} vorhanden ist.
updatePath = Aktualisiere PowerShell-Profilskript {0}
createPath = Erstelle PowerShell-Profilskript {0}
testPath = Teste PowerShell-Profilskript {0}
newProfile = Erstellen des PowerShell-Profilskripts für {0}
existingProfile = Ein vorhandenes PowerShell-Profilskript für {0} wurde unter {1} gefunden.
profileTutorialTitle = Erste Schritte mit PowerShell-Profilskripten
"@