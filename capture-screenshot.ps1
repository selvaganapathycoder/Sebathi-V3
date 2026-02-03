# PowerShell Script to Capture Screenshot of Sebathi V3 App

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Write-Host "Opening Sebathi V3 in browser..." -ForegroundColor Cyan
Start-Process "http://localhost:3000"

# Wait for browser to open and page to load
Write-Host "Waiting 8 seconds for page to fully load..." -ForegroundColor Yellow
Start-Sleep -Seconds 8

# Maximize the browser window (send F11 for fullscreen, then F11 again to exit, or just maximize)
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WindowHelper {
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@

# Get the foreground window (browser) and maximize it
$hwnd = [WindowHelper]::GetForegroundWindow()
[WindowHelper]::ShowWindow($hwnd, 3) # 3 = SW_MAXIMIZE

Start-Sleep -Seconds 2

Write-Host "Capturing screenshot..." -ForegroundColor Green

# Get screen bounds
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Capture the screen
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)

# Save the screenshot
$outputPath = "public\assets\sebathi-banner-temp.png"
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$graphics.Dispose()
$bitmap.dispose()

Write-Host "Screenshot saved to: $outputPath" -ForegroundColor Green
Write-Host "`nNow cropping to banner dimensions..." -ForegroundColor Cyan

# Load and crop the image to a nice banner size (1200x630)
$img = [System.Drawing.Image]::FromFile((Resolve-Path $outputPath))

# Calculate crop area (top portion of screen for hero section)
$bannerWidth = [Math]::Min(1200, $img.Width)
$bannerHeight = [Math]::Min(630, $img.Height)

$cropBitmap = New-Object System.Drawing.Bitmap $bannerWidth, $bannerHeight
$cropGraphics = [System.Drawing.Graphics]::FromImage($cropBitmap)
$srcRect = New-Object System.Drawing.Rectangle 0, 0, $bannerWidth, $bannerHeight
$destRect = New-Object System.Drawing.Rectangle 0, 0, $bannerWidth, $bannerHeight
$cropGraphics.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

# Save cropped banner
$finalPath = "public\assets\sebathi-banner.png"
$cropBitmap.Save($finalPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$cropGraphics.Dispose()
$cropBitmap.Dispose()
$img.Dispose()

# Remove temp file
Remove-Item $outputPath -Force

Write-Host "`n✅ SUCCESS! Banner screenshot saved to: $finalPath" -ForegroundColor Green
Write-Host "The README.md file is already configured to use this image!" -ForegroundColor Cyan
