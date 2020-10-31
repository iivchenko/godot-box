using Godot;
using System;

[Tool]
public class JustPlugin : EditorPlugin
{
	public override void _EnterTree()
	{
		// Initialization of the plugin goes here.
		// Add the new type with a name, a parent type, a script and an icon.
		var script = GD.Load<Script>("res://addons/JustPlugin/MyButton.cs");
		var texture = GD.Load<Texture>("res://addons/JustPlugin/icon.png");
		AddCustomType("MyButton", "Button", script, texture);
	}

	public override void _ExitTree()
	{
		// Clean-up of the plugin goes here.
		// Always remember to remove it from the engine when deactivated.
		RemoveCustomType("MyButton");
	}
}
