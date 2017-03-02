
Get-ChildItem -Path "C:\elasticSearch\elasticsearch-2.4.3\logs" -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt (Get-Date).AddDays(-15)} | Remove-Item -Force

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoLogo -NoProfile -NonInteractive -executionpolicy bypass  -command "& {Get-ChildItem -Path "C:\elasticSearch\elasticsearch-2.4.3\logs" -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt (Get-Date).AddDays(-15)} | Remove-Item -Force}" > c:\logclean.txt 2>&1'

$trigger =  New-ScheduledTaskTrigger -Daily -At 9am

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName cleaneslog -Description "clean es log"