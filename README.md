# Typst Libraries

Library of personal Typst templates.

## Install

Installation on Windows:

```pwsh
# Execute as administrator

$datadir = "${env:LOCALAPPDATA}\typst\packages\local"
$packages = ,"langnote"

New-Item -ItemType Directory -Force -Path $datadir
foreach ($package in $packages) {
    $name = $null
    $version = $null
    foreach($line in [System.IO.File]::ReadLines("${PWD}\${package}\typst.toml")) {
        if($line -match 'name\s*=\s*"(.+)"\s*'){
            $name = $Matches.1
        }
        if($line -match 'version\s*=\s*"(.+)"\s*'){
            $version = $Matches.1
        }
        if ($name -ne $null -and $version -ne $null) {
            break
        }
    }
    if ($name -ne $null -and $version -ne $null) {
        $pkgdir = "${datadir}\${name}\${version}"
        New-Item -ItemType SymbolicLink -Force -Path "${pkgdir}" -Value "${PWD}\${package}"
    }
}
```

Installation on Linux:

```sh
# Execute as user
# TODO
```
