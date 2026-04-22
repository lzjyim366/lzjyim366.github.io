param(
    [string]$PostsDir,
    [string]$OldName,
    [string]$NewName
)

$filePath = Join-Path $PostsDir "$NewName.md"

if (-not (Test-Path $filePath)) {
    Write-Host "File not found: $filePath"
    exit 1
}

$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

if ([string]::IsNullOrEmpty($content)) {
    Write-Host "ERROR: File content is empty, aborting to prevent data loss."
    exit 1
}

# Fix title in front-matter
$content = $content -replace '(?m)^title:.*$', "title: $NewName"

# Fix image paths
$content = $content -replace "images/$OldName/", "images/$NewName/"

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)

Write-Host "Updated title and image paths."
