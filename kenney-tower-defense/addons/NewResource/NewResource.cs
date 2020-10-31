#if TOOLS
using Godot;
using System;

[Tool]
public class NewResource : EditorPlugin
{
	public override void _EnterTree()
	{
		// Initialization of the plugin goes here.
		// Add the new type with a name, a parent type, a script and an icon.
		var script = GD.Load<Script>("res://addons/NewResource/NewResourcePlugin.cs");
		var texture = GD.Load<Texture>("res://addons/NewResource/icon.png");
		AddCustomType("NewResource", "Resource", script, texture);

		//var waveScript =  GD.Load<Script>("res://addons/NewResource/WaveResource.cs");
		//AddCustomType("WaveResource", "Resource", waveScript, texture);
	}

	public override void _ExitTree()
	{
		// Clean-up of the plugin goes here.
		// Always remember to remove it from the engine when deactivated.
		RemoveCustomType("NewResource");
		//RemoveCustomType("WaveResource");
	}
}
#endif
