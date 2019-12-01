$Modules = Get-Content 'AoC-2019-D01-Input.txt'
$FuelRequired = 0

$Modules | ForEach-Object { 
    $i = [math]::Floor($_ / 3) - 2 
    $FuelRequired += $i

    while ($i -gt 0) {
        $i = [math]::Floor($i / 3) - 2
        if ($i -gt 0) {
            $FuelRequired += $i
        } 
    }
}

$FuelRequired