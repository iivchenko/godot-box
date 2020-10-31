#if TOOLS
using Godot;

public sealed class WaveInspectorPlugin : EditorInspectorPlugin
{
	public override bool CanHandle(Godot.Object @object)
	{
		return true;
	}

	public override bool ParseProperty(Godot.Object @object, int type, string path, int hint, string hintText, int usage)
	{
		if(@object.Get(path) is WaveProperty)
		{
			AddPropertyEditor(path, new WavePropertyEditor());
		
			return true;
		}

		return false;
	}
}
#endif