$repeat = (New-TimeSpan -Minutes 5)
$Trigger= New-ScheduledTaskTrigger -Once -At 11:19am -RepetitionInterval $repeat # Specify the trigger settings
$User= "$username" # Specify the account to run the script
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "$path" # Specify what program to run and with its parameters
Register-ScheduledTask -TaskName "copytask" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force # Specify the name of the task
