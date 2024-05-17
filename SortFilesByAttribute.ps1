# Save this script as SortFilesByAttribute.ps1

param (
    [string]$Path,
    [string]$SortBy
)

# Get all files in the specified directory
$files = Get-ChildItem -Path $Path -File

foreach ($file in $files) {
    switch ($SortBy.ToLower()) {
        "extension" {
            $attribute = $file.Extension.TrimStart('.')
        }
        "creationdate" {
            $attribute = $file.CreationTime.ToString("yyyy-MM-dd")
        }
        "size" {
            if ($file.Length -gt 1MB) {
                $attribute = "Large"
            } elseif ($file.Length -gt 100KB) {
                $attribute = "Medium"
            } else {
                $attribute = "Small"
            }
        }
        default {
            Write-Host "Invalid sorting option. Please use 'extension', 'creationdate', or 'size'."
            exit
        }
    }

    $destination = Join-Path -Path $Path -ChildPath $attribute

    # Create the folder if it doesn't exist
    if (-not (Test-Path -Path $destination)) {
        New-Item -Path $destination -ItemType Directory
    }

    # Move the file to the folder
    Move-Item -Path $file.FullName -Destination $destination
}

Write-Host "Files sorted by $SortBy and moved to respective folders."
