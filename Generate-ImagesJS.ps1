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
