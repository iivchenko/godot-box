$url = "https://downloads.tuxfamily.org/godotengine/3.2.3/mono/Godot_v3.2.3-stable_mono_win64.zip" 
$out = ".\.tools"
$godot = "$out\godot\godot.exe"
$publish = "..\publish"


function Download-Godot {

    New-Item -ItemType Directory -Force -Path $out
    wget -Uri $url -OutFile "$out\godot.zip"
    expand-archive -path "$out\godot.zip" -DestinationPath $out 
    Rename-Item -Path "$out\Godot_v3.2.3-stable_mono_win64\Godot_v3.2.3-stable_mono_win64.exe"  -NewName "godot.exe"
	Rename-Item -Path "$out\Godot_v3.2.3-stable_mono_win64"  -NewName "godot"
    Remove-Item "$out\godot.zip"
}

function Run-Editor {
    
    param()

    if (-not (Test-Path -Path $godot))
    {
        Download-Godot
        
    }

    & $godot --editor
}

function Run-Game {

    param()

    if (-not (Test-Path -Path $godot))
    {
        Download-Godot
        
    }

    & $godot
}

function Run-Export {
    param()

    if (-not (Test-Path -Path $godot))
    {
        Download-Godot
        
    }

    New-Item -ItemType Directory -Force -Path "$publish\html5\"
    New-Item -ItemType Directory -Force -Path "$publish\winx64\"

    & $godot --path . --export "HTML5" "$publish\html5\index.html"
    & $godot --path . --export "Windows Desktop" "$publish\winx64\game.exe"
}

Export-ModuleMember -Function * -Alias *