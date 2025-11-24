#these are private helper functions

function pause {
    $r=(Read-Host "`e[3;37m$($strings.continue)$($PSStyle.Reset)")
    if ($r -eq 'q') {
        Break
    }
    else {
        "`e[2A"
        "`e[K"
        "`e[3A"
        "`e[1G"
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
        [ValidateNotNullOrEmpty()]
        [string[]]$Text,
        [Parameter(HelpMessage = 'Enter an optional title')]
        [string]$Title,
        [Parameter(HelpMessage = 'Specify an ANSI or PSStyle sequence for the border color.')]
        [ValidateNotNullOrEmpty()]
        [string]$BorderColor = $PSStyle.Foreground.BrightGreen
    )

    Begin {
        [string]$topLeft = [char]0x256d
        [string]$bottomRight = [char]0x256f
        [string]$topRight = [char]0x256e
        [string]$bottomLeft = [char]0x2570
        [string]$horizontal = [char]0x2500
        [string]$vertical = [char]0x2502
        $Reset = $PSStyle.Reset

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