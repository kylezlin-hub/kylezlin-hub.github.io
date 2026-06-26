# Auto-generate media manifests for all gallery folders
# Run this script after adding new photos/videos to regenerate the manifests

$galleryFolders = @(
    'fun-facts/community-service',
    'fun-facts/mop2025',
    'fun-facts/power-plant',
    'fun-facts/drama-play',
    'fun-facts/waterpolo'
)

$imageExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.webp')
$videoExtensions = @('.mp4', '.mov', '.webm', '.m4v')

foreach ($folder in $galleryFolders) {
    $folderPath = Join-Path $PSScriptRoot $folder

    if (Test-Path $folderPath) {
        # Get all image files, sorted by name
        $photos = Get-ChildItem $folderPath -File |
            Where-Object { $imageExtensions -contains $_.Extension.ToLower() } |
            Sort-Object Name |
            Select-Object -ExpandProperty Name

        # Get all video files, sorted by name
        $videos = Get-ChildItem $folderPath -File |
            Where-Object { $videoExtensions -contains $_.Extension.ToLower() } |
            Sort-Object Name |
            Select-Object -ExpandProperty Name

        # Create manifest JSON
        $manifest = @{
            photos = $photos
            videos = $videos
            updated = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
            count = ($photos.Count + $videos.Count)
            photoCount = $photos.Count
            videoCount = $videos.Count
        }

        $manifestPath = Join-Path $folderPath 'photos.json'
        $manifest | ConvertTo-Json -Depth 4 | Set-Content -Path $manifestPath -Encoding UTF8

        Write-Host "Updated $folder - found $($photos.Count) photos and $($videos.Count) videos"
    }
    else {
        Write-Host "Folder not found: $folder"
    }
}

Write-Host "Done! Manifests updated."
