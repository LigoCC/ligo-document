# win开机自启动 定时任务
tasklist|find /i "DingtalkLauncher.exe" && echo started || start "" "C:\Program Files (x86)\DingDing\DingtalkLauncher.exe"
tasklist|find /i "Snipaste.exe" && echo started || start "" "C:\Snipaste-2.8.3-Beta-x64\Snipaste.exe"
tasklist|find /i "Docker Desktop.exe" && echo started || start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
tasklist|find /i "idea64.exe" && echo started || start "" "C:\Program Files\JetBrains\IntelliJ IDEA 2023.1\bin\idea64.exe"
