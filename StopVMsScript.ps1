$vmboxInstallPath = "C:\Program Files\Oracle\VirtualBox";                       # Place here actual path to VirtualBox installation
$vmboxManage = $vmboxInstallPath + "\VBoxManage.exe";
$vmNameRegex = "^""(?<name>.*)"" {(?<uuid>\S{8}-\S{4}-\S{4}-\S{4}-\S{12})}$";

# Saving state of VMs

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

    $argsList = "controlvm " + $vmUuid + " savestate"
    Start-Process $vmboxManage -ArgumentList $argsList
}
