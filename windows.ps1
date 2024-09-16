# Helper function 

function Link {
	param ([String] $Link, [String] $Target)

	# Remove item if it already exists
	Remove-Item -Recurse $Link 2>$null
	New-Item -Path $Link -ItemType SymbolicLink -Value ( $PSScriptRoot + $Target ) | out-null
}

# GIT CONFIG
Link -Link "~/.gitconfig" -Target "\git\windows.gitconfig"

# Oh My Posh 
Link -Link "~/.omp.json" -Target "\omp\omp.json"

# Powershell Profile
Link -Link $profile -Target "\pwsh\profile.ps1"

# Nvim config
Link -Link $($env:localappdata + "/nvim") -Target "/nvim/"