using Godot;
using System;

public sealed class CustomResource : EditorPlugin
{
	private EditorImportPlugin _importPlugin = null;


	public override void _EnterTree()
	{
		base._EnterTree();

		_importPlugin = GD.Load<EditorImportPlugin>("CustomResourcePlugin.cs");
		AddImportPlugin(_importPlugin);
	}

	public override void _ExitTree()
	{
		RemoveImportPlugin(_importPlugin);
		base._ExitTree();
	}
}
