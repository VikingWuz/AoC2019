[int[]]$Integers = (Get-Content 'AoC-2019-D02-Input.txt').Split(",")
$SearchedOutput = 19690720
$PossibleValues = 99

:loop for ($x = 0; $x -lt $PossibleValues; $x++) {
    for ($y = 0; $y -lt $PossibleValues; $y++) {
        $Noun = $x
        $Verb = $y
        $Integers[1] = $Noun
        $Integers[2] = $Verb

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
        if ($Integers[0] -eq $SearchedOutput) {
            100 * $Noun + $Verb
            break loop
        } else {
            [int[]]$Integers = (Get-Content 'AoC-2019-D02-Input.txt').Split(",")
        }        
    }   
}



