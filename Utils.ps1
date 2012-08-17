# General Utility Functions

function Coalesce-Args {
    $result = $null
    foreach($arg in $args) {
        if ($arg -is [ScriptBlock]) {
            $result = & $arg
        } else {
            $result = $arg
        }
        if ($result) { break }
    }
    $result
}

Set-Alias ?? Coalesce-Args -Force

function Get-LocalOrParentPath($path) {
    $checkIn = Get-Item .
    while ($checkIn -ne $NULL) {
        $pathToTest = [System.IO.Path]::Combine($checkIn.fullname, $path)
        if (Test-Path $pathToTest) {
            return $pathToTest
        } else {
            $checkIn = $checkIn.parent
        }
    }
    return $null
}

function Limit-Path ($path, $limit) {
    if (!$path -or $path.Length -le $limit) { return $path }

    $takeBefore = 1 + $path.IndexOf('\')
    $between = '...'
    $takeAfter = $path.IndexOf('\', $path.Length - ($limit - $between.Length - $takeBefore))
    if ($takeAfter -lt 0) { $takeAfter = $path.LastIndexOf('\') }
    $path.Substring(0, $takeBefore) + $between + $path.Substring($takeAfter, $path.Length - $takeAfter)
}

function dbg ($Message, [Diagnostics.Stopwatch]$Stopwatch) {
    if($Stopwatch) {
        Write-Verbose ('{0:00000}:{1}' -f $Stopwatch.ElapsedMilliseconds,$Message) -Verbose # -ForegroundColor Yellow
    }
}
