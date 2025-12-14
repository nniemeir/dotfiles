function notes {
    & "$env:USERPROFILE\dotfiles\Files\Windows\fzf\notes.ps1"
}
function prompt {
    $Location = Get-Item -Path (Get-Location)
    if ($Location.PSChildName) {
        $LocationName = $Location.PSChildName
    }
    else {
        $LocationName = $Location.BaseName
    }
    Write-Host -Object "$LocationName>" -NoNewLine -ForegroundColor DarkGreen
    Return ' '
}
