$Wires = Get-Content 'AoC-2019-D03-Input.txt'

$FirstPath = $Wires[0].Split(",")
$SecondPath = $Wires[1].Split(",")
$Global:IntersectionsStepsCounter = 0

function Get-Coordinates ($Paths) { 
    $x = 0
    $y = 0
    $Coordinates = @{}  
    Write-Host "Calculating coordinates for $($Paths.Count) paths" 
    $Counter = 1
    foreach ($Path in $Paths) {
        

        $Direction = $Path[0]
        [int]$CombinedSteps = -join $Path[1..($Path.Length)]

        for ($i = 0; $i -lt $CombinedSteps; $i++) {
            switch ($Direction) {
                L {
                    $x -= 1
                }
                R {
                    $x += 1
                }
                U {
                    $y += 1
                }
                D {
                    $y -= 1
                }
            }
            if ($Coordinates.ContainsKey("$x,$y")) {
                $Coordinates["$x,$y"]++
            } else {
                $Coordinates["$x,$y"] = 1
            }        
        }
        Write-Host "Calculated coordinates for $Counter paths" 
        $Counter++        
    }
    return $Coordinates
}

function Remove-SelfIntersection ($Coordinates) {
    Write-Host "Removing selfintersections from coordinates" 
    if ($Coordinates.ContainsValue(2)) {
        $SelfIntersections = $Coordinates.GetEnumerator() | Where-Object {$_.Value -eq 2}
        foreach ($SelfIntersection in $SelfIntersections.Key) {
            $Coordinates[$SelfIntersection] = 1
        }
        return $Coordinates
    } else {
        return $Coordinates
    }
}

function Get-Intersections {
    param (
        $FirstCoordinates,
        $SecondCoordinates
    )
    Write-Host "Calculating intersections" 
    $Coordinates = @{}
    foreach ($Key in $FirstCoordinates.Keys) {
        if ($SecondCoordinates.ContainsKey($Key)) {
            $Coordinates[$Key] = 2
        }
    }    
    return $Coordinates
}

function Get-LeastSteps {
    param (
        $IntersectionCoordinates,
        $Paths
    )
    $Steps = 0
    $x = 0
    $y = 0    

    foreach ($Path in $Paths) {
        $Direction = $Path[0]
        [int]$CombinedSteps = -join $Path[1..($Path.Length)]
        $Coordinates = @{}

        for ($i = 0; $i -lt $CombinedSteps; $i++) {
            switch ($Direction) {
                L {
                    $x -= 1
                }
                R {
                    $x += 1
                }
                U {
                    $y += 1
                }
                D {
                    $y -= 1
                }
            }
            if ($Coordinates.ContainsKey($IntersectionCoordinates)) {
                $Global:IntersectionsStepsCounter++
                Write-Host "Calculated steps for $Global:IntersectionsStepsCounter intersections"                 
                return $Steps
            } else {
                $Coordinates["$x,$y"] = 1
                $Steps++
            }        
        }              
    }    
    return $Steps
}

$FirstCoordinates = Get-Coordinates -Paths $FirstPath
$FirstCoordinatesWithoutSelfIntersection = Remove-SelfIntersection -Coordinates $FirstCoordinates

$SecondCoordinates = Get-Coordinates -Paths $SecondPath
$SecondCoordinatesWithoutSelfIntersection = Remove-SelfIntersection -Coordinates $SecondCoordinates

$Intersections = Get-Intersections -FirstCoordinates $FirstCoordinatesWithoutSelfIntersection -SecondCoordinates $SecondCoordinatesWithoutSelfIntersection
$Leaststeps = 0

#Double the amount because intersections have to calulated for both wires
$IntersectionsToCalculateForBothWires = $Intersections.Count * 2
Write-Host "Calculating least steps for $IntersectionsToCalculateForBothWires intersections" 
foreach ($Intersection in $Intersections.Keys) {    
        
    $FirstDistance = Get-LeastSteps -IntersectionCoordinates $Intersection -Path $FirstPath
    $SecondDistance = Get-LeastSteps -IntersectionCoordinates $Intersection -Path $SecondPath
    $CombinedSteps = $FirstDistance + $SecondDistance
    
    if ($Leaststeps -eq 0) {
        $Leaststeps = $CombinedSteps
    }
    if ($CombinedSteps -lt $Leaststeps) {
        $Leaststeps = $CombinedSteps
    }
}

Write-Host "The least steps are $Leaststeps" 
