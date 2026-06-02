# install-apps.ps1

# This script installs a list of applications using winget and also downloads and installs some applications directly from their websites.

$apps = @(
    "7zip.7zip",
    "Discord.Discord",
    "Spotify.Spotify",
    "Valve.Steam",
    "LocalSend.LocalSend",
    "RevoUninstaller.RevoUninstaller",
    "Google.Chrome",
    "JAMSoftware.TreeSize.Free",
    "voidtools.Everything",
    "Logitech.GHUB"
)

foreach ($app in $apps) {
    Write-Host "Installing $app..." -ForegroundColor Cyan
    winget install -e --id $app --silent --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "$app installed successfully." -ForegroundColor Green
    }
    else {
        Write-Host "$app failed (exit code $LASTEXITCODE)." -ForegroundColor Yellow
    }
}

Write-Host "Done." -ForegroundColor Cyan

# Install HWiNFO

$url = "https://www.hwinfo.com/files/hwi64_846.exe"
$output = "$env:TEMP\hwi64_846.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -ArgumentList "/VERYSILENT /NORESTART" -Wait
Remove-Item -Path $output -Force


# Installing NVIDIA APP

$url = "https://us.download.nvidia.com/nvapp/client/11.0.7.247/NVIDIA_app_v11.0.7.247.exe"
$output = "$env:TEMP\NVIDIA_app_v11.0.7.247.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -ArgumentList "/S" -Wait
Remove-Item -Path $output -Force

# Installing Rockstar Games Launcher

$url = "https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe"
$output = "$env:TEMP\Rockstar-Games-Launcher.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -ArgumentList "/VERYSILENT /NORESTART" -Wait
Remove-Item -Path $output -Force


#Downloading FiveM into Downloads folder

$url = "https://runtime.fivem.net/client/FiveM.exe"
$output = "C:\Users\$env:USERNAME\Downloads\FiveM.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Write-Host "FiveM downloaded to $output" -ForegroundColor Green


# Creating shortcuts for Intel Platform Performance Package and Motherboard Drivers on the desktop

Write-Host "Don't forget to install Intel Platform Performance Package & Motherboard Drivers" -ForegroundColor Cyan
$installIntel = "https://www.intel.com/content/www/us/en/download/869519/intel-platform-performance-package.html"
new-item -Path "C:\Users\$env:USERNAME\Desktop\Intel Platform Performance Package.url" -ItemType File -Value "[InternetShortcut]`nURL=$installIntel"
Write-Host "A shortcut to download Intel Platform Performance Package has been created on your desktop." -ForegroundColor Green

$motherboardDrivers = "https://www.gigabyte.com/Motherboard/Z890-AORUS-ELITE-WIFI7-ICE/support"
New-item -Path "C:\Users\$env:USERNAME\Desktop\Motherboard Drivers.url" -ItemType File -Value "[InternetShortcut]`nURL=$motherboardDrivers"
Write-Host "A shortcut to download motherboard drivers has been created on your desktop." -ForegroundColor Green
