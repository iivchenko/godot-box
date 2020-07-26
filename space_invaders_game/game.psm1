$url = "https://downloads.tuxfamily.org/godotengine/3.2.2/Godot_v3.2.2-stable_win64.exe.zip"
$out = ".\.tools"

function Download-Godot {

    New-Item -ItemType Directory -Force -Path $out
    wget -Uri $url -OutFile "$out\godot.zip"
    expand-archive -path "$out\godot.zip" -DestinationPath $out 
    Rename-Item -Path "$out\Godot_v3.2.2-stable_win64.exe"  -NewName "godot.exe"
    Remove-Item "$out\godot.zip"
}

function Run-Editor {
    
    param()

    if (-not (Test-Path -Path "$out\godot.exe"))
    {
        Download-Godot
        
    }

    & "$out\godot.exe" --editor
}

function Run-Game {

    param()

    if (-not (Test-Path -Path "$out\godot.exe"))
    {
        Download-Godot
        
    }

    & "$out\godot.exe"
}

function Run-Export {
    param()

    if (-not (Test-Path -Path "$out\godot.exe"))
    {
        Download-Godot
        
    }

    New-Item -ItemType Directory -Force -Path .\publish\html5\
    New-Item -ItemType Directory -Force -Path .\publish\winx64\

    & "$out\godot.exe" --path . --export "HTML5" .\publish\html5\index.html
    & "$out\godot.exe" --path . --export "Windows Desktop" .\publish\winx64\sig.exe
}

Export-ModuleMember -Function * -Alias *