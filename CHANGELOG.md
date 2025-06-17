# Changelog for PSIntro

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
- Changed tutorial prompt to use Y as the continuation character for all cultures.
- Fixed localization issues on non-Windows systems where no culture is detected. [[Issue #6](https://github.com/jdhitsolutions/PSIntro/issues/6)]

## [0.8.0] - 2025-06-16

### Added

- Added localization of string data for messaging and prompts. Command help has __not__ been localized.
- Added French localization for the module including tutorials.

### Changed

- Moved tutorials to culture-specific folder and updated code to use culture-aware versions.
- Updated `README.md`. [[Issue #5](https://github.com/jdhitsolutions/PSIntro/issues/5)]

## [0.7.0] - 2025-06-11

### Added

- Added tutorial for PowerShell essentials and fundamentals.

### Changed

- Modified `Start-PSTutorial` to allow user to specify a topic. If no topic is specified, the user will get the menu.
- Updated the `Get-Member` tutorial.
- Updated the `Get-Help` tutorial.
- Updated the `Get-Command` tutorial.
- Help updates
- Updated `README`.

## [0.6.0] - 2025-05-30

### Added

- Added a link to the PowerShell Gallery in `Get-PSIntro`.

### Changed

- Modified `Get-PSIntro` so that the user needs to *opt-in* to get the tutorial prompt. Modified the tutorial parameter and reversed the behavior. __This is a breaking change from previous versions.__
- Minor updates to tutorials.
- Updated `README`.

## 0.5.0 - 2025-05-22

### Added

- Moved module status code to a new function `Get-ModuleStatus`.

### Changed

- Updated `Get-PSIntro` to not display module information by default. The command now has a parameter, `ModuleStatus`, to display the module status information.
- Updated `README`.
- Help updates.
- Exported public functions to separate files.

### Removed

- Removed the requirement for the ThreadJob module.

## 0.4.0 - 2025-05-12

### Added

- Initial release to GitHub

[Unreleased]: https://github.com/jdhitsolutions/PSIntro/compare/v0.8.0..HEAD
[0.8.0]: https://github.com/jdhitsolutions/PSIntro/compare/v0.7.0..v0.8.0
[0.7.0]: https://github.com/jdhitsolutions/PSIntro/compare/v0.6.0..v0.7.0
[0.6.0]: https://github.com/jdhitsolutions/PSIntro/compare/v0.5.0..v0.6.0