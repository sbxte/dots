Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

oh-my-posh init pwsh --config "D:/Source/Repo/omp-config/custom.omp.json" | Invoke-Expression

# Import-Module posh-git    # Already covered by oh-my-posh

$PSStyle.FileInfo.Directory = "`e[38;2;255;255;255m"

Invoke-Expression (& { (zoxide init powershell | Out-String) })

