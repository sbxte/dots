# Helper function 

function link ($target, $link) {
	# Remove item if it already exists
	Remove-Item $link
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

# GIT CONFIG
link("~/.gitconfig", "./git/windows.gitconfig")
