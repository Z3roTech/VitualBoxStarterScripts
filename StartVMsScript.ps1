$vmboxInstallPath = "C:\Program Files\Oracle\VirtualBox";                       # Place here actual path to VirtualBox installation
$vmboxManage = $vmboxInstallPath + "\VBoxManage.exe";
$vmboxHeadless = $vmboxInstallPath + "\VBoxHeadless.exe";
$vmNameRegex = "^""(?<name>.*)"" {(?<uuid>\S{8}-\S{4}-\S{4}-\S{4}-\S{12})}$";

# Start all VMs
Write-Output "Starting VMs..."

$excludeVMs = $null;                                                            # Place here VM names or uuid that must be excluded from auto-start. Example: $excludeVMs = "git", "app";
$vms = & $vmboxManage list vms

foreach($vm in $vms) {
    $msg = "Controlling " + $vm;
    Write-Output $msg
    if (-not ($vm -match $vmNameRegex)) {
        $msg = "There are error with " + $vm;
        Write-Error $msg;
        continue;
    }

    $vmName = $Matches.name
    $vmUuid = $Matches.uuid

    if ($excludeVMs -contains $vmName -or
        $excludeVMs -contains $vmUuid) {
        $msg = "VM " + $vm + " excluded from auto-start!";
        Write-Output $msg;
        continue;
    }

    $argsList = "-s " + $vmUuid + " -v on"
    Start-Process $vmboxHeadless -ArgumentList $argsList
}
