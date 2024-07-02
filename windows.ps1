# Helper function 

function Link {
	param ([String] $Link, [String] $Target)

	# Remove item if it already exists
	Remove-Item $Link 2>$null
	New-Item -Path $Link -ItemType SymbolicLink -Value ( $PSScriptRoot + $Target ) | out-null
}

# GIT CONFIG
Link -Link "~/.gitconfig" -Target "\git\windows.gitconfig"
