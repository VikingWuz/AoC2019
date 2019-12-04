$Range = Get-Content 'AoC-2019-D04-Input.txt'

[int]$RangeLow = ($Range.split("-"))[0]
[int]$RangeHigh = ($Range.split("-"))[1]
$PossiblePasswords = 0

function IsAdjacent($Number) {
    $HasAdjacentNumber = $false
    [string]$Number = $Number
    for ($i = 1; $i -lt $number.Length; $i++) {
        if (($Number[$i] - $Number[$i - 1]) -eq 0) {
            $HasAdjacentNumber = $true
            break
        }
    }
    if ($HasAdjacentNumber) {
        #Write-Host "Sequence has adjacent numbers"
        return $true
    } else {
        #Write-Host "Sequence DOESNT has adjacent numbers"
        return $false
    }
}

function Decreases($Number) {
    $NeverDecreases = $true
    [string]$Number = $Number
    for ($i = 1; $i -lt $number.Length; $i++) {
        if (($Number[$i] - $Number[$i - 1]) -lt 0) {
            $NeverDecreases = $false
            break
        }
    }
    if ($NeverDecreases -eq $true) {
        #Write-Host "Sequence never decreases"
        return $true
    } else {
        #Write-Host "Sequence decreases"
        return $false
    }
}

function CheckNumber($Number) {
    if (IsAdjacent -Number $Number) {
        if(Decreases -Number $Number) {
            return $true
        } else {
            return $false
        }
    } else {
        return $false
    }
}

$TotalPossibilietiesToCheck = $RangeHigh - $RangeLow + 1
Write-Host "Checking $TotalPossibilietiesToCheck possibilities"
$Counter = 0

for($i = $RangeLow; $i -le $RangeHigh ; $i++){
    $Counter++
    if (($Counter % 50000) -eq 0) {
        Write-Host "Checked $Counter possibilities"
    }
    if (CheckNumber -Number $i) {
        $PossiblePasswords++
    }
}

Write-Host "$PossiblePasswords possible passwords found"

