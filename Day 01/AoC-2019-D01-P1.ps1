$Modules = Get-Content 'AoC-2019-D01-Input.txt'
$FuelRequired = 0

$Modules | ForEach-Object { $FuelRequired += [math]::Floor($_ / 3) - 2 }

$FuelRequired