Translate each here-string block to French using straight quotes. Maintain a line length of approximately 100 characters.

<
# border characters
[string]$topLeft = [char]0x256d
[string]$bottomRight = [char]0x256f
[string]$topRight = [char]0x256e
[string]$bottomLeft = [char]0x2570
[string]$horizontal = [char]0x2500
[string]$vertical = [char]0x2502

#style settings
$borderColor = $PSStyle.Foreground.BrightGreen
$linkStyle = $PSStyle.Underline + $PSStyle.Italic + $PSStyle.Foreground.BrightYellow

$verString = "PowerShell v$($PSVersionTable.PSVersion)"
$links = [ordered]@{
    'PowerShell Documentation' = 'https://learn.microsoft.com/powershell'
    'PowerShell on Slack'      = 'https//aka.ms/psslack'
    'PowerShell on Discord'    = 'https://aka.ms/psdiscord'
    'PowerShell Team Blog'     = 'https://devblogs.microsoft.com/powershell'
    'GitHub Discussion'        = 'https://github.com/PowerShell/PowerShell/discussions'
}

$longestKey = $links.keys.length | Sort-Object | Select-Object -Last 1
#get longest line length
$longestLine = $links.GetEnumerator().Foreach({ '{0} : {1}' -f ($_.Key).PadRight($longestKey), $_.Value }).length | Sort-Object | Select-Object -Last 1

$width = $longestLine + 2
$head = @'

{0}{1}{2}{3}{4}{5}{6}

'@ -f $borderColor, $TopLeft, ($horizontal * 5), $verString, ($horizontal * ($width - $verString.Length - 5)), $TopRight, $reset

$Links.GetEnumerator() | ForEach-Object {
    $rawLine = '{0} : {1}' -f ($_.Key).PadRight($longestKey), $_.Value
    $line = "{0} : $LinkStyle{1}$reset" -f ($_.Key).PadRight($longestKey), $_.Value
    $head += "$borderColor{0}$reset {1} {2}$borderColor{0}$reset`n" -f $vertical, $line, (' ' * ($width - $rawLine.length - 2))
}

$head += '{0}{1}{2}{3}{4}' -f $borderColor, $bottomLeft, ($horizontal * $width), $bottomRight, $reset


