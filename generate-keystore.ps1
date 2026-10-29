<#
.SYNOPSIS
    Generates a keystore for Android app signing and outputs GitHub Secrets.

.DESCRIPTION
    This script creates a release.keystore file and generates the base64 encoding
    needed for GitHub Actions secrets.

.NOTES
    Run this in PowerShell as Administrator.
    Keep the generated files SAFE - they are your signing keys!
#>

param(
    [string]$Alias = "release-key",
    [string]$KeyPassword = "",
    [string]$StorePassword = "",
    [string]$DName = "CN=Your Name, OU=Your Unit, O=Your Org, L=City, S=State, C=US",
    [int]$ValidityDays = 10000,
    [int]$KeySize = 2048
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Android Keystore Generator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Prompt for passwords if not provided
if (-not $KeyPassword) {
    $KeyPassword = Read-Host -AsSecureString "Enter KEY password" | ConvertFrom-SecureString
    $KeyPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyPassword))
}

if (-not $StorePassword) {
    $StorePassword = Read-Host -AsSecureString "Enter KEYSTORE password" | ConvertFrom-SecureString
    $StorePassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($StorePassword))
}

$KeystorePath = "release.keystore"
$Base64Path = "release.keystore.base64"

# Check if keystore already exists
if (Test-Path $KeystorePath) {
    Write-Warning "Keystore already exists at $KeystorePath"
    $overwrite = Read-Host "Overwrite? (y/N)"
    if ($overwrite -ne 'y') {
        Write-Host "Aborted." -ForegroundColor Yellow
        exit
    }
}

Write-Host "`nGenerating keystore..." -ForegroundColor Green

# Generate keystore
$keytool = "keytool"
if (-not (Get-Command $keytool -ErrorAction SilentlyContinue)) {
    # Try common Java locations
    $javaHome = $env:JAVA_HOME
    if ($javaHome -and (Test-Path "$javaHome\bin\keytool.exe")) {
        $keytool = "$javaHome\bin\keytool.exe"
    } else {
        Write-Error "keytool not found. Please install JDK and set JAVA_HOME."
        exit 1
    }
}

& $keytool -genkeypair `
    -alias $Alias `
    -keyalg RSA `
    -keysize $KeySize `
    -validity $ValidityDays `
    -keystore $KeystorePath `
    -storepass $StorePassword `
    -keypass $KeyPassword `
    -dname $DName

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to generate keystore"
    exit 1
}

Write-Host "`nConverting to Base64..." -ForegroundColor Green
[Convert]::ToBase64String([IO.File]::ReadAllBytes($KeystorePath)) | Out-File -FilePath $Base64Path -Encoding ASCII

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  KEYSTORE CREATED SUCCESSFULLY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Files created:" -ForegroundColor Yellow
Write-Host "  • $KeystorePath (KEEP THIS SAFE!)"
Write-Host "  • $Base64Path (for GitHub Secrets)"
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GITHUB SECRETS TO ADD" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Go to: Settings → Secrets and variables → Actions → New repository secret" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. SIGNING_KEY_BASE64" -ForegroundColor Green
Write-Host "   Value: (content of $Base64Path)" -ForegroundColor Gray
Write-Host ""
Write-Host "2. KEY_ALIAS" -ForegroundColor Green
Write-Host "   Value: $Alias" -ForegroundColor Gray
Write-Host ""
Write-Host "3. KEY_STORE_PASSWORD" -ForegroundColor Green
Write-Host "   Value: $StorePassword" -ForegroundColor Gray
Write-Host ""
Write-Host "4. KEY_PASSWORD" -ForegroundColor Green
Write-Host "   Value: $KeyPassword" -ForegroundColor Gray
Write-Host ""
Write-Host "========================================" -ForegroundColor Red
Write-Host "  ⚠️  BACKUP release.keystore SECURELY!" -ForegroundColor Red
Write-Host "  ⚠️  DO NOT COMMIT TO GIT!" -ForegroundColor Red
Write-Host "========================================" -ForegroundColor Red

# Show base64 content for easy copying
Write-Host "`nBase64 content (copy for SIGNING_KEY_BASE64):" -ForegroundColor Cyan
Get-Content $Base64Path