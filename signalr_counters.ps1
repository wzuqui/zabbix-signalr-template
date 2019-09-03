write-host "{"
write-host " `"data`":[`n"
foreach ($name in Get-Counter -ListSet * | Where-Object CounterSetName -eq "SignalR" | Select -ExpandProperty PathsWithInstances)
{
    if ($idx -lt $basename.Rows.Count)
        {
            $line= "{ `"{#SIGNALRNAME}`" : `"" + $name + "`" }," | convertto-encoding "cp866" "utf-8"
            write-host $line
        }
    elseif ($idx -ge $basename.Rows.Count)
        {
            $line= "{ `"{#SIGNALRNAME}`" : `"" + $name + "`" }" | convertto-encoding "cp866" "utf-8"
            write-host $line
        }
    $idx++;
}

 write-host
write-host " ]"
write-host "}"
