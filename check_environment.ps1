# Check if Visual Studio is installed with required components
$vsPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (-not (Test-Path $vsPath)) {
    Write-Host "Visual Studio not found. Please install Visual Studio 2019 or 2022 with:"
    Write-Host "- Desktop development with C++"
    Write-Host "- Universal Windows Platform development"
    Start-Process "https://visualstudio.microsoft.com/downloads/"
    exit 1
}

# Check Flutter prerequisites
flutter doctor -v

# Verify Windows 10 SDK
$windows10SDK = Get-ChildItem "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SDKs\Windows\v10.0" -ErrorAction SilentlyContinue
if (-not $windows10SDK) {
    Write-Host "Windows 10 SDK not found. Installing Visual Studio will include this."
    exit 1
}

Write-Host "Environment check completed. If any issues were found, please resolve them before running clean_project.sh"
