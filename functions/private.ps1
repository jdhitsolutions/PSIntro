#these are private helper functions

$e = [char]27
$reset = "$e[0m"

function pause {
    Param(
        [int]$CurrentPage,
        [int]$TotalPageCount
    )
    #display progress. Page progress makes more sense as the percentage on the
    #first page could be 6% which seems odd. Page 1/17 is clearer.
    if ($CurrentPage -AND $TotalPageCount) {
        $progress = "Page $CurrentPage/$TotalPageCount"
        #"{0:p0}" -f ($CurrentPage/$TotalPageCount)
    }

    $rh = (Read-Host "$e[3;37m[$progress] $e[3;37m$($strings.continue) $e[0m")
    if ( ($rh -eq 'q') -AND ($script:tutorialParam.ContainsKey('menu'))) {
        $script:i = 1000
       ## Start-PSTutorial
    }
    elseif ($rh -eq 'q') {
        Clear-Variable -name i,pg,tutorialParam -Scope Script
        Clear-Variable -name CurrentPage
        $msg = $strings.tutorialCommand -f $cmdStyle,$reset
        Write-Host "`n$msg"
        Break
    }
    elseif ($rh -eq 'p' -AND $CurrentPage -gt 1) {
        $script:i-=2
        $script:pg-=2
        Clear-Host
    }
    else {
        "$($e)[2A"
        "$($e)[K"
        "$($e)[3A"
        "$($e)[1G"
    }
}

Function Format-BorderBox {
    [CmdletBinding()]
    Param (
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            HelpMessage = 'Enter the text to be displayed in the box.'
        )]
        #blank lines should be allowed
        [string[]]$Text,
        [Parameter(HelpMessage = 'Enter an optional title')]
        [string]$Title,
        [Parameter(HelpMessage = 'Specify an ANSI or PSStyle sequence for the border color.')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = "$e[92m"
    )

    Begin {
        [string]$topLeft = [char]0x256d
        [string]$bottomRight = [char]0x256f
        [string]$topRight = [char]0x256e
        [string]$bottomLeft = [char]0x2570
        [string]$horizontal = [char]0x2500
        [string]$vertical = [char]0x2502
        $Reset = "$e[0m"

        $list = [System.Collections.Generic.List[string]]::new()
    } #begin
    Process {
        foreach ($line in $Text) {
            $list.Add($line)
        }
    } #process
    End {
        #process the list of strings stripping off any ANSI codes
        $longestLine = ($list | ForEach-Object { $_ -replace '\x1b\[[0-9;]*m', '' } | Sort-Object -Property Length | Select-Object length -Last 1).length
        $width = $longestLine + 2
        $box = @'

{0}{1}{2}{3}{4}{5}{6}

'@ -f $borderColor, $TopLeft, ($horizontal * 5), $Title, ($horizontal * ($width - $Title.Length - 5)), $TopRight, $reset

        #Add each line to the head
        foreach ($line in $list) {
            #get the length of the line without any ANSI codes
            $rawLine = $line -replace '\x1b\[[0-9;]*m', ''
            $box += "$borderColor{0}$reset {1} {2}$borderColor{0}$reset`n" -f $vertical, $line, (' ' * ($width - $rawLine.length - 2))
        }

        $box += '{0}{1}{2}{3}{4}' -f $borderColor, $bottomLeft, ($horizontal * $width), $bottomRight, $reset

        $box
    } #end
}

function ConvertTo-AnsiColor {
    param([string]$Color)

    $colorMap = @{
        "Black"       = "$([char]27)[30m"
        "DarkBlue"    = "$([char]27)[34m"
        "DarkGreen"   = "$([char]27)[32m"
        "DarkCyan"    = "$([char]27)[36m"
        "DarkRed"     = "$([char]27)[31m"
        "DarkMagenta" = "$([char]27)[35m"
        "DarkYellow"  = "$([char]27)[33m"
        "Gray"        = "$([char]27)[37m"
        "DarkGray"    = "$([char]27)[90m"
        "Blue"        = "$([char]27)[94m"
        "Green"       = "$([char]27)[92m"
        "Cyan"        = "$([char]27)[96m"
        "Red"         = "$([char]27)[91m"
        "Magenta"     = "$([char]27)[95m"
        "Yellow"      = "$([char]27)[93m"
        "White"       = "$([char]27)[97m"
    }

    return $colorMap[$Color]
}

<#
function old_pause {
    Param(
        [int]$CurrentPage,
        [int]$TotalPageCount
    )
    #display progress. Page progress makes more sense as the percentage on the
    #first page could be 6% which seems odd. Page 1/17 is clearer.
    if ($CurrentPage -AND $TotalPageCount) {
        $progress = "Page $CurrentPage/$TotalPageCount"
        #"{0:p0}" -f ($CurrentPage/$TotalPageCount)
    }
    $r = (Read-Host "$e[3;37m[$progress] $e[3;37m$($strings.continue) $e[0m")
    if ($r -eq 'q') {
        $msg = $strings.tutorialCommand -f $cmdStyle,$reset
        Write-Host "`n$msg"
        Break
    }
    else {
        "$($e)[2A"
        "$($e)[K"
        "$($e)[3A"
        "$($e)[1G"
    }
}
#>