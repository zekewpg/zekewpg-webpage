$Folder = "D:\Rob's Documents\GitRepositories\zekewpg-webpage\images"

# Get all files (change the filter if needed)
$Files = Get-ChildItem -Path $Folder -File | Sort-Object Name

$Counter = 1

foreach ($File in $Files) {
    $NewName = "{0:D3}{1}" -f $Counter, $File.Extension.ToLower()

    Rename-Item -Path $File.FullName -NewName $NewName

    Write-Host "$($File.Name) -> $NewName"

    $Counter++
}

Write-Host "`nDone!"


# Folder containing your images
$imageFolder = "images"

# Output file
$outputFile = "images.js"

# Image extensions to include
$extensions = "*.jpg","*.jpeg","*.png","*.gif","*.webp"

# Get all image files
$files = Get-ChildItem -Path $imageFolder -File -Include $extensions |
         Sort-Object Name

# Start the JavaScript file
$content = @()
$content += "const images = ["

foreach ($file in $files) {
    $content += "    `"images/$($file.Name)`","
}

# Remove trailing comma from the last entry
if ($files.Count -gt 0) {
    $content[$content.Count-1] =
        $content[$content.Count-1].TrimEnd(',')
}

$content += "];"

# Write the file
$content | Set-Content -Path $outputFile -Encoding UTF8

Write-Host ""
Write-Host "$($files.Count) images added to images.js"
Write-Host "Created $outputFile"
