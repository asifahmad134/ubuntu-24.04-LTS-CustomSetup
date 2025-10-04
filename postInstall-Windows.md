# Essential Tweaks - Steps to do after clean install

###### Chris Titus Tech's Windows Utility

irm "https://christitus.com/win" | iex

###### MAS activation script to activate Windows / MS Office

irm https://get.activated.win | iex

###### Allow scripts to run

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

###### Disable the Reserved Storage

- by changing following value from 1 to 0. (reduction approx 4 GiB)
- HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager
- after that Run DISM, immediately restart, now reserved storage will be disabled.

```
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v ShippedWithReserves /t REG_DWORD /d 0 /f

DISM /Online /Set-ReservedStorageState /State:Disabled
```

###### Turnoff Hibernation (reduction approx 1+ GiB)

```
powercfg /h /type reduced
powercfg /hibernate off
powercfg /hibernate on
powercfg /batteryreport
```

###### Only after all updates & AME, to Reduce WinSXS Folder Size in Windows (reduction approx 1-3 GiB)

```
DISM /Online /Cleanup-Image /AnalyzeComponentStore
DISM /Online /Cleanup-Image /StartComponentCleanup
cleanmgr /d C: /VERYLOWDISK
DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
```

###### Only after all above, for error correction, Check C drive (Windows drive) at startup

```
chkdsk C: /x /b /spotfix
chkdsk C: /F /R /X /B
```

###### Only Win 10, for free up space by compressing installation footprint (reduction approx 2-3 GiB)

```
Compact /CompactOS:query
Compact /compactOS:always
// Run this in command console (old) in SAFE MODE in the main dir C:\
compact /c /i /s:\ /EXE:LZX
```

###### To delete startup items, this will improve startup time

```
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32", "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce" -Force -Recurse
```

##### Delete this regedit value to delete intel graphics utility menu (in old systems)

```
Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\igfxcui" -Force
Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\igfxDTCM" -Force
```

###### Delete 3D Objects on Windows 10 64-bit, Go to & delete:

```
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force
Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force
```

###### Delete / Disable these services in hp laptop

```
Get-Service ETDService, HPAppHelperCap, HPDiagsCap, HPNetworkCap, HpTouchpointAnalyticsService, HPSysInfoCap, RtkAudioUniversalService | ForEach-Object { Stop-Service -Name $_.Name -Force; Set-Service -Name $_.Name -StartupType Disabled }
```

###### Removes the Home and Gallery from explorer and sets This PC as default

```
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /f

REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d "1"
```

###### Prevent Device Encryption (no need if secure boot / TPM disabled)

```
manage-bde -status
Disable-BitLocker -MountPoint "C:"
manage-bde -off C:
```

###### hp laptop info (bought in Feb 2022)

```
Model: 15-ef2126wm
ProdID: 4J771UA#ABA
S/N#: SCD1462999
INPUT: 19.5Vdc ~~ 2.31A
```
