# VitualBox Scripts

There are some scripts for automatic start and stop batch of virtual machines in OracleVirtualBox via CLI.

## How to use

I use scripts with Windows Task Scheduler.

### Auto start VMs on server start

1. Open TaskScheduler, right-click on "Task Scheduler Library" and then click on **"Create New Task"**
2. On **"General"** tab
    1. Write a name of task
    2. In **"Secutiy option"** block choose option `Run whether user is logged on or not`
    3. In **"Secutiy option"** block set option `Run with highest privileges`
3. On **"Triggers"** tab click "New"
    1. Choose begin the task `At startup`
    2. Set **"Delay task for"** to `30 sec` for getting system to warmup
    3. Click "Ok"
4. On **"Actions"** tab click **"New"**
    1. Action must be set `Start a program`
    2. In **"Program/script:"** write `powershell.exe`
    3. In **"Add arguments (optional)"** write `-File <path_to_StartVMsScript.ps1>`
    4. Click "Ok"
5. On **"Conditions"** tab
    1. Unset all options if you don't need neither.
6. On **"Settings"** tab
    1. Unset options that stops the task
    2. Set options that needed only for you

### Savestate of VMs on server shutdown

1. Open TaskScheduler, right-click on "Task Scheduler Library" and then click on **"Create New Task"**
2. On **"General"** tab
    1. Write a name of task
    2. In **"Secutiy option"** block choose option `Run whether user is logged on or not`
    3. In **"Secutiy option"** block set option `Run with highest privileges`
3. On **"Triggers"** tab click "New"
    1. Choose begin the task `On an event`
    2. In **"Settings"** block choose `Basic` option
    3. In **"Settings"** block set `System` for **Log** option
    4. In **"Settings"** block set `User32` for **Source** option
    5. In **"Settings"** block set `1074` for **EventID** option
    6. Click "Ok"
1. On **"Actions"** tab click **"New"**
    1. Action must be set `Start a program`
    2. In **"Program/script:"** write `powershell.exe`
    3. In **"Add arguments (optional)"** write `-File <path_to_StartVMsScript.ps1>`
    4. Click "Ok"
1. On **"Conditions"** tab
    1. Unset all options if you don't need neither.
1. On **"Settings"** tab
    1. Unset options that stops the task
    2. Set options that needed only for you
