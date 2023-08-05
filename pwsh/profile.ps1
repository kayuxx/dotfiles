param (
    [switch]$lazy
)
# define-config-for-the-settings--------------------------------------------------------------------------------------
$windowsTerminalSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json"
$darkColorschemeName = "Poimandres"
$lightColorschemeName = "Catppuccin Latte"
$darkBackgroundImagePath = "$Home\Pictures\dark.jpg"
$lightBackgroundImagePath = "$Home\Pictures\light.jpg"
# jsonContent for Windows Terminal json settings
$wtSettings = Get-Content -Path $windowsTerminalSettingsPath -Raw | ConvertFrom-Json
# this function will call after the settings will applied
function Set-Envs {
  $defaults = $wtSettings.profiles.defaults
  $env:ThemeName=$defaults.colorScheme
  $env:TerminalFont=$defaults.font.face
  $env:TerminalFontSize=$defaults.font.size
  $env:NEOFETCH_PROFILE="$Home\.config\neofetch\config.conf"
  $nfProfile = $env:NEOFETCH_PROFILE 
}
# ---------------------------------------------------------------------------------------------------------------------

function Get-WindowsDarkThemeStatus {
    $registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    if (Test-Path $registryPath) {
        $themeProperties = Get-ItemProperty -Path $registryPath

        # Check if the "AppsUseLightTheme" registry value is set to 0 (dark theme) or 1 (light theme)
        $isDarkThemeEnabled = $themeProperties.AppsUseLightTheme -eq 0
        return $isDarkThemeEnabled
    } else {
        Write-Host "Theme information not found. Are you using a supported version of Windows?"
        return $false
    }
}
function Set-WallPaper {
  param (
      [parameter(Mandatory=$True)]
      # Provide path to image
      [string]$Image,
      # Provide wallpaper style that you would like applied
      [parameter(Mandatory=$False)]
      [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
      [string]$Style
      )
    $WallpaperStyle = Switch ($Style) {
      "Fill" {"10"}
      "Fit" {"6"}
      "Stretch" {"2"}
      "Tile" {"0"}
      "Center" {"0"}
      "Span" {"22"}
    }
  if($Style -eq "Tile") {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
      New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
  }
  else {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
      New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
  }
#refresh the User32
  Add-Type -TypeDefinition @" 
    using System; 
  using System.Runtime.InteropServices;

  public class Params
  { 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
      public static extern int SystemParametersInfo (Int32 uAction, Int32 uParam, String lpvParam, Int32 fuWinIni);
  }
"@ 
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}
function Set-WindowsTerminalColorScheme {
  if (Test-Path $windowsTerminalSettingsPath) {
# Determine if the dark theme is enabled in Windows
    $isDarkThemeEnabled = Get-WindowsDarkThemeStatus

# Set the colorscheme based on whether dark theme is enabled or not
      $selectedColorscheme = if ($isDarkThemeEnabled) {$darkColorschemeName} else { $lightColorschemeName }

# Ensure the 'profiles' and 'defaults' properties exist in the JSON object
    if (-not $wtSettings.profiles) {
      $wtSettings.profiles = @{}
    }
    if (-not $wtSettings.profiles.defaults) {
      $wtSettings.profiles.defaults = @{}
    }

# Update the colorscheme setting in the JSON object
    $wtSettings.profiles.defaults.colorScheme = $selectedColorscheme

# Convert the updated object back to JSON
      $updatedJsonContent = $wtSettings | ConvertTo-Json -Depth 4

# Write the updated JSON back to the settings.json file
      $updatedJsonContent | Set-Content -Path $windowsTerminalSettingsPath -Encoding UTF8

# Change the Windows background based on the theme
      $currentBgPath = (Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name 'Wallpaper').Wallpaper
      $currentBgName = "'$(Split-Path -Path $currentBgPath -Leaf)'"
      if ($isDarkThemeEnabled) {
        if ($currentBgPath -ne $darkBackgroundImagePath) {
          Set-WallPaper -Image $darkBackgroundImagePath -Style Center > $null
        } else {
          Write-Host("$currentBgName Background is already set")
        }
      } else {
        if ($currentBgPath -ne $lightBackgroundImagePath) {
          Set-WallPaper -Image $lightBackgroundImagePath -Style Center > $null
        } else {
          Write-Host("$currentBgName Background is already set")
        }
      }
  } else {
    Write-Host "Windows Terminal settings.json not found. Make sure Windows Terminal is installed and run it at least once."
  }
}
if (Get-WindowsDarkThemeStatus) {
  oh-my-posh init pwsh --config ("$Home/Documents/PowerShell/" + "poimandres.omp.json") | Invoke-Expression
} else {
  oh-my-posh init pwsh --config ("$Home/Documents/PowerShell/" + "kayux.omp.json") | Invoke-Expression
}

# PSRadLine Options
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -Colors @{ "InlinePrediction" = "blue" }
# Set-PSReadLineOption -EditMode Vi
## KeyBindgs
Set-PSReadLineKeyHandler -Key "ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key "ALT+j" -Function BackwardChar
Set-PSReadLineKeyHandler -Key "ALT+l" -Function ForwardChar
Set-PSReadLineKeyHandler -Key "Ctrl+h" -Function BackwardWord
Set-PSReadLineKeyHandler -Key "Ctrl+l" -Function ForwardWord
# Modules
Import-Module -name Terminal-Icons
# Aliases
Set-Alias vim nvim
Set-Alias pt "~\scoop\apps\powertoys\0.71.0\PowerToys.exe"
Set-Alias opera "~\scoop\apps\opera\99.0.4788.9\launcher.exe"
Set-Alias zt "$env:localappdata\Programs\Zettlr\Zettlr.exe"

# Utility Functions
# delete files and folders
function dlt {
  $numOfArgs = $args.Length
    $Faileds = @()
    $Success = @()
    for ($i=0; $i -lt $numOfArgs; $i++) {
      if (Test-Path $args[$i]) {
        Remove-Item -r -fo $args[$i]
          $Success+= $args[$i]
      } else {
        $Faileds+= $args[$i]
      }
    }
  if ($Faileds.length -eq 0 -and $Success.length -gt 0) {
    Write-Host "$($Success.length) removed successfuly"
  } elseif ($Faileds.length -gt 0 -and $Success.length -eq 0) {
    Write-Host "$($Faileds.length) files failed to removed"
      Write-Host "Failed Files: ('$Faileds')" -ForegroundColor 'red' 
  } elseif ($Faileds.length -eq 0 -and $Success.length -eq 0) {
    Write-Host "nothing removed"
  } else {
    Write-Host "$($Success.length) removed successfuly, but $($Faileds.length) failed to removed"
      Write-Host "Failed Files: ('$Faileds')" -ForegroundColor 'red' 
  }
}
# copy to clipboard
function cpy ($target, $o) {
  if ((Test-Path $target) -eq $false -and $o) {
    $target | clip
      Write-Host "content copied"
  } elseif (Test-Path $target) {
    Get-Content $target | clip
      Write-Host "file content copied"
  }
  else {
    Write-Host "$target file does not exist" -ForegroundColor "red"
  }
}
# generate a typescript interface for an api or existing file using quicktype library
function getinterface ($target, $output, $getcontent) {
  if (Get-Command "quicktype" -ErrorAction SilentlyContinue) {
    if ($target) {
      if ($output) {
        quicktype $target --just-types --lang ts --out $output | clip
          Write-Host ("Interface saved in '{0}\{1}' file" -f $(Get-Location), $output)
      } else {
        quicktype $target --just-types --lang ts | clip
          Write-Host "interface copied"
      }
    } else {
      Write-Host "target must not be empty"
    }
  } else {
    Write-Host "you have to install the 'quicktype' library to run this command"
  }	
}
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
function cme($path) {
  if (Get-Command "git" -ErrorAction SilentlyContinue) {
    git clone git@github.com:kayuxcodes/${path}.git 
  } else {
    Write-Host 'you need to install git to run this command'
  }
}

if (-not $lazy) {
  Set-WindowsTerminalColorScheme
    if (Get-Command "neofetch" -ErrorAction SilentlyContinue) {
      neofetch
    } else {
      Write-Host 'neofetch is not installed in your path'
    }
} else {
  Write-Host("loading script with lazy mod") -ForegroundColor DarkMagenta
}
Set-Envs