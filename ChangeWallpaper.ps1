Add-Type @"
using System.Runtime.InteropServices;
public class Wallpaper
{
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$Folder = "C:\Company\Wallpaper\T7"
$Wallpaper1 = Join-Path $Folder "Wallpaper1.png"
$Wallpaper2 = Join-Path $Folder "Wallpaper2.png"
$StateFile = Join-Path $Folder "wallpaper.state"

if (!(Test-Path $Wallpaper1) -or !(Test-Path $Wallpaper2)) {
    exit
}

# Đọc trạng thái lần trước
if (Test-Path $StateFile) {
    $Current = Get-Content $StateFile
} else {
    $Current = "2"
}

if ($Current -eq "1") {
    $NextWallpaper = $Wallpaper2
    $NextState = "2"
}
else {
    $NextWallpaper = $Wallpaper1
    $NextState = "1"
}

# Đổi hình nền
[Wallpaper]::SystemParametersInfo(20, 0, $NextWallpaper, 3) | Out-Null

# Lưu trạng thái
$NextState | Set-Content $StateFile
