using Godot;

[Tool]
public class InspectorRegisterPlugin : EditorPlugin
{
	private EditorInspectorPlugin _plugin;

	public override void _EnterTree()
	{
		base._EnterTree();

		_plugin = new WaveInspectorPlugin();

		AddInspectorPlugin(_plugin);
	}

	public override void _ExitTree()
	{
		RemoveInspectorPlugin(_plugin);

		base._ExitTree();
	}
}

