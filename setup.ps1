# Set symlinks for our dotfiles

# Windows autocreates the default terminal config, so we remove it
Remove-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force

New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Target "$env:USERPROFILE\.dotfiles\Files\Windows\terminal\settings.json"

New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.glzr\" -Target "$env:USERPROFILE\.dotfiles\Files\Windows\.glzr\" 

New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Usability.ahk" -Target "$env:USERPROFILE\.dotfiles\Files\Windows\Usability.ahk"

Remove-Item "$env:USERPROFILE\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target "$env:USERPROFILE\.dotfiles\Files\Windows\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

New-Item -Path "$env:LOCALAPPDATA" -Name "nvim" -ItemType "Directory"

New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim\init.lua" -Target "$env:USERPROFILE\.dotfiles\Files\Common\nvim\init.lua" 

Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Install Visual Studio Code extensions
extensions = @(
    "ms-vscode.cpptools",
    "ms-vscode.powershell",
    "ms-python.python",
    "mechatroner.rainbow-csv",
    "enkia.tokyo-night"
)

foreach ($ext in $extensions) {
    code --install-extension $ext
}
