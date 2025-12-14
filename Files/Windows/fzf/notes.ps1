$notePath = "$HOME\OneDrive\Documents\MEGA\Notes"
$finished = $false

while (-not $finished) {
    # Collect files with desired extensions
    $noteFiles = Get-ChildItem -Path $notePath -File -Recurse |
        Where-Object { $_.Extension -in @(".csv", ".md", ".tex", ".txt") } |
        ForEach-Object { $_.FullName }

    # Get-ChildItem returns nothing on no match
    if (-not $noteFiles) {
        Write-Host "No files found."
        break
    }

    # We only need the path after notePath
    $relativeFiles = $noteFiles | ForEach-Object { $_.Substring($notePath.Length + 1) }

    # This cmdlet changes the current working directory to the specified path and pushes the previous one to a stock
    Push-Location $notePath

    # Run fzf with preview
    $selection = $relativeFiles | fzf --preview "Get-Content '{}'" --preview-window=right:70%:wrap --reverse

    # Pop-Location returns us to the last saved directory
    Pop-Location

    # Selection will be empty if the user presses ESC, signifying that we should exit
    if ([string]::IsNullOrWhiteSpace($selection)) {
        $finished = $true
    } else {
        nvim (Join-Path $notePath $selection)
    }
}
