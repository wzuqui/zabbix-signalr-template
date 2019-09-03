clear

$list = New-Object System.Collections.ArrayList;
foreach($name in Get-Counter -ListSet * | Where-Object CounterSetName -eq "SignalR" | Select -ExpandProperty PathsWithInstances)
{
    [regex]$regex = '.+\(([\w-]+)\)\\(.+)';
    
    $item = New-Object System.Object
    $item | Add-Member -MemberType NoteProperty -Name name -Value $regex.Matches($name).groups[1].Value
    $item | Add-Member -MemberType NoteProperty -Name proc -Value $regex.Matches($name).groups[2].Value

    $list.Add($item) | Out-Null;
}
$idx = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($name in $list)
{
    if ($idx -lt $list.Count)
        {
            $line= "{ `"{#SIGNALAPPNAME}`" : `"" + $name.name + "`, `"{#SIGNALCOUNTERNAME}`" : `"" + $name.proc + "`" }," | convertto-encoding "cp866" "utf-8"
            write-host $line
        }
    elseif ($idx -ge $list.Rows.Count)
        {
            $line= "{ `"{#SIGNALAPPNAME}`" : `"" + $name.name + "`, `"{#SIGNALCOUNTERNAME}`" : `"" + $name.proc + "`" }" | convertto-encoding "cp866" "utf-8"
            write-host $line
        }
    $idx++;
}

 write-host
write-host " ]"
write-host "}"
