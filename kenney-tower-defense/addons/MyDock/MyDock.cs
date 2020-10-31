using Godot;
using System;

[Tool]
public class MyDock : EditorPlugin
{
 	Control dock;

	public override void _EnterTree()
	{
		dock = (Control)GD.Load<PackedScene>("addons/MyDock/MyDock.tscn").Instance();
		AddControlToDock(DockSlot.LeftUl, dock);
	}

	public override void _ExitTree()
	{
		// Clean-up of the plugin goes here.
		// Remove the dock.
		RemoveControlFromDocks(dock);
		// Erase the control from the memory.
		dock.Free();
	}
}
