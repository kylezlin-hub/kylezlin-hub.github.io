# Auto-generate photo manifests for all gallery folders
# Run this script after adding new photos to regenerate the manifests

$galleryFolders = @(
    'fun-facts/community-service',
    'fun-facts/mop2025',
    'fun-facts/power-plant'
)

$imageExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.webp')

foreach ($folder in $galleryFolders) {
    $folderPath = Join-Path $PSScriptRoot $folder
    
    if (Test-Path $folderPath) {
        # Get all image files, sorted by name
        $photos = Get-ChildItem $folderPath -File | 
            Where-Object { $_.Extension -in $imageExtensions } |
            Sort-Object Name |
            Select-Object -ExpandProperty Name
        
        # Create manifest JSON
        $manifest = @{
            photos = $photos
            updated = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')
            count = $photos.Count
        }
        
        $manifestPath = Join-Path $folderPath 'photos.json'
        $manifest | ConvertTo-Json | Set-Content $manifestPath -Encoding UTF8
        
        Write-Host "✓ Updated $folder - found $($photos.Count) photos"
    } else {
        Write-Host "✗ Folder not found: $folder"
    }
}

Write-Host "Done! Manifests updated."
