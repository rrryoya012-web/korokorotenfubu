$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing
$root = "c:\Users\rrryo\OneDrive\ドキュメント\Antigravity\10_ころころてんふぶ"
$path = Join-Path $root "assets\bg\bg01.png"
$tempPath = Join-Path $root "assets\bg\bg01_resized.png"

if (-not (Test-Path $path)) {
    Write-Error "File not found: $path"
    exit 1
}

$img = [System.Drawing.Image]::FromFile($path)
$newImg = new-object System.Drawing.Bitmap(380, 500)
$graph = [System.Drawing.Graphics]::FromImage($newImg)
$graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graph.DrawImage($img, 0, 0, 380, 500)
$img.Dispose()
$newImg.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
$newImg.Dispose()
$graph.Dispose()

Move-Item -Path $tempPath -Destination $path -Force
Write-Output "Resize Success"
Remove-Item -Path $MyInvocation.MyCommand.Path -Force
