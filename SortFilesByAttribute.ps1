# Save this script as SortFilesByAttribute.ps1

param (
    [string]$Path
)

# Get all files in the specified directory
$files = Get-ChildItem -Path $Path -File

foreach ($file in $files) {
    $attribute = $file.Extension.TrimStart('.')
    $destination = Join-Path -Path $Path -ChildPath $attribute

    # Create the folder if it doesn't exist
    if (-not (Test-Path -Path $destination)) {
        New-Item -Path $destination -ItemType Directory
    }

    # Move the file to the folder
    Move-Item -Path $file.FullName -Destination $destination
}

Write-Host "Files sorted by extension and moved to respective folders."
