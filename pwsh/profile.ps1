Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

oh-my-posh init pwsh --config "~/.omp.json" | Invoke-Expression

# Import-Module posh-git    # Already covered by oh-my-posh

$PSStyle.FileInfo.Directory = "`e[38;2;255;255;255m"

Invoke-Expression (& { (zoxide init powershell | Out-String) })


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
