clear

$lista = Get-Counter -ListSet * | Where-Object CounterSetName -eq "SignalR" | Select -ExpandProperty PathsWithInstances


$list = New-Object System.Collections.ArrayList;
foreach($name in Get-Counter -ListSet * | Where-Object CounterSetName -eq "SignalR" | Select -ExpandProperty PathsWithInstances)
{
    [regex]$regex = '.+\(([\w-]+)\)\\(.+)';
    
    $item = New-Object System.Object
    $item | Add-Member -MemberType NoteProperty -Name "#{SIGNALAPPNAME}" -Value $regex.Matches($name).groups[1].Value
    $item | Add-Member -MemberType NoteProperty -Name "#{SIGNALCOUNTERNAME}" -Value $regex.Matches($name).groups[2].Value

    $list.Add($item) | Out-Null;
}

write-host "{"
write-host " `"data`":"
$list | ConvertTo-Json
write-host "}"
