# Fun Facts Gallery System

Your photo galleries are now fully automated using manifest files. Here's how to manage them:

## Quick Start: Adding New Photos

1. **Add your photos** to the appropriate folder:
   - `fun-facts/community-service/` - Community service photos
   - `fun-facts/mop2025/` - MOP 2025 photos
   - `fun-facts/power-plant/` - Power plant visit photos

2. **Run the update script** to auto-generate the manifests:
   ```powershell
   .\update-gallery-manifests.ps1
   ```

3. **Commit and push** your changes:
   ```bash
   git add .
   git commit -m "Add new gallery photos"
   git push origin V1
   ```

## How It Works

- Each gallery folder contains a `photos.json` manifest file that lists all photos
- The gallery pages read from this manifest to display photos
- No code changes needed—just add photos and regenerate the manifests
- Photos are displayed in alphabetical order (rename files to control order)

## The Update Script

`update-gallery-manifests.ps1` automatically:
- Scans each gallery folder for image files (jpg, jpeg, png, gif, webp)
- Generates/updates the `photos.json` manifest with current filenames
- Records when the manifest was last updated

## Manual Manifest Format (if needed)

Each `photos.json` looks like:
```json
{
  "photos": [
    "photo1.jpg",
    "photo2.jpg",
    "photo3.jpg"
  ],
  "updated": "2026-06-23T00:00:00Z",
  "count": 3
}
```

## Tips

- **Control photo order** by prefixing filenames with numbers (e.g., `01-photo.jpg`, `02-photo.jpg`)
- **Supported formats**: jpg, jpeg, png, gif, webp
- **File size**: Keep photos optimized for web (typically under 2MB each)
- **Gallery preview**: The first photo in each folder becomes the preview on the main gallery hub

## Troubleshooting

- If photos don't appear, check the browser console for errors
- Make sure `photos.json` exists in each gallery folder
- After adding photos, always run `update-gallery-manifests.ps1`
