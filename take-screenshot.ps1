# Simplified PowerShell Screenshot Script for Sebathi V3

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Sebathi V3 Screenshot Capture Tool  " -ForegroundColor Cyan  
Write-Host "========================================`n" -ForegroundColor Cyan

# Open browser
Write-Host "[1/4] Opening browser..." -ForegroundColor Yellow
Start-Process "https://sebathi-v3.vercel.app"
Start-Sleep -Seconds 8

Write-Host "[2/4] Taking screenshot..." -ForegroundColor Yellow

# Capture full screen
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$screenshot = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($screenshot)
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)

# Save full screenshot temporarily
$tempPath = Join-Path $env:TEMP "sebathi-full-screenshot.png"
$screenshot.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose()
$screenshot.Dispose()

Write-Host "[3/4] Cropping to banner size..." -ForegroundColor Yellow

# Load and resize to banner dimensions (1200x630)
$sourceImage = [System.Drawing.Image]::FromFile($tempPath)

# Create banner-sized bitmap
$bannerWidth = 1200
$bannerHeight = 630

# Calculate scaling to maintain aspect ratio
$scaleWidth = $bannerWidth / $sourceImage.Width
$scaleHeight = $bannerHeight / $sourceImage.Height
$scale = [Math]::Max($scaleWidth, $scaleHeight)

$scaledWidth = [int]($sourceImage.Width * $scale)
$scaledHeight = [int]($sourceImage.Height * $scale)

# Create final banner
$banner = New-Object System.Drawing.Bitmap $bannerWidth, $bannerHeight
$bannerGraphics = [System.Drawing.Graphics]::FromImage($banner)
$bannerGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Draw and crop
$xOffset = [int](($bannerWidth - $scaledWidth) / 2)
$yOffset = 0  # Start from top
$bannerGraphics.DrawImage($sourceImage, $xOffset, $yOffset, $scaledWidth, $scaledHeight)

# Save final banner
$outputPath = "public\assets\sebathi-banner.png"
$banner.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$bannerGraphics.Dispose()
$banner.Dispose()
$sourceImage.Dispose()
Remove-Item $tempPath -Force -ErrorAction SilentlyContinue

Write-Host "[4/4] Saved banner!" -ForegroundColor Green
Write-Host "`n✅ SUCCESS!" -ForegroundColor Green
Write-Host "Screenshot saved to: $outputPath`n" -ForegroundColor Cyan
