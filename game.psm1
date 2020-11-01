$workdir = "$PSScriptRoot\.tools\godot"
$publish = "$PSScriptRoot\publish"

function Download-Godot {
    param($Version)

    $out = "$workdir\"
    $url = "https://downloads.tuxfamily.org/godotengine/$Version/mono/Godot_v$Version-stable_mono_win64.zip" 

    New-Item -ItemType Directory -Force -Path $out
    wget -Uri $url -OutFile "$out\godot.zip"
    expand-archive -path "$out\godot.zip" -DestinationPath $out 
    Rename-Item -Path "$out\Godot_v$version-stable_mono_win64\Godot_v$version-stable_mono_win64.exe"  -NewName "godot.exe"
	Rename-Item -Path "$out\Godot_v$version-stable_mono_win64"  -NewName "$Version"
    Remove-Item "$out\godot.zip"
}

function Run-Editor {

    param($Version)

    $godot = "$workdir\$Version\godot.exe"
    if (-not (Test-Path -Path $godot))
    {
        Download-Godot -Version $Version
        
    }

    & $godot --editor
}

function Run-Game {

    param($Version)

    $godot = "$workdir\$Version\godot.exe"

    if (-not (Test-Path -Path $godot))
    {
        Download-Godot -Version $Version
        
    }

    & $godot
}

function Run-Export {
    param(
        $Version, 
        $Game, 
        [ValidateSet("WINX64", "HTML5")] $Type)

    $godot = "$workdir\$Version\godot.exe"

    if (-not (Test-Path -Path $godot))
    {
        Download-Godot -Version $Version
    }

    switch($Type)
    {
        "WINX64"
        {
            New-Item -ItemType Directory -Force -Path "$publish\$Game\winx64\"
            & $godot --path . --export "Windows Desktop" "$publish\$Game\winx64\game.exe"
        }
        
        "HTML5"
        {
            New-Item -ItemType Directory -Force -Path "$publish\$Game\html5\"
            & $godot --path . --export "HTML5" "$publish\$Game\html5\index.html"
        }
    }
}

Export-ModuleMember -Function * -Alias *