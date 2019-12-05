$Wires = Get-Content 'AoC-2019-D03-Input.txt'

$FirstPath = $Wires[0].Split(",")
$SecondPath = $Wires[1].Split(",")

function Get-Coordinates ($Paths) { 
    $x = 0
    $y = 0
    $Coordinates = @{}  
    Write-Host "Calculating coordinates for $($Paths.Count) paths" 
    $Counter = 1
    foreach ($Path in $Paths) {
        

        $Direction = $Path[0]
        [int]$Distance = -join $Path[1..($Path.Length)]

        for ($i = 0; $i -lt $Distance; $i++) {
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

function Get-ManhattanDistance {  
    param (
        $X1,
        $Y1,
        $X2,
        $Y2
    )
    $Distance = [math]::abs($Y1 - $Y2) + [math]::abs($X1 - $X2)
    return $Distance  
}

$FirstCoordinates = Get-Coordinates -Paths $FirstPath
$FirstCoordinatesWithoutSelfIntersection = Remove-SelfIntersection -Coordinates $FirstCoordinates

$SecondCoordinates = Get-Coordinates -Paths $SecondPath
$SecondCoordinatesWithoutSelfIntersection = Remove-SelfIntersection -Coordinates $SecondCoordinates

$Intersections = Get-Intersections -FirstCoordinates $FirstCoordinatesWithoutSelfIntersection -SecondCoordinates $SecondCoordinatesWithoutSelfIntersection
$ShortestDistance = 0

Write-Host "Calculating Manhattan distance of $($Intersections.Count) intersections" 
foreach ($Intersection in $Intersections.Keys) {    
    $XYCoordinate = $Intersection -split ","
    [int]$XCoordinate = $XYCoordinate[0]
    [int]$YCoordinate = $XYCoordinate[1]
    $Distance = Get-ManhattanDistance -X1 0 -Y1 0 -X2 $XCoordinate -Y2 $YCoordinate
    if ($ShortestDistance -eq 0) {
        $ShortestDistance = $Distance
    }
    if ($Distance -lt$ShortestDistance) {
        $ShortestDistance = $Distance
    }
}

Write-Host "The shortest Manhattan distance is $ShortestDistance" 
