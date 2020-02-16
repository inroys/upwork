<# 
1. Get all log files 
2. Create dictionary with key (month) => value (all logs corresponding to that months as list)
3. All the logs files and map them as list to dictionary
#4. Read the contents of all the files except first 3 lines and write it to a new file
#>

param(
    [Parameter(Mandatory=$False, Position=0, ValueFromPipeline=$false)]
    [System.String]
    $PathWhereAllLogFilesAreLocated = "LogFiles",

    [Parameter(Mandatory=$False, Position=1, ValueFromPipeline=$false)]
    [System.String]
    $DestinationPathWhereToCopy = "Result"
)

#1. Get all log files 
$LogFiles = Get-ChildItem $PathWhereAllLogFilesAreLocated -Name -Include *.log

#2.Create dictionary with key (month) => value (all logs corresponding to that months as list)
$MonthsHash = @{}
foreach ($item In $LogFiles) {
    $null = $item -match '\d{4}\d{2}'
    $yearMonthMatch = $Matches[0]
    if ($MonthsHash.ContainsKey($yearMonthMatch)) {
        $MonthsHash[$yearMonthMatch] += $item;
    } else {
        $MonthsHash[$yearMonthMatch] = @($item)
    }
}

#3. Move the log files to a new directory based on month names.
foreach ($month in $MonthsHash.GetEnumerator()) {
    $destinationMonthFolder = Join-Path -Path $DestinationPathWhereToCopy -ChildPath $($month.Name)
    foreach ($item In $($month.Value)) {
        $logFilePath = Join-Path -Path $PathWhereAllLogFilesAreLocated -ChildPath $item

        if (!(Test-Path -path $destinationMonthFolder)) { New-Item $destinationMonthFolder -Type Directory }
        $destinationLogFilePath = Join-Path -Path $destinationMonthFolder -ChildPath $item
        copy-item $logFilePath $destinationLogFilePath -Force
    }

    #4. Read the contents of all the files except first 3 lines and write it to a new file
    foreach ($logFilePath in Get-ChildItem $destinationMonthFolder -recurse) {
        #Write-output $logFilePath.FullName
        $lines = @(Get-content $logFilePath.FullName | select-object -skip 3)
        #Write-output $lines
        Add-Content "$destinationMonthFolder.txt" $lines
    }
}

