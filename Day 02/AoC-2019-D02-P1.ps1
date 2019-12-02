[int[]]$Integers = (Get-Content 'AoC-2019-D02-Input.txt').Split(",")

$Integers[1] = 12
$Integers[2] = 2

$ProgramNotHalted = $true
$i = 0

while ($ProgramNotHalted) {
    $Opcode = $Integers[$i]
    switch ($Opcode) {
        1 {
            $AddValue1 = $Integers[$i + 1]
            $AddValue2 = $Integers[$i + 2]         
            $AddWhereToStore = $Integers[$i + 3]

            $AddResult = $Integers[$AddValue1] + $Integers[$AddValue2]
            $Integers[$AddWhereToStore] = $AddResult
            break
        }
        2 {
            $MultiplyValue1 = $Integers[$i + 1]
            $MultiplyValue2 = $Integers[$i + 2]         
            $MultiplyWhereToStore = $Integers[$i + 3]

            $MultiplyResult = $Integers[$MultiplyValue1] * $Integers[$MultiplyValue2]
            $Integers[$MultiplyWhereToStore] = $MultiplyResult
            break
        }
        99 {
            $ProgramNotHalted = $false
            break
        }
        Default {
            Write-Host "Something went wrong"
            break
            
        }
    }
    $i = $i + 4 
}

$Integers[0]


<#
[System.Collections.ArrayList]$steps = @()
foreach ($Integer in $Integers) {
    $steps += $Integer
}

$steps[1] = 12
$steps[2] = 2



#>