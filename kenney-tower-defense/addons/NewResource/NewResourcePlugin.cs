using System.Collections.Generic;
using Godot;

[Tool]
public class NewResourcePlugin : Resource
{
    [Export]
    public string LevelName {get;set;}

   // [Export(PropertyHint.ResourceType, "WaveResource")]
   // public IEnumerable<WaveResource> Waves { get; set;}
}
