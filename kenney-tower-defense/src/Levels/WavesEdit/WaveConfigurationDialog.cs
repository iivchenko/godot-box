using Godot;

public class WaveConfigurationDialog : WindowDialog
{
	private Level _level;

	private Label _levelName;

	[Export]
	public WaveConfiguration Configuration { get; set; }

	public override void _Ready()
	{
		base._Ready();
		_levelName = GetNode<Label>("VBoxContainer/LevelName/Label2");
		var a1 = GetNode<Label>("VBoxContainer");
		var a2 = GetNode<Label>("VBoxContainer/LevelName");
		var a3 = GetNode<Label>("VBoxContainer/LevelName/Label2");
	}

	public void SetLevel(Level level)
	{
		_level = level;

		_levelName.Text = _level.Name;
	}
}
