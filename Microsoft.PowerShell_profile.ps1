Import-Module -Name Terminal-Icons
Install-Module -Name posh-git -RequiredVersion 1.0.0
Install-Module -Name PSFzf -AllowPrerelease

Install-Module -Name z

Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSFzf
Import-Module PowerShellGet
oh-my-posh init pwsh --config './chris.omp.json' | Invoke-Expression








function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }



function atob {
    param(
        [string]$userInput
    )

    $encodedString = $userInput
    $decodedResult = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedString))

    Write-Output $decodedResult
}

function btos {
    param(
        [string]$binaryInput
    )

    $binaryArray = $binaryInput -split '\s+' | ForEach-Object { [Convert]::ToByte($_, 2) }

    $decodedString = [System.Text.Encoding]::UTF8.GetString($binaryArray)

    Write-Output $decodedString
}

#BinaryToString
function btoa {
    param(
        [string]$userInput
    )

    $encodedBytes = [System.Text.Encoding]::UTF8.GetBytes($userInput)
    $encodedString = [System.Convert]::ToBase64String($encodedBytes)

    Write-Output $encodedString
}

#StringToBinary
function stob {
    param(
        [string]$userInput
    )

    $binaryString = [System.Text.Encoding]::UTF8.GetBytes($userInput) | ForEach-Object { [Convert]::ToString($_, 2).PadLeft(8, '0') }

    $binaryString | Join-String -Separator ' ' | Write-Host -NoNewline
}

# StringToCrypto
function stoc {
    param (
        [string]$inputString
    )

    # Check if the input string is empty
    if ($inputString -eq "") {
        Write-Output "Input string is empty. Cannot generate UUID."
        return
    }

    # Compute MD5 hash
    $md5Hash = [System.Security.Cryptography.MD5]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($inputString))
    $formattedUUID = [guid]::NewGuid()

    return $formattedUUID

# Convert the string to crypto
$cryptoResult = stoc -inputString $inputString
Write-Output "Original String: $inputString"
Write-Output "Crypto Result: $cryptoResult"


}










# Check if the encoded string is provided as a command-line argument
if ($args.Count -eq 1) {
    $encodedString = $args[0]

    # Call the function with the encoded string
    $decodedResult = atob $encodedString

    # Output the decoded result
    Write-Output $decodedResult
} else {
    Write-Output "Usage: PowerShellScript.ps1 <base64-encoded-string>"
}



function touch($file) {
  "" | Out-File $file -Encoding ASCII
}

function pkill($name) {
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}






function Edit-Profile {
  if ($host.Name -match "ise") {
    $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
  }
  else {
    notepad $profile.CurrentUserAllHosts
  }
}

function gcom {
  git add .
  git commit -m "$args"
}
function lazyg {
  git add .
  git commit -m "$args"
  git push
}


function find-file($name) {
  Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
    $place_path = $_.directory
    Write-Output "${place_path}\${_}"
  }
}
function unzip ($file) {
  Write-Output("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}




$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-Alias -Name where -Value find-file
Set-alias -Name touch -Value New-Item
Set-alias ll ls

 Clear-Host







