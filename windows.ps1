# Helper function 

function Link {
	param ([String] $Link, [String] $Target)

	# Remove item if it already exists
	Remove-Item $Link 2>$null
	New-Item -Path $Link -ItemType SymbolicLink -Value ( $PSScriptRoot + $Target ) | out-null
}

# Powershell Profile
Link -Link $profile -Target "\pwsh\profile.ps1"

# GIT CONFIG
Link -Link "~/.gitconfig" -Target "\git\windows.gitconfig"
