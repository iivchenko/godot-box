using Godot;

public sealed class Main : Control
{
	private SceneTree _tree;

	private Button _playButton;
	private Button _exitButton;

	public override void _Ready()
	{
		_tree = GetTree();

		_playButton = GetNode<Button>("Menu/PlayButton");
		_exitButton = GetNode<Button>("Menu/ExitButton");

		_playButton.Connect("pressed", this, nameof(OnPlay));
		_exitButton.Connect("pressed", this, nameof(OnExitGame));
	}

	private void OnPlay()
	{
		_tree.ChangeScene("res://src/Levels/Level01.tscn");
	}

	private void OnExitGame()
	{
		_tree.Quit();
	}
}
